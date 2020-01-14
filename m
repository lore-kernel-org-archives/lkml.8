Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88055C33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 03:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA6F2187F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 03:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jha953gw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbgAND7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 22:59:02 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:40475 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728894AbgAND7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 22:59:02 -0500
Received: by mail-qv1-f66.google.com with SMTP id dp13so5069371qvb.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 19:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ztJ1V0LnCB/uV/QxWONsGT2VGSCtiLH36uJ9ZnQL11k=;
        b=Jha953gwcEctikRVgy1BwWSp1AOSzwFroA4riLAgjF0Ca759v22jbjV6iiC+XaTfXd
         whRDyHz7vYanB9Kbv1TaGdNr20mF5tma/3L64IpziirlGRzyNL+TUUsyRxFx3ZzbBAkX
         Q3pLbZ06A91feXTg5mHcE6vEHdcNDYbo5qR3zLa+atvldUi4GwpZ2K/VH1/6GQaT1qxK
         qPJ258Ob6IzYE0d33dlAXW+8diQ6lSN4BFImIbf616k9h7tl+hlSAJXKYh9DMY+5qnFv
         CyCaaeGsZYWARlUSH178E286UJxnp3dn/E7c5yst3iFbuyU/VuBPpQ8tPp3UTJrfrq3v
         SPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ztJ1V0LnCB/uV/QxWONsGT2VGSCtiLH36uJ9ZnQL11k=;
        b=O5tk/nGRUU1MxrQ4FaNnACqXdlUoEr5doHEaafqb7JXdS/F4zxQOe4MtXKxTQqj5TK
         muiLcsY1wiWeiTdT/hj9IyeUIM8ZwHfjGWXi7pMp9xLXDCYyKeEqNbQ6iPPtpsJ23GMe
         umX6HUEAUe3KWIx7U8W6P3i937QUB1ppp8+0HcWN31JtKZY4bhiVMBfgjZgei+Dsylx9
         uVQz5r+dkVJ+uY1mDUPRAFZzy5S8jAxBmE94dKJiH0G+0AQ0Bi1ReiKKqi3tKaK8Mfq5
         BCXJ1FeAhq8HNZC/VXW9K41tgaL2GLSZ7LOOgF5bGvcNJfxODDx1lctdNslkL4u7U2A8
         +s5Q==
X-Gm-Message-State: APjAAAUGV5qk47/MWuEyCz/V4V+VkIzFA1BtlxCTRdS+qLJ5UE7uV1jp
        orOv98nje1vRuDdzyrPBNOc=
X-Google-Smtp-Source: APXvYqz9gZeO73r+YapWUNO12FvABCSxxgvUlTyOdaZTIzFZx9NEBcrgmHJ1I7Pe2uYL5BAt5sHtQw==
X-Received: by 2002:ad4:4dc3:: with SMTP id cw3mr18642276qvb.130.1578974341294;
        Mon, 13 Jan 2020 19:59:01 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v5sm6967439qth.70.2020.01.13.19.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 19:59:00 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 13 Jan 2020 22:58:59 -0500
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH v3] x86/vmlinux: Fix vmlinux.lds.S with pre-2.23 binutils
Message-ID: <20200114035858.GA2536335@rani.riverdale.lan>
References: <20200113161310.GA191743@rani.riverdale.lan>
 <20200113195337.604646-1-nivedita@alum.mit.edu>
 <202001131750.C1B8468@keescook>
 <261ae869-4169-296e-f673-5c08ff34bdde@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <261ae869-4169-296e-f673-5c08ff34bdde@zytor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
> 
> 	-hpa
> 
> 
> 

Kees, thanks, I noted in the other email that you had mentioned this in
a since-reverted commit, but you did not mention in the most recent
commit.

hpa, I think this runs afoul of the bug you noted in commit fd952815307f
("x86-32, relocs: Whitelist more symbols for ld bug workaround"), ld
version 2.22.52.0.[12] can incorrectly promote relative symbols to
absolute, if the output section they appear in is otherwise empty.

That's 2.22, which is more recent than the 2.21 that the kernel
documents as supported.
