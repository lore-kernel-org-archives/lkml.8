Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28F4C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF13A2145D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgEHMrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:47:13 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:39588 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729485AbgEHMqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:46:55 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07441439|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.221532-0.00382694-0.774641;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03293;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.HVGJWfr_1588942007;
Received: from 172.16.10.102(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.HVGJWfr_1588942007)
          by smtp.aliyun-inc.com(10.147.41.121);
          Fri, 08 May 2020 20:46:48 +0800
Subject: Re: [PATCH v3 02/11] pstore/blk: new support logger for block devices
To:     Kees Cook <keescook@chromium.org>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
References: <1585126506-18635-1-git-send-email-liaoweixiong@allwinnertech.com>
 <1585126506-18635-3-git-send-email-liaoweixiong@allwinnertech.com>
 <202005072301.57F73B61CC@keescook>
From:   WeiXiong Liao <liaoweixiong@allwinnertech.com>
Message-ID: <6dcadbb0-8720-7973-8b33-747ae0579567@allwinnertech.com>
Date:   Fri, 8 May 2020 20:46:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <202005072301.57F73B61CC@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Kees Cook,

On 2020/5/8 PM 2:07, Kees Cook wrote:
> On Wed, Mar 25, 2020 at 04:54:57PM +0800, WeiXiong Liao wrote:
>> pstore/blk is similar to pstore/ram, but dump log to block device
>> rather than persistent ram.
>> [...]
>> +int psblk_register_blkdev(unsigned int major, psblk_panic_write_op panic_write)
>> +{
>> +	struct block_device *bdev;
>> +	struct psblk_device dev = {0};
>> +	struct bdev_info *binfo;
>> +	int ret = -ENODEV;
>> +	void *holder = blkdev;
>> +
>> +	binfo = psblk_get_bdev_info();
>> +	if (IS_ERR(binfo))
>> +		return PTR_ERR(binfo);
>> +
>> +	/* only allow driver matching the @blkdev */
>> +	if (!binfo->devt || MAJOR(binfo->devt) != major) {
>> +		pr_debug("invalid major %u (expect %u)\n",
>> +				major, MAJOR(binfo->devt));
>> +		return -ENODEV;
>> +	}
>> +
>> +	/* hold bdev exclusively */
>> +	bdev = psblk_get_bdev(holder);
>> +	if (IS_ERR(bdev)) {
>> +		pr_err("failed to open '%s'!\n", blkdev);
>> +		return PTR_ERR(bdev);
>> +	}
>> +
>> +	/* psblk_bdev must be assigned before register to pstore/blk */
>> +	psblk_bdev = bdev;
>> +	blkdev_panic_write = panic_write;
>> +
>> +	dev.total_size = psblk_bdev_size(bdev);
>> +	dev.panic_write = panic_write ? psblk_blk_panic_write : NULL;
>> +	dev.read = psblk_generic_blk_read;
>> +	dev.write = psblk_generic_blk_write;
>> +
>> +	ret = psblk_register_do(&dev);
>> +	if (ret)
>> +		goto err_put_bdev;
>> +
>> +	pr_info("using '%s'\n", blkdev);
>> +	return 0;
>> +
>> +err_put_bdev:
>> +	psblk_bdev = NULL;
>> +	blkdev_panic_write = NULL;
>> +	psblk_put_bdev(bdev, holder);
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(psblk_register_blkdev);
> 
> I've gotten this series refactored on top of current pstore, and I've
> been making various bikeshed changes to names, etc, and as I went to go
> start testing, I realized that nothing actually uses
> psblk_register_blkdev().
> 
> It seems like it should be possible to just start using this on any
> block device of the user's choosing. I assume the idea is to allow for
> drivers to register panic_write handlers, but even without that, it'd be
> nice to just be able to test this with something like /dev/loop0.
> 

Yes. psblk_register_blkdev() is there for block drivers to register
panic_write()
handlers. The panic_wrire() is used only when panic occurs. Not only the
panic
log, but also all data on dirty zones. I implement the panic_write() of mmc
and nand on the platform of Allwinner, but I think it is not ready to
submit to
community.

All other front-ends but dmesg for panic are available since pstore/blk
provides
the general write/read through IO stack. That's why /dev/loop0 seemed to
works well.

> What's your thinking on how this would happen? It seems like if
> pstore/blk uses pstore/zone, and mtdpstore uses pstore/blk, there should
> be a blkoops that uses pstore/blk too?  I guess I need to learn a bit> more about how block device probing works so pstore/blk can notice
> devices as they're brought online, etc.
> 

pstore/blk provides all  user options and register function for device
drivers.
The mtdpstore is the implementation case using pstore/blk. How about
'mmc_pstore' for mmc and *_pstore for others block device?

I guess I need to learn more about how pstore/blk can notice devices too.
I think pstore/blk can be better if block device can do like mtd device that
not only notifies but also provides generic panic_write().

-- 
WeiXiong Liao
