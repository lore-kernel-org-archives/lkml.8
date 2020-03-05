Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6483CC3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F032207FD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="WnwAb5d1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgCEU25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 15:28:57 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36087 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgCEU24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 15:28:56 -0500
Received: by mail-pg1-f193.google.com with SMTP id d9so3296231pgu.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 12:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=HmV0FbbTWHLNbEk18HRKmUQTmdvAb4GvXJNWIO8inpU=;
        b=WnwAb5d1RStcMvL3G6qv4iE1QY1aQtZjztVhcUwHLiYbgE5zZ0JXszDfD3lwrVqyEu
         Kdm5SRwXEzXdgyWsmnnf2qpUZv8e9Pp3337mPcRc+FO/qa61nUpE5JNAeC3uIl6Sk7aZ
         zEScB88mw8C1wc8IlERsLazES/1iiv6dwlrGBRDCwRAihk9DCNz/UKEVMAc/KIeo8bCg
         X5vvpK01hbb4iaXxC+iHsO9iPBxBtQwUjk/WduX/3jJiXiIYFEiS7Ymakdm2kpN+svRh
         NPnjd+56lWMHdDiscVAMwx4SjrFfc6nX8RgUgJyoNS0YwDdRICHgGGuRnUlaq9IHgGUE
         sPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=HmV0FbbTWHLNbEk18HRKmUQTmdvAb4GvXJNWIO8inpU=;
        b=PgqgBuz8HMLV/aO8Qz0gx/W59S/HoZsYOtQ0UAEYZxGw76wEYmjQLVtL+7d6lb6sS3
         A96Sr2iRsJb/IVT/o+WJn6f50gFl/bBv4naZxmjYbanOWzbkUtkHv0iR4T2/CQaKlxCI
         c3znVJwb74ifVt1xDUHPFAB2cQ/CFaIfSs/Yhi1JkWg8o4SgADKMiVBtBGzME5Xbn+XY
         5RF5WQmHb6SJEW4uTIgNQIslngiDbjmAVEh8BCC8owyv3eTabFJfM5t0z2bym2knJVPG
         gpC9Iz7j0sEQnLaM6781rvYKb7qF9s46emvlrJJ06w1Lxd6dHaK6W8o/5cWb1NYK/BDF
         gHBQ==
X-Gm-Message-State: ANhLgQ18bklR8YKxsMlaJ3reLEzHUTkoLvzPK3KBnYMMdVKFq3TPedJ/
        nK6UW5sgO76MdsLWcC9km1U5BQ==
X-Google-Smtp-Source: ADFU+vuDn2wW8R29ceg7yGU4g1TMD8aF53aa5zyxzy79BYqzrEg5t0wg3/ksTytImORhH9AfXvij9w==
X-Received: by 2002:a62:25c3:: with SMTP id l186mr151830pfl.52.1583440135288;
        Thu, 05 Mar 2020 12:28:55 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
        by smtp.gmail.com with ESMTPSA id y5sm33080681pfr.169.2020.03.05.12.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 12:28:54 -0800 (PST)
Date:   Thu, 05 Mar 2020 12:28:54 -0800 (PST)
X-Google-Original-Date: Thu, 05 Mar 2020 12:28:24 PST (-0800)
Subject:     Re: [PATCH] riscv: dts: Add GPIO reboot method to HiFive Unleashed DTS file
In-Reply-To: <1582084147-24516-1-git-send-email-yash.shah@sifive.com>
CC:     robh+dt@kernel.org, mark.rutland@arm.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Atish Patra <Atish.Patra@wdc.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, yash.shah@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     yash.shah@sifive.com
Message-ID: <mhng-96dfac99-10d0-466f-8119-fbca6a67fa22@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 19:49:07 PST (-0800), yash.shah@sifive.com wrote:
> Add the ability to reboot the HiFive Unleashed board via GPIO.
>
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> index 609198c..4a2729f 100644
> --- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> +++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> @@ -2,6 +2,7 @@
>  /* Copyright (c) 2018-2019 SiFive, Inc */
>
>  #include "fu540-c000.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
>
>  /* Clock frequency (in Hz) of the PCB crystal for rtcclk */
>  #define RTCCLK_FREQ		1000000
> @@ -41,6 +42,10 @@
>  		clock-frequency = <RTCCLK_FREQ>;
>  		clock-output-names = "rtcclk";
>  	};
> +	gpio-restart {
> +		compatible = "gpio-restart";
> +		gpios = <&gpio 10 GPIO_ACTIVE_LOW>;
> +	};
>  };
>
>  &uart0 {

Thanks, this is on fixes -- I figure that given it's just a DT change there's
no reason to delay it.
