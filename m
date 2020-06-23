Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87554C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F9B62072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfKUA1iM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbgFWIcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731579AbgFWIcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:32:14 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C697C061573;
        Tue, 23 Jun 2020 01:32:14 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l188so5025069qkf.10;
        Tue, 23 Jun 2020 01:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WUXkMq3EwcMN7rag+IOzTouUq2jW1leXveyXqam81mE=;
        b=MfKUA1iM2cNLIQb0gJHMFANrfHxAxLJ7OauUZ2pO/Zib5rQxdceNoygxEhaSDMdHF9
         oRekPg5JE8wO67W1XXq2VajDG1CD5zGtq6DzJ+Qqzc0xSSHh8EvgNnEnJ7pA67a4qEGf
         lPl3QQNFvtUUy0Dxt3X/UuNwZ7fbemOh29ZTt497SOrwO3oL3Sey/D/ilE2uGS2PQFbx
         8eRe/P+4LFzxcDQI8ZY/wsYR0Eaj3Q5c4e3/otG65UcV+dUVpriPExa1pjkoV6FtNKsk
         eTFyhw3iNwgYihpOJRXlLTx1rYmcfRPPKKxP+HEqKHn704oUg1p1fMwDArGlPS5755W+
         rRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WUXkMq3EwcMN7rag+IOzTouUq2jW1leXveyXqam81mE=;
        b=NPmLEXhIFO7gTqA+k8vpP7MYud0A+r3q8Ubve1H6sA3J2dPviSNkghi+MUw+dnuu0a
         p/nGw/tlksPlPcUY+5s687gBXqBDTfYS3tyMDjR9GOLnkV7Wtv++ktS6j4qSWEmMXsyF
         JW+RLftnFWcaXhZfJDKrgbTlHHa1CQuJ3D5C6KTR15j+0Eeje/yqMZjpDd9dPWvQOLMT
         X1iu0T7//EA4rQLlOhvZH1MOF68twVotefhQlAuOWPct1Qq1vp6rYGv5EVifQf1ospGE
         iMbNr07eQp/laNfohMNJUPyjNbOVukhZufHBRboMYfmBtSc3BWAxV3BZStyB1jEvhm1x
         Rhkg==
X-Gm-Message-State: AOAM531zWSygy4VEtqHmYpcZjZL2Jeu/jjkaM4WfIZspC89Q7sHTlMJy
        yVAPET9ZrXnaKWqGx93Nb7+VR+LN2xM4pBRbSxE=
X-Google-Smtp-Source: ABdhPJy8aJP9b/KoDke180z5lb657c5ulXpRf52exbUwqEylh9UUhQV3q7rSAK3MRe5vqIrWMG20D3EDlUJCCfc0XW8=
X-Received: by 2002:a37:8a43:: with SMTP id m64mr18899695qkd.37.1592901133739;
 Tue, 23 Jun 2020 01:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <39ac8f24-3148-2a3d-3f8d-91567b3c4c9e@web.de>
In-Reply-To: <39ac8f24-3148-2a3d-3f8d-91567b3c4c9e@web.de>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Tue, 23 Jun 2020 16:32:02 +0800
Message-ID: <CAA+D8APR2NGAn9jRDSZzr1fgj5u0hAvH19VxZS+tj2A7j3PCuw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: fsl_mqs: Don't check clock is NULL before
 calling clk API
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 3:38 PM Markus Elfring <Markus.Elfring@web.de> wrote:
>
> > In-Reply-To: <cover.1592888591.git.shengjiu.wang@nxp.com>
>
> I guess that it should be sufficient to specify such a field once
> for the header information.

seems it's caused by my "git format-patch" command, I will update
it, hope it is better next time.

>
>
> > Because clk_prepare_enable and clk_disable_unprepare should
> > check input clock parameter is NULL or not internally,
>
> I find this change description unclear.

    clk_prepare_enable and clk_disable_unprepare check the input
    clock parameter in the beginning of the function, if the parameter
    is NULL, clk_prepare_enable and clk_disable_unprepare will
    return immediately.

    So Don't need to check input clock parameters before calling clk
    API.

Do you think this commit message is better?

best regards
wang shengjiu
