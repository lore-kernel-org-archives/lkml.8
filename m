Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC17C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A13A214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h5o11Cvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgDVLde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725808AbgDVLdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:33:33 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994FFC03C1A8;
        Wed, 22 Apr 2020 04:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TvSrnbry2EaNGIReXKuYBNE6jfhcSFlv+Vxlnn4f+8k=; b=h5o11Cvonxs0Dq7WLqdvO0qcXa
        EMAVNUNDE22MzBUxBd/Y8IYUC/zrxEUnyrgMWhkvSMa140lbtBkl1sDuqvQkH7/iSbLUwFyFnrIM5
        9FmsLqgteFSgQCUDGUbuiVpffwjqbYRcyYAQNDGBdMU3FzBEJhCfVk62N1l4UwSNsMRatblZi+VyH
        aWMlrfK9vRAx9XqrP5efC/ovGw4gL2Lnwg1FT+eNeCvzLrueMP+/WRkUAT908gufqVi5fKN2dp6xy
        3fSdtij9ctFKv683guef0TFyr0O94YiGOpv3b6+fknATnHFkfb5y0Oo8TjlG8RYJS1E5lWaXUZIeN
        cQdZa5DA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRDcn-000708-MQ; Wed, 22 Apr 2020 11:33:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 226E0304CFD;
        Wed, 22 Apr 2020 13:33:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E236F202801A5; Wed, 22 Apr 2020 13:33:03 +0200 (CEST)
Date:   Wed, 22 Apr 2020 13:33:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     tglx@linutronix.de, pbonzini@redhat.com, bigeasy@linutronix.de,
        rostedt@goodmis.org, torvalds@linux-foundation.org,
        will@kernel.org, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v3 -tip 0/5] kvm: Use rcuwait for vcpu blocking
Message-ID: <20200422113303.GZ20730@hirez.programming.kicks-ass.net>
References: <20200422040739.18601-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422040739.18601-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 09:07:34PM -0700, Davidlohr Bueso wrote:
> Davidlohr Bueso (5):
>   rcuwait: Fix stale wake call name in comment
>   rcuwait: Let rcuwait_wake_up() return whether or not a task was awoken
>   rcuwait: Introduce prepare_to and finish_rcuwait
>   kvm: Replace vcpu->swait with rcuwait
>   sched/swait: Reword some of the main description

Thanks Dave!
