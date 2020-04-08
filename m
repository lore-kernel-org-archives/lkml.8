Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2D4C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 08:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9406020769
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 08:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A1T8p1qr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbgDHIw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 04:52:29 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40432 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgDHIw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 04:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LGMlwxA6iQKlbkoboMiMffftFbfeoS94qV39YmWsn/s=; b=A1T8p1qrP/TaONEfVnHluuKPl6
        Z3hadrSaWt4qacRmm4slU8C7HNzwELWEnY3G/eoSYaEWV4+mAH0Hm37saLoY4cThh7O3pY+uKpAH+
        QIf2PLD6extSoXdd9/EIb/thI85jjdsiWH/GDOfdPWh8nVmKaeMp1VtOb0Y/DYbA7ekKtJe39XYtH
        acw7CTuWPMhtu1svywaojutx/huJ3T3sHDNMKz5phmULRjLmaJGcG++drinY7dFO2RgwnwZx/xeck
        H6l0P+6r7g45ImA2owX87KEl+CrNuO2u3JiulaIt0GoGl243xv9roJTx/Tj7lkC7Cxlp4lIDGAVNK
        CJERZ3xA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jM6Qu-0006Ln-9K; Wed, 08 Apr 2020 08:51:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 87400305FB6;
        Wed,  8 Apr 2020 10:51:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 735992BB00B60; Wed,  8 Apr 2020 10:51:38 +0200 (CEST)
Date:   Wed, 8 Apr 2020 10:51:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        sean.j.christopherson@intel.com, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, kenny@panix.com, jeyu@kernel.org,
        rasmus.villemoes@prevas.dk, pbonzini@redhat.com,
        fenghua.yu@intel.com, xiaoyao.li@intel.com, nadav.amit@gmail.com,
        thellstrom@vmware.com, tony.luck@intel.com,
        gregkh@linuxfoundation.org, jannh@google.com,
        keescook@chromium.org, David.Laight@aculab.com,
        dcovelli@vmware.com, mhiramat@kernel.org,
        Wolfgang Mauerer <wolfgang.mauerer@oth-regensburg.de>
Subject: Re: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
Message-ID: <20200408085138.GQ20713@hirez.programming.kicks-ass.net>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.429362016@infradead.org>
 <20200407174824.5e97a597@gandalf.local.home>
 <137fe245-69f3-080e-5f2b-207cd218f199@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <137fe245-69f3-080e-5f2b-207cd218f199@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 07:58:53AM +0200, Jan Kiszka wrote:
> On 07.04.20 23:48, Steven Rostedt wrote:

> > Hmm, wont this break jailhouse?

Breaking it isn't a problem, it's out of tree and it should be fixable.

> Yes, possibly. We load the hypervisor binary via request_firmware into
> executable memory and then jump into it. So most of the "suspicious" code is

W.T.H. does the firmware loader have the ability to give executable
memory? We need to kill that too. /me goes find.
