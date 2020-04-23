Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D240C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54E352077D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f89TjFaq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgDWMwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 08:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728422AbgDWMwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 08:52:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0A8C09B040
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 05:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=MmWDzrYVXIVgWsUeAlvJsS1/JNqcyjdtQ1qm7Ad0/WE=; b=f89TjFaqm2I9hI8SkhQ7/+e34e
        wsDDnNTUTQSFijv3sdSeFC1GWsJRYAdskPNI+2FNgl9VvPtqunUpmV3BXrTgV3o1ITL3uDYnPpg2H
        4clAHUgMYV65jE02NrEa7q32e0aAIx5M7XCIKHGHdJvU53yRbhUXTwTpZEpqJ4rruvzCvTUbKDQ/m
        4NU2Gjq63JX0HJO1rMs2RFlrSUTtI/jGCFAxLgMf9Q0x1t6uuOTA+SsQrYYzJhkUnmH9OdU6gRtH8
        cTI1ItPZE04vi+jxiGxwS7ie4MuOs3dLbCTUKKrOeqS9ldRPHabFEBVtTnfTPmd5PVj5S7a41bINR
        gdjLpCCg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRbKi-0005mZ-LM; Thu, 23 Apr 2020 12:52:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4580C300739;
        Thu, 23 Apr 2020 14:51:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 30F0320BE6372; Thu, 23 Apr 2020 14:51:58 +0200 (CEST)
Message-Id: <20200423125013.452964352@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 23 Apr 2020 14:47:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, alexandre.chartre@oracle.com
Cc:     linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org, mbenes@suse.cz,
        peterz@infradead.org
Subject: [PATCH 0/8] objtool vs retpoline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Based on Alexandre's patches, here's a pile that goes on top of tip/objtool/core.

With these patches on objtool can completely understand retpolines and RSB
stuffing, which means it can emit valid ORC unwind information for them, which
in turn means we can now unwind through a retpoline.

