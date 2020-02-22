Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBED3C35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 17:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0CC2071E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 17:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ed0YXDpl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgBVRxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 12:53:36 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36780 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgBVRxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 12:53:36 -0500
Received: by mail-qk1-f193.google.com with SMTP id f3so2085650qkh.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 09:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OoXYjbkbmqVWu6iVaF4lgXs2+HYn6dbDpIOR72en5t4=;
        b=ed0YXDplB0bwxABjT+TUErhXVi1NE/M1r2lVNrpGUgsuu+LJeWWriMA+lRC0nNCwLs
         9nsABqNm2TkPIQ8izDuI/weiUgNZiN+0DfrfaBp2rDQ5mzFsvRtvuUGdt8AEAfScWHDB
         kKCAnES7FEp+XLA1gyDFz2lw91Qevgch5VIJBOGvpV4DzteMgcIpXC4kSvutuvFTaFdq
         1TEpbuPv+ab/WFHT7hHM54QLtTeCPw0A8YH7YKlJiYQV+jCa1R0s2WjrVpT9derkJRiQ
         kMZBlWGzoubDqe/hdI8jrAoR5J813Cr7NcYmWZFpxhnPfXyWV97zTXj5cWFxQE1O6ku/
         N7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OoXYjbkbmqVWu6iVaF4lgXs2+HYn6dbDpIOR72en5t4=;
        b=cHvRboRE4Tu2f7RHgThxKzqsJ0BmATIUnIxIhV+TZ7GTcQpTL5l2sxTnIrTHIJ0v//
         C9/mv30xi8a0yCM0MqMt8nLz3ZLEU5mAM7u1zpQ2dK8TPJIvANsl2568/HLmYtjxHrRd
         t+d6xQywVx4nofMaJbb9fPdsAIVvoVtyP89DPFYoHy39h6Vk1qWNMR0GN6O8l0zDE5jJ
         HTMKInwsVKCql9VdmTNisdqKoAitLZphWivf+LOKfYwK4I46/m8fBbgrpVMYpp98lIKe
         8dElEvL/pgAUGMLxfD0kksn46AKqaRMPj9IWKZZrFUtrt7UmfpVoP/moJWckbqEQyhez
         LTOw==
X-Gm-Message-State: APjAAAV+HbouMvuVuX36t9E+XWhvZpOWKYk84FpcrFOgBN26hoBWvl4r
        QBOmOkBVc4v2RAHHaEn+zTQ=
X-Google-Smtp-Source: APXvYqy1E/CwCTyKPZCppJ3szTceBegx4Qc1X1PO9knXvtXATafI+We1uhfPT/gRqIIQytMgboV+ng==
X-Received: by 2002:a37:6197:: with SMTP id v145mr39509968qkb.443.1582394014922;
        Sat, 22 Feb 2020 09:53:34 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id j17sm3258912qke.69.2020.02.22.09.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 09:53:34 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 22 Feb 2020 12:53:32 -0500
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH 2/2] x86/boot/compressed: Remove unnecessary sections
 from bzImage
Message-ID: <20200222175332.GA3610600@rani.riverdale.lan>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
 <20200109150218.16544-2-nivedita@alum.mit.edu>
 <20200222050845.GA19912@ubuntu-m2-xlarge-x86>
 <20200222065521.GA11284@zn.tnic>
 <20200222070218.GA27571@ubuntu-m2-xlarge-x86>
 <20200222072144.asqaxlv364s6ezbv@google.com>
 <20200222074242.GA17358@ubuntu-m2-xlarge-x86>
 <20200222153747.GA3234293@rani.riverdale.lan>
 <20200222164419.GB3326744@rani.riverdale.lan>
 <20200222172948.GC11284@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200222172948.GC11284@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 06:29:48PM +0100, Borislav Petkov wrote:
> On Sat, Feb 22, 2020 at 11:44:20AM -0500, Arvind Sankar wrote:
> > Boris, should I send the fix as a diff to the current patch in tip, or
> > as a fresh one that can replace it?
> 
> The offending commit is the top commit on tip:x86/boot so I'll merge
> your new one with it and thus "convert" the former one into the new one
> discarding .eh_frame only.
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

Thanks.
