Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B85DC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 02:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66E0C207DD
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 02:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsSx91mq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgGSCeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 22:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbgGSCeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 22:34:08 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A17C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 19:34:08 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g26so2130376qka.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 19:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qX58jUqaJ49mNFouIofRWLjVD0TFUn0tvAooDUGQpj4=;
        b=KsSx91mqPqOYLsM7Ws6rKLhe9zoMM09xDHn24fh7T8HvoaOXyDuX/6LqfdrJKtHcKm
         r8QCEMjkH45Ym3ixp8GOozN9Xq5oW8GCIJu77aXZ1/rW1x15wozBYKQB+Z+zEgNpLQWK
         kGh6TU5f1GZZRT5rpW1s6tkPoWjGNcPpSF5XRYehiZakLdSHavPcAjW/wVz1P9lMg6ib
         ZuIQztVhYFtIOd5/7WHc7kdkBXZ6jXp++pJwWr4Zx6kBdHwWEJ6ATdtJHTMwcXSW+8yw
         HX24b+NngdYmawUV/W9eHr8uUj+cyP1lmjg/NXu5yRRpCOaFjCEY9ny4f7/wsnqYe7GD
         NVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=qX58jUqaJ49mNFouIofRWLjVD0TFUn0tvAooDUGQpj4=;
        b=S/z4NU7RjG8P6AwZNcTEDKdFRAl1UredEUMaK1jhiw+L2rIKY5BJoGgExF+sMbBvMK
         AxKJt0/I5tn8q4hAPXtXTcn3QXMBZOP+3VV3nA4tiXxmcGyXzv0MPkYko2JEcjXvZl0+
         qyEjh5qKeJcT+vL7OPIY2FYX4Q5C8zrpMSn5E9qLUYQ94DYtErxm7+Mmz4O40Pd+2gnE
         uF14hKqk6za00Erktpq1/dLVO6fZVA7hUd2HnF4NvokzWzBnZjNIF7J2u6N0vW2dyTAn
         vmExoJbPJGoNHnLvgv1i9n1gHX4RVzM2L2GBf0vB6rKsLLRDqhXR1yFu6/ypbhwwdIhn
         yzYw==
X-Gm-Message-State: AOAM532f9+nSehqArzSaWE0qZAMMUa1xq8sSIk+NumKb7Za/tIjL9IEP
        WinCa74iMhjbCcjci7B77vE=
X-Google-Smtp-Source: ABdhPJxqbXU65xiH5Xa24eGyDuOy7WMedN+rbe1CLICiI6FBE0dW38ccHS9ST+HtDkrBltmsW5GXrg==
X-Received: by 2002:a37:7ec5:: with SMTP id z188mr7128646qkc.461.1595126047686;
        Sat, 18 Jul 2020 19:34:07 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o4sm16485127qtf.92.2020.07.18.19.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 19:34:07 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 18 Jul 2020 22:34:05 -0400
To:     hpa@zytor.com
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/idt: Make sure idt_table takes a whole page
Message-ID: <20200719023405.GA564835@rani.riverdale.lan>
References: <0CEC6A66-FD50-4B6B-9521-A40E5B9DA10F@zytor.com>
 <7FB389D0-77D4-482E-8A21-8662DDB00268@amacapital.net>
 <0B7CF270-EC04-4907-821A-A01F24BEF156@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0B7CF270-EC04-4907-821A-A01F24BEF156@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 06:15:26PM -0700, hpa@zytor.com wrote:
> On July 18, 2020 12:25:46 PM PDT, Andy Lutomirski <luto@amacapital.net> wrote:
> >
> >> On Jul 18, 2020, at 10:57 AM, hpa@zytor.com wrote:
> >> 
> >> ﻿On July 9, 2020 3:33:55 AM PDT, Joerg Roedel <joro@8bytes.org>
> >wrote:
> >>> From: Joerg Roedel <jroedel@suse.de>
> >>> 
> >>> On x86-32 the idt_table with 256 entries needs only 2048 bytes. It
> >is
> >>> page-aligned, but the end of the .bss..page_aligned section is not
> >>> guaranteed to be page-aligned.
> >>> 
> >>> As a result, symbols from other .bss sections may end up on the same
> >>> 4k page as the idt_table, and will accidentially get mapped
> >read-only
> >>> during boot, causing unexpected page-faults when the kernel writes
> >to
> >>> them.
> >>> 
> >>> Avoid this by making the idt_table 4kb in size even on x86-32. On
> >>> x86-64 the idt_table is already 4kb large, so nothing changes there.
> >>> 
> >>> Fixes: 3e77abda65b1c ("x86/idt: Consolidate idt functionality")
> >>> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> >> 
> >> NAK... this isn't the right way to fix this and just really kicks the
> >can down the road. The reason is that you aren't fixing the module that
> >actually has a problem.
> >> 
> >> The Right Way[TM] is to figure out which module(s) lack the proper
> >alignment for this section. A script using objdump -h or readelf -SW
> >running over the .o files looking for alignment less than 2**12 should
> >spot the modules that are missing the proper .balign directives.
> >
> >I don’t see the problem. If we are going to treat an object as though
> >it’s 4096 bytes, making C think it’s 4096 bytes seems entirely
> >reasonable to me.
> >
> >> -- 
> >
> >> Sent from my Android device with K-9 Mail. Please excuse my brevity.
> 
> It isn't the object, it is its alignment. You can have an object
> page-aligned so it doesn't cross page boundaries.
> 
> The bigger issue, though, is that this means there are other object
> files which don't have the correct alignment directives, which means
> that this error can crop up again at any point. The really important
> thing here is that we fix the real problem.  -- 
> Sent from my Android device with K-9 Mail. Please excuse my brevity.

To repeat the commit message, the problem is not misaligned
bss..page_aligned objects, but symbols in _other_ bss sections, which
can get allocated in the last page of bss..page_aligned, because its end
isn't page-aligned (maybe it should be?)

bss..page_aligned objects are unlikely to be misaligned, because its
used in C via a macro that includes the alignment attribute, and its
only use in x86 assembly is in head_{32,64}.S which have correct
alignment.

Given that this IDT's page is actually going to be mapped with different
page protections, it seems like allocating the full page isn't
unreasonable.
