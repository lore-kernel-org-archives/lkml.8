Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AFBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55DDA20738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CZmeYv88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgFCLma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 07:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgFCLm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 07:42:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5ECEC08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 04:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=8Kdbt0b37eerZhg/nVUe4tBYOkqdJz7+Q7Dw50pmBzY=; b=CZmeYv881QdKwxCUtnBfzVNN84
        oTnuSOa8f1Z2LnsY84txATKa8ljmhGhTJpIYk/wROM2JI6ZPNarlJRmTvEs1bcfidenSwpj+DXcI5
        ZhJ11fIc48CeXzC4b/TYP35QwRyWKP+3UDKiUj34dJskYWdTo6IzC23w+Ni3+ZqlpEWDBR0Nu3gwV
        WxP6WcmfxcwmMOfbns53oNvF+V2XgwNF6tHkpY3nPi3pTHeZhTzK4RSK/xVdBXwgA/mM40Vn8MYs7
        BhY5Ep/fpkhxRe+b2Gk03j21nC/9j3wvZQGD6fsDtq3/Xcf4QKIiJJ3A7h3WP5MjyStgCJ4jdrKUh
        s7MkiCPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgRmr-0005jl-RV; Wed, 03 Jun 2020 11:42:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B67E530581E;
        Wed,  3 Jun 2020 13:42:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A2068209C23EC; Wed,  3 Jun 2020 13:42:23 +0200 (CEST)
Message-ID: <20200603114014.152292216@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 03 Jun 2020 13:40:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de
Cc:     x86@kernel.org, elver@google.com, paulmck@kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com
Subject: [PATCH 0/9] x86/entry fixes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch is a fix for x86/entry, I'm quicky runing out of brown paper bags again :/

The rest goes on top of these:

  https://lkml.kernel.org/r/20200602173103.931412766@infradead.org
  https://lkml.kernel.org/r/20200602184409.22142-1-elver@google.com

patches from myself and Marco that enable *SAN builds. So far GCC-KASAN seen to
behave quite well, I've yet to try UBSAN.

