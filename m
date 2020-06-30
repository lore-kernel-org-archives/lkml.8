Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EF7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C32220768
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VX0xWz/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731136AbgF3Hui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731033AbgF3Huh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:50:37 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCDEC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yEgSNSvBO7JS80R0g7L6v7cEOtvmMnbOhWUqmFKR918=; b=VX0xWz/0ti0sq4TDRZf55a5Iq+
        0Ru8Ss1cQvLK1Fev5ESkkP16ne8mx5zoXdaYIBV0TNQdveZGj8aXJgVyDHMHh9QcSaFHdCvngzJ2q
        gdvXc+gcTDc8yhMXEc/K2Q4qO0BsLOU4lGwrgzl9V6dlKbMKBYxO/4Tx6+j3fLBudyLLgyDskKAwl
        Te/VpQ0EYY3Lm1Stw3l63u2s0rdSRqoSz2De1Ss6xtRFZl1oLLw0SU7Wy2CdVChJvg3zvUQFKD8Si
        3YzRZ8tLMZqKvizpEh2R8031TYSrvPSb9lOnqcF/wsdayA/xfnxgIMQtkVWSAzRm+E93Dvf8muJIh
        6xF3wnQQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqB2D-0001Gy-6D; Tue, 30 Jun 2020 07:50:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 05055302753;
        Tue, 30 Jun 2020 09:50:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BCB1123D58AC6; Tue, 30 Jun 2020 09:50:26 +0200 (CEST)
Date:   Tue, 30 Jun 2020 09:50:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chen Ni <vulab@iscas.ac.cn>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: events: use offset_in_page macro
Message-ID: <20200630075026.GN4817@hirez.programming.kicks-ass.net>
References: <20200630074258.8301-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630074258.8301-1-vulab@iscas.ac.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 07:42:58AM +0000, Chen Ni wrote:

> Use offset_in_page macro instead of (addr & ~PAGE_MASK).

Shees, so now we're replacing a trivial expression with something that's
actually longer to type? How does that make sense?

> -	memcpy(dst, kaddr + (vaddr & ~PAGE_MASK), len);
> +	memcpy(dst, kaddr + offset_in_page(vaddr), len);
