Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D515C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 00:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C52D206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 00:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anholt-net.20150623.gappssmtp.com header.i=@anholt-net.20150623.gappssmtp.com header.b="j2JrZAWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgGGAvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 20:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgGGAvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 20:51:42 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B69BC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 17:51:42 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g20so36739451edm.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 17:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fP4OpLp0FjsIYxMifwNx7k+9nkUSsvv31ikh9HglHIY=;
        b=j2JrZAWlwruxerUFy6eYB7r/b1mBHmiLW+tOmUbIJ6oIXT79vVI/tddFTHoQqA/Dag
         rjKhpQqSsxsj79lP9td1HcHxhkVvqTbZyMu48pEGRTfEf2yuqs8Td7KOtlyzYNOKQGkF
         FQ1ah6AkelWrfLcHEGS18zqKSL3HJ8vkSVaBiDFcK+L7Nl+nQbxs/CZ0W7RiQF1H1urJ
         fwuLjrYyYSOw2TtMlD1lnj01RwHdCXmUU4cIA7QbmZDU9kGef5FVAHH9X7oWkHxfjbbz
         cYrA5UiQqdYa6JRuXQy5WLFuuR/gudReKjl8b5QAANlchWmmAPaQAphPqomY8QuId3bw
         8miA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fP4OpLp0FjsIYxMifwNx7k+9nkUSsvv31ikh9HglHIY=;
        b=d336N2rXv8ZUTPF2bEZ4q3uDuEvM+MqVT5VAa5b98rACqOADlhfYxaFaRaauPFS/5h
         8Q1ZaXkHyx1rt5mZ0+ncF6jTdf0mb/5e9c8tO2IEBcvTN+V4MXlmfkQB3wtT3PxgmBQf
         jV1QC5++JW0vhhqVftYATnbJfaKHpqr0VDBbHf0GAFIR9j/lkCQMmN3vy85zU8CVQgfo
         p2zdqTdsbYKejBvQ8ekfrTFHOp4wWCvI/mTlqMbe3spf5WOQEA1rAIHpSfI7n9S6+nIV
         4DhC62I6FxG/wkBF5O3x8AxxAtMlPuFNMmUyVt8nNcR6OspmGmVejVXYCJijRp+VM6b5
         rQ1Q==
X-Gm-Message-State: AOAM531/p48OFPTPOs4GwXMujO0lMwtwkaylYW3ny+Mqnm3S0TM45kkx
        Pz8a+Y6Y+WR2pePgvpwAG8oDF0EZBD6JXnMXJDRwVQ==
X-Google-Smtp-Source: ABdhPJzp8OxMJ6XX57N3wsB50xwXQiNgeDUcSeD89047WHNDCTbtIajsV/i86EY+rHSRbixicaAeReheN7Jay3TZvaI=
X-Received: by 2002:a50:fe16:: with SMTP id f22mr52368626edt.315.1594083100783;
 Mon, 06 Jul 2020 17:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.c33f5fd8b1b2703081f25398eb879937c9f7ce0b.1591882579.git-series.maxime@cerno.tech>
 <20200630082509.puuzneiipalvrxup@gilmour.lan>
In-Reply-To: <20200630082509.puuzneiipalvrxup@gilmour.lan>
From:   Eric Anholt <eric@anholt.net>
Date:   Mon, 6 Jul 2020 17:51:29 -0700
Message-ID: <CADaigPXSaZ8K2m_fyq2dFwf-X76LpYMagjXqA01b0ST6QYzE2g@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] drm/vc4: Turn the TXP into a CRTC
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 1:25 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi Eric,
>
> On Thu, Jun 11, 2020 at 03:36:45PM +0200, Maxime Ripard wrote:
> > Hi,
> >
> > This is another part of the rpi4 HDMI series that got promoted to a
> > series of its own to try to reduce the main one.
> >
> > This rework is needed since the bcm2711 used in the rpi4 has a more
> > complex routing in the HVS that doesn't allow to use a fairly simple
> > mapping like what was used before.
> >
> > Since that mapping affects both the pixelvalves and the TXP, turning the
> > TXP into a CRTC just like pixelvalves are allows to deal with the
> > mapping in the CRTC states, which turns out to be pretty convenient.
> >
> > Let me know what you think,
> > Maxime
> >
> > Changes from v3:
> >   - Stripped the patches out of the main HDMI series
> >   - Change the bind order of the HVS to avoid a compatible check
> >   - Added Eric's tags
> >   - Rebased on top of drm-misc-next
> >
> > Maxime Ripard (9):
> >   drm/vc4: Reorder the bind order of the devices
> >   drm/vc4: crtc: Move HVS setup code to the HVS driver
>
> Could you review those two patches? You haven't reviewed them yet and
> it's holding back the rest of the patches.

LKML email workflow is the worst, the patches never came through to me
so I didn't see them until you linked me the patchwork.  Patch 2,
commit message should say "We'll need the HVS to be bound before the
TXP", but other than that, r-b.
