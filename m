Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25418C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED22920767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gi2e6zQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgIBOie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbgIBOiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:38:02 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1127DC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 07:38:00 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id s62so812109vsc.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 07:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TadnzZ2GBx4yX2HwMOimGbeZb2PcWtu+wm80cNcN0fQ=;
        b=Gi2e6zQsylDEwMGGD9uEtv0/zSfm3ttGeUD8jtFwieUhWNz0g3Vc3c3/fWdq3Jxcl+
         wc5w1QXNLwWb/D+NAQUk301/Aa9k7cL/XXJBR3Zfjxg9R0zUvZFColuIyLnXOKEftlar
         w/s11uKYBxNLykoVFCzrHIFXavzYRCaiEFZt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TadnzZ2GBx4yX2HwMOimGbeZb2PcWtu+wm80cNcN0fQ=;
        b=g6Oo3OlZHhpJ5DIVUZE1q78uszZ1Q/y6E1rlI4w5bkzGaqcvk8HWmrj/zP2wi9GOCx
         Vcw8AE0uAAwYyGH5pjEurPhdLZ/Wl4WQV1gjDDO5EU2on/VNSNpO9zgr2am2esm+/44/
         nKoZK6xDuhdTHeiTkiJUZSyV/t4HHrzUbE57lUxDZ7BnESXhS3bL3YO9YJahDtWeTOK0
         7CUlg98nHH90vlA54wAr1TdSze069nJJadaMUF4Hv2aQBFN4UbbWU6q6OJV0mFIDareu
         Dr5GCJTiL9fQquXNgufxmIH+t1zugVbERbKObcAnZDMBmGkqN05qyRrgF1IN5ApQvl5m
         hLHw==
X-Gm-Message-State: AOAM531iSsipPzV7D1qI9TTFo8g/xnUcF7yGNIlY85Xjd6/g2ruMWOOu
        axXJI8DwMP/LzZmPQL0iM/jqtTNRMToKMg==
X-Google-Smtp-Source: ABdhPJxdGZL2f7pBWPuPbju0r+syxe3T8o0uwj9ii9MXZUshTouHX9IjCPKB4Hd715LL58/89BtMAw==
X-Received: by 2002:a67:641:: with SMTP id 62mr5447207vsg.2.1599057479754;
        Wed, 02 Sep 2020 07:37:59 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id n16sm698707vsr.17.2020.09.02.07.37.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 07:37:58 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id u48so1642893uau.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 07:37:58 -0700 (PDT)
X-Received: by 2002:ab0:37d3:: with SMTP id e19mr5065664uav.64.1599057477726;
 Wed, 02 Sep 2020 07:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191218143416.v3.6.Iaf8d698f4e5253d658ae283d2fd07268076a7c27@changeid>
 <20200710011935.GA7056@gentoo.org> <CAD=FV=X3oazamoKR1jHoXm-yCAp9208ahNd8y+NDPt1pU=5xRg@mail.gmail.com>
 <CAD=FV=UWQsGit6XMCzHn5cBRAC9nAaGReDyMzMM2Su02bfiPyQ@mail.gmail.com>
 <dc786abb-4bc2-2416-7ee5-de408aceb8f1@kali.org> <e0702671-3bed-9e3d-c7f4-d050c617eb65@kali.org>
 <bc795659-7dd6-c667-1c93-4331510ecfbc@kali.org> <CAD=FV=VC+RP8WfS-yuc65WRN2KokNbAs-F3UdQtQoZjcMMSNFA@mail.gmail.com>
 <f81f0d22-85d6-66eb-c8d9-345757f53959@kali.org> <CAD=FV=WB_4xLe9UZX3eVemybQ1neXJVZgzrDCW-xUxbAM6hCTA@mail.gmail.com>
 <8e306b6d-246d-aa7f-cb24-923e13afcd04@kali.org> <CAD=FV=XeBLRc4v5K3vj=m9PGMuW8GVUq110ApX6xS2QaiJd=pw@mail.gmail.com>
In-Reply-To: <CAD=FV=XeBLRc4v5K3vj=m9PGMuW8GVUq110ApX6xS2QaiJd=pw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 2 Sep 2020 07:37:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W60u2Ck6NP_k8+V1oWY7FRXs4G3e49Lp+h7Zii14nVQA@mail.gmail.com>
Message-ID: <CAD=FV=W60u2Ck6NP_k8+V1oWY7FRXs4G3e49Lp+h7Zii14nVQA@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] drm/bridge: ti-sn65dsi86: Use 18-bit DP if we can
To:     Steev Klimaszewski <steev@kali.org>
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Steev Klimaszewski <steev@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 14, 2020 at 8:31 AM Doug Anderson <dianders@chromium.org> wrote:
>
> > Hopefully BOE gets back to you soon, and there's no rush, I'm just an
> > end user who is extremely appreciative of all the work everyone on the
> > list and the kernel in general put in to make my machines usable.
>
> Just FYI that I got confirmation that the panel is truly 6 bpp but it
> will do FRC dithering if given an 8 bpp input.  That means that you
> should be getting just as good picture quality (and possibly more
> tunable) by using the dithering in the display pipeline and leaving
> the panel as 6bpp.  Thus I'm going to assume that's the route we'll go
> down.  If ever we find someone that wants to use this panel on a
> display controller that can't do its own dithering then I guess we'll
> have to figure out what to do then...
>
> In terms of the more optimal pixel clock for saving power, my proposal
> is still being analyzed and I'll report back when I hear more.  I'm
> seeing if BOE can confirm that my proposal will work both for my panel
> (the -n62 variant) and the one you have (the -n61 variant).

To close the loop here: we finally got back an official word that we
shouldn't use my proposed timings that would have allowed us to move
down to a 1.62 GHz pixel clock.  Though they work most of the time,
there are apparently some corner cases where they cause problems /
flickering.  :(  While you could certainly use the timings on your own
system if they happen to work for you, I don't think it'd be a good
idea to switch the default over to them or anything.  I'm told that
hardware makers will take this type of thing into consideration for
future hardware.

-Doug
