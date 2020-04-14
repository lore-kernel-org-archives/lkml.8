Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C33EC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5773206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNuMkIEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504579AbgDNTAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504540AbgDNTAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:00:43 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA876C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:00:42 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id m19so597780lfq.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vku39TN+p8W1cXG35tH9xBj8XE2RMoUOgq+LnuxWOGc=;
        b=rNuMkIEsC4qajqgUvs5Frlpje0uAD8GkEIHjosF8sq4n2OnrChikeB3fsuKOG/rJ4c
         Nrh91u1nEqfMxgdrdcAWV5KajTRPvwtWqmE8bJzF64ae2pQ+K1BhO26kpsDVnzADehle
         1CC5HospidLMjwvkQtWJSIz549zH7abBvoN6b5IhUhprAO/jxWY21CPTVoE6i6aAt9gS
         weVY1qSTM5VyQ4VZ8erSp44DI0ua/5QaKEwP9drIaN0jD14Di3Mm2EKs9f5z7+E85uqg
         y4GwqN9XehWXO68+Apz4MHkes+pyxB4zi4sDjCimCBCiluKdBUdoWL2w4WJPQULWrqci
         w4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vku39TN+p8W1cXG35tH9xBj8XE2RMoUOgq+LnuxWOGc=;
        b=oC2/71C3y/SxCix262qBKce1mvd1sR5TTcl3y0lxfr/xIqMBkVDZIRLJL4EL3kD+4F
         6HgthZpf74GragNXCiTCtQecnb1DDPUBEuK0eHyacwztSiv3AN3E5auHtWfDVtIE0u/U
         QLLvcn94mIU8shit1L3bngJDQTwZObY9DRLLXSZXif604Tt9MtXp+z8o5ntNmn9Nt4Gc
         UKARpc89yjb8FfzqvEewpFNehnQb90m+U8xYWlMMiWB/n47IpnQeEVr55YUm/92ZfGnu
         P4uKsV6LlNIQQ6feZBtnIFJe4CRkMJ0KrtbiTHHUORYncvxePREM0/QRCT1tOtEH9Unv
         ik/g==
X-Gm-Message-State: AGi0PuZ+kFW8xzc0A4Q7oeOmqomSLOWFXR49SzUK1QYNtrbEZ5CwdjtJ
        R8Bff1ZvVK7UAAgXHQfsWizVRfFEKlhi41293/zdNQWm
X-Google-Smtp-Source: APiQypJghBXx+OqXpdcaUnjKNCywSLM1ufuFhoEC2HYC+rFBDg+uV3fLp3aPSO0JR3plIeP29EYSKJaWLGUDK93YN3g=
X-Received: by 2002:ac2:57cc:: with SMTP id k12mr701931lfo.69.1586890841018;
 Tue, 14 Apr 2020 12:00:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200414181140.145825-1-sebastian.reichel@collabora.com>
In-Reply-To: <20200414181140.145825-1-sebastian.reichel@collabora.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 14 Apr 2020 16:01:10 -0300
Message-ID: <CAOMZO5C5CVz=2gUm70ewt=etpW8yUp+OLQ7qKWOt-_+OCPRmuQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: sgtl5000: Fix VAG power-on handling
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Tue, Apr 14, 2020 at 3:11 PM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> As mentioned slightly out of patch context in the code, there
> is no reset routine for the chip. On boards where the chip is
> supplied by a fixed regulator, it might not even be resetted
> during (e.g. watchdog) reboot and can be in any state.
>
> If the device is probed with VAG enabled, the driver's probe
> routine will generate a loud pop sound when ANA_POWER is
> being programmed. Avoid this by properly disabling just the
> VAG bit and waiting the required power down time.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Fabio Estevam <festivem@gmail.com>
