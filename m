Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2AEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 22:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 981AA207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 22:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kID/aOsj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgFPW2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 18:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgFPW2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 18:28:22 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807A3C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 15:28:22 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id d27so51706qtg.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 15:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mGsJpvZJmzw6VFMfATWAqn83hx8/PHV4IC9zhJSVGPg=;
        b=kID/aOsjYQ06FX341gItfQKHP3WyS1OIJB9yopLde9hqPrrumlRlkpKkZNu2UwusQr
         svnuUk+YjbpG7GKymIhl4Jf5haBv/4idVv917wCWo5G1mKcUYJni/qA3pINs/7pOwfqt
         jJnOUp7ms1hvrKWspSDL62aoLdlCQM6JeKh7H2n9lSexQk4pvd1XAUD7Q0q1OmlaK0aG
         A2q71XqSgfBzqg+aYET0d4P2mpzwgFya68krw0QbrPNvnGNdJoYeeKe/Z31VIRWUZg3h
         U/L/DJzqetrJPxSV7qs67qqlT4wuUwbDLFLPJFCVK0IgqeXFHna0GyQo3YXndJNx2N5z
         3hXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mGsJpvZJmzw6VFMfATWAqn83hx8/PHV4IC9zhJSVGPg=;
        b=ZEcimx/5r4lHUcu1yw9mtL4kVbAXY0EYSNzq9W/UHMYSHsNWbjg91D25RuZzvIQops
         eW1j5WbgE/c1TaZWiRqUPIrtgRIIMFS305ntMHS235AJ3ABkcg4mlDW2y3VmddzDCGio
         3oZdAiqk4DL+OHFWzv0UYmRGF4Xx6gkXYfZz9JzW4de1sKHaI14ahO1wzyG1ZqJOyD8l
         Dw11mMkyw1VZ4IaEclg8Rh7k9Xqt+r/lowI1kps/2T3OsjOQuH0RbLfguuIVl5qmdeZZ
         yWHsYT+oULtmBRklYUntY573X1cW4bC2MNLM8lt6yfNHwsbJj3qGd44kbdOOZ+rmLmjE
         pXMA==
X-Gm-Message-State: AOAM531YSJxF4o8e3DKO7EVel1p7E9t4VvmAk9bduNe/hgqyciWR5hOv
        9srWq+ozxj/ZLtF3ulaiowQ=
X-Google-Smtp-Source: ABdhPJzlhLRwg717xDwcFSQ1er3E588zR+nPbFKodhns3BwBjN4tsvk0HDL767BQUb65AoHF2BNEaQ==
X-Received: by 2002:ac8:4f46:: with SMTP id i6mr23248812qtw.317.1592346501666;
        Tue, 16 Jun 2020 15:28:21 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id h19sm2531671qkj.109.2020.06.16.15.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 15:28:20 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 16 Jun 2020 18:28:19 -0400
To:     Gabriel C <nix.or.die@googlemail.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: Linux 5.8-rc1
Message-ID: <20200616222819.GA1977632@rani.riverdale.lan>
References: <CAHk-=whfuea587g8rh2DeLFFGYxiVuh-bzq22osJwz3q4SOfmA@mail.gmail.com>
 <CAEJqkgi3w+zvMkRBP4VtAewX1UJxrVNRQ03MtRN_yH-PwOOScQ@mail.gmail.com>
 <20200616203352.GA1815527@rani.riverdale.lan>
 <CAEJqkghzD_6F2N=M65uYHzpOOJ8bvMw18JCfwsiQoH-kToPKLQ@mail.gmail.com>
 <20200616212536.GA1934393@rani.riverdale.lan>
 <CAEJqkgij-_Z1S-F=ooHr=OYcE8biHr1Z-RGgOzHpC7Y0wm7BhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEJqkgij-_Z1S-F=ooHr=OYcE8biHr1Z-RGgOzHpC7Y0wm7BhA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 12:00:14AM +0200, Gabriel C wrote:
> Am Di., 16. Juni 2020 um 23:25 Uhr schrieb Arvind Sankar
> <nivedita@alum.mit.edu>:
> >
> > On Tue, Jun 16, 2020 at 11:17:08PM +0200, Gabriel C wrote:
> > > Am Di., 16. Juni 2020 um 22:33 Uhr schrieb Arvind Sankar
> > > <nivedita@alum.mit.edu>:
> > > >
> > > > Can you attach the output of gcc -dumpspecs and gcc -v? I suspect your
> > > > compiler enables stack protector by default. My distro compiler does
> > > > that too, but not if -ffreestanding is enabled (which it is for the
> > > > purgatory).
> > > >
> > >
> > > Files including config uploaded to there:
> > >
> > > http://crazy.dev.frugalware.org/kernel/
> > >
> >
> > Yeah, your gcc doesn't have the -ffreestanding handling. Mine (from
> > gentoo) has this in the -dumpspecs output:
> >
> > *cc1_options:
> > ... %{nostdlib|nodefaultlibs|ffreestanding:-fno-stack-protector} ...
> >
> > to switch off the default ssp when the standard libraries aren't available.
> 
> I wondered what they enable to do that. it turns out it is a custom patch.
> While I think having that is not bad, such patches lead to bugs like this one.

Right. Debian also has a similar custom patch to adjust the specs. It
would probably be better if something were upstreamed :)
