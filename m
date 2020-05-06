Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615FFC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 22:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4030420753
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 22:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbgEFWSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 18:18:35 -0400
Received: from gate.crashing.org ([63.228.1.57]:41528 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729114AbgEFWSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 18:18:35 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 046MI3xQ029691;
        Wed, 6 May 2020 17:18:03 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 046MI1Hs029690;
        Wed, 6 May 2020 17:18:01 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 6 May 2020 17:18:01 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 1/2] powerpc/uaccess: Implement unsafe_put_user() using 'asm goto'
Message-ID: <20200506221801.GW31009@gate.crashing.org>
References: <23e680624680a9a5405f4b88740d2596d4b17c26.1587143308.git.christophe.leroy@c-s.fr> <87sggecv81.fsf@mpe.ellerman.id.au> <20200505153245.GN31009@gate.crashing.org> <87pnbhdgkw.fsf@mpe.ellerman.id.au> <20200506175849.GT31009@gate.crashing.org> <bd336b0f-9cf7-e2ce-e0a8-1891599638d1@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd336b0f-9cf7-e2ce-e0a8-1891599638d1@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 08:10:57PM +0200, Christophe Leroy wrote:
> Le 06/05/2020 à 19:58, Segher Boessenkool a écrit :
> >>  #define __put_user_asm_goto(x, addr, label, op)			\
> >>  	asm volatile goto(					\
> >>-		"1:	" op "%U1%X1 %0,%1	# put_user\n"	\
> >>+		"1:	" op "%X1 %0,%1	# put_user\n"		\
> >>  		EX_TABLE(1b, %l2)				\
> >>  		:						\
> >>-		: "r" (x), "m<>" (*addr)				\
> >>+		: "r" (x), "m" (*addr)				\
> >>  		:						\
> >>  		: label)
> >
> >Like that.  But you will have to do that to *all* places we use the "<>"
> >constraints, or wait for more stuff to fail?  And, there probably are
> >places we *do* want update form insns used (they do help in some loops,
> >for example)?
> >
> 
> AFAICT, git grep "m<>" provides no result.

Ah, okay.

> However many places have %Ux:

<snip>

Yes, all of those are from when "m" still meant what "m<>" is now.  For
seeing how many update form insns can be generated (and how much that
matters), these all should be fixed, at a minimum.


Segher
