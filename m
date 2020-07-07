Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB362C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 04:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3C2420702
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 04:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Ko2E1qSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgGGEEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 00:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgGGEEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 00:04:36 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4461C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 21:04:36 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id h28so37237567edz.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 21:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6hAZTl6K9ZZJRuBGIigtyyzN/0NQAjksX5TVG0PUHis=;
        b=Ko2E1qSbx1nPmsdQ2RpYc/VqrXF1Cu5ICoGXOuJxNyDPXqCaBxOcU6CHjE7y2ANaQk
         ecW473NBRf9zCvXHP8VdmnVSI3S0fy8xmnlfCHQIIFB+kmdslLRxVaL7kmIY3gUKmH9V
         mYps5GQuD67dAb2WudLc0YUhIDoscm8t876DSC8TIpELsu4XYL3MtQ6XD35/XEeCoo3P
         8QeiSdT3mRB6rt6zp6/TaWBnnWSzIghx8Ki817lgozICwcVxPHZo2uj+dHRaKpDwwVsJ
         rJHbFemch7qSRQSND4Wsmj48BO7oi+445FvlOZcWTSKl36VCEhSo3Pm/to5hbfAmhpCU
         VZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6hAZTl6K9ZZJRuBGIigtyyzN/0NQAjksX5TVG0PUHis=;
        b=YHtZSoppO70VAVOQ6T/gVewGYx56uzcPUXUHiC3BFWVDpa6r1Sq9tkLBi9HS4GeFva
         QO8Koh0bsfE9JaeVjaCPWxg4i9ReDMrGVLRwtnkhlz1PizkgcJs0RwiSdSfqenQjHj7O
         NXljNQqt+ZOItxpftMIiO3GXZLoj5vdwNAkJ2FuGEDM6zyIdIde0NxbFIYyWK1jQsX0I
         lyZGNoGblbupUJcks8DHb+mcUi1TGTXG1vBeqJlyL0Pmx5g+SDLuyODG5doUPOkGIrSw
         kIhVWhNxf+zmh4Vq5TH19gpyKmaMiYyHMM1SG/I7RWnzpAAAsiItuFA4bxRESazwFl5o
         1KBQ==
X-Gm-Message-State: AOAM5306XFAjO5r+sSZJBs+ZkIgebsfWXonDKjEuEt2dafw9FRPa7dtb
        7E4WiX9VzF7BQHR4lgd/lkXz2Nw+UOmCmkNACmFzMA==
X-Google-Smtp-Source: ABdhPJwzaF51I0jM6b8skPP1l6fWj5clqHzchbKv9dG535YIcTRiQ81iT+YC/Ds98lHb+oxpNTipHjX5FUp2OW28c+I=
X-Received: by 2002:aa7:c24d:: with SMTP id y13mr62007695edo.123.1594094675451;
 Mon, 06 Jul 2020 21:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <79214066-3886-e0ef-f26e-8cb3d53404be@linuxfoundation.org>
In-Reply-To: <79214066-3886-e0ef-f26e-8cb3d53404be@linuxfoundation.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 6 Jul 2020 21:04:24 -0700
Message-ID: <CAPcyv4hOJHazV5UdE_Km4AWTvZvsrNtHR+2LUiOTYsDttRZZ5Q@mail.gmail.com>
Subject: Re: [Tech-board-discuss] [PATCH] CodingStyle: Inclusive Terminology
To:     Shuah Khan <skhan@linuxfoundation.org>
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

On Mon, Jul 6, 2020 at 11:30 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 7/4/20 2:02 PM, Dan Williams wrote:
> > Recent events have prompted a Linux position statement on inclusive
> > terminology. Given that Linux maintains a coding-style and its own
> > idiomatic set of terminology here is a proposal to answer the call to
> > replace non-inclusive terminology.
> >
>
> Hi Dan,
>
> Thanks for taking the time to work on this patch and updating the
> coding-style.rst with the with inclusive terminology guidelines and
> adding a new document outlining the scope.
>
> The suggestions you made will help us adapt inclusive terminology
> for the current times, and also help us move toward terms that are
> intuitive and easier to understand keeping our global developer
> community in mind.
>
> Allowlist/denylist terms are intuitive and action based which have a
> globally uniform meaning.
>
> Terms such as "whitelist" etc are contextual, hence assume contextual
> knowledge on the part of the reader.
>
> A couple comments below:
>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Chris Mason <clm@fb.clm>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >   Documentation/process/coding-style.rst          |   12 ++++
> >   Documentation/process/inclusive-terminology.rst |   64 +++++++++++++++++++++++
> >   Documentation/process/index.rst                 |    1
> >   3 files changed, 77 insertions(+)
> >   create mode 100644 Documentation/process/inclusive-terminology.rst
> >
> > diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> > index 2657a55c6f12..4b15ab671089 100644
> > --- a/Documentation/process/coding-style.rst
> > +++ b/Documentation/process/coding-style.rst
> > @@ -319,6 +319,18 @@ If you are afraid to mix up your local variable names, you have another
> >   problem, which is called the function-growth-hormone-imbalance syndrome.
> >   See chapter 6 (Functions).
> >
> > +For symbol names, avoid introducing new usage of the words 'slave' and
> > +'blacklist'. Recommended replacements for 'slave' are: 'secondary',
> > +'subordinate', 'replica', 'responder', 'follower', 'proxy', or
> > +'performer'.  Recommended replacements for blacklist are: 'blocklist' or
> > +'denylist'.
>
> allowlist and blocklist or denylist are lot more intuitive than
> white/black in any case.

Yes, that was interesting to me when I first grappled with this. The
replacements are more direct.

I was going to go with blocklist/passlist as the common shorthand
recommendation, but if a subsystem picks allowlist/denylist as a local
custom that's fine too.

[..]
> Please add my Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> or Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Thanks Shuah.
