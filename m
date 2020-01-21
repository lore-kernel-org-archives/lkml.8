Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45337C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D1C2253D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579602622;
	bh=CFvr2yZi8uW4XNkhcRrDChld0311DjfCPF5hmWVFq2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ukZwijVp1JWLjKOTYwNAffM2/C3koxyoRxlij6K+65c4rNviySO0Ud6L7nPm0Z4NG
	 AGGYmtg7p6qixgP2Ixqr4XzOsF+1S6lfuP5mtKIzJtzC4kgVXBmrmporAEb0938798
	 UMKWLxPmrIGTF4nqH/Bzx2oZJeuoyyCek6pl2838=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbgAUKaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:30:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:47830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728792AbgAUKaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:30:21 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE7C620678;
        Tue, 21 Jan 2020 10:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579602621;
        bh=CFvr2yZi8uW4XNkhcRrDChld0311DjfCPF5hmWVFq2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0MP6HHPrVVzubge9LFKPs2C7/a5MhgGKkqCgklkd87xtb5fGI0LbX2zgVFRKSm31N
         2MVekLMbQ1OB+TCX4J0MFIBvX9z/YUwE5S6aoQ71QpYqnygk3WXBrW7UgvuJ08gfl2
         shlScMCvueUcvHYilImUt8EImVg25wKcTpUwdmrA=
Date:   Tue, 21 Jan 2020 10:30:16 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Julien Thierry <jthierry@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jpoimboe@redhat.com,
        raphael.gault@arm.com, catalin.marinas@arm.com
Subject: Re: [RFC v5 12/57] objtool: check: Allow jumps from an alternative
 group to itself
Message-ID: <20200121103016.GB11154@willie-the-truck>
References: <20200109160300.26150-1-jthierry@redhat.com>
 <20200109160300.26150-13-jthierry@redhat.com>
 <20200120145656.GC14897@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120145656.GC14897@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 03:56:56PM +0100, Peter Zijlstra wrote:
> On Thu, Jan 09, 2020 at 04:02:15PM +0000, Julien Thierry wrote:
> > Alternatives can contain instructions that jump to another instruction
> > in the same alternative group. This is actually a common pattern on
> > arm64.
> 
> LL/SC I bet...

I think there are some nasty errata workarounds that need it too.

WIll
