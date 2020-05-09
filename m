Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD80DC47254
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 10:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C720D214D8
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 10:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgEIKc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 06:32:28 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:33256 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726877AbgEIKc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 06:32:27 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436712|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0310074-0.00171468-0.967278;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16367;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.HVnmYjV_1589020342;
Received: from 172.16.10.102(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.HVnmYjV_1589020342)
          by smtp.aliyun-inc.com(10.147.41.143);
          Sat, 09 May 2020 18:32:22 +0800
Subject: Re: [PATCH v4 00/12] pstore: mtd: support crash log to block and mtd
 device
To:     Kees Cook <keescook@chromium.org>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200508064004.57898-1-keescook@chromium.org>
 <202005080020.41C33738@keescook>
From:   WeiXiong Liao <liaoweixiong@allwinnertech.com>
Message-ID: <c1583001-bf03-d198-ad57-3d2a0baf93ca@allwinnertech.com>
Date:   Sat, 9 May 2020 18:32:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <202005080020.41C33738@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Kees Cook,

On 2020/5/8 PM 3:27, Kees Cook wrote:
> On Thu, May 07, 2020 at 11:39:52PM -0700, Kees Cook wrote:
>> So far, I've identified the following stuff left to do:
>> [...]
>>         - implement ramoops-like probe feature for pstore/blk
> 
> With the following hack, I'm able to start testing the series:
> 
> diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
> index a736555e1ed3..7145da079267 100644
> --- a/fs/pstore/blk.c
> +++ b/fs/pstore/blk.c
> @@ -373,12 +373,14 @@ int psblk_register_blkdev(unsigned int major, unsigned int flags,
>  	if (IS_ERR(binfo))
>  		return PTR_ERR(binfo);
>  
> +#if 0
>  	/* only allow driver matching the @blkdev */
>  	if (!binfo->devt || MAJOR(binfo->devt) != major) {
>  		pr_debug("invalid major %u (expect %u)\n",
>  				major, MAJOR(binfo->devt));
>  		return -ENODEV;
>  	}
> +#endif
>  
>  	/* hold bdev exclusively */
>  	bdev = psblk_get_bdev(holder);
> @@ -423,7 +425,7 @@ void psblk_unregister_blkdev(unsigned int major)
>  	struct psblk_device dev = {.read = psblk_generic_blk_read};
>  	void *holder = blkdev;
>  
> -	if (psblk_bdev && MAJOR(psblk_bdev->bd_dev) == major) {
> +	if (psblk_bdev/* && MAJOR(psblk_bdev->bd_dev) == major*/) {
>  		psblk_unregister_device(&dev);
>  		psblk_put_bdev(psblk_bdev, holder);
>  		blkdev_panic_write = NULL;
> @@ -476,6 +478,24 @@ int pstore_blk_usr_info(struct pstore_blk_info *info)
>  }
>  EXPORT_SYMBOL_GPL(pstore_blk_usr_info);
>  
> +static int __init pstore_blk_init(void)
> +{
> +	int ret = 0;
> +
> +	if (blkdev[0])
> +		ret = psblk_register_blkdev(0, 0, NULL);
> +
> +	return ret;
> +}
> +postcore_initcall(pstore_blk_init);
> +
> +static void __exit pstore_blk_exit(void)
> +{
> +	psblk_unregister_blkdev(0);
> +}
> +module_exit(pstore_blk_exit);
> +
> +
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("WeiXiong Liao <liaoweixiong@allwinnertech.com>");
>  MODULE_DESCRIPTION("pstore backend for block devices");
> 
> 
> Then I can get things up and running with:
> 
> # insmod pstore.ko compress=off
> # insmod pstore_zone.ko
> # truncate pstore-blk.raw --size 100M
> # losetup -f --show pstore-blk.raw
> /dev/loop0
> # insmod pstore_blk.ko blkdev=/dev/loop0 kmsg_size=16 console_size=64
> 
> So far, I've hit a few bugs. The most obvious is that "rmmod" causes a
> fault, so I think locking and other things need to be fixed up further.
> After that, it looked like all the compressed files were failing to
> decompress, which implies some kind of buffer offset problem. When I
> loaded with pstore.compress=off I got readable logs, but there is a span
> of garbage between the header and the body in
> /sys/fs/pstore/dmesg-pstore-zone-1 etc.
> 

Both of the above two bugs have been fix on series v6.

The following diff is to fix "rmmod" bug.

@@ -1273,8 +1273,8 @@ static void psz_free_zones(struct pstore_zone
***pszones, unsigned int *cnt)
                return;

        while (*cnt > 0) {
-               psz_free_zone(&zones[*cnt]);
                (*cnt)--;
+               psz_free_zone(&zones[*cnt]);
        }
        kfree(zones);
        *pszones = NULL;

> Cool so far! It just needs a bit more testing a polish. :)
> 

-- 
WeiXiong Liao
