Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CF3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96F74207C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Op3B2LdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390862AbgEYOIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388862AbgEYOIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:08:20 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFF9C061A0E;
        Mon, 25 May 2020 07:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PO3yERWHmB8+QRSkMGVpwgQOq3YGaqk7/bHMgrlUzuQ=; b=Op3B2LdRkLowOoFosfpIk3IvYW
        5kDfoxDzKbBWHO1iuggHZzE0DEU97ZulQpMA/rBfv/iuADt73Np3Ih13qRhkZVW4eQZN8CE/CGJn3
        f8dRiwUt4xvamUEcIURsgXAx0up8jKmVvBW9ZOIadnCo+plYOOU7I0xuVkRA90qbB1nbhZW04TSO6
        nMP3xEB2J2l5SjwSXvf4r76jlb1j2vfIWCA6cYFtKRS44luNJu2CeB76WYg2pLH51sN+BRmGY0TUs
        PMZZT58WMIRFxGzrshnPNK7pJbNYXf+KsAvae6BACKypIYpBPlG3dkFluV3Q66nje5z/F0m32404E
        S+GEv6UQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdDlh-0008SV-Q3; Mon, 25 May 2020 14:07:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 421D230018B;
        Mon, 25 May 2020 16:07:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F1E99285ECE8A; Mon, 25 May 2020 16:07:51 +0200 (CEST)
Date:   Mon, 25 May 2020 16:07:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 10/25] seqlock: Add RST directives to kernel-doc code
 samples and notes
Message-ID: <20200525140751.GH325303@hirez.programming.kicks-ass.net>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200519214547.352050-11-a.darwish@linutronix.de>
 <20200522180254.GS325280@hirez.programming.kicks-ass.net>
 <20200522180336.GD325303@hirez.programming.kicks-ass.net>
 <871rnbsu57.fsf@nanos.tec.linutronix.de>
 <20200522183216.GT325280@hirez.programming.kicks-ass.net>
 <20200525093649.GA370823@debian-buster-darwi.lab.linutronix.de>
 <20200525134429.GE317569@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525134429.GE317569@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 03:44:29PM +0200, Peter Zijlstra wrote:

> I've never claimed that. My claim is that RST is shite and has no added
> value.

Or rather, it has negative value, for it makes comments less readable.
