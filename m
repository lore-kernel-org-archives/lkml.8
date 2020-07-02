Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17137C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC9AB2075D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sm2IOQme"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgGBVq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 17:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgGBVq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 17:46:56 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E861C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 14:46:56 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id d17so19446174ljl.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 14:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wEWLJugUEoJF13EVG36TIW/5jfa4TRoxlnl+tX/Wn14=;
        b=sm2IOQmesVWJ2z0ORa2TSdnYdjJIGzToARHSUN1fhHU3JQH4rkm/9yUzqJe18MjgRO
         cEfd9xFFw94U9bfjx/6tCrVEw+YDC25KG3GqUB+h+ESGVBxgaP8AdZSSX2IMS/OjIiYE
         jD4v7Y1Y7biuhhoMmQPttanmkCj97ERsYN5jC+NQHkuSXZ7cQUUSm/iWRn1nFaxgXIjL
         h7uDrGbnQ4rawQoaUIYFheBUEuwy8/ODC9Pi2eqLqx9I9he1VSRmTP+fZZIN63A2f9pj
         3LL25C9HRCgceLBWY/9UXCtL99epNMGZNvJovRC3HKKIHoIANYTepGWuX9bPeeDVX7fs
         Y08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wEWLJugUEoJF13EVG36TIW/5jfa4TRoxlnl+tX/Wn14=;
        b=bOXpdvxBdJGJsbepXA69uzeA9sPLOhC2gdTaALAZRcFWyoDBZo6ePVloUbIybObgH8
         RUwdi2Ib5ZqAjnBwtXWrm3dhMeOSLjpdgmIbSzN3gpz+eNnPbbWF0D8Jzr3lbd/L4FC6
         yOfhUPelMOabip9k6+H6JfibIFOCag55W7uKTPWN8+AEpZlOc6tAW5sd094bs+oBdjC6
         aE1q1lyYBwtMgSsYpBWGHYu7wM4udY4W58xATrDQjwJAeO3zYVa8Wasw/L/5RUE/Im9p
         i/Cvh07PHLmh+9nVGryI1c2pf2Zsx/MpnEsuV4SoCVCje1CRs61k4q/7N1bVQJHkFGOC
         2DNg==
X-Gm-Message-State: AOAM530BM0p7ogOO7UWMRsbsmGbLMrIVqQDSDZ93ATLuWVYVZvydcdHb
        CRLvKWujLaSRgQKkgXTyNvK9W2Ic37vPy8stRu8=
X-Google-Smtp-Source: ABdhPJyiO67FouY0jlSz55/tgTo3v5o4FPE/8mfJyTgmhx7uN6BdSgCL6JlgSdYfOLxyZadGIa83ykMwT8pYWiLh6ms=
X-Received: by 2002:a05:651c:200f:: with SMTP id s15mr4716908ljo.125.1593726414677;
 Thu, 02 Jul 2020 14:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200702193102.25282-1-nicoleotsuka@gmail.com>
In-Reply-To: <20200702193102.25282-1-nicoleotsuka@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 2 Jul 2020 18:46:43 -0300
Message-ID: <CAOMZO5BveOO3wNpGYbqDyQ290wNE3Xp5X_jXkvcDdP8iytRZiA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Shengjiu to reviewer list of sound/soc/fsl
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Xiubo Li <Li.Xiubo@freescale.com>, Timur Tabi <timur@tabi.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 4:31 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> Add Shengjiu who's actively working on the latest fsl/nxp audio drivers.
>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> Cc: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
