Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8302C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F022081E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578927719;
	bh=IwFnZ0iS2TqcsY4ZJUrAuecFC99O9aKSSg5OWPi/iHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M5OKNL1hF1TBoecFfdM/vy8RffBq9K+v9IkrZFHQU8s10A0VEHbwt1YOyXshBZJQ3
	 KtVx9dMXlsuOisnbIvzyl8xLAYsTx+QXA7gpODXeELUEBPwTlx0qaFnuT+gRfZPuel
	 /RMRzLBaP3HWL2DMPtrKUW182iVU7ZjBS+Cdvob4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgAMPB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:01:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:35962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbgAMPB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:01:57 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18E7F21556;
        Mon, 13 Jan 2020 15:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578927716;
        bh=IwFnZ0iS2TqcsY4ZJUrAuecFC99O9aKSSg5OWPi/iHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yil8UwhmgUW1I5DUpfw5Wf2O/odBx0QvZpNz4/fkshx9BKVq4jS2366ElerA4s2yz
         +AFTww45L2YrUS4PiG0Spnvcquaro7Ll9/UlM58xtWjbfBHCcoVGwYMuX+h97YQG5o
         9i/iIqU+7TAIPFacWTIoj+p4e2aBsRPtm+I9VwSU=
Date:   Mon, 13 Jan 2020 15:01:52 +0000
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC PATCH 7/8] locking/barriers: Use '__unqual_scalar_typeof'
 for load-acquire macros
Message-ID: <20200113150151.GC4458@willie-the-truck>
References: <20200110165636.28035-1-will@kernel.org>
 <20200110165636.28035-8-will@kernel.org>
 <CAK8P3a2dBFiu37_YAvpoug-+RkKqq3i+8-Tkv5HPBag3JAEJrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2dBFiu37_YAvpoug-+RkKqq3i+8-Tkv5HPBag3JAEJrA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 08:42:37PM +0100, Arnd Bergmann wrote:
> On Fri, Jan 10, 2020 at 5:57 PM Will Deacon <will@kernel.org> wrote:
> 
> > @@ -128,10 +128,10 @@ do {                                                                      \
> >  #ifndef __smp_load_acquire
> >  #define __smp_load_acquire(p)                                          \
> >  ({                                                                     \
> > -       typeof(*p) ___p1 = READ_ONCE(*p);                               \
> > +       __unqual_scalar_typeof(*p) ___p1 = READ_ONCE(*p);               \
> >         compiletime_assert_atomic_type(*p);                             \
> >         __smp_mb();                                                     \
> > -       ___p1;                                                          \
> > +       (typeof(*p))___p1;                                              \
> >  })
> 
> Doesn't that last  (typeof(*p))___p1 mean you put the potential
> 'volatile' back on the assignment after you went through the
> effort of taking it out?

Yes, but that's ok wrt codegen since the local variable isn't volatile,
and I definitely ran into issues with 'const' if I returned the unqualified
type here.

Will
