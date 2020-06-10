Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3DCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 05:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26EFE207F9
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 05:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgFJFYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 01:24:06 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:33441 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725844AbgFJFYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 01:24:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U.9Jxv2_1591766642;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U.9Jxv2_1591766642)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 10 Jun 2020 13:24:03 +0800
Subject: Re: [PATCH] docs/zh_CN: update sysfs.txt about show() usage
To:     Chen Zhou <chenzhou10@huawei.com>, harryxiyou@gmail.com,
        corbet@lwn.net
Cc:     mchehab+huawei@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200610025333.84010-1-chenzhou10@huawei.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <6df52c93-5f95-38b3-a724-46cdb78605ef@linux.alibaba.com>
Date:   Wed, 10 Jun 2020 13:24:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200610025333.84010-1-chenzhou10@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>

Thanks
Alex

在 2020/6/10 上午10:53, Chen Zhou 写道:
> Update the show() usage according to the English version.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  Documentation/translations/zh_CN/filesystems/sysfs.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/translations/zh_CN/filesystems/sysfs.txt b/Documentation/translations/zh_CN/filesystems/sysfs.txt
> index fcf620049d11..9481e3ed2a06 100644
> --- a/Documentation/translations/zh_CN/filesystems/sysfs.txt
> +++ b/Documentation/translations/zh_CN/filesystems/sysfs.txt
> @@ -213,10 +213,12 @@ Sysfs 将会为每次读写操作调用一次这个方法。这使得这些方
>  
>  - 缓冲区应总是 PAGE_SIZE 大小。对于i386，这个值为4096。
>  
> -- show() 方法应该返回写入缓冲区的字节数，也就是 snprintf()的
> +- show() 方法应该返回写入缓冲区的字节数，也就是 scnprintf()的
>    返回值。
>  
> -- show() 应始终使用 snprintf()。
> +- show() 方法在将格式化返回值返回用户空间的时候，禁止使用snprintf()。
> +  如果可以保证不会发生缓冲区溢出，可以使用sprintf()，否则必须使用
> +  scnprintf()。
>  
>  - store() 应返回缓冲区的已用字节数。如果整个缓存都已填满，只需返回
>    count 参数。
> 
