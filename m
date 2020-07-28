Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640FEC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 21:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 384392065C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 21:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V5MukAfm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbgG1V3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 17:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgG1V27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 17:28:59 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E69C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 14:28:59 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k1so691509pjt.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 14:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=kPGoT8s13omTFNLCI8y7UaQObCEr5Pzu6OocwkPR56Y=;
        b=V5MukAfmPZeP4aIDTIhSue8ndeaeyGkhpdAHPu2hyKKHhOzb1iz8DoClfumxbPXtlV
         N93kujMyBKOCP/idEO/LXjf4GNbna4zE7cgBq52Jv35fyyxO7u7YAofQNnubN9m7mW+A
         oaA9D09fzYr3DaRrgaHZdqjAF6ClKK4d6Pxqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=kPGoT8s13omTFNLCI8y7UaQObCEr5Pzu6OocwkPR56Y=;
        b=YnOBjL70nuDNt6Ps59Dq/NQPP9q1XJSkTJ92KwZYzZBBOACBC7KG4x/OoCxwGh9AxJ
         a0mFbAnwIPiXndGUd770X6k2/VOtcly85f9zo7sjFGKO0z0C5vUfpPaexA121SjZ6GZ1
         lLobsJ8yboA3lnflbj0Tufrz2KHHnFcjaN5+pq760AsKyCmung9l9HgKn+tDNg6aQYr4
         GSu1mjp/zvrwSDl265Ie51WkreajtcPpvKDRSoMVDGE6jz23IpthN4oMMUknsO9vw4VZ
         j8fz7scoqQkg7SwpIn2SYcaj0YGpj7R6xDy73GuaWpTOB/kG67BffEu2R9IUuGPpzH/Q
         STtg==
X-Gm-Message-State: AOAM530YZ0apyugnA4Xt7fj/DpQDi3dW/iDq8z5+ft04Ppdae146Kp7f
        oVN79mSNJnYC0OTc7+FmapLHqg==
X-Google-Smtp-Source: ABdhPJy0cOg/GfVtiku/hOfqRfko3DsvECjRR2zpYmFdCae290d7JSv7mlpJxoudN1Jln3ld6Y2Nww==
X-Received: by 2002:a17:902:b58f:: with SMTP id a15mr25193175pls.87.1595971738617;
        Tue, 28 Jul 2020 14:28:58 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id t1sm18950308pgq.66.2020.07.28.14.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 14:28:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHcu+Va0DVm1Pw__jYF_EhZHSQnSqb_zex2NN1M67zc=FTAitA@mail.gmail.com>
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid> <20200728151258.1222876-1-campello@chromium.org> <20200728091057.4.I33c50453845a8167969130d514af86e573b6ef31@changeid> <CAHp75VcRBCmRdGh5WVGDY28AzNhBufkoNkrEZ7uEFCW2MsJ=qg@mail.gmail.com> <CAHcu+Va0DVm1Pw__jYF_EhZHSQnSqb_zex2NN1M67zc=FTAitA@mail.gmail.com>
Subject: Re: [PATCH 04/15] iio: sx9310: Remove acpi and of table macros
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Campello <campello@chromium.org>
Date:   Tue, 28 Jul 2020 14:28:56 -0700
Message-ID: <159597173651.1360974.12339018912922779958@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Campello (2020-07-28 13:47:15)
> On Tue, Jul 28, 2020 at 12:09 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Tue, Jul 28, 2020 at 6:16 PM Daniel Campello <campello@chromium.org>=
 wrote:
> > >
> > > Avoids unused warnings due to acpi/of table macros.
> > >
> >
> > At the same time I would check if mod_devicetable.h is included.
> I did the following and no error showed up:
> #ifndef LINUX_MOD_DEVICETABLE_H
> #error Missing include
> #endif

That's fine, but it's usually better to avoid implicit include
dependencies so that order of includes doesn't matter and so that if the
headers change outside of this driver this driver doesn't have to be
fixed to include something it needs like mod_devicetable.h
