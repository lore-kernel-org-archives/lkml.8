Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11B1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69C1220835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZTr9tY13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgFLOhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 10:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgFLOhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 10:37:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B05C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 07:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=o8Ne4mF5hiMjy68Cd2Jibbz9gAZEggeduQGzA7GEfPQ=; b=ZTr9tY13yVX06h2LuBD+OIgZ1C
        ibFGUSlNB7CHgN6jLIPNZGu8pJI0NkyiV1tGdeKq8wmRaBN3h1MPz5nTb7/tihtYzJ5bTksantabP
        9AMLbPUkT8ciPKgY8DsXADnZmSuOrNu7osL6pLWEyQwoVkhNYVk7xkDnKdvcYFDALDRGWePMdfXBN
        UIPk32aLjzssW6o4Brzok0/qMr8d9T8n/pALyEk1ZR2SiIb9VISEb+j+TOsO/dloSErPx512R9JBX
        ZXhLSZ1kl4jsWd7s9RKWXvNXhnm24FRbCvJTwwCL56l8M+675seRz0oWPZ/JrvaCjTxSgMltz1UNz
        39/J9Xjg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjkoI-0006ub-62; Fri, 12 Jun 2020 14:37:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E3DD13011B2;
        Fri, 12 Jun 2020 16:37:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BFE732389EB9E; Fri, 12 Jun 2020 16:37:31 +0200 (CEST)
Message-ID: <20200612143034.933422660@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 12 Jun 2020 16:30:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, dvyukov@google.com,
        elver@google.com, andreyknvl@google.com, mark.rutland@arm.com,
        mhelsley@vmware.com, rostedt@goodmis.org, jthierry@redhat.com,
        mbenes@suse.cz, peterz@infradead.org
Subject: [RFC][PATCH 0/3] objtool: KCOV vs noinstr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

These patches go on top of objtool/core, although possibly we need them earlier.

In order to solve the KCOV-vs-noinstr situation, we need objtool to rewrite
calls to __sanitizer_cov_*() into NOPs, similar to what recordmcount does.

I'm hoping the pending objtool-recordmcount patches can also reuse some of this.


