Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28ABCC33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 16:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00A3206E3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 16:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgBAQSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 11:18:06 -0500
Received: from gate.crashing.org ([63.228.1.57]:55059 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbgBAQSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 11:18:05 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 011GHdmS018483;
        Sat, 1 Feb 2020 10:17:39 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 011GHbUu018479;
        Sat, 1 Feb 2020 10:17:37 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sat, 1 Feb 2020 10:17:37 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/32s: Don't flush all TLBs when flushing one page
Message-ID: <20200201161737.GO22482@gate.crashing.org>
References: <e31c57eb5308a5a73a5c8232454c0dd9f65f6175.1580485014.git.christophe.leroy@c-s.fr> <20200131155150.GD22482@gate.crashing.org> <27cef66b-df5b-0baa-abac-5532e58bd055@c-s.fr> <20200131193833.GF22482@gate.crashing.org> <248a3cf3-1b5e-a6e1-ceec-0e3904d1cf51@c-s.fr> <20200201140629.GM22482@gate.crashing.org> <96671e01-6206-8952-a498-942b42e98ef0@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96671e01-6206-8952-a498-942b42e98ef0@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 01, 2020 at 03:53:12PM +0100, Christophe Leroy wrote:
> >>No, in end the low bits are set, that's a BIT OR with ~PAGE_MASK, so it
> >>sets all low bits to 1.
> >
> >Oh, wow, yes, I cannot read apparently.
> >
> >Maybe there are some ROUND_DOWN and ROUND_UP macros you could use?
> 
> Yes but my intention was to modify the existing code as less as possible.
> What do you think about version v2 of the patch ?

It looked fine to me.

Add my

Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>

if you want.


Segher
