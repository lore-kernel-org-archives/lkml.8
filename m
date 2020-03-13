Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8AFC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418FB20749
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mo+6Uwjp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgCMSdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 14:33:55 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:44620 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgCMSdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 14:33:54 -0400
Received: by mail-qv1-f67.google.com with SMTP id w5so5124256qvp.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 11:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IatxmkA0MPPH/jxsQO3JS1Cap5XHBwRG57sBC+1NLQ0=;
        b=Mo+6UwjpfLDeIQqUqahaBvF3Qki4vOpHA3enGGY+JrV4bpihJ1ZZXHdQOctDeqMbZI
         HuX7MabUSyaedE/pcCGyk1r4RMC4LLAYVYy2YzLs5sl7tKolLMOvir9jVJ1f5Rc7p8Ty
         1qp7LmO3VAuHEZPDSAo+ylMkISEuMpOCMjtbC9vjiexEaAvE855JiFnM6It6oJbMr5t9
         nrOiagHAV+IFcqkPRgjGKnSmFvMRqREZg0nfsVnwgqlOqLsPRYorkal/cD6DukGEXvhR
         en3VgFnUN+FHjWG2VdC0RPDp1c2gaKK0uNPm5d7Zrm4A7nVXpaxMRUSXZEyvHtEbEWKQ
         ALYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IatxmkA0MPPH/jxsQO3JS1Cap5XHBwRG57sBC+1NLQ0=;
        b=ZPaSegcoxFoipbkD2TUY1VEa7V8VGyRWvz7QYEJwJuM3rGglp+5DZ6QcG8EWeWbEVJ
         G2uyz/KpzeXxBxdHuuRFyVtGb9y/3WsLXCbG4sa58j2MlfavAm2/2UHbqKFEq00pOmZ1
         cImXgsWACztqZHQYeYMMLTv1Eyou9mld4EsW8C3woK7EfZKnOM1faub1k/h3/3kEQhwQ
         1nZRdrturBPEIt/CSI5qavJSK6SecIlF+V0B7vUqaKyhgG9gvcWL7aBvqtn1bqYiSK7R
         /Vv1SqXMneVP0/DQxwa19bKkLmzpOyL7ch3bPGLqpjmIxw8pjrhXjXVvCW9Eg2SZh0I/
         aSKw==
X-Gm-Message-State: ANhLgQ08dd9adw7qpFqKmUC9n47havaCPHsMXE31gW2hUnGt3ZEu3je5
        QZEkrnvxKdi/YU28FOSBqBo=
X-Google-Smtp-Source: ADFU+vvvDSLHNVDbCO01PMMfpsU4J2V32lm/IjBkopPYn4j7c7wkv8rmCR3bc5lS7HEHc1yCa6k90Q==
X-Received: by 2002:ad4:5642:: with SMTP id bl2mr14091018qvb.11.1584124433196;
        Fri, 13 Mar 2020 11:33:53 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id l92sm3917781qte.25.2020.03.13.11.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 11:33:52 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 13 Mar 2020 14:33:50 -0400
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>
Subject: Re: [PATCH v2] x86/boot: Correct relocation destination on old
 linkers
Message-ID: <20200313183349.GA1544820@rani.riverdale.lan>
References: <20200111190015.3257863-1-nivedita@alum.mit.edu>
 <20200207214926.3564079-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200207214926.3564079-1-nivedita@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 04:49:26PM -0500, Arvind Sankar wrote:
> For the 32-bit kernel, as described in commit 6d92bc9d483a ("x86/build:
> Build compressed x86 kernels as PIE"), pre-2.26 binutils generates
> R_386_32 relocations in PIE mode.  Since the startup code does not
> perform relocation, any reloc entry with R_386_32 will remain as 0 in
> the executing code.
> 
> Commit 974f221c84b0 ("x86/boot: Move compressed kernel to the end of the
> decompression buffer") added a new symbol _end but did not mark it
> hidden, which doesn't give the correct offset on older linkers. This
> causes the compressed kernel to be copied beyond the end of the
> decompression buffer, rather than flush against it. This region of
> memory may be reserved or already allocated for other purposes by the
> bootloader.
> 
> Mark _end as hidden to fix. This changes the relocation from R_386_32 to
> R_386_RELATIVE even on the pre-2.26 binutils.
> 
> For 64-bit, this is not strictly necessary, as the 64-bit kernel is only
> built as PIE if the linker supports -z noreloc-overflow, which implies
> binutils-2.27+, but for consistency, mark _end as hidden here too.
> 

Gentle reminder.

https://lore.kernel.org/lkml/20200207214926.3564079-1-nivedita@alum.mit.edu/
