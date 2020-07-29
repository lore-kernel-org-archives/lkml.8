Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD8DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1100B2075F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LNxPwbmW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgG2TTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 15:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2TTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 15:19:38 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E008C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 12:19:38 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k18so6241364pfp.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 12:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=In/D8z7gXollo69UOvFLAqKOH13VGluD7VCN2My2HlQ=;
        b=LNxPwbmWGNwoKFWOhWj+aic4gew6jbzuSQoWMCIW9H3Bu4L9ERufl8BuSoq4xKURew
         6YtlzSH4znGguD72XRJPXxpiJSwjSTx2PFtdX0hVaxffUFlSxmk66dN5xrMOTr36xF13
         vCZFLASN9sUauLJWKZr72/6Tj3uGsr8VyvPbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=In/D8z7gXollo69UOvFLAqKOH13VGluD7VCN2My2HlQ=;
        b=I1rvC3/8qIN/VwLt8T5RRZ95fM9v8KdVlJSSdbPw4NAemU107aP01KGRuRecaQHMsG
         k1YEHffl78ZqIa/ZA00ygIlzkYHBGPP4vciYBHHv+UIccuU3Vmi1nlETtPUIhyjC/a08
         VaWJN7ymMDiBfhdUk75T3zx7Vib087AX8QEzgfGhfkHEih4VufK41pe5eBOlltTVGL2G
         Qc2VvUlANiqtuNtDm1Vqiqkeo0P7TXvbwUoUDGOml+X0cCeezb7/c6T9/uTn2nXTl2Ya
         oQc4gRnWWFYmPNHE4qSHmMOVJ3Q0lwLKG38krRWPJUa5XpN7AFXzeP6y6W8A0bsbMLZ+
         zzng==
X-Gm-Message-State: AOAM530jMSILV7aHtszKZDR5kYMsrAyw3TiYlRse1OdooTQNbTVAaK1x
        kW+WonuHws2bT6rd+kXhZon7A95QPoc=
X-Google-Smtp-Source: ABdhPJzqnH4uuQ8Tg6K+0tUON2W91DHVjKrpN7yvvLhVnzAdDTcIF8VPsDlQt2A3jI4YlO70HoOINg==
X-Received: by 2002:a63:f254:: with SMTP id d20mr31037862pgk.119.1596050378022;
        Wed, 29 Jul 2020 12:19:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g8sm3197436pgr.70.2020.07.29.12.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 12:19:37 -0700 (PDT)
Date:   Wed, 29 Jul 2020 12:19:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>
Subject: Re: [Intel-gfx] [PATCH v12 2/3] drm/i915: add syncobj timeline
 support
Message-ID: <202007291218.E129CEE@keescook>
References: <20200708131751.334457-1-lionel.g.landwerlin@intel.com>
 <20200708131751.334457-3-lionel.g.landwerlin@intel.com>
 <CAKMK7uFkMKiwyTFMRASk5L=1NdFqeuKfCh_FHRLg4FxzHpXpfw@mail.gmail.com>
 <CAHk-=wjD-6phO85fvLMt7rvk5ZwaJ1Q5Zor4urYps6C8vG_Txg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjD-6phO85fvLMt7rvk5ZwaJ1Q5Zor4urYps6C8vG_Txg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 10:51:23AM -0700, Linus Torvalds wrote:
> On Wed, Jul 29, 2020 at 5:24 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > Do we have a access_ok_array or so? Instead of duplicating overflow checks
> > everywhere and getting it all wrong ...
> 
> I really really think you should get away from access_ok() entirely.
> 
> Please just get rid of it, and use "copy_from_user()" instead.

Yes please. :) It also makes code SO much easier to audit (both
automatically and manually).

-- 
Kees Cook
