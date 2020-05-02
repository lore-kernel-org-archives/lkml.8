Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A975EC3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 12:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8717A24960
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 12:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVj1+G8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgEBMbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 08:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727029AbgEBMby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 08:31:54 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC52C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 05:31:53 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t12so6819929ile.9
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 05:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fgoH8rWRDI/PbUnxgxiFsD6XVhiop1SpajRlUIN+Oco=;
        b=AVj1+G8Up1VQJVrTlIQpNLvPVV9Wkqudp5nqxmAikkUlcsWJdsnNs/FIZ9AtlkZkFx
         /czLyFq5gPcrlRiAVGTvE/lqErkikswZ2FXy1ncn8DpDyKF0mV9TR2mr8a3xy6ESJ/nM
         XWg5Eam9Uio1at5SIsA5PtnSagaQzwx8OopK1BpW7oi3WRGYchbEMvJ3q8+bf13WufVA
         ZDsa0wIA5FMi7PjmGgm/+bMKg4zKqd3vVuPm0H5G1RpGoeQGuE3eezikFaH3mLN9vwmh
         gL+CXUSkbLnSbdshtZh5vlO09AOJOfLeg/yHCEFOI02GsfjuGVAv15zrU/D/lf/LJjRJ
         Jzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fgoH8rWRDI/PbUnxgxiFsD6XVhiop1SpajRlUIN+Oco=;
        b=lAXf38CyMHRJbYqI4SGm2L48KTH07P414GRC+sd8RScZLFPclaHNgspDELj8Dt+nKr
         OBxZdj1IJrWukC2v9ueaCp0U03FDv2a8KWG1hvGKVf0V4hpDJCf+JzGTM29M8mhrb7pQ
         tPzpBvag9bo8+9OVpKwroE8UdAQbvGz9bRoFhJlGzXxWl9n1UQR/Yoy3CJ1L3m/3POLe
         wjQNy/NSuv8QldrJ0K1CAYWTJI2Yo0koSo/bVgsa3JNgKzUIBWi6rtTwY2UToilvRtbP
         5opaYWq6fidgQs0ivPfIt29rzj2DZFEHV7+Ot1ebEOyBC+b7zXP2A0eBG+JuZEDXqqZZ
         n07g==
X-Gm-Message-State: AGi0Pua5pCCcv8KSK1O8Pk1l+JSyCIqXxd3mrJL/83haw+/tKmbTwhON
        z/OaA5uYc19OusxVQg7WuKW3DOmkqTuEVkOXpBY=
X-Google-Smtp-Source: APiQypJHTVygTlm3uyDu7YafDrHABrINeBqBAiUQVWG7p7zY1ObzStEJ3q3g7DjLjaDfPw4PGNZTm8uUfwW+ANSBL0A=
X-Received: by 2002:a92:c144:: with SMTP id b4mr7893681ilh.89.1588422712733;
 Sat, 02 May 2020 05:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200306105939.1233360-1-aford173@gmail.com>
In-Reply-To: <20200306105939.1233360-1-aford173@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sat, 2 May 2020 07:31:41 -0500
Message-ID: <CAHCN7x+ZGgs__ZOg5qxz0yoZBsMN6Ps_btG9smi8C-gL0jAN4A@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Enable AT24 EEPROM as module
To:     arm-soc <linux-arm-kernel@lists.infradead.org>
Cc:     Adam Ford-BE <aford@beaconembedded.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 6, 2020 at 4:59 AM Adam Ford <aford173@gmail.com> wrote:
>
> The Beacon EmbeddedWorks Kit based on i.MX8M Mini uses an AT24
> EEPROM on one of its I2C buses.
>
> This patch enables the AT24 as a module.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
>

Gentle ping.  I don't know who the right person is to ask for this.

> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index ab71a407288f..8018a52f6792 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -224,6 +224,7 @@ CONFIG_BLK_DEV_NBD=m
>  CONFIG_VIRTIO_BLK=y
>  CONFIG_BLK_DEV_NVME=m
>  CONFIG_SRAM=y
> +CONFIG_EEPROM_AT24=m
>  CONFIG_EEPROM_AT25=m
>  # CONFIG_SCSI_PROC_FS is not set
>  CONFIG_BLK_DEV_SD=y
> --
> 2.25.0
>
