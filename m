Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A200C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 01:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD8C24655
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 01:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbgBSBMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 20:12:50 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:46063 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726757AbgBSBMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 20:12:49 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07472768|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.264101-0.0159969-0.719902;DS=SPAM|spam_other|0.930438-0.00178347-0.0677784;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03310;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.GpVrOsg_1582074763;
Received: from 172.16.10.102(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.GpVrOsg_1582074763)
          by smtp.aliyun-inc.com(10.147.40.44);
          Wed, 19 Feb 2020 09:12:44 +0800
Subject: Re: [PATCH v2 11/11] mtd: new support oops logger based on pstore/blk
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
References: <1581078355-19647-1-git-send-email-liaoweixiong@allwinnertech.com>
 <1581078355-19647-12-git-send-email-liaoweixiong@allwinnertech.com>
 <20200218113449.5ac44955@xps13>
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
Message-ID: <5e95d596-3ba1-09e6-1777-007a5257f1cc@allwinnertech.com>
Date:   Wed, 19 Feb 2020 09:13:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200218113449.5ac44955@xps13>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Miquel Raynal,

On 2020/2/18 下午6:34, Miquel Raynal wrote:
> Hi WeiXiong,
> 
> WeiXiong Liao <liaoweixiong@allwinnertech.com> wrote on Fri,  7 Feb
> 2020 20:25:55 +0800:
> 
>> It's the last one of a series of patches for adaptive to MTD device.
>>
>> The mtdpstore is similar to mtdoops but more powerful. It bases on
>> pstore/blk, aims to store panic and oops logs to a flash partition,
>> where it can be read back as files after mounting pstore filesystem.
>>
>> The pstore/blk and blkoops, a wrapper for pstore/blk, are designed for
>> block device at the very beginning, but now, compatible to not only
>> block device. After this series of patches, pstore/blk can also work
>> for MTD device. To make it work, 'blkdev' on kconfig or module
>> parameter of blkoops should be set as mtd device name or mtd number.
>> See more about pstore/blk and blkoops on:
>>     Documentation/admin-guide/pstore-block.rst
>>
>> Why do we need mtdpstore?
>> 1. repetitive jobs between pstore and mtdoops
>>    Both of pstore and mtdoops do the same jobs that store panic/oops log.
>>    They have much similar logic that register to kmsg dumper and store
>>    log to several chunks one by one.
>> 2. do what a driver should do
>>    To me, a driver should provide methods instead of policies. What MTD
>>    should do is to provide read/write/erase operations, geting rid of codes
>>    about chunk management, kmsg dumper and configuration.
>> 3. enhanced feature
>>    Not only store log, but also show it as files.
>>    Not only log, but also trigger time and trigger count.
>>    Not only panic/oops log, but also log recorder for pmsg, console and
>>    ftrace in the future.
>>
>> Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>
> 
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> Richard, your PoV on this is welcome.
> 
> I suppose this patch depends on the others to work correctly so maybe
> we should wait the next release before applying it.
> 

Of couse, thank you for your review

> Thanks,
> Miquèl
> 

-- 
liaoweixiong
