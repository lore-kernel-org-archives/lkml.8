Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DD4C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72CE4227BF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnzvOfZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgBFO5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 09:57:43 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:32839 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgBFO5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 09:57:43 -0500
Received: by mail-qv1-f68.google.com with SMTP id z3so2989157qvn.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 06:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RZ9NJDIbWcrAEyEkJwDMX1aZAP0YYo29FNXlGHMIGQw=;
        b=dnzvOfZJKCM5xvqTIclONKxwiBItGZs8UIgn8Fk10PpAuZaplCf7IscWx4zMayxhcO
         ReV5O9ns/ekvQcmhhx0l/Mx/9QK+WSrmJfOS/yqSkCH8a+r8IuZrD+nfAw0uX+tAYMgV
         Io8k1IZ8ovNPruVZatVwYPFBDoexpLx+112VqTOgrKbIGilUOQZtOA3hKjhP6hpS+89R
         ZTsjc/21sT3pAD+sCwDcYj1iGK3aW9UAWKkm/ccVgs1Pyzuy7qvcS9ZOph3gIEecZ4bW
         +rQToxvK5oaJ7ZLvpLsxrARapxPqZWZgRdS1C7P8KodRAJ0H1MJQXdouR3S9UTWFZHJB
         1OMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RZ9NJDIbWcrAEyEkJwDMX1aZAP0YYo29FNXlGHMIGQw=;
        b=E7No1oYYacdsquvdQtizajI12OvKrG/1zrS6JA0qoGS6YlzOchf33TZegaal+4rlfC
         YLOoWxX1+YOGDX/MiTCnS8Dxb5FSBqAZARPJDU9YOE9qQHBJS9VoaSW+XHsE+9z6UBd1
         ZfqBYX0+3JQ+nDjA/LwHhC+98f0Zg6sYwYNvWr/m1lBH3jFaESFWAoPoFYeSoWGcM2wt
         sginuTU7S1UviIbY98mEl80n0ItzBqNfJCim6sbtmvueWSl5eZc/7UQLBjEpd4nIN1iI
         tVV00isF4UYAmQ4zpPrJauvkTUsTwi17AvLtAN4OxA5Pj8mo9ofMg17IJoQqHLGBSBI6
         i1JA==
X-Gm-Message-State: APjAAAU0R4TxQk8ETnAKrHcxGkDWNwTPsqya5l2QunfUw0ujEojFmnDo
        /WHrkzph7pidQnkPCUPKliO5vnxF
X-Google-Smtp-Source: APXvYqzSR+LvuHHY7wghsgNsc3U54x7pEcW92hBA1JGBJkdzhFttgrScjQyIM2VUxm8P7vgTDk+piA==
X-Received: by 2002:ad4:4c42:: with SMTP id cs2mr2655012qvb.198.1581001062337;
        Thu, 06 Feb 2020 06:57:42 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id h8sm1709132qtm.51.2020.02.06.06.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 06:57:41 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 6 Feb 2020 09:57:40 -0500
To:     Kees Cook <keescook@chromium.org>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 06/11] x86: make sure _etext includes function
 sections
Message-ID: <20200206145738.GA3049612@rani.riverdale.lan>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
 <20200205223950.1212394-7-kristen@linux.intel.com>
 <202002060408.84005CEFFD@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202002060408.84005CEFFD@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 04:26:23AM -0800, Kees Cook wrote:
> On Wed, Feb 05, 2020 at 02:39:45PM -0800, Kristen Carlson Accardi wrote:
> > We will be using -ffunction-sections to place each function in
> > it's own text section so it can be randomized at load time. The
> > linker considers these .text.* sections "orphaned sections", and
> > will place them after the first similar section (.text). However,
> > we need to move _etext so that it is after both .text and .text.*
> > We also need to calculate text size to include .text AND .text.*
> 
> The dependency on the linker's orphan section handling is, I feel,
> rather fragile (during work on CFI and generally building kernels with
> Clang's LLD linker, we keep tripping over difference between how BFD and
> LLD handle orphans). However, this is currently no way to perform a
> section "pass through" where input sections retain their name as an
> output section. (If anyone knows a way to do this, I'm all ears).
> 
> Right now, you can only collect sections like this:
> 
>         .text :  AT(ADDR(.text) - LOAD_OFFSET) {
> 		*(.text.*)
> 	}
> 
> or let them be orphans, which then the linker attempts to find a
> "similar" (code, data, etc) section to put them near:
> https://sourceware.org/binutils/docs-2.33.1/ld/Orphan-Sections.html
> 
> So, basically, yes, this works, but I'd like to see BFD and LLD grow
> some kind of /PASSTHRU/ special section (like /DISCARD/), that would let
> a linker script specify _where_ these sections should roughly live.
> 

You could go through the objects that are being linked and find the
individual text sections, and generate the linker script using that?
