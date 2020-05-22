Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE094C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B97EA2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GuCPn0pH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbgEVUuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 16:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731000AbgEVUuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 16:50:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D014C08C5C0
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 13:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ui6qN/VsDMa8d0TtbA4QUsOoNa9pIsvogYj/5A7/E2g=; b=GuCPn0pHBlEJQUfcp4HcrdK4lR
        NuLifwlw5sFMPUlRV6fpelexvZNbxNMvKJEsYdrENwErIYFnw3uN2E7bQahxqYDc06zN2jNZIskBD
        /H+OqUP6G1yNaTclnt9dXMn/p6WaD4YmIebsiGvgjL+zs6X5LKphCn48eHtU6arHUxGYtd3yZajEj
        lL2MXZBhF0hwe5DuN2FgYElCkwj7Xg8LjkawhDPQI9isSI78JAl5fbQCuXx3LRtwxohQqI3sgGmbO
        tMbE+LlZGiCYlSi0Ek+P1rr//J43+FTgqXCmG3RGOFcuPX/F7y6wOUuj91tHqIJRGLuAnHx7toX8W
        H93WOAIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jcEcA-0000lQ-PQ; Fri, 22 May 2020 20:49:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D06B63060FD;
        Fri, 22 May 2020 22:49:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AA81023D5338D; Fri, 22 May 2020 22:49:56 +0200 (CEST)
Message-ID: <20200522204738.645043059@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 22 May 2020 22:47:38 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, luto@amacapital.net, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [RFC][PATCH 0/4] x86/entry: disallow #DB more
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hai, this kills #DB during NMI/#MC and with that allows removing all the nasty
IST rewrite crud.

