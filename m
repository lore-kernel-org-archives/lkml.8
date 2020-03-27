Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D640EC2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A537720714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L5O+beAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgC0Ixp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 04:53:45 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:46288 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725946AbgC0Ixp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 04:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585299223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0q7+oK+xU3Z8kXzQCu6KZqoOG1NNGcrqKhoyLJsys48=;
        b=L5O+beAQ9iRCtLTaIEc78+KN0D49+LhNDOG3uXt22xEbOYD9b0CdGWe04Oqc+LAEgAgMBA
        AwjsOQSUa2RdLQhQuSUp/Gdz3f+wXamkA9V8b1BscLgWyEBU1beqHPINUWoZxc45rXINXn
        85eU+4tfk087895k6oqlr4AiFRVTaq0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-ENzHJTI9Ovmxmz856vq7fA-1; Fri, 27 Mar 2020 04:53:42 -0400
X-MC-Unique: ENzHJTI9Ovmxmz856vq7fA-1
Received: by mail-wr1-f69.google.com with SMTP id y1so4226014wrn.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 01:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=0q7+oK+xU3Z8kXzQCu6KZqoOG1NNGcrqKhoyLJsys48=;
        b=D2ezCEG5Pm/NwePzr9pVgekoSsvXS3/wKqCGmjijTqyNz7F869PLRfNjsVF6b1Y0o1
         1v7EfXT04zVC/KdrHwpOO0+yfIx8xqyxxHRwF10xs4an3BWSU2yMGc4MjLaFf4ZdnBvs
         AgQK8VPGZbVDzInnw18D0gABVyDMPbaoeM8U3tXXfIb+ojX/WLifjvr0I1oS//L91Muk
         +H100n6dMjpOUcPnoKqEDRCIudeBOz9hnKSBSe8Q9NDjYJlxpmGhhfSLfaNiKT94M2Bf
         B3Sm9uLQGEcfW9Qzov+4nap1LCrA8jAwDl7awugZWDm6zHmRYx8rJefYviGoxNwYSSPG
         bCuQ==
X-Gm-Message-State: ANhLgQ2hWS7XSABt3tfHzRTQO7j3pioW2wGUyXAceSzgQbU/s+JDO2fJ
        BCmbyWrLn+AR4xDwDyhYLsaGvKsolSBChj9BjongiulFCpADkHG8X/WM7OsB4+pDW4Mfmp7myMR
        j6pI4h+iABHXvNWzRXO0uiPhg
X-Received: by 2002:a1c:b789:: with SMTP id h131mr4015732wmf.141.1585299221188;
        Fri, 27 Mar 2020 01:53:41 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvc0WHbcYocOiWt9cgoCAX+Uwqe6OC53OE8hVNqrC4SkjsDw268gg9CvPXU5dV7SBm//7wNEQ==
X-Received: by 2002:a1c:b789:: with SMTP id h131mr4015719wmf.141.1585299220950;
        Fri, 27 Mar 2020 01:53:40 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id u8sm7088146wrn.69.2020.03.27.01.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 01:53:40 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Yubo Xie <yuboxie@microsoft.com>,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        michael.h.kelley@microsoft.com
Subject: Re: [PATCH V2] x86/Hyper-V: Fix hv sched clock function return wrong time unit
In-Reply-To: <20200327021159.31429-1-Tianyu.Lan@microsoft.com>
References: <20200327021159.31429-1-Tianyu.Lan@microsoft.com>
Date:   Fri, 27 Mar 2020 09:53:39 +0100
Message-ID: <87k13641rg.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tianyu Lan <ltykernel@gmail.com> writes:

> From: Yubo Xie <yuboxie@microsoft.com>
>
> sched clock callback should return time with nano second as unit
> but current hv callback returns time with 100ns. Fix it.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Yubo Xie <yuboxie@microsoft.com>
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> Fixes: bd00cd52d5be ("clocksource/drivers/hyperv: Add Hyper-V specific sched clock function")
> ---
> Change since v1:
> 	Update fix commit number in change log. 
> ---
>  drivers/clocksource/hyperv_timer.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index 9d808d595ca8..662ed978fa24 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -343,7 +343,8 @@ static u64 notrace read_hv_clock_tsc_cs(struct clocksource *arg)
>  
>  static u64 read_hv_sched_clock_tsc(void)
>  {
> -	return read_hv_clock_tsc() - hv_sched_clock_offset;
> +	return (read_hv_clock_tsc() - hv_sched_clock_offset)
> +		* (NSEC_PER_SEC / HV_CLOCK_HZ);
>  }
>  
>  static void suspend_hv_clock_tsc(struct clocksource *arg)
> @@ -398,7 +399,8 @@ static u64 notrace read_hv_clock_msr_cs(struct clocksource *arg)
>  
>  static u64 read_hv_sched_clock_msr(void)
>  {
> -	return read_hv_clock_msr() - hv_sched_clock_offset;
> +	return (read_hv_clock_msr() - hv_sched_clock_offset)
> +		* (NSEC_PER_SEC / HV_CLOCK_HZ);
>  }
>  
>  static struct clocksource hyperv_cs_msr = {

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

