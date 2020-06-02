Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B519BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91B462072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ErEmBwVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgFBSgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 14:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgFBSgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 14:36:00 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BB0C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 11:35:59 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id h188so6795972lfd.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 11:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ijFpZRjwoX99ihI6aAs0JBxKZ+/9IGA5AcjqDRRxjVE=;
        b=ErEmBwVZMzkC+6G17Sf/f4on+HIvZSZ8AKzHtw2WN/e8HA2YTsmF9nWW8KKw3DJLKe
         me5TqmdmNjfI5P78MUGsnW7a7Dii5HwIzqYhuYskjDyatp9sbSa71pmV8MU+CKmoKMWS
         kqSzc5ZAe9uDm/UNtKVFJjB4LyNBB/Ms7PbzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ijFpZRjwoX99ihI6aAs0JBxKZ+/9IGA5AcjqDRRxjVE=;
        b=mfduqDD/GDaF6RiKBVUWTCzajIE+gaYCwMJ2LAlO+JiqK2SyBx9gCG5Q11YZrCvJSO
         ti58uO7IgkAniyHrn9Eh6sC8NqmsQ+OzAGYK5czZXp3nTwFuQU+l41C3YXOfRum8+5XJ
         7heIMJ5nv5wu0zT3FZgJJwo1ACuzTRMopW344h8j2sGbvyIWsO5e3kF0RnEg1gyJfF4e
         bTJRJZcYGh54tnOm0NhKPaAiU3dN3v82tn7q9T0ObYs1Snzs0i86fkpPZIhRp+wDhoAD
         8rVILWjES+MwBZW8r18WyvHVC53g5go2iVmptV9WOzPkOI+u7xbakXyS1nakxwETgndo
         JyTA==
X-Gm-Message-State: AOAM533Vj43hagG/hrPvnrpOApYx8bOO7lAeJI2f94CgOPg9r9E5/y5x
        f8nV2inAqhIoaOSvxATo5PIf4LIBdFA=
X-Google-Smtp-Source: ABdhPJzNArPaYmcxaafaQIHDLTW65fx0qFVb+l3+QIMAdIn0VO0uCZ+5iTTGO8X0eXDL2QTb0WgstA==
X-Received: by 2002:a05:6512:3208:: with SMTP id d8mr376495lfe.38.1591122957713;
        Tue, 02 Jun 2020 11:35:57 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id z2sm803273ljh.72.2020.06.02.11.35.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 11:35:56 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id u16so6794508lfl.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 11:35:56 -0700 (PDT)
X-Received: by 2002:a19:4acf:: with SMTP id x198mr353040lfa.129.1591122955826;
 Tue, 02 Jun 2020 11:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200527165718.129307-1-briannorris@chromium.org>
 <CAGRGNgX5n=0OEi7hMrmgVZGD=orGpgvkyLrhmXVKSFYdBJ+eUw@mail.gmail.com> <CAJ-Vmomx0UFEa1w2HsGMQsZb+K8hyK=Zz9cKSo7tHv5GiMc1yw@mail.gmail.com>
In-Reply-To: <CAJ-Vmomx0UFEa1w2HsGMQsZb+K8hyK=Zz9cKSo7tHv5GiMc1yw@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 2 Jun 2020 11:35:43 -0700
X-Gmail-Original-Message-ID: <CA+ASDXNicJmAKvkjD5mGFVQ+bmz8nHT_A1oqtjoS=spRSFP70A@mail.gmail.com>
Message-ID: <CA+ASDXNicJmAKvkjD5mGFVQ+bmz8nHT_A1oqtjoS=spRSFP70A@mail.gmail.com>
Subject: Re: [PATCH] Revert "ath: add support for special 0x0 regulatory domain"
To:     Adrian Chadd <adrian@freebsd.org>
Cc:     Julian Calaby <julian.calaby@gmail.com>,
        ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Wen Gong <wgong@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 8:42 AM Adrian Chadd <adrian@freebsd.org> wrote:
> On Thu, 28 May 2020 at 05:02, Julian Calaby <julian.calaby@gmail.com> wrote:
> > On Thu, May 28, 2020 at 5:18 AM Brian Norris <briannorris@chromium.org> wrote:
> > >
> > > This reverts commit 2dc016599cfa9672a147528ca26d70c3654a5423.
> > >
> > > Users are reporting regressions in regulatory domain detection and
> > > channel availability.
> > >
> > > The problem this was trying to resolve was fixed in firmware anyway:
> >
> > Should we tell the user their firmware needs to be upgraded if it
> > reports this regulatory domain instead of completely dropping support
> > for it?

I'm not really sure how to do that properly in general, and I don't
plan to do so. I'm simply reverting a change that caused people
problems, and noting at the same time that the original problem was
resolved differently.

I don't really have a stake in this patch, because everything I care
about works correctly either way. (And AFAICT, any hardware that is
affected by this patch is somewhat broken.) I'm only posting the
revert as a community service, because Wen couldn't be bothered to do
it himself.

> Also that commit mentioned a 6174 firmware, but what about all the other older chips with a regulatory domain of 0x0 ?

My understanding was that no QCA modules *should* be shipped with a
value of 0 in this field. The instance I'm aware of was more or less a
manufacturing error I think, and we got Qualcomm to patch it over in
software. I don't think people expected anybody else to have shipped
modules with a 0 value, but apparently they did. I don't know what to
do with those, other than just leave well enough alone (i.e., $subject
revert).

> As a side note, I'd /really appreciate/ if ath10k changes were tested on a variety of ath10k hardware and firmware revisions, rather than just either the Rome or embedded radios, rather than also including peregrine, cascade, besra, etc.

Wouldn't we all love it if everybody else tested appropriately. But
Qualcomm folks can't be coordinated (trust me, I've tried), and apart
from things like KernelCI (which so far has no WiFi tests, IIUC),
there's no community testing efforts that don't involve
"${RANDOM_PERSON} boots ${PERSONAL_BOX} and see if it blows up."

This also might not be the best place to admit it, but I'll be up
front: I have no idea what peregrine, cascade, or besra are.

Brian
