Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F57C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 19:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47AA720707
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 19:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgAaTjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 14:39:03 -0500
Received: from gate.crashing.org ([63.228.1.57]:58945 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbgAaTjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 14:39:03 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 00VJcZbS006329;
        Fri, 31 Jan 2020 13:38:35 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 00VJcXRI006321;
        Fri, 31 Jan 2020 13:38:33 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 31 Jan 2020 13:38:33 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/32s: Don't flush all TLBs when flushing one page
Message-ID: <20200131193833.GF22482@gate.crashing.org>
References: <e31c57eb5308a5a73a5c8232454c0dd9f65f6175.1580485014.git.christophe.leroy@c-s.fr> <20200131155150.GD22482@gate.crashing.org> <27cef66b-df5b-0baa-abac-5532e58bd055@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27cef66b-df5b-0baa-abac-5532e58bd055@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 05:15:20PM +0100, Christophe Leroy wrote:
> Le 31/01/2020 à 16:51, Segher Boessenkool a écrit :
> >On Fri, Jan 31, 2020 at 03:37:34PM +0000, Christophe Leroy wrote:
> >>When the range is a single page, do a page flush instead.
> >
> >>+	start &= PAGE_MASK;
> >>+	end = (end - 1) | ~PAGE_MASK;
> >>  	if (!Hash) {
> >>-		_tlbia();
> >>+		if (end - start == PAGE_SIZE)
> >>+			_tlbie(start);
> >>+		else
> >>+			_tlbia();
> >>  		return;
> >>  	}
> >
> >For just one page, you get  end - start == 0  actually?
> 
> Oops, good catch.
> 
> Indeed you don't get PAGE_SIZE but (PAGE_SIZE - 1) for just one page.

You have all low bits masked off in both start and end, so you get zero.
You could make the condion read "if (start == end)?

Maybe a nicer way to describe what you do is "if start and end are on the
same memory page, flush that page."


Segher
