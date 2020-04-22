Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C63EC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CA4420784
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FSh5B9kv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgDVL32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726112AbgDVL3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:29:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCB0C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 04:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Cg7TnfeMbVTc6R9MMQLUz/C06aiqu3W/Qg0iPfWUfeg=; b=FSh5B9kvUO5j16tClwcqwns7+A
        G+6MWXoxXfSj8mogm5Ocnt9tJo+lvKe3Ttx9Fm5T83nMf2ReYvuQRp26Qxsq2Vlw8C6a9yCAjoYXj
        OVg4xsBZyYzF7SOAYalk/s8HwNT5mHNnNKOlenwv8t0cwQcPPoOJi5m/UZMMtb5Z2e+PWH7Sir8OI
        5U3wdba3YR4I0G+ebNSY+QwauDyDiUjbiKnnxnshpOVHXuBdnololVWcj1eF9Tk/DQK0Aa7N1Nus5
        4iWtf91OyCu52BC6AmetzJvspS2BDgNh24nghkB3ZV4XkOGZOZQCLoeezD3G8bIe7pIfH7N6Iiitu
        NP805C9g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRDYv-0003aW-3x; Wed, 22 Apr 2020 11:29:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D5C5630746C;
        Wed, 22 Apr 2020 13:29:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B1B5320195233; Wed, 22 Apr 2020 13:29:02 +0200 (CEST)
Message-Id: <20200422112719.826676174@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 22 Apr 2020 13:27:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org, qais.yousef@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        peterz@infradead.org
Subject: [PATCH 00/23] sched: Remove FIFO priorities from modules
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After having seen yet another patch that adds a FIFO kernel thread at a random
priority, I bit the bullet and implemented the suggestion done a while ago:

  Flat out remove the ability to set a specific FIFO priority

As argued in the patches themselves, the kernel has no clue what actual
priority it should use for various things, so it is useless (or worse, counter
productive) to even try.

