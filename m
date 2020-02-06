Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16B8C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814332082E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ys8PYYc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgBFOjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 09:39:46 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38869 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbgBFOjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 09:39:46 -0500
Received: by mail-qt1-f195.google.com with SMTP id c24so4636011qtp.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 06:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i8ZXRcb1q1ZSxQ8Q/mjcQROT9/CmLPHcpBtDmaBy1Do=;
        b=Ys8PYYc/0KffCBFLBHCfIiPTSWh7o1gs3pvRab778kYvcRem+EEiC9ArZsRPtdj/MU
         qz8rh87ZY4R8tPufcXRQ3WJZSBAv4EHo4oS6iNeaIewlyDE1i2lE1m5TCGmLzxJk3ol/
         bIjLXlLTmfXIX3l79fRVQWu9wo+eXgVNQju9mZliLwvBZu35Br26tMCtk4f1h9HiFUjG
         sqkZpxTdi4r1pM8uPb/wfWgmgOrA4ZR86hVUtj42PSRmET8iDZsrhaJh7VaGFlhJOZE2
         1/EHItqP5lbpohrYWipysvn41cif3BBCHN/jgOlcUgnUJFTodDjrrsqjuEC185sijP9c
         nJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=i8ZXRcb1q1ZSxQ8Q/mjcQROT9/CmLPHcpBtDmaBy1Do=;
        b=UqpNyLlvY/Qs3Gchjd1t87Kndbh1V2Rwh0oms1NU+3gSdoMiYq2/TkqZWNlaL6azLZ
         P1hHuOVmGyardXFnBe5lDni/N7v64lFWX0NkIOjRLOp9YudMTbNL7bciDro/YHpQxOX6
         m9x5dpxXi4+5EyxDmikUZIwQuPwKFnBFkVTL69Cqwmfe9t5stXWsEKjA+q0UmJV1iUE0
         u/hYIzAWlNZgV6ylrQaZelZcTEO0RXiLaDN3hFDBnJXolPDUsxWlS9r+9wmP6RTXxpMJ
         IpV9lwlv61uj9ZJ7Cfv6nYt8jAs51Y3hJov9BZRHE54KNlGJ9sG6ytF3AJWPIDoPIzav
         iMDQ==
X-Gm-Message-State: APjAAAUJEZoybR2NdpG+/VYzI6155lWTROKE3zh5wZf/wa+lTgUAhcOm
        m4ihM9lWg2C2kBtJ1h7VShc=
X-Google-Smtp-Source: APXvYqyhDdGz3eHPZG7fiLYgFKopt6WoAXsJMOS9fseDCa61oFpV5/CBKfnx7SYfx4rk1uiOCCLshQ==
X-Received: by 2002:ac8:75d8:: with SMTP id z24mr2850675qtq.193.1580999985259;
        Thu, 06 Feb 2020 06:39:45 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c45sm1787163qtd.43.2020.02.06.06.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 06:39:45 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 6 Feb 2020 09:39:43 -0500
To:     Kees Cook <keescook@chromium.org>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 06/11] x86: make sure _etext includes function
 sections
Message-ID: <20200206143941.GA3044151@rani.riverdale.lan>
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
> I know x86_64 stack alignment is 16 bytes. I cannot find evidence for
> what function start alignment should be. It seems the linker is 16 byte
> aligning these functions, when I think no alignment is needed for
> function starts, so we're wasting some memory (average 8 bytes per
> function, at say 50,000 functions, so approaching 512KB) between
> functions. If we can specify a 1 byte alignment for these orphan
> sections, that would be nice, as mentioned in the cover letter: we lose
> a 4 bits of entropy to this alignment, since all randomized function
> addresses will have their low bits set to zero.
> 

The default function alignment is 16-bytes for x64 at least with gcc.
You can use -falign-functions to specify a different alignment.

There was some old discussion on reducing it [1] but it doesn't seem to
have been merged.

[1] https://lore.kernel.org/lkml/tip-4874fe1eeb40b403a8c9d0ddeb4d166cab3f37ba@git.kernel.org/
