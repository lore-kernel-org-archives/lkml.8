Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D17C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 11:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E63F21707
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 11:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JGwYkKAG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgIGLtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 07:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729059AbgIGLqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:46:35 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC171C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 04:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6Meo6VP3IoqacG95rPph6TDsxA/MRSELmhoUGpi7TNA=; b=JGwYkKAGN4NSZcP+XEryM4KmDX
        IrlEnLSS1+CZgqgZLfmBFySPL5yzkU3ykYwyGFstAn7eRGBJwWI8oubTSdYwBUn1hHxjmI+lkN5C7
        ET4RXOCcynRA5Dz3Z24iCW1vNaxCLSJfCpr6c+QUeDNbqBxBpyjACYdF3Pb4B9e1EMYisfC9o76h/
        a3XZxfa0pI8tkS4D4228dR7OSWb8on5QTAWV6YpLKDaRXI9GU7IXcifSBAgFhlIW++xv6lFg/WvM6
        bXSL3a0N/ZhZO/Jcsl1NLKgOJrcRH7q3wRfdv69HW7CzhFUCZb8pewqt4TsVaSogNlLUsJfTAjf5L
        CcRMZNdA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFFbJ-0002NU-3H; Mon, 07 Sep 2020 11:46:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1523D300130;
        Mon,  7 Sep 2020 13:46:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EA024201057EE; Mon,  7 Sep 2020 13:46:18 +0200 (CEST)
Date:   Mon, 7 Sep 2020 13:46:18 +0200
From:   peterz@infradead.org
To:     Joerg Vehlow <lkml@jv-coder.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>
Subject: Re: [BUG RT] dump-capture kernel not executed for panic in interrupt
 context
Message-ID: <20200907114618.GR2674@hirez.programming.kicks-ass.net>
References: <2c243f59-6d10-7abb-bab4-e7b1796cd54f@jv-coder.de>
 <20200528084614.0c949e8d@gandalf.local.home>
 <cbbf7926-148e-7acb-dc03-3f055d73364b@jv-coder.de>
 <20200727163655.8c94c8e245637b62311f5053@linux-foundation.org>
 <c6b095af-fc92-420f-303f-d2efd9f28873@jv-coder.de>
 <20200821110848.6c3183d1@oasis.local.home>
 <20200821134753.9547695c9b782275be3c95b5@linux-foundation.org>
 <20200821170334.73b52fdd@oasis.local.home>
 <95d7a489-a295-1c11-ac62-83e941ed3a87@jv-coder.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95d7a489-a295-1c11-ac62-83e941ed3a87@jv-coder.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 12:51:37PM +0200, Joerg Vehlow wrote:
> Hi,
> 
> I guess there is currently no other way than to use something like Steven
> proposed. I implemented and tested the attached patch with a module,
> that triggers the soft lockup detection and it works as expected.
> I did not use inline functions, but normal function implemented in
> kexec_core,
> because there is nothing time critical here.
> I also added the mutex_lock to the trylock variant, because then the unlock
> function can be the same for both lock functions.
> 
> What do you think?

I think it's too complicated for that is needed, did you see my
suggestion from a year ago? Did i miss something obvious?


