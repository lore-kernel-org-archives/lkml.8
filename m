Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A186C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E852E21741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dv4MZUYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgHZOyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgHZOyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:54:32 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5899C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 07:54:31 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id g11so648003ual.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 07:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uMUsAzrt4TI19w2Cq60GN2aXgQIdXvc8FuMeNUtVglE=;
        b=dv4MZUYXkGeHUaa9XtV4J0egU16hKnMN/WsnKFJFHs+NOkqv7yzfRXMbLsAClOITmQ
         /joaOoQ3o83HikVzSTz7JEdMOKm74mpnUQTnGF18au4nmhUGEmJljSENovzcxCSbE9o2
         eFqylNdvAFUBuemiw43omuZGmxt5XFTW3/LNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uMUsAzrt4TI19w2Cq60GN2aXgQIdXvc8FuMeNUtVglE=;
        b=jpR/i2mWNugLujHOQGSgH7ToRPK6Blmjzu6zd9RxDkuBLm2nbEVKEzMe32hUFeFy9N
         YVAGPTfZ7q/xE0PapOdZTSr9B4ZKlUGWRItC8CIoEoWkqN20HK/h0x8hDerxAC28ycRE
         VgPkrhRjtp4AOSGBd6+jwdYy9Y8zxR21hDJiZ2WblrgSRLiGGnQm2vtDlajoQYerlxCE
         3D/TWopbUs5xhXHlZrf7687x8bQ6bMOQ0fqH+qjiZ/lIgz51zlKV0Rlwty/K09WZJLR/
         fpXA2qUJ0miP3Qhj5Oc0G/FNzbl5t0edafjMd8fa3znXvjEycibeXITbD/7BZPPmihgt
         ur+Q==
X-Gm-Message-State: AOAM533IkcFM3F64ePuKnt4JMAr2/jNwmYhe8ilFlECtyHPEJ2iHTJEO
        M6CygfDM1FZ88njKNRQRPky4nOM08k0wYw==
X-Google-Smtp-Source: ABdhPJzLv39pPaPVbkD5TpjL1lNjiN5QdNcFBGiY4J4iTT/jjRQgJ68AFMt78uQOGXm+JA1yFKvThQ==
X-Received: by 2002:ab0:6453:: with SMTP id j19mr8994130uap.134.1598453670111;
        Wed, 26 Aug 2020 07:54:30 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id g127sm354143vsc.5.2020.08.26.07.54.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 07:54:29 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id a13so1075653vso.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 07:54:29 -0700 (PDT)
X-Received: by 2002:a67:1e47:: with SMTP id e68mr9364977vse.45.1598453668950;
 Wed, 26 Aug 2020 07:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <1593193967-29897-1-git-send-email-pillair@codeaurora.org>
 <CAD=FV=V_ynwukeR92nbJXkuQ7OAW4mLaTjxko7fXt5aEfDUNhA@mail.gmail.com>
 <CAD=FV=XJDmGbEJQ1U-VDuN2p0+V+uRm_1=DwBnDPmPQsXqS4ZA@mail.gmail.com>
 <CA+ASDXNOCFZhdNMDk9XTuC2H+owQ0+wHipDbkJAGnU9q7BXz_w@mail.gmail.com>
 <871rlcx8uv.fsf@codeaurora.org> <CALhWmc1PbTKhrkaPn9yfpx3gZHAMuR-bPY=4_o4wQHv_H5D9dA@mail.gmail.com>
 <CALhWmc3i9Z+KiG1cJNvpSWNsiFhOa5jBw=XfcFz_gKwi_5QibA@mail.gmail.com>
 <CALhWmc1B0+SONV6_AF+nUzgxZdekPD3sZuhrsmwVQx1Q-cgT_g@mail.gmail.com>
 <CALhWmc0qF5stKRcikjwbeFmE-32hNCDazgQdqTMidUyt7u-T1Q@mail.gmail.com>
 <CALhWmc0JtQZE5CfLPb1WnwhE9wCYsjE-53kYWbwtFCs1k7FrCQ@mail.gmail.com>
 <CALhWmc11OefTh6Ov5GqP-yHMVTUO4r9CxqkdHT1F3yzor72v7g@mail.gmail.com>
 <000201d65f51$83d2ac60$8b780520$@codeaurora.org> <877dtlcvs1.fsf@codeaurora.org>
