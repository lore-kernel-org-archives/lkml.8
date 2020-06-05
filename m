Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A815C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A42420663
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ahcs6+je"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgFEOKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgFEOKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:10:20 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB156C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 07:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CTDjHOYywg0dzAZum3m+Nt5Wkkb7tkG5ghWQVQsdx9E=; b=Ahcs6+jewEkdxKxU668AM9UnTJ
        Cba2jwg6qTPzchqN0LuIik49zhmiORJFRvQZM9BlCXRNay6LQ/WjTWfsBtIQG1RWDlRRO9EOR6Rmy
        GGB/lT7RSkxH0CgUs8iJgugrnjtigJHW7XSZgJrt2Xo2RbnQlEBN8DIg4OV1w3puahVBVei6VVagn
        fag6yzO+7y7b7+WYLhmOdtcn4mqmXttgzJ8+dq6RsFFr+BS2V1ltruvHZx2aTWjYQqXcfYyb1OEDm
        PP6IA4oCL8mfeSAn3iw0xEl7bCxJn1IEUd/ZXvK/tq8kG11KfV7anz69KY6INFRO6gQVdxxoW1ODx
        msZQ2UPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jhD2f-000378-TS; Fri, 05 Jun 2020 14:09:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F0ACC301DFC;
        Fri,  5 Jun 2020 16:09:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DDB7F21A74B49; Fri,  5 Jun 2020 16:09:51 +0200 (CEST)
Date:   Fri, 5 Jun 2020 16:09:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     tglx@linutronix.de, frederic@kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, cai@lca.pw,
        mgorman@techsingularity.net
Subject: Re: [RFC][PATCH 7/7] sched: Replace rq::wake_list
Message-ID: <20200605140951.GE4117@hirez.programming.kicks-ass.net>
References: <20200526161057.531933155@infradead.org>
 <20200526161908.129371594@infradead.org>
 <20200604141837.GA179816@roeck-us.net>
 <20200605081028.GC2750@hirez.programming.kicks-ass.net>
 <9784a2ec-b778-2492-76fc-c5aef83b66ad@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9784a2ec-b778-2492-76fc-c5aef83b66ad@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 06:33:38AM -0700, Guenter Roeck wrote:

> I have not made the C standard. You point out yourself a possible explicit
> culprit: struct randomization. 

The randomization crud is very much outside the C spec.

> That by itself shows that you can not rely
> on two elements of different structures having the same alignment,

Randomization does not change the alignment, if it were to do that it
would break all sorts. All it does is change the order of elements.

> which is pretty much exactly what I said (and may explain why observing
> the problem seemed to at least somewhat depend on the weather).

A normal C compiler will have deterministic layout, otherwise unions and
union based type punning would not be a thing.
