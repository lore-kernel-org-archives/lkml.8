Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D062BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4538207ED
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMjsPKlR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgERJcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 05:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgERJcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 05:32:03 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5BEC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 02:32:03 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id y85so3630036oie.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 02:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V4KeqXR0hNSztYcChgmQJ2RuPcBryFoEBZpBxPtEK1g=;
        b=OMjsPKlRJNovbMXdN7PC/UbB5x/ok9CgOjvbFeDQaKLZcapBo3SmFsXhl83qYpeZ1X
         4v1doHRPZgTJVULZfhezrgsDQreWoBgxlrMarCoklCE7VNrjmX+ye/wxY2Jpvt6zAqID
         ix5IUJQHrwMMGEwuDeMMKIu9xJ2J4asRqkaAxus1vfjk31DjrcgDGNhte6g3uhOlYXG0
         NVyh2phiENxysE4topMDwC1/uRUMc73XhiabkiCuJoZVyLvcvxb6g5LC0lwkgVv0h7Mx
         CwfMRI9GUcmmVkdnjjeWDYT32nse3PfOrJTiaWPbat/+q26ucbFrVEEuAFQMYRtY9kvn
         ze+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V4KeqXR0hNSztYcChgmQJ2RuPcBryFoEBZpBxPtEK1g=;
        b=q17Dl0D/dXNRZbSrSgHRTrtoYr/6t2sdh6tSNkCtCD4Ar2Y1/K6YIlM2UEEsihg3hG
         REciKY3wBVIzhtQ/kmOegKlwxBAldfCjZkZC3gdxpIas55A2o7CEDo9MLMe50GpKhkMd
         K01T4zWSOdUV7IsGaUFu3ND3OMA3Mtc3YYHg4rK5OkvUIXeJ0SVULa9odSkO+yQAQ4Sw
         B1aP50Jx2AvuuMQJCl+GyzcdgIRmxK1puQWIs4xIX53+wKz1oYxMe7JmZOMQnl9S5pSp
         oPtiEDT+vS/ebZrBvW/tzzrquCzZ6zKWleLkNHxgoKanYxFZb3a+pRE7Ahq3F6SbUdDe
         r7kw==
X-Gm-Message-State: AOAM532YYbnOEVwbDeJSwzm/c/96aFsuluUwc/lwafK0DMqFHonSBnCk
        OSwe9XIY5Wo6PrT/n9uSor9NcITS
X-Google-Smtp-Source: ABdhPJyQZxsr3+7xZB5tqZ22a95AwBRRBavHJtII9Q46eLcjZ4yUF4AIUVQSrdTx74t1cjcXxMFn/g==
X-Received: by 2002:aca:e1d6:: with SMTP id y205mr1544032oig.142.1589794322753;
        Mon, 18 May 2020 02:32:02 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id r14sm2820213otk.60.2020.05.18.02.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 02:32:02 -0700 (PDT)
Date:   Mon, 18 May 2020 02:32:00 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] powerpc/wii: Fix declaration made after definition
Message-ID: <20200518093200.GA719945@ubuntu-s3-xlarge-x86>
References: <20200413190644.16757-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413190644.16757-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 12:06:45PM -0700, Nathan Chancellor wrote:
> A 0day randconfig uncovered an error with clang, trimmed for brevity:
> 
> arch/powerpc/platforms/embedded6xx/wii.c:195:7: error: attribute
> declaration must precede definition [-Werror,-Wignored-attributes]
>         if (!machine_is(wii))
>              ^
> 
> The macro machine_is declares mach_##name but define_machine actually
> defines mach_##name, hence the warning.
> 
> To fix this, move define_machine after the is_machine usage.
> 
> Fixes: 5a7ee3198dfa ("powerpc: wii: platform support")
> Reported-by: kbuild test robot <lkp@intel.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/989
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  arch/powerpc/platforms/embedded6xx/wii.c | 25 ++++++++++++------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/embedded6xx/wii.c b/arch/powerpc/platforms/embedded6xx/wii.c
> index 67e48b0a164e..a802ef957d63 100644
> --- a/arch/powerpc/platforms/embedded6xx/wii.c
> +++ b/arch/powerpc/platforms/embedded6xx/wii.c
> @@ -172,19 +172,6 @@ static void wii_shutdown(void)
>  	flipper_quiesce();
>  }
>  
> -define_machine(wii) {
> -	.name			= "wii",
> -	.probe			= wii_probe,
> -	.setup_arch		= wii_setup_arch,
> -	.restart		= wii_restart,
> -	.halt			= wii_halt,
> -	.init_IRQ		= wii_pic_probe,
> -	.get_irq		= flipper_pic_get_irq,
> -	.calibrate_decr		= generic_calibrate_decr,
> -	.progress		= udbg_progress,
> -	.machine_shutdown	= wii_shutdown,
> -};
> -
>  static const struct of_device_id wii_of_bus[] = {
>  	{ .compatible = "nintendo,hollywood", },
>  	{ },
> @@ -200,3 +187,15 @@ static int __init wii_device_probe(void)
>  }
>  device_initcall(wii_device_probe);
>  
> +define_machine(wii) {
> +	.name			= "wii",
> +	.probe			= wii_probe,
> +	.setup_arch		= wii_setup_arch,
> +	.restart		= wii_restart,
> +	.halt			= wii_halt,
> +	.init_IRQ		= wii_pic_probe,
> +	.get_irq		= flipper_pic_get_irq,
> +	.calibrate_decr		= generic_calibrate_decr,
> +	.progress		= udbg_progress,
> +	.machine_shutdown	= wii_shutdown,
> +};
> 
> base-commit: 8f3d9f354286745c751374f5f1fcafee6b3f3136
> -- 
> 2.26.0
> 

Gentle ping for review/acceptance.

Cheers,
Nathan
