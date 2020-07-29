Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A74EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42F8B20658
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NwBWlauT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgG2UJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgG2UJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 16:09:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D18C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 13:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HBPpMEN0+wHZjSVYvpdEqLIdalPNauSoM1Z1gLrPDn4=; b=NwBWlauTMU/PFjXOsLx23P+vJS
        al6iH5jWWEgxiNz3/5pFqCzKCnrAVfbs/0fjFu3+yo3NBOwSRyNivOypn654XYDQjGKB/TJtt/NaW
        WgjUKkSoOMdUDGKkM1F9tV14E+9YYR5QDan3r/hqU1aCQ58vKUPhHhIT9R5D2MoqQ2eLyNVwoSwhe
        llEpsZxMRZ3nkK5URczZk9PaCS5JLgCBW3KF76oQsU86fT0GToiTvK8Ix7LOYEQ9Cl2LfH6MNi1Kg
        0zrgZgrjE+oB1p3s7DbnpEuJHyasjCPbn+T7EqKOxyJCyM7pmQzgUBCgYLcQWC7QwkT/Xj0/+H18f
        ux2LpJ3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0sNy-0002f4-GV; Wed, 29 Jul 2020 20:09:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A5E0E300238;
        Wed, 29 Jul 2020 22:09:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 939962B4DBEF0; Wed, 29 Jul 2020 22:09:06 +0200 (CEST)
Date:   Wed, 29 Jul 2020 22:09:06 +0200
From:   peterz@infradead.org
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Li, Xiaoyao" <xiaoyao.li@intel.com>, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] x86/bus_lock: Enable bus lock detection
Message-ID: <20200729200906.GC2655@hirez.programming.kicks-ass.net>
References: <1595021700-68460-1-git-send-email-fenghua.yu@intel.com>
 <20200729030232.GE5583@linux.intel.com>
 <e23b04a2adc54a5dbca48271987de822@intel.com>
 <20200729184614.GI27751@linux.intel.com>
 <20200729194259.GA318576@otcwcpicx6.sc.intel.com>
 <20200729200033.GJ27751@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729200033.GJ27751@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 01:00:33PM -0700, Sean Christopherson wrote:
> Why do they need to be exclusive?  We've already established that BLD catches
> things that SLD does not.  What's wrong with running sld=fatal and bld=ratelimit
> so that split locks never happen and kill applications, and non-WB locks are
> are ratelimited?

It's all moot until there's a sane proposal for #DB that isn't utterly
wrecked.
