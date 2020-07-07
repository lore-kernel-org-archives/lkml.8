Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281FBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 04:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 029AD20722
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 04:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="aQAWV/vp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgGGEJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 00:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgGGEJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 00:09:10 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ED5C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 21:09:10 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id l12so45127150ejn.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 21:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kd+hagxNLahxDCtppBjRUEK5tAfJnWOu81ahPEztSaE=;
        b=aQAWV/vpjJSXXFpPeSnG+kfh7lIyxfzTTwOYdEKW7QlmmS2VKBfdIeF9N2k88UppGc
         VH/DtzoShRTBp3M4emxE4DHRfm7n7p8p3/C8PU0P5jGTZfgfm9jXg406VhS5VuV+OyyG
         Vfgukri/R8fDyfCAW6m2Htts6MpWlzgluu7z5SNlK+8B8f6+vPR+6WLXT+H21/4hreMU
         3txu3qWPmln0t3uT6YlhutbWPcYqglkwIxNM9z3hrcH5sRnaj9Q6CQR201CUAV9n0yr9
         Tp8f2TzWiK1jcBSaBsZK9aQlMFsuAc7G2hjnbVFnPRDegUd6Z0WtMk280LPV+oIkNjNb
         0TfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kd+hagxNLahxDCtppBjRUEK5tAfJnWOu81ahPEztSaE=;
        b=DBtHrIJ+Itlz0G1Ti+bMshj1qnqIP9Q0cWugWbW8UGN5lCYZHKb75/zIGxPnxbJ5E8
         QZn/XJZxYpGUkbfAJRUqCICP5WdkTHGOIsmmhigpuChg1N5EApErKi1U/CHa/ikLPDOX
         VzQSwxo/UHi/WiKUtkLA95v24pnE4vQcoQWt7t+Ogq9Fl2Bfe54B97t770ER5Ta7TSqe
         giuJrG4I9qL/06vuziettYcBLASK2R8ddjKHe7mFjwhW6uFt803Odgqytv1ai4jej4e3
         sGoHnS7sBF3nxz/TkCZ4Nv26uqrV1AMdaACS/SWRaDyvXrQSlRzA8xCgBLuekjwJU0Wz
         nQJA==
X-Gm-Message-State: AOAM531l+nX9ZMPDZar0yP5JoU0Mv3tx2PjCpkBVyqc185cqNAs4C80s
        ZEEhLUdpmW9g6BuxPXdWxpGP8P6GuXlLg1BOQhEq4A==
X-Google-Smtp-Source: ABdhPJyPRqnkRZMh1ri4hzJHg5glOXCDJbyxpChWsHOcw8ODDEd5rTUzWvDESEc9IgnbrZlOqqJb1aAqJeDVIOGl5mY=
X-Received: by 2002:a17:906:1a54:: with SMTP id j20mr45158330ejf.455.1594094948779;
 Mon, 06 Jul 2020 21:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200706191555.GD6176@sirena.org.uk>
In-Reply-To: <20200706191555.GD6176@sirena.org.uk>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 6 Jul 2020 21:08:57 -0700
Message-ID: <CAPcyv4iiVvJHPTmgssTvp=jsFCs2r068mPtZ9s0qXfEKFNdVBw@mail.gmail.com>
Subject: Re: [Tech-board-discuss] [PATCH] CodingStyle: Inclusive Terminology
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 12:16 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Sat, Jul 04, 2020 at 01:02:51PM -0700, Dan Williams wrote:
>
> > +'blacklist'. Recommended replacements for 'slave' are: 'secondary',
> > +'subordinate', 'replica', 'responder', 'follower', 'proxy', or
>
> I'd second the suggestion of device as an option here.

Sure, will do. I'm assuming you're thinking of cases where 'slave' is
used in isolation without a paired relative term? If not, please
clarify.

>
> > +Of course it is around this point someone jumps in with an etymological
> > +argument about why people should not be offended. Etymological arguments
> > +do not scale. The scope and pace of Linux to reach new developers
> > +exceeds the ability of historical terminology defenders to describe "no,
>
> More generally etymological arguments are just not super relevant here
> anyway, the issues people have are around current perceptions rather
> than where things came from.
>
> > +not that connotation". The revelation of 2020 was that black voices were
> > +heard on a global scale and the Linux kernel project has done its small
> > +part to answer that call as it wants black voices, among all voices, in
> > +its developer community.
>
> This, especially the bit about "revelation of 2020", sounds a little
> off to me - I think it's that it's worryingly close to the frequently
> derided pattern where people recognise a problem that other people have
> been talking about for a while and treat it as something new.  Perhaps a
> more neutrally worded reference to current events and/or our desire to
> improve instead?

I'd just as soon let this commentary live in the archives if people
need some more background. It's not like we have companion essays on
the other recommendations in coding-style, and we seem to be
converging on just amending coding-style.
