Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB03C47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E927820747
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UhypDkam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbgEFSKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 14:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728892AbgEFSKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 14:10:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426D4C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 11:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gHpMvr4vTAmGCPgtEsIXaDhEQrCbi3uAV67KLEVjxes=; b=UhypDkamACtZ+4CG4QVVyWh796
        P0iO5/rVAtlEEzkWLelMKQOAEWBw6d0TJXc7XmilP9xSjHlsfsud4856OToJHY4HQUujDj7bvsocA
        dq7AHaDpI31TP0w6ewyFhM0MH6fYXM9iFkec4JhawvwZJhgeUpZ4z8SGEIk6A8AxfE4PlSpQqptkK
        JBG45/lCxDlTV9aMVwCJLR032iok3mlewjy1fd2+JbCzC/WJpA9irWjvrAddwxur/frUQnlBo+ISt
        IG9l1UBEZOQVpZ1PY09Icf8BaH/gGekkFzRulgXlQjrz5XKRiB/42MOi7eEf2LXu+TJZFQFi82z9m
        xL+D7CzQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWOUi-0008OX-Gg; Wed, 06 May 2020 18:10:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D8363301EFB;
        Wed,  6 May 2020 20:10:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF06229DE2DD0; Wed,  6 May 2020 20:10:05 +0200 (CEST)
Date:   Wed, 6 May 2020 20:10:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v4 15/18] static_call: Handle tail-calls
Message-ID: <20200506181005.GY3762@hirez.programming.kicks-ass.net>
References: <20200501202849.647891881@infradead.org>
 <20200501202944.650069893@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501202944.650069893@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 10:29:04PM +0200, Peter Zijlstra wrote:
>  	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE) && site)
> -		__static_call_transform(site, !func, func);
> +		__static_call_transform(site, 2*tail + !func, func);

I'm having trouble making that more readable though... that !func can be
exanded like proposed in 14 without code-gen changes, but:

	__static_call_transform(site, tail ? (func ? JMP : RET)
					   : (func ? CALL : NOP), func);

generates a right old mess.
