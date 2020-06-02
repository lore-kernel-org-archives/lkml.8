Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF7AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88E3B2074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bgDNsT7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgFBRfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 13:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgFBRfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 13:35:03 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D011DC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 10:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=CRY2i7oTTcHsoBGlkd2B0oUO1HOZbzEReMqjQzmMN0o=; b=bgDNsT7IvLzH/1iV7/YbSncGsx
        /lcAvruNRBugXqbYsFrR2jd1lhQHdjd4NTmWzBpXs8+E1i01aBoeZRphB3CWGVtXBAWeD3l3B4DJB
        tcwpZYDMGvGqm9KYHyj1r5EOveKZQzmMA2RXonyMaozR2E3zvzvlbpMIb6hX4cjF9FeqKUDBnJ+1h
        1i0xz95T7tDWIpzCXfkYA1BjhwiyoKtcpVqsAgmnqkM8BMlOqDVfaQE/qYla/lMkkjP1ol1AVS6BG
        jT/sXO5UEwbaZVUUWLEXZozJeDVVg5b9mPLd5rdB2Im+6FaOCdpBjV8VXIxr9xg1TXfKE4dWKl6VB
        kwd6wVeQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgAoC-0000Q5-QK; Tue, 02 Jun 2020 17:34:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 22E5A3011B2;
        Tue,  2 Jun 2020 19:34:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F2AD02022DEAB; Tue,  2 Jun 2020 19:34:37 +0200 (CEST)
Message-ID: <20200602173103.931412766@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 02 Jun 2020 19:31:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de
Cc:     x86@kernel.org, elver@google.com, paulmck@kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Subject: [PATCH 0/3] KCSAN cleanups and noinstr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here's two KCSAN cleanups and the required noinstr change for x86.