In-Reply-To: <877dtlcvs1.fsf@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 26 Aug 2020 07:54:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XMPZhS6NHGcxTu5DWbsg5PvL=8Je2JyQF=zX-hY3R0Lw@mail.gmail.com>
Message-ID: <CAD=FV=XMPZhS6NHGcxTu5DWbsg5PvL=8Je2JyQF=zX-hY3R0Lw@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Add interrupt summary based CE processing
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Rakesh Pillai <pillair@codeaurora.org>,
        Peter Oh <peter.oh@eero.com>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 26, 2020 at 7:44 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> (Guys, PLEASE edit your quotes. These long emails my use of patchwork
> horrible.)
>
> "Rakesh Pillai" <pillair@codeaurora.org> writes:
>
> >> -----Original Message-----
> >> From: Peter Oh <peter.oh@eero.com>
> >> Sent: Tuesday, July 21, 2020 7:03 AM
> >> To: Kalle Valo <kvalo@codeaurora.org>
> >> Cc: Brian Norris <briannorris@chromium.org>; Doug Anderson
> >> <dianders@chromium.org>; linux-wireless <linux-
> >> wireless@vger.kernel.org>; Rakesh Pillai <pillair@codeaurora.org>; ath10k
> >> <ath10k@lists.infradead.org>; LKML <linux-kernel@vger.kernel.org>
> >> Subject: Re: [PATCH] ath10k: Add interrupt summary based CE processing
> >>
> >> I'll take my word back.
> >> It's not this patch problem, but by others.
> >> I have 2 extra patches before the 3 patches so my system looks like
> >>
> >> backports from ath.git 5.6-rc1 + linux kernel 4.4 (similar to OpenWrt)
> >> On top of the working system, I cherry-picked these 5.
> >>
> >> #1.
> >> ath10k: Avoid override CE5 configuration for QCA99X0 chipsets
> >> ath.git commit 521fc37be3d879561ca5ab42d64719cf94116af0
> >> #2.
> >> ath10k: Fix NULL pointer dereference in AHB device probe
> >> wireless-drivers.git commit 1cfd3426ef989b83fa6176490a38777057e57f6c
> >> #3.
> >> ath10k: Add interrupt summary based CE processing
> >> https://patchwork.kernel.org/patch/11628299/
> >
> > This patch is applicable only for snoc target WCN3990, since there is
> > a check for per_ce_irq. For PCI targets, per_ce_irq is false, and
> > hence follows a different path.
>
> This information should be in the commit log. But I have a patch in the
> pending branch which removes per_ce_irq:
>
> [v2,2/2] ath10k: Get rid of "per_ce_irq" hw param
>
> https://patchwork.kernel.org/patch/11654621/
>
> So how will multilple hardware support work then?

In theory my patches and Rakesh's patches could be squashed.  His
patch made things marginally better but still didn't really address
the root cause.  When addressing the root cause, I ended up deleting
most of the code that he introduced.  I think it'd be fine to just
apply all 3 patches (Rakesh's plus my 2) and the end result will be
good, but if desired either Rakesh or I could post a squashed series.


> In theory I like the patch but there's no information in the patch if
> this works or breaks other hardware, especially QCA9884 or QCA6174 PCI
> devices. I really need some kind of assurance that this works with all
> ath10k devices, not just WCN3990 which you are working on.
>
> I have written about this in the wiki:
>
> https://wireless.wiki.kernel.org/en/users/drivers/ath10k/submittingpatches#hardware_families

The end result is that it should only affect "wcn3990-wifi", which is
what this was tested on.  Specifically you can see that "snoc.c" only
includes one compatible string: "qcom,wcn3990-wifi".  You can also see
that the only place that has "per_ce_irq" set to true is
"WCN3990_HW_1_0_DEV_VERSION".



-Doug
