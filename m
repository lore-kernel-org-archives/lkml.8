Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38023C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 17:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027502063A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 17:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586282365;
	bh=Y5zA/2MNx1AT4+A3BcVTDRe1NStV24TsTi006Ymf0oM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=erxUZKharCe8dOsBzgIV/fUvw/nbvAK3FV2cTIC1pwKVZhZnzmKX19CsQG8H0rWEi
	 YozWRBLlkHeo7GgefU0hNzCfGaTbPWPtEjjrAcqE581k6iffulSVRjK15iabPBhkbR
	 va+XRKwPVLifgTsbL5ZojbYtJSvjvngy8OHZmh6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgDGR7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 13:59:24 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35661 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgDGR7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 13:59:23 -0400
Received: by mail-lj1-f194.google.com with SMTP id k21so4799860ljh.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 10:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RdWHnkyUOuIQT5df0SRBbcUjsw9tkuNDCfUJgegsx2Y=;
        b=GuMJrA5+OPCrFlqiWIQXdF0sRv1DXcntWrvutmyZqOFRpLpgvLws+UiZLwJA7kK6Sd
         +vwfQHhWYtc8mTZoTJRh3SqPJYbGEQlYNQpReplC+lHRTbAsoBc7dLrK+rxls3EDRoOA
         QbPRBs61u/GOBlZBjbijLCzyGt3+UWROpo2Ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RdWHnkyUOuIQT5df0SRBbcUjsw9tkuNDCfUJgegsx2Y=;
        b=DCTtbBxx8fMbREY6ZBtflzx60R+ZCDXWfvcOQFS2R2SLqCVPNHo589q/erEWX/AnJE
         k1DchA/bVsvXhQIk4MD9Wj7zWwASn2f5r9T18GFfRUfWeT9gP4aR0bj41XslEN2hDGXA
         OZdihDgPE0xo4uehb24H1OsR8DQhur+WVj6Ac23dlR+A8eWscR92BwS4CCavyNfiN1SR
         caFOpQyAMIYrf+kZmOAEKHchi2NA4TVU3IBeQ+Cw/HpTCh0GkGqkw/zyXpeDKz54NZu+
         bEb+WbfZhtdm0fMNlh11sJuOoqOkdXHg65B3KOhyBRNh9Uq6M4HnCz1MRpVwmHqtceRV
         UqhQ==
X-Gm-Message-State: AGi0Puap7FNxL035m90XcX8KreGfoOel72LHC7IjqY6UuVbnKUyGnRdg
        bZu3+2MsbbQp+aI3LNTDVEIyFOCLAQA=
X-Google-Smtp-Source: APiQypIyNEyFSUuMW0psSwo/KOSbUMkyiW0R8nmO38K73AhrrwNEvC/BACpHOjrkQZGHO6UFwX4LNA==
X-Received: by 2002:a05:651c:92:: with SMTP id 18mr2249209ljq.141.1586282361305;
        Tue, 07 Apr 2020 10:59:21 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id m12sm12077160lji.50.2020.04.07.10.59.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 10:59:20 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 131so3067335lfh.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 10:59:20 -0700 (PDT)
X-Received: by 2002:a19:240a:: with SMTP id k10mr2247587lfk.30.1586282359598;
 Tue, 07 Apr 2020 10:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200406110702.GA13469@nautica> <CAHk-=whVEPEsKhU4w9y_sjbg=4yYHKDfgzrpFdy=-f9j+jTO3w@mail.gmail.com>
 <20200406164057.GA18312@nautica> <20200407021626.cd3wwbg7ayiwt4ry@l29ah-x201.l29ah-x201>
In-Reply-To: <20200407021626.cd3wwbg7ayiwt4ry@l29ah-x201.l29ah-x201>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Apr 2020 10:59:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiE6_L2NnSo82erMHxbP8fa=f_b64G+Muu0JnUEBgDwOg@mail.gmail.com>
Message-ID: <CAHk-=wiE6_L2NnSo82erMHxbP8fa=f_b64G+Muu0JnUEBgDwOg@mail.gmail.com>
Subject: Re: [GIT PULL] 9p update for 5.7
To:     L29Ah <l29ah@cock.li>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 7:16 PM L29Ah <l29ah@cock.li> wrote:
>
> In fact i would prefer disabling the full reads unconditionally, but AFAIR some userspace programs might interpret a short read as EOF (and also would need to check the logic that motivated the kernel-side looping).

Oh, it's even worse than "might interpret a short read as EOF".

Lots of ad-hoc small tools will basically do something like

     fd = open(name, O_RDONLY);
     fstat(fd, &st);
     buf = malloc(st.st_size);
     read(fd, buf, st.st_size);

and be done with it. Obviously they may have some error handling (ie
imagine the above being written with proper tests for buf beign NULL
and 'fstat()' returning an error), but if they check the return value
of "read()" at all, it might be just to verify that it matches
st.st_size.

I've written stuff like that myself.

Sure, the "real" programs I write would have loops with EAGAIN and
partial reads, and maybe I'd have a helper function called "xread()"
that does that.  And most major applications will do things like that,
exactly because they've seen years of development, they're trying to
be portable, and they might even have hit other network filesystems
that do partial reads or return EAGAIN - or they might have more
complex functionality anyway which allows you to pipe things in from a
buffer etc.

But the above kind of "assume read() gets the whole thing" is not
unusual for quick hacks.

After all, it's a _valid_ assumption for a proper POSIX filesystem,
although it obviously _also_ assumes that nobody else is writing to
that file at the same time.

And some of those quick hacks may end up existing for years in major
code-bases, who knows..

[ Honesty in advertising: the Linux VFS layer itself says "screw
POSIX" for some things.

  Particularly, if somebody tries to do a read larger than 2GB in
size, the VFS layer will just say "POSIX is garbage in this situation,
we _will_ truncate this read".

  So if you deal with huge files, you _have_ to do the proper "loop
until EOF" even for regular files, and POSIX be damned.

  The kernel refuses to do crazy things, and no amount of standard
paperwork matters. ]

But basically honoring full reads for any _reasonable_ situation is
pretty much required for a lot of reasons. Yes, lots of apps will deal
gracefully with partial reads - maybe even most. But "lots" is not
"all".

             Linus
