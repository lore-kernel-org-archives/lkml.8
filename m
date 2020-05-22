Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D9CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 15:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B375F2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 15:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Q68AtwCb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgEVPCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 11:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730050AbgEVPCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 11:02:32 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12288C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 08:02:32 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id i5so10906666qkl.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 08:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dkxEj1coOfFtDRdGk3SHlsiZ4KhnaU7casF53YxwhU0=;
        b=Q68AtwCbz8IXixg1Uv4JuWkQ/dS2CfBaNQlV3gMnByIVeI6j/GvmAfME+iKXxJ0KDB
         nnwMs2C8RhJ/lGobWxPffVUcGTzVwRhI7bmIinrBQIVwE9PD+hwyBH1MQ1mIlG1o0Lrg
         k3yKlXRa7zUNA0osoCCV4GAbD6XdNd/IkBBOM/gWIhTs7azCEzkx0yi6NwlLwffLOoyW
         twVYFHZ46gAUn6FmFpdhPIMPjv4OzLlyHosrBX+kmE3Gj4sNZO2VCnjV+CL2ad69b4Z4
         9VxRkUDHFjzarPLdcJ8I7fWevXAwuekDxAXylXfy2NuO4ZpDcWL4KKk5l7VuwWNI8tl6
         fCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dkxEj1coOfFtDRdGk3SHlsiZ4KhnaU7casF53YxwhU0=;
        b=DPPeTO4VmBAMJjb//M3ttMHzfJYHllB0qZgHqRsxs0nTRGNxums4T1IXpMB5k32tAe
         HRfkOluXG0K4DBQPQ/tqzqiYevdqHM/Ob6XFsJe6frip15FM9jbMLKoMCluKDNtey/3I
         OnuHkvrXheLpoVSJLcjZV3/r4X7MvmFKwSL29kqs623dVPIT6Q5PuHRb7PhjmIOXDDpf
         LQ4FFN/PcvrkrLDfib+lfTWUWgN9IoIZR7eXlKUPeRO+0rbaathwTIgRRUXQ/ycotguf
         o9Tpwg/Tepwblkyw/ptHU8WK0p2C9NhC1V1GJ3UrxwM7+NMmJj0A2M8IfwTA97hsFayp
         6u5g==
X-Gm-Message-State: AOAM532Byo+vmzcpv2V5mCfr0kw0lKglOcA1eilhQGXhxcWr9tAGit1H
        6s/iLaUY85zgbNDtFbJiiDc2TVd3XzqPZtM3DbKJwQ==
X-Google-Smtp-Source: ABdhPJxePnh+DCaZ9Lz/G9eTquabOUYZMu3bEyC+yNH7arwpZItl5eI97xafp7tSps5d0QkUa/ya6COnAk8O0yMuNic=
X-Received: by 2002:a05:620a:6bc:: with SMTP id i28mr15831334qkh.330.1590159751249;
 Fri, 22 May 2020 08:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <1589461212-27357-1-git-send-email-alencar.fmce@imbel.gov.br>
In-Reply-To: <1589461212-27357-1-git-send-email-alencar.fmce@imbel.gov.br>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 22 May 2020 17:02:19 +0200
Message-ID: <CAMpxmJXwS21ByzGTsZf6MC-ar-ajUeCCxzP-vNrBEWSLKD9+sw@mail.gmail.com>
Subject: Re: [PATCH] gpio: gpio-max730x: bring gpiochip_add_data after port config
To:     Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rodrigo Alencar <alencar.fmce@imbel.gov.br>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 14 maj 2020 o 15:00 Rodrigo Alencar
<455.rodrigo.alencar@gmail.com> napisa=C5=82(a):
>
> gpiochip_add_data being called before might cause premature calls of
> the gpiochip operations before the port_config values are initialized,
> which would possibily write zeros to port gonfiguration registers,
> an operation not allowed. For example, if there are gpio-hog nodes
> in a device-tree, the sequence of function calls are performed
>
> gpiochip_add_data
> of_gpiochip_add
> of_gpiochip_scan_gpios
> of_gpiochip_add_hog
> gpiod_hog
> gpiochip_request_own_desc
> gpiod_configure_flags
> gpiod_direction_output/gpiod_direction_input
>
> which would call later the gpiochip operation direction_output or
> direction_input prior the port_config[] initialization.
>
> Moreover, gpiochip_get_data is replaced by the container_of macro
> inside the gpiochip operations, which would allow the calling of
> max7301_direction_input prior to gpiochip_add_data
>
> Signed-off-by: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>

Applied with some tweaks to the commit message.

Bartosz
