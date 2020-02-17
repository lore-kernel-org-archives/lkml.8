Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C53DC7619F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699F020718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgBQIT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:19:59 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:32995 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgBQIT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:19:58 -0500
Received: by mail-ed1-f65.google.com with SMTP id r21so19685824edq.0;
        Mon, 17 Feb 2020 00:19:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ATnQLLigNnNp+3vrMMUywd96YC/sdkp/YQzir+b0HgQ=;
        b=G242rs+PDBmmgooaB2XqYB1dGRNvDnJOs03wZzB8y9bJpR4Cd3LDMuZ9k4DvNLEdd7
         Ey3bwblhwnKeQmCkNetL1kpwSHZdLfCqfb3Qo4XlsMmgmHsUPEjfptPqMvhxJx8Z5eYj
         bd51hx63y1M63ZQIH6mJTneVZqI4tyqxLm6t9dfaj6IbHkqpDTdRC41PxoI/Uh5GEuN7
         pb8JfGGphWNyvyVGJ7A+PiSCd/rHpqpmy5+8DnLyhx65laWvajKWBqhh9v2rQUf57zXL
         cDRCrP+Pmfff6goRcRReCSQzs53NHQG3Mo/k0tyIqeQRSQDM+VtNSzM8dmUV6KOjLvyB
         /mkg==
X-Gm-Message-State: APjAAAXbwIYYq/LfvuIHxr7xi6isa/UG63vXKjeThAHlW0zUeV/IH+Vr
        4zSH20qodyrY57Ct6NM4yaoHPmv/8kY=
X-Google-Smtp-Source: APXvYqxslzR90ipQN6pVb+aQ+bJiil+U8VHigr94WA1ReDW3LRyk/OLB84bRFXvmlID7e+zGSSsnHA==
X-Received: by 2002:a05:6402:1764:: with SMTP id da4mr13492458edb.24.1581927595038;
        Mon, 17 Feb 2020 00:19:55 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id m7sm445260edq.37.2020.02.17.00.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2020 00:19:54 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id s144so6786815wme.1;
        Mon, 17 Feb 2020 00:19:54 -0800 (PST)
X-Received: by 2002:a05:600c:34d:: with SMTP id u13mr21454590wmd.77.1581927594021;
 Mon, 17 Feb 2020 00:19:54 -0800 (PST)
MIME-Version: 1.0
References: <20200217064250.15516-1-samuel@sholland.org> <20200217064250.15516-6-samuel@sholland.org>
In-Reply-To: <20200217064250.15516-6-samuel@sholland.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 17 Feb 2020 16:19:43 +0800
X-Gmail-Original-Message-ID: <CAGb2v64p9QEhni1sAQWA9eOtGYDcc2_VnUd92sUxK7M_doHZJA@mail.gmail.com>
Message-ID: <CAGb2v64p9QEhni1sAQWA9eOtGYDcc2_VnUd92sUxK7M_doHZJA@mail.gmail.com>
Subject: Re: [RFC PATCH 05/34] ASoC: sun8i-codec: Remove incorrect SND_SOC_DAIFMT_DSP_B
To:     Samuel Holland <samuel@sholland.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 2:43 PM Samuel Holland <samuel@sholland.org> wrote:
>
> DSP_A and DSP_B are not interchangeable. The timing used by the codec in
> DSP mode is consistent with DSP_A. This is verified with an EG25-G modem
> connected to AIF2, as well as by comparing with the BSP driver.
>
> Remove the DSP_B option, as it is not supported by the hardware.
>
> Cc: stable@kernel.org
> Fixes: 36c684936fae ("ASoC: Add sun8i digital audio codec")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
