Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0D5C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 12:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E36FE2078B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 12:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o7k+1ZKw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgIBMCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 08:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbgIBMBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 08:01:41 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989E2C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 05:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t9vCosA7Q25givWDzRn1JHIcMUVRAm5ErTsp3ohNpV8=; b=o7k+1ZKwUj257zrnPWwIUAzY2q
        qf9abQdcFxyaquNOHWLY9azlVCtI2Q9DosE3XFy0fZlBbMfO7iH9bLvkVyIWXzR2Ig5pxrcdSMdS/
        /pppyXn1QSFADrMmOajq7dKX9chLxv7kteuaDm+hh6+mmldE35d1Uo/V4HumYBp/lNrz7hNYyM7bb
        p4di94YF7JpdFUVjHI4QRBq851tPm7Ds/brgH26O5v56CeVTzGz66UtwybjmBHdGdSX0uhLFprPdI
        UQ/7Wz+SUypTFWsfGjUPqQvqM6qCZqTCtnACb0n6CBsreXnd9QWOte38gOfgy/Ol6BoIYp1VCFFym
        L1SPtSMg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDRS4-0007RL-Hi; Wed, 02 Sep 2020 12:01:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4188D3003E5;
        Wed,  2 Sep 2020 14:01:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 21B4923D3D728; Wed,  2 Sep 2020 14:01:18 +0200 (CEST)
Date:   Wed, 2 Sep 2020 14:01:18 +0200
From:   peterz@infradead.org
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v7 08/18] static_call: Avoid kprobes on inline
 static_call()s
Message-ID: <20200902120118.GD1362448@hirez.programming.kicks-ass.net>
References: <20200818135735.948368560@infradead.org>
 <20200818135804.744920586@infradead.org>
 <20200902103508.2872d92709fc8de7c6bffe08@kernel.org>
 <20200902094820.GA1362448@hirez.programming.kicks-ass.net>
 <20200902191637.72307d7ec6d493a6c0678346@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902191637.72307d7ec6d493a6c0678346@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 07:16:37PM +0900, Masami Hiramatsu wrote:

> Is the data format in the section same as others?

All 3 sections (mcount, jump_label and static_call) have different
layout.
