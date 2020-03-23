Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF3CC4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3084720753
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EQ3ZqVc1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgCWUo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:44:57 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:35063 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbgCWUo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 16:44:57 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 34bb9f45;
        Mon, 23 Mar 2020 20:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=mail; bh=lO1tfTg2EiIAONfM9UiInlqel2I=; b=EQ3ZqVc
        1rOs+mxB/P0W1ebcdTeJHplIaDOV4gL8GTuteSAFNQypSC2uNxAv+ikkkQasf/BD
        6id/edk4fHX6E8Oir60ULnCpPr+adAC21hmJWWsBeb7JCFmbfPbx8VUtZEqDV6Mp
        2VBkY0KCJejYuRfxx0NAV53yy1WRzY+6lF0zqOj1hmqVUGSXvMU0K4qIiodNtIwn
        R2Wrmtep+hxGsSav/c/i3ChzI3jsTMc6UssD6iX5v79hETPfZ/aSed4bEPRxBxmo
        A3GTxzh/k8Pmx5SanmBdb1lIv/VgcZ9iX2kBuRWfOiHXnJHPqABSXiHLWnsjvJUP
        4uPVzzqwvqnNQXQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 17584a94 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Mon, 23 Mar 2020 20:37:53 +0000 (UTC)
Date:   Mon, 23 Mar 2020 14:44:54 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     bp@alien8.de
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH] Documentation/changes: Raise minimum supported binutils
 version to 2.23
Message-ID: <20200323204454.GA2611336@zx2c4.com>
References: <20200113161310.GA191743@rani.riverdale.lan>
 <20200113195337.604646-1-nivedita@alum.mit.edu>
 <202001131750.C1B8468@keescook>
 <20200114165135.GK31032@zn.tnic>
 <20200115002131.GA3258770@rani.riverdale.lan>
 <20200115122458.GB20975@zn.tnic>
 <20200316160259.GN26126@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200316160259.GN26126@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 05:02:59PM +0100, Borislav Petkov wrote:
> Long overdue patch, see below.
> 
> Plan is to queue it after 5.7-rc1.
> 
> ---
> From: Borislav Petkov <bp@suse.de>
> Date: Mon, 16 Mar 2020 16:28:36 +0100
> Subject: [PATCH] Documentation/changes: Raise minimum supported binutilsa version to 2.23
> 
> The currently minimum-supported binutils version 2.21 has the problem of
> promoting symbols which are defined outside of a section into absolute.
> According to Arvind:
> 
>   binutils-2.21 and -2.22. An x86-64 defconfig will fail with
>           Invalid absolute R_X86_64_32S relocation: _etext
>   and after fixing that one, with
>           Invalid absolute R_X86_64_32S relocation: __end_of_kernel_reserve
> 
> Those two versions of binutils have a bug when it comes to handling
> symbols defined outside of a section and binutils 2.23 has the proper
> fix, see: https://sourceware.org/legacy-ml/binutils/2012-06/msg00155.html
> 
> Therefore, up to the fixed version directly, skipping the broken ones.
> 
> Currently shipping distros already have the fixed binutils version so
> there should be no breakage resulting from this.
> 
> For more details about the whole thing, see the thread in Link.

That sounds very good to me. Then we'll be able to use ADX instructions
without ifdefs.

Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>
