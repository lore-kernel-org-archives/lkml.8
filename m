Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URG_BIZ,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EF3C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 21:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390BA20719
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 21:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J37CbPnI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgCXVmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 17:42:08 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33484 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgCXVmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 17:42:08 -0400
Received: by mail-qk1-f195.google.com with SMTP id v7so284590qkc.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 14:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cLX18O5zuj5gsRsOAaCKiSE0TdgmSPuMWJpHQFaI6lY=;
        b=J37CbPnIYJ5h8G4MvA2lsctS++TcxsRtVuXiKxKVHDNhpfvCifvp1lDA/ywOrBl0vo
         THDrEqNPPwGCGXvTaJxaZydNhiIdARh4lGOYBy0io8tQCXIbv3QbVD9MTLwqvOMIWiY6
         uDAgwKdaQDvFARUDzeX1mACWrk/5RgltWf+xgpnydp5/UYqF1QZbVW+g4f+5dgov6nzV
         haBfhecolSUeML9r0vmwzOTfluH3iJpDiE4jAjO4afPn7ML04zKYJ4phvlaGQX1VF9DX
         mmSHpd0zrjtXa5mcBkyL2kH+a/h59wFCM6lEUUKk5mUjJe2K1XbQsCRenZy/028juXIE
         ntCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cLX18O5zuj5gsRsOAaCKiSE0TdgmSPuMWJpHQFaI6lY=;
        b=lLX4u63Qq0qSw2nyd5F7cZVy5PCurF3wslnLjmrBxLGkPr3faSYl9ri4nIyardxoYC
         SzYatNe4L38Zd6SieaFSnt7qYamydeWdekbpx8eubtVOghnNuPTO+oMFnsX1T/kQTQ+Q
         Fa6acdTUh497A4nBdV9m/dZBo5bnjG7zTAY39P7mHVzeD6oUDtuTMH4xyNL2vKIySAeU
         jHDZwF1ptz6hc8jroOOjGQDTy37HB430zpCZMJtJ3lZQwKQ3wFcm+sYf6uTsugATDccA
         hfDS22+R0Jgktd1KcXHwF0PEjFjeqo5wy9f7B3d2h24AlxTiTgBvGO63/vjTjlA3UX/I
         lOuA==
X-Gm-Message-State: ANhLgQ0olDnXfeepFtzJjpXri+VB0uvWEHTZIMSn+9WEBLn6iQQlLOZa
        igHGuLFIZXOAerS8NWzmCOQ=
X-Google-Smtp-Source: ADFU+vsS//dwMFSJeYOdPt0MdStWMiJz3a5R7CKmTnhRsl0tq43ejNp91DZNQ8r8pf6UYcIcppIlqg==
X-Received: by 2002:ae9:ea07:: with SMTP id f7mr15779664qkg.499.1585086127342;
        Tue, 24 Mar 2020 14:42:07 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id q34sm14438331qtb.41.2020.03.24.14.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 14:42:06 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 24 Mar 2020 17:42:05 -0400
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH] Documentation/changes: Raise minimum supported binutils
 version to 2.23
Message-ID: <20200324214204.GB3220053@rani.riverdale.lan>
References: <20200115122458.GB20975@zn.tnic>
 <20200316160259.GN26126@zn.tnic>
 <20200323204454.GA2611336@zx2c4.com>
 <202003231350.7D35351@keescook>
 <CAK7LNARMBkc666kZ9jOG9sSThzA69JvKi++WZXMtCP9ddyqcBw@mail.gmail.com>
 <20200324091437.GB22931@zn.tnic>
 <CAHmME9q2VuhN+Dhi-nzuJKPjXo8dZq013cZ-0x0t9StZFXCAJQ@mail.gmail.com>
 <20200324162843.GE22931@zn.tnic>
 <CAHk-=whXBO-Z=Ra_UX=w_LefG1r6iLXcPT=sLuZ+EaKFtWtCBQ@mail.gmail.com>
 <20200324164812.GG22931@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200324164812.GG22931@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 05:48:12PM +0100, Borislav Petkov wrote:
> On Tue, Mar 24, 2020 at 09:37:13AM -0700, Linus Torvalds wrote:
> > I think it's ok. It's not going to cause any _subtle_ failures, it's
> > going to cause very clear "oh, now it doesn't build" errors.
> > 
> > No?
> > 
> > And binutils 2.23 is what, 7+ years old by now and apparently had
> > known failure cases too.
> > 
> > But if there are silent and subtle failures, that might be a reason to
> > be careful. Are there?
> 
> Well, not that I know of and that's why I'm being overly cautious. Maybe
> too cautious but a lot of hectic testing of last minute fixes in the
> past have taught me to take my time.
> 
> And since it doesn't really matter when the patch goes in - there's
> always the next merge window - I would prefer to take our time and have
> it simmer in -next for max period.
> 
> So yeah, 2.23 has been tested for a long time now and it is very likely
> that nothing would happen and if you think it's ok, then sure. Then if
> you happen to see urgent pull requests with build or some other fixes,
> at least you'll be prepared. :-)
> 

This is just a documentation patch right? Nothing actually changes with
the build. The only possible thing that we would potentially have to
deal with is

(1) people noticing the doc change and complaining that they
still need to use binutils-2.21 for some reason -- but they can't
currently build an x86 kernel without patches anyway, so...

(2) people noticing the doc change and suggesting moving to 2.26 or some
later version instead of 2.23.
