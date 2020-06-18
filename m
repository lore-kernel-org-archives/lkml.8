Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57F2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8396720739
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c7t85aaj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731124AbgFROu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730476AbgFROus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:50:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADA9C0613EE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=HUZcrpjeWpTlgDPTgfnQW8KeYszUYqHGMt39rKQ+9KE=; b=c7t85aajMTzu5eNf4S54HsoM7L
        6QNKl5cOrZsKV2oNYWHQJSanWGTGRRjl4jOiA0QWJVyzrZAcyUibv8E8piKld7OVT8zZS5uKLW9ng
        cC+2IFaPv88Nrr+JEWRxGpd8BA0LaSH8uH6KS1bbtKZ9G74Px3CpelIvh09Z2uGE9YnuYs3zx1kFw
        670N0GN2/Jsn3GXZbxzq/BBvicvO0HNaONMm4byXxsN6iDNLmwC6V+7iCqZucNTozbL1MwaG4KES5
        8ibdm2n+dJH7lHNYcG92H/sNIzRl3Xbmd+FQcLEm764ctk95NSreO++FsTBlsOkHQdZydQK22mHlt
        RWh2RBGA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlvsA-0002xe-3L; Thu, 18 Jun 2020 14:50:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 33EC6307458;
        Thu, 18 Jun 2020 16:50:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1D4F82146C3FF; Thu, 18 Jun 2020 16:50:32 +0200 (CEST)
Message-ID: <20200618144407.520952071@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 18 Jun 2020 16:44:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, dvyukov@google.com,
        elver@google.com, andreyknvl@google.com, mark.rutland@arm.com,
        mhelsley@vmware.com, rostedt@goodmis.org, jthierry@redhat.com,
        mbenes@suse.cz, peterz@infradead.org
Subject: [PATCH 0/7] x86/entry: noinstr fixes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

These are the objtool/kcov patches that fix kcov-vs-noinstr and
a few patches that fix bad_iret noinstr issues.

I'm going to merge the objtool patches in objtool/urgent but make sure the
merge into objtool/core looks like the patches as posted here, since there's
the reloc conflicts.

The other patches I'm going to stick in x86/entry unless complaints.

