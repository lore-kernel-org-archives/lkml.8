Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BF4C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 19:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DE6C20786
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 19:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbgDPTC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 15:02:29 -0400
Received: from gate.crashing.org ([63.228.1.57]:48202 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727800AbgDPTC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 15:02:26 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 03GJ20UU003931;
        Thu, 16 Apr 2020 14:02:00 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 03GJ1wgI003930;
        Thu, 16 Apr 2020 14:01:59 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 16 Apr 2020 14:01:58 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc/uaccess: Implement unsafe_put_user() using 'asm goto'
Message-ID: <20200416190158.GC26902@gate.crashing.org>
References: <c9abd91e9bb0b3dd6e3470015e92b98bc2483780.1586942304.git.christophe.leroy@c-s.fr> <20200415223747.GX26902@gate.crashing.org> <f797e5ac-a29a-0eb0-89c8-ff0a9f537ccf@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f797e5ac-a29a-0eb0-89c8-ff0a9f537ccf@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 02:41:56PM +0200, Christophe Leroy wrote:
> Le 16/04/2020 à 00:37, Segher Boessenkool a écrit :
> >>+	__put_user_nocheck_goto((__typeof__(*(ptr)))(x), (ptr), 
> >>sizeof(*(ptr)), label)
> >
> >This line gets too long, can you break it up somehow?
> 
> This line has 86 chars.

(And your mail program has wrapped it ;-) )

> powerpc arch tolerates lines with up to 90 chars, see 
> arch/powerpc/tools/checkpatch.sh

I *tolerate* it as well, sure, but long lines are bad for readability.
Like, I noticed it because it wrapped :-)

That "90" thing is just dumb, we should get rid of it.  Sometimes you
can have long lines, if that is better than the alternatives.  There
does not need to be a ridiculous "rule" that is unhappy *both* ways!

(This is true for many things in checkpatch, btw...  Rules of thumb,
not rules).


Segher
