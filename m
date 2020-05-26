Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F139CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5661208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgvely/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404044AbgEZUw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 16:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404010AbgEZUwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 16:52:55 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C081C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 13:52:55 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p21so10628302pgm.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 13:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5I2hn2Gk7YS7ZyJinmSH1ekt14dXnz61kMHW/CzJYGI=;
        b=lgvely/SxEXaS3BMmX1MjOiEviMZbVKq/GONEWEqz6i7dkTjGv4OAlFZlqGZ7Q0+wV
         8veoY8oarMh7tEB/5WUFfeiiP4n7VE/BYMQRRCfdVDUW7+o/neqqiq3F6Hf0IzhCzwsf
         6FXX8pcmpwJaWyjJg5Qb1zvP7RTxBARiTdaws6QjOMIjeYqdXYWhff778GN0+2wrKowh
         jZZC/Hl9n12OLhIKO6XcktIML92w7u6VrXad2pWVDmMZbzXZajCPVjkEEKmejaW9AI0y
         0eJUp/q9nwBBASnfjJ6Etc95/Stp0SEkwgysQSFcjVP4B+RkodeLtgQZNN3ieRdBNHy/
         y1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5I2hn2Gk7YS7ZyJinmSH1ekt14dXnz61kMHW/CzJYGI=;
        b=CPTbkkvoMHhHZ8sveoQzCqYKE1l297uxLAd9RPcPY+0/FvHh6DpH8zlASueTC7hgGd
         fvQaZd0wunCRUXXn+O7r7sVrle5jXjPLZbFfiBjp0XQRMPHzXKcF0jp0eDuOWYfUyLxj
         dsOZU8zPBUjDtDDrY+6dxhcicueQuKC3aJvtZq4lafSAvttouVlFoBXa78NFqszzfaPA
         776c0Ut9MXrmYFHoH4mIiwfVJE0UH8B0OSjyCeUJ3RUVpyKS36Px1Ik3mGhvTIKxfoFw
         8zb9WwaFquoRPiokSI6dRbqLI8uGPzhUv6EgT1zxVF+o39+6M4OV2l3ETriXA3UpsJtU
         tvWA==
X-Gm-Message-State: AOAM5312f2q3BptRnzkRa1Yhz7zewVrpweOImM3IaYNagBbHcq6EQkVP
        dvM+JijqBMgGlUIP3T+m+3ZmZbM1
X-Google-Smtp-Source: ABdhPJzRHkpHW2cRAQLk69i1Jo1A2qvttqX+/6C3Hk6E98hqWuHA827JH/rvb7nUQEE4SZA4JyT6PA==
X-Received: by 2002:a63:9556:: with SMTP id t22mr632025pgn.83.1590526374755;
        Tue, 26 May 2020 13:52:54 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id y4sm375056pfq.10.2020.05.26.13.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 13:52:54 -0700 (PDT)
Date:   Tue, 26 May 2020 13:52:52 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] phy: intel: Eliminate unnecessary assignment in
 intel_cbphy_set_mode
Message-ID: <20200526205252.GA2607849@ubuntu-s3-xlarge-x86>
References: <20200523035043.3305846-1-natechancellor@gmail.com>
 <CAKwvOdn5R0md+9jVGrzQhR4ZfcSWsCqPE9qK2UxMDOKnWnpaKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdn5R0md+9jVGrzQhR4ZfcSWsCqPE9qK2UxMDOKnWnpaKA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 11:12:58AM -0700, Nick Desaulniers wrote:
> On Fri, May 22, 2020 at 8:51 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns:
> >
> > drivers/phy/intel/phy-intel-combo.c:202:34: warning: implicit conversion
> > from enumeration type 'enum intel_phy_mode' to different enumeration
> > type 'enum intel_combo_mode' [-Wenum-conversion]
> >         enum intel_combo_mode cb_mode = PHY_PCIE_MODE;
> >                               ~~~~~~~   ^~~~~~~~~~~~~
> > 1 warning generated.
> >
> > The correct enum to use would be PCIE0_PCIE1_MODE. However, eliminating
> > this assignment is a little better because the switch statement always
> 
> Indeed, the switch is exhaustive.  Might be a risk if new enumeration
> values are added to the enum, though.

Clang will warn about that (and since there is no default case
statement, that would point to a bug).

> Probably should just initialize it to PCIE0_PCIE1_MODE, then you can
> simplify the PHY_PCIE_MODE case a little (replace ternary with
> if+assignment).

I did consider this but every maintainer has their preference around
initializing local variables at the top versus close to their usage...

I do not really have a preference for what happens here, I'm happy to
rework the patch based on maintainer feedback, thanks for the review!

Cheers,
Nathan

> > assigns a new value to cb_mode, which also takes care of the warning.
> >
> > Fixes: ac0a95a3ea78 ("phy: intel: Add driver support for ComboPhy")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1034
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/phy/intel/phy-intel-combo.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/phy/intel/phy-intel-combo.c b/drivers/phy/intel/phy-intel-combo.c
> > index c2a35be4cdfb..4bc1276ecf23 100644
> > --- a/drivers/phy/intel/phy-intel-combo.c
> > +++ b/drivers/phy/intel/phy-intel-combo.c
> > @@ -199,9 +199,9 @@ static int intel_cbphy_pcie_dis_pad_refclk(struct intel_cbphy_iphy *iphy)
> >
> >  static int intel_cbphy_set_mode(struct intel_combo_phy *cbphy)
> >  {
> > -       enum intel_combo_mode cb_mode = PHY_PCIE_MODE;
> >         enum aggregated_mode aggr = cbphy->aggr_mode;
> >         struct device *dev = cbphy->dev;
> > +       enum intel_combo_mode cb_mode;
> >         enum intel_phy_mode mode;
> >         int ret;
> >
> >
> > base-commit: c11d28ab4a691736e30b49813fb801847bd44e83
> > --
> 
> -- 
> Thanks,
> ~Nick Desaulniers
