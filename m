Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96ABAC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CC320721
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I/lMOFuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388883AbgDBSZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 14:25:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44458 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732330AbgDBSZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 14:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uWgCX/1mc5yc7fqQ2M+/UK3mVmqfmNOaG9U6JirPJUs=; b=I/lMOFuqhoylI39oNfq1fQfPe8
        4328JjnIFNjnk8iVPMDAXdl9hWQ9ub7etqJG0CIqgUgFRZcEZKGVY0+MwdkSYR1BB34YW603xlQdc
        63oVpwOf4aw9M4g9GWt/0mzcYqEggaMcBbWQLsb+bM2siHli9qOoAT70S1Aiht58/TPQKO9G2M1wS
        jNCr4O9nf/a/rU+pbJylXiNvyMmT6ikenZoqx9dUtM9x9l1CZ7pPwId/mAtEKP/0CBFEzW+Dx2U2Y
        JBBWThvyQI9MTvAc/eUFCAaoAFNDO4hh7tdSr+REVPTD/PX1dDcA1DBBY3psIKNerdCpVPe9GSgAd
        A32NoznA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jK4XI-0001dm-Rr; Thu, 02 Apr 2020 18:25:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DFC543056DE;
        Thu,  2 Apr 2020 20:25:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BDA672B120905; Thu,  2 Apr 2020 20:25:49 +0200 (CEST)
Date:   Thu, 2 Apr 2020 20:25:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Julien Thierry <jthierry@redhat.com>, linux-kernel@vger.kernel.org,
        raphael.gault@arm.com
Subject: Re: [PATCH v2 10/10] objtool: Support multiple stack_op per
 instruction
Message-ID: <20200402182549.GI20730@hirez.programming.kicks-ass.net>
References: <20200327152847.15294-1-jthierry@redhat.com>
 <20200327152847.15294-11-jthierry@redhat.com>
 <20200402175426.77houvk46xhcxxmn@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402175426.77houvk46xhcxxmn@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 12:54:26PM -0500, Josh Poimboeuf wrote:
> On Fri, Mar 27, 2020 at 03:28:47PM +0000, Julien Thierry wrote:
> > @@ -127,6 +129,10 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
> >  	if (insn.sib.nbytes)
> >  		sib = insn.sib.bytes[0];
> >  
> > +	op = calloc(1, sizeof(*op));
> > +	if (!op)
> > +		return -1;
> > +
> 
> Why not malloc()?

calloc() does a memset(), I wondered the same and read the manpage ;-)

