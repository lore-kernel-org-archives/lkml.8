Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE42C55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 14:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18858206B9
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 14:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgDYO2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 10:28:22 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:43089 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726062AbgDYO2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 10:28:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Twc3hdz_1587824898;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0Twc3hdz_1587824898)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 25 Apr 2020 22:28:18 +0800
Subject: Re: [RFC] Documentation: zh_CN: convert to use
 i2c_new_client_device()
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-doc@vger.kernel.org
Cc:     Harry Wei <harryxiyou@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org
References: <20200425100616.3363-1-wsa+renesas@sang-engineering.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <cb2d1373-5bb3-93c2-f5af-40a04b21651b@linux.alibaba.com>
Date:   Sat, 25 Apr 2020 22:26:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200425100616.3363-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/4/25 下午6:06, Wolfram Sang 写道:
> Move away from the deprecated API and advertise the new one.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> I can't read Chinese. But given the context, I think just updating to
> the new function name is enough. Please let me know if not. Thanks!

It looks good. Thanks!

Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>

> 
>  Documentation/translations/zh_CN/video4linux/v4l2-framework.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/translations/zh_CN/video4linux/v4l2-framework.txt b/Documentation/translations/zh_CN/video4linux/v4l2-framework.txt
> index 4d2af480a112..a88fcbc11eca 100644
> --- a/Documentation/translations/zh_CN/video4linux/v4l2-framework.txt
> +++ b/Documentation/translations/zh_CN/video4linux/v4l2-framework.txt
> @@ -488,7 +488,7 @@ struct v4l2_subdev *sd = v4l2_i2c_new_subdev(v4l2_dev, adapter,
>  
>  这个函数会加载给定的模块（如果没有模块需要加载，可以为 NULL），
>  并用给定的 i2c 适配器结构体指针（i2c_adapter）和 器件地址（chip/address）
> -作为参数调用 i2c_new_device()。如果一切顺利，则就在 v4l2_device
> +作为参数调用 i2c_new_client_device()。如果一切顺利，则就在 v4l2_device
>  中注册了子设备。
>  
>  你也可以利用 v4l2_i2c_new_subdev()的最后一个参数，传递一个可能的
> 
