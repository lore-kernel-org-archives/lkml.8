Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1851BC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D2E20848
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NOxUvXET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgBKMby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:31:54 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55522 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbgBKMbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:31:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d8hdSd/7aIqAefDk077COrSiAbGuHv2/hZDaRbUHx5o=; b=NOxUvXETeTx1yz6UwjTSSunpNI
        kwvGGa78MbKRfwe/RFXQkj5DgLnQ/ApsOAdtNBUr67aLVxLnyqO8L3vXrp9AH0N/sxNR1Br6lWBxY
        NkuQOO0h90BocBVdUBYcnRlAq4YnwGox6zB9KMwxDGVSKljAjDwobsR77xYYo04u22sN3I+7hOexb
        BOzNK/tzrzDDX+WbI9ccFvw+wxtEe1+N/rrflhgIPjgq4/A6WPXtkur5fkLMclSWtA0QieFCY90g5
        O7rsCI3T0AjeXe8zsRlzfDwPAeInZE2UVgK6hCh1CZJDxRCFYNYParzljOehktB8K4+XY+PR5NHnm
        T+SO/evQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1UhZ-00035s-V3; Tue, 11 Feb 2020 12:31:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6C18B300739;
        Tue, 11 Feb 2020 13:29:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1F9F62B88D73B; Tue, 11 Feb 2020 13:31:38 +0100 (CET)
Date:   Tue, 11 Feb 2020 13:31:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/3] locking/mutex: Add mutex_timed_lock() to solve
 potential deadlock problems
Message-ID: <20200211123138.GN14914@hirez.programming.kicks-ass.net>
References: <20200210204651.21674-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210204651.21674-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 03:46:48PM -0500, Waiman Long wrote:
> An alternative solution proposed by this patchset is to add a new
> mutex_timed_lock() call that allows an additional timeout argument. This
> function will return an error code if timeout happens. The use of this
> new API will prevent deadlock from happening while allowing the task
> to wait a sufficient period of time before giving up.

We've always rejected timed_lock implementation because, as akpm has
already expressed, their need is disgusting.

