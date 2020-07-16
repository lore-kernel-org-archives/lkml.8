Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDC5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 04:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 108432071B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 04:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6awRv9s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgGPEtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 00:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgGPEtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 00:49:15 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683EFC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 21:49:15 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id l6so4392124qkc.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 21:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xx24gMtqvTtf4HuF/EbOVN4ZFpQ4/y2jI0UB6sU6PdA=;
        b=V6awRv9swXVxyw87nwwxAT0Hl7BJuF1gsHXns0hlPDgJ3zxcCOJNEv4Pqn+R6lLQXe
         v5cO03vJ6JC1b2vLliuE27+n6Bql6ZGiMW9SesX2Jz1bN0yZ6PfBJdcPlMQRFy4f/ze5
         uWOeM/3f3rvOJb+DBzpD4luO2nPdAAwMk/E5r9RbxN8Vt6XazlHeX5ZZekkE9OsXyMOe
         PWplfHi9Ey2rKkAF8AKSBpeFBy+BeoUJKeyjiyzBtkoNYuW3ORijcodKkEOLt3mNtDT8
         hDs8gVdMAHmywX7UIhzUoGD8k+NDUNUrCswey5ACb7UJ9Gpzt2Fo1pKcvTdHAoFmGanJ
         ZHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xx24gMtqvTtf4HuF/EbOVN4ZFpQ4/y2jI0UB6sU6PdA=;
        b=UGuq2tonpknY/8h+zDFwPio5iSiR5hkKyi0llM8TcLU//wOYN8EOTl0sEccR/pQuHF
         xJP8n7j8WU8FjjTCdlAQT88oRpaW4z31pYYHnwzcP7tjK7j5dj1ezlcdDZe8QussmGaf
         VFVpm7CFoggpMhf28LjWZCIN5c0+2zaMOrBY9Ui4xSI9HbBYQ8wAZht6CsGYNKWmwoIe
         RCbNfHP8wmhrNs3l/Lzibiyiyr49W4rqVnu2py3jG/EzZSkbpfqce4+5T/yLN9LMu5el
         Nt2cmUcHFADU6M/xvLUsQOQrE3+VLV5iQ7feIgK7uWIXM+TzWbE7LMupSHBlIUlC1FZr
         noOg==
X-Gm-Message-State: AOAM53120DO+NVCi6UYWwO0p/+iDuOHi7L38HbrbnYNoBIAM5H0D4UM3
        UfJd1ZhP/GaJRCDI1oYP50QWDB2PPS6z3AjIjiA=
X-Google-Smtp-Source: ABdhPJxoXcUYZVT+9qi7K3c3hJEUT9Rario97Q0An5IWeSreYrlbuihMsUlvUArYbBREACQ1PlALrL1JnIJBpxIrZ6w=
X-Received: by 2002:ae9:c010:: with SMTP id u16mr2207177qkk.37.1594874954633;
 Wed, 15 Jul 2020 21:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <1594871563-30088-1-git-send-email-shengjiu.wang@nxp.com> <87sgds2ixs.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87sgds2ixs.wl-kuninori.morimoto.gx@renesas.com>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Thu, 16 Jul 2020 12:49:02 +0800
Message-ID: <CAA+D8ANH082mozu+SSsQShAzpfF8=vm_tgyPe0gERb4JsJ-sqw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: soc-component: Add missed return for snd_soc_pcm_component_mmap
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        ranjani.sridharan@linux.intel.com, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 12:19 PM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
>
> Hi Shengjiu
>
> > Add missed return for snd_soc_pcm_component_mmap, otherwise it always
> > return -EINVAL.
> >
> > Fixes: e2329eeba45f ("ASoC: soc-component: add soc_component_err()")
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
>
> Oops, indeed.
> Thank you for the patch.
>
> But it seems these functions are also missing "return"
>         snd_soc_pcm_component_new()
>         snd_soc_pcm_component_sync_stop()
>
> Can you please care these, too ?
Ok, will send v2

best regards
wang shengjiu
