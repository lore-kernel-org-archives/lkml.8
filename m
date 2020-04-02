Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F635C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23043206E9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y44LYPWR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389160AbgDBSwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 14:52:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54048 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732214AbgDBSwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 14:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qd5xuLJzU3mBucxLenFQ+oj6WqOdCWeIJKMVqEffaug=; b=Y44LYPWRj75Go9ZxA68YxS4Gtw
        DBiWZDq0vpo/K4QQ0jt5Cv1oJJzXXMjeV6OF6dFoCvpS9kqMleo8IoVOCWR+ACk6L1T+iCa2AVH/3
        u0Kiuji5tF1syj0LkhhGqJQ5ATiJNU5fk6ydylozSVTyjTWeZzIKmtu4Cr7Pl19A3oPkX7jeFgfzE
        nNwVtsvUx67GITe+EVx+axOqM1FfrHnzcMTFtu8509UAKQNL29Lhvg868KAQ6T0FWi5bA3IBhbZ7S
        zbik+HgiQpJiKJ+w57A5CUcVBnZ8fDQCSjASAVIFBr7ZsUREMoHjTcJyjTdT1BbYqITJAE2tIRxkJ
        HVv4aEIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jK4wQ-0003xo-FQ; Thu, 02 Apr 2020 18:51:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A175A305E45;
        Thu,  2 Apr 2020 20:51:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5A3D82B12094D; Thu,  2 Apr 2020 20:51:48 +0200 (CEST)
Date:   Thu, 2 Apr 2020 20:51:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch v2 1/2] x86,module: Detect VMX modules and disable
 Split-Lock-Detect
Message-ID: <20200402185148.GL20730@hirez.programming.kicks-ass.net>
References: <20200402123258.895628824@linutronix.de>
 <20200402124205.242674296@linutronix.de>
 <20200402152340.GL20713@hirez.programming.kicks-ass.net>
 <725ca48f-8194-658e-0296-65d4368803b5@intel.com>
 <20200402162548.GH20730@hirez.programming.kicks-ass.net>
 <2d2140c4-712a-2f8d-cde7-b3e64c28b204@intel.com>
 <87pncpn650.fsf@nanos.tec.linutronix.de>
 <20200402175127.GJ13879@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402175127.GJ13879@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 10:51:28AM -0700, Sean Christopherson wrote:
> On Thu, Apr 02, 2020 at 07:34:35PM +0200, Thomas Gleixner wrote:
> > Aside of that I'm still against the attempt of proliferating crap,
> > i.e. disabling it because the host is triggering it and then exposing it
> > to guests. The above does not change my mind in any way. This proposal
> > is still wrong.
> 
> Eh, I still think the "off in host, on in guest" is a legit scenario for
> debug/development/testing, but I agree that the added complexity doesn't
> justify the minimal benefits versus sld_warn.

Off in host on in guest seems utterly insane to me. Why do you care
about that?

That's like building a bridge with rotten timber.
