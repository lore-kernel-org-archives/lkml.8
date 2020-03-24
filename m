Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B125AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E2C206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YpkuBmqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgCXRxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 13:53:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37464 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbgCXRxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:53:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id h72so7466827pfe.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 10:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZxsdTUrUeVBSfB6rvEsxkEaFkTBJO/lH7iiBmlj/6eg=;
        b=YpkuBmqmv35d13reGYGHJ/SXgArEhrZkhyk+sONMPJmw+KbuGmF6diuOwKtLDfoi3N
         TU0nUUSy6E41+i+bhoyeN2D2mKtdTy/uBuZYO5ca/TiO+TpZA4nsvwfHRjbsg9qaJYMK
         6dpZjelxFqfc5HkCmisodj64Hrqf8btwAT/as=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZxsdTUrUeVBSfB6rvEsxkEaFkTBJO/lH7iiBmlj/6eg=;
        b=DUo6iUMeSqPrmPM3Bi6stURieMEx8/8Zoc7kO3FxrkxCrDBwjmCkM3ArZUk1WttWon
         CUHN6SGKvr1Sd7vEx+fcd6wVAeUIDQxz2ebzoRPYDGrLFk58wA4DAfpMNVuHpVaf6yaW
         qSklNgDFJ/xSVhyVbYh1v28GKNyP0v0RyIZEfs+69f2zEEMV2wzBOVHXnmkhulJwwIEa
         ZHYbf34WEWLb4KZbpEiqFnTFs3MCSZuDwWZvN8OILT90G3xPdOjhirTPn4z7QpypP9pL
         IorGkrkPSsB7CelknQ6RpWhLMGz7b7OTwbRUi36LRfmIKw6Mk4Mfvw8rzGt9ur7dCE2E
         OWpg==
X-Gm-Message-State: ANhLgQ077duJMfzM2B3PUGitRbddyfQsCTl2mI45aPDNjCvMC2LLTZr0
        G3dOeiEqnrm1MawebB0YfdnUOQ==
X-Google-Smtp-Source: ADFU+vuW3LeLIp5eiH8Tf7XqO9zZW1F5sw0Q2LjIaG/VPlcO2qjQ4T5kSNKnTaLwFb8eB8uGq3Pzhg==
X-Received: by 2002:aa7:95ae:: with SMTP id a14mr29129311pfk.164.1585072412906;
        Tue, 24 Mar 2020 10:53:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v123sm16600631pfv.146.2020.03.24.10.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 10:53:32 -0700 (PDT)
Date:   Tue, 24 Mar 2020 10:53:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
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
Message-ID: <202003241051.D2CF0F0@keescook>
References: <20200115002131.GA3258770@rani.riverdale.lan>
 <20200115122458.GB20975@zn.tnic>
 <20200316160259.GN26126@zn.tnic>
 <20200323204454.GA2611336@zx2c4.com>
 <202003231350.7D35351@keescook>
 <CAK7LNARMBkc666kZ9jOG9sSThzA69JvKi++WZXMtCP9ddyqcBw@mail.gmail.com>
 <20200324091437.GB22931@zn.tnic>
 <CAHmME9q2VuhN+Dhi-nzuJKPjXo8dZq013cZ-0x0t9StZFXCAJQ@mail.gmail.com>
 <20200324162843.GE22931@zn.tnic>
 <CAHk-=whXBO-Z=Ra_UX=w_LefG1r6iLXcPT=sLuZ+EaKFtWtCBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whXBO-Z=Ra_UX=w_LefG1r6iLXcPT=sLuZ+EaKFtWtCBQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 09:37:13AM -0700, Linus Torvalds wrote:
> On Tue, Mar 24, 2020 at 9:28 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > Are you or Kees going to deal with any fallout from upping the binutils
> > version, rushed in in the last week before the merge window?
> 
> I think it's ok. It's not going to cause any _subtle_ failures, it's
> going to cause very clear "oh, now it doesn't build" errors.
> 
> No?
> 
> And binutils 2.23 is what, 7+ years old by now and apparently had
> known failure cases too.
> 
> But if there are silent and subtle failures, that might be a reason to
> be careful. Are there?

FWIW, I have plenty of other hills to die on, so I have no urgency on
this change. I actually thought it had already happened, since it was
brought up a while ago. :) I am just excited to see it happen since it
unblocks other work I've been touching. As long as it's "eventually",
I don't care when. :)

-- 
Kees Cook
