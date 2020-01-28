Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84629C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 20:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294B220708
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 20:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580242461;
	bh=4SM/2bdnv+DFbeLsTV2fqxBw/Yh8zMSu+SuA3eOC/1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Nz5NkWFgKkofjjDEq9ME0XRyO/ea8Lq2zLEXAVxORpz040nwTwIlGi5sUMMAgYHVY
	 efNZRk1xpCG9DrWzHaQgXM4okDmmD1TABMgQe4q4EqNFoNfs5JIzgUzqlpbAPVAnoe
	 NTefQYdyn1Sm7mksb4Gx4lr8PZsbjQMLQ+mu1+jA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgA1UOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 15:14:20 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51305 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgA1UOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 15:14:20 -0500
Received: by mail-wm1-f65.google.com with SMTP id t23so3925411wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 12:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y/ed9DUQExY9n11iK5mbjNhe8YjTArUKxK4NVRoKnXc=;
        b=VybF2xFfvJabsCgeo4SwZvw7v3ouC7JxqF/KS3M/WSwRoFOd7xjvrwH1s21UNAzSr6
         PvSHkGRqgb+9qYFMQ92KJMdcU9vovmhiCjAWorvdueMlBH9kqGaNE8VInQow7shLsq0q
         OmPP/xDOKziicv0Je1CWw9Im8WFpGIGy6tWaaRAzZjylJOd1vHf1knc4+aw9RezZzPFW
         Fv0HHHno4AyyB0b0OohgcFlLB1tw2HI0Kxs7wkefTVVElyXC45XJTdUDvap1KoxV27Xn
         Zav9SN/DK1pv0S0ANaovA4Qz7d3wmwh4pJz/cW+iz6F57YqsH7KYeoe48okthhIK/Md5
         duzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=y/ed9DUQExY9n11iK5mbjNhe8YjTArUKxK4NVRoKnXc=;
        b=ZUxdG7kXFoC+i7RjspbadOt+D0dBeeZMkeOb7+sVHxyTvZyV9Ezbm0mu9UbV7vl9Nu
         2LbOFGsn2LQvW0qV+QvcWaHkQQlKZSX5BegV8LeHkLgKpcXRt6yu/J4lV0RSJd/XPHpb
         HVXJZZQRQxi+sJHijjZWfu0R1shTcUifTW0p98PnHIRwBGREfq1jCR7MR/fSo9QyTOf/
         pd+8wbkAVaHIVQ5UM1JY7bVlFDoQhdL0ZpgUfU8hztr6agfPsYrV0bPLswSHVpzkV4CX
         cqIDWk6aYqOH73A5CHwJMb7XFKfvPAg+kqC0L9tPeTQBBHImspJV8xdy4iNTF8AWBW0R
         P40Q==
X-Gm-Message-State: APjAAAU6RpRfDLth7op6mexlbMfD+NuvKeQuICIre6IdFZoqmF0Cs6LA
        cDTHVm5ny35P4R1k5yFkhf8=
X-Google-Smtp-Source: APXvYqzZNMu6ODSHvWgoDTZLaLu1muxIJVdFQ3ZzjU2etpeEsDzN9DZZHHilsFHH+kkujz7zq4vDOg==
X-Received: by 2002:a7b:c4cc:: with SMTP id g12mr7336168wmk.68.1580242458477;
        Tue, 28 Jan 2020 12:14:18 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id v3sm27201166wru.32.2020.01.28.12.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 12:14:17 -0800 (PST)
Date:   Tue, 28 Jan 2020 21:14:15 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86/asm changes for v5.6
Message-ID: <20200128201415.GA89586@gmail.com>
References: <20200128165906.GA67781@gmail.com>
 <CAHk-=wgm+2ac4nnprPST6CnehHXScth=A7-ayrNyhydNC+xG-g@mail.gmail.com>
 <CAHk-=wi=otQxzhLAofWEvULLMk2X3G3zcWfUWz7e1CFz+xYs2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi=otQxzhLAofWEvULLMk2X3G3zcWfUWz7e1CFz+xYs2Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, Jan 28, 2020 at 11:51 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> >         ALTERNATIVE_2 \
> >                 "cmp  $680, %rdx ; jb 3f ; cmpb %dil, %sil; je 4f", \
> >                 "movq %rdx, %rcx ; rep movsb; retq", X86_FEATURE_FSRM, \
> >                 "cmp $0x20, %rdx; jb 1f; movq %rdx, %rcx; rep movsb; retq", X86_FEATURE_ERMS
> 
> Note the UNTESTED part.
> 
> In particular, I didn't check what the priority for the alternatives
> is. Since FSRM being set always implies ERMS being set too, it may be
> that the ERMS case is always picked with the above code.
> 
> So maybe the FSRM and ERMS lines need to be switched around, and
> somebody should add a comment to the ALTERNATIVE_2 macro about the
> priority rules for feature1 vs feature2 when both are set..
> 
> IOW, testing most definitely required for that patch suggestion of mine..

Understood, thanks!

	Ingo
