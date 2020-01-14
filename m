Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD84C33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 02:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845472084D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 02:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lFyxxfzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbgANCUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 21:20:15 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46498 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbgANCUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 21:20:15 -0500
Received: by mail-pg1-f194.google.com with SMTP id z124so5619607pgb.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 18:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6wdIQTk2u3shrEGMLPGloxQ7vVbN8oza1fYuUhlAUQk=;
        b=lFyxxfzcpJSu0nYit7+aVxAut4x51T+edJt9QIltxVRy/hgpaN++DEXJlvPmNm6//q
         1jgfFAGl58yn8xJXGOucsyqN9AbLaFSJZx3paamG735tTiL8AlomN/fuVsQmgDLwI4KN
         T7rUVDQEaK5jP1Bf8dI5nTsWmthJY8GrEzUCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6wdIQTk2u3shrEGMLPGloxQ7vVbN8oza1fYuUhlAUQk=;
        b=MMVP0k99eadV6BcAlqEiOK5ia83dTPLQUnItByhUdvvuNfNa+Ci3UJ9BOga48eLyQV
         1usSEfl/O/aMqbiZuX6l2JpG31O0LTudN/fPUFoY0qU3qMZ7ir6waXuTTnI7yjuSr7/r
         jK4SvIamOKjvm4vdjdnNRfje64ZE7RWEo8Jw2p1011EikrMvWBQtBMvpqX7WZe6DR+bJ
         Vd1TdccC5vmbojVcFAmZRCE2KNBJGUs+qDD0PRyMaR+Y9fu/3hFqrKrnmgOSSfGp/fNi
         l5zoNEnDO6IKwYRxiBINeHC09X770BQYJo68W/Ox+RbFEZWi8C2oqqdYapFdYTEN6J4G
         CFkA==
X-Gm-Message-State: APjAAAUut7nt9xvmn+6f8qe/9yZ+i7rlfmsvEzbnIwu0cJackcPKiiu0
        PQTKFQZcbdYLGC8Wa/CsGxhtESiIRaJdzg==
X-Google-Smtp-Source: APXvYqxaecbsRMSe7SLHJYeer9udqGm2UAu6BCR/CbwDSgvVG9E6Me2o+sF6NHvC8MfaG+T9rQPdmQ==
X-Received: by 2002:a63:6c86:: with SMTP id h128mr22326396pgc.200.1578968414315;
        Mon, 13 Jan 2020 18:20:14 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k12sm14573870pgm.65.2020.01.13.18.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 18:20:13 -0800 (PST)
Date:   Mon, 13 Jan 2020 18:20:12 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH v3] x86/vmlinux: Fix vmlinux.lds.S with pre-2.23 binutils
Message-ID: <202001131819.5A0031F611@keescook>
References: <20200113161310.GA191743@rani.riverdale.lan>
 <20200113195337.604646-1-nivedita@alum.mit.edu>
 <202001131750.C1B8468@keescook>
 <261ae869-4169-296e-f673-5c08ff34bdde@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <261ae869-4169-296e-f673-5c08ff34bdde@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 05:57:23PM -0800, H. Peter Anvin wrote:
> On 2020-01-13 17:53, Kees Cook wrote:>>
> >> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> >> index 3a1a819da137..bad4e22384dc 100644
> >> --- a/arch/x86/kernel/vmlinux.lds.S
> >> +++ b/arch/x86/kernel/vmlinux.lds.S
> >> @@ -144,10 +144,12 @@ SECTIONS
> >>  		*(.text.__x86.indirect_thunk)
> >>  		__indirect_thunk_end = .;
> >>  #endif
> >> +
> >> +		/* End of text section */
> >> +		_etext = .;
> >>  	} :text =0xcccc
> >>  
> >> -	/* End of text section, which should occupy whole number of pages */
> >> -	_etext = .;
> >> +	/* .text should occupy whole number of pages */
> >>  	. = ALIGN(PAGE_SIZE);
> > 
> > NAK: linkers can add things at the end of .text that will go missing from
> > the kernel if _etext isn't _outside_ the .text section, truly beyond the
> > end of the .text section. This patch will break Control Flow Integrity
> > checking since the jump tables are at the end of .text.
> > 
> > Boris, we're always working around weird linker problems; I don't see a
> > problem with the v2 patch to fix up old binutils...
> > 
> 
> Why not add the marker into a separate section instead of leaving it as an
> absolute "floater"? Very old binutils would botch that case, but I think that
> has been long since addressed well below our current minimum version.

Can you send a patch with what you're thinking?

-- 
Kees Cook
