Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586FEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F15D207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZCu8CXIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgGPNqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgGPNqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:46:07 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DB4C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:46:07 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f18so11655433wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1Crn7XaTOFPhrYlDIsZatzqk+FDLvcbXlzkZjad2WAY=;
        b=ZCu8CXInP03TrQAxb0+85FxBWLoCqTLjBYofXz9dz/MHBJ77oYeCkS8BZyB8PfsyfR
         h7cjuoHQ174FvNAJe35uUkTDTuLXEnw9B1Cflc08dT7LoiAJ9eS/MTClE919psUmJ1Yu
         p4hq+AQIbrL3c/EQPIxO7/uBvFi2BgRHqOB6Iaxhwlr7sxy4ZjOm3HmFduE5nVCaoc40
         GLk8L5R5p6M8YK+HSwfbUvxTgwY7ielCaJZwmN2BYHiTS/+L6bfalaUV0qJPIu/KD7Kw
         S9tgrpiX2WcT4Xz3ZUF3ygTqzjgJ1Tn23fETuDN+PWti4AfK+fNPDv5fpTB+vXXq4CvH
         hiIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1Crn7XaTOFPhrYlDIsZatzqk+FDLvcbXlzkZjad2WAY=;
        b=ndDRHGHLDXosrgIZ7/iGhDU3wiFXjWBOLmjf26JGRMMzaLiAdr/HMXWWecLY5EiLRu
         ofPvjYKeNhjP7ZixF8/Ww1YaqMCOkPthAe9AzOFHPud17JvhbwWkvWzOymBQk8rJeMV9
         Ent9f5+3S0v1u8CwFzi5+KRvijPN1Clq2gva1r6G1i2tJPeE8WvgO9g/3yRVahFi6Lv5
         McUwOZYu2ZNrD+N3nZkDuda6Zz8h5+PSgScMCzINf6MjEq0QdP9HDQfEYLbFyiR3HymC
         +KBCCgnqjAGgvhGxjud1LN/cCZ/SO8JIAso2znwSoB06Ll/pxtsUxA3GKUPDrn44w+yz
         Tcbg==
X-Gm-Message-State: AOAM532yi8hA/bC0Z8cdXyOHARCM18oNc/iNTVE9NXo06fS0kCzDByt5
        5/6rj4fG0lmaJakeuyIcWJTDDQ==
X-Google-Smtp-Source: ABdhPJzABLymprHrJbOu3vDvVfyXX0rXIMPbOqyh2TEOe8TDMx7XvUjAN27s4XgvRAL1AYfWA8gMCA==
X-Received: by 2002:a7b:ca52:: with SMTP id m18mr4433464wml.92.1594907165870;
        Thu, 16 Jul 2020 06:46:05 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id w13sm9162781wrr.67.2020.07.16.06.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:46:05 -0700 (PDT)
Date:   Thu, 16 Jul 2020 14:46:03 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mfd: Convert to DEFINE_SHOW_ATTRIBUTE
Message-ID: <20200716134603.GR3165313@dell>
References: <20200716090236.13057-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200716090236.13057-1-miaoqinglang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jul 2020, Qinglang Miao wrote:

> From: Yongqiang Liu <liuyongqiang13@huawei.com>
> 
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> ---
>  drivers/mfd/ab3100-core.c | 15 ++-------------
>  drivers/mfd/ab3100-otp.c  | 16 +++-------------
>  drivers/mfd/tps65010.c    | 14 ++------------

Can you split this out into different patches please.

>  3 files changed, 7 insertions(+), 38 deletions(-)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
