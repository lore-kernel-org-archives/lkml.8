Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7AEC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 17:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E0E620849
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 17:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590254407;
	bh=m05tFrEbf2m1NPbPYNxX3YOuv436rKNnJOpYIC07+kk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=A+FUGBpspbtOUAHI6ADshyUDXQ4wF6Hz7ndOuaZ6ljmcix+P9md9JShDK7XgZLik0
	 KLGqDBn2vGGemaQCous7CRJrx/ywR8ullvPyqKvrz5l0znE3ANDN2/eXhMq4MPPsx1
	 SucTD7D/gDVySbujXVOd4ZAfR7K6tAx5nfqqnR/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388110AbgEWRUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 13:20:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387571AbgEWRUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 13:20:05 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3154F2085B
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 17:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590254405;
        bh=m05tFrEbf2m1NPbPYNxX3YOuv436rKNnJOpYIC07+kk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ocetK+ReMqXLPvEAWNueUZVAkCN5naBt77jffyqNtmIqXptiyxgCfAts9+BUUw3Fy
         iwjeMp/AJSVOwxBzGbut1ebw5QpEESnS0MCUBICPBX8uuaJoIF30+oRXzm7imKdHPv
         3olGhI3ALdaEqYOurUcaqrjHZ2O0XbhA+2A26lYM=
Received: by mail-wr1-f54.google.com with SMTP id l11so13424297wru.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 10:20:05 -0700 (PDT)
X-Gm-Message-State: AOAM533ecIAowUgZwoVNPobfuYO7vq0kHXtDJZqIcvTUaCc/dtuZTaj/
        XWU6sFVAZnjVxA9nIIDaQoq1avmmY+0m6aqGochklw==
X-Google-Smtp-Source: ABdhPJygf+Ofrce7h1FhXXAEt66GetOSSV9c0nVEKeKvATyoyRigt6PTqqxZlJlYaPB2PDtfyA/+i4NM6vpS24BabmA=
X-Received: by 2002:adf:ea11:: with SMTP id q17mr6325873wrm.75.1590254403670;
 Sat, 23 May 2020 10:20:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200523155737.GC1189358@rani.riverdale.lan>
In-Reply-To: <20200523155737.GC1189358@rani.riverdale.lan>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 23 May 2020 10:19:52 -0700
X-Gmail-Original-Message-ID: <CALCETrW2O0xFe733EVchVDXdJv3tazA=aXuBQ3fKfmHEwdZnLQ@mail.gmail.com>
Message-ID: <CALCETrW2O0xFe733EVchVDXdJv3tazA=aXuBQ3fKfmHEwdZnLQ@mail.gmail.com>
Subject: Re: x86: Question about state of general purpose registers on switch
 to 64-bit mode
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 8:57 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Hi,
>
> I have a question about the state of the upper 32 bits of the general
> purpose registers following a switch from/to 64-bit mode.
>
> Both the AMD [0] and Intel [1] manuals state that these bits are
> undefined following a switch from 64 to 32-bit mode. Since they can't be
> accessed in 32-bit mode, presumably this means they are undefined once
> you switch back to 64-bit mode and can see them again.

I would guess that all x86_64 CPUs actually preserve those registers
across mode changes and clear the high bits on 32-bit operations.  But
making the kernel boot code more robust sounds entirely sensible to
me.
