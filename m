Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213CFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F141F207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MhXBQfag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407083AbgE1UYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406986AbgE1UYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:24:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451ECC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 13:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ZlitLrg58PjBubp1jZcu8kKsgkfU14EybJiixuLj3Ro=; b=MhXBQfags+orS9/WAp5Xvw/ePk
        OQ4klb6NH0QGlt5FJXhVfYtqdSoLIBNrTL+HxO5pKmYJICdp2esm+TPpyx2ZhPmkUqDZoYF68LAuR
        ueENZp8g3aa6gjzLMfLlL+cx7YwFQLBiMmJBL4tIQ++5JeM7kv4rv9w2eSRkI0MqUIPwsmzyWiDQU
        3QDszMg9naP7XRXVHABBJTjHLT/mK5bFxcQLl+HTFwUT8ZL4vukb4YKGw84BLczi8pw6H2vrSSege
        GSsIbNIqQIsjI/IGdTD5naI81QvfwIUDTKCaC1O4UcSQNsRYC4JiDEBsLU0ZlSgcsI9O1/qNrqt9A
        pozzj2mA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeP4j-0005Zn-72; Thu, 28 May 2020 20:24:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D6868301205;
        Thu, 28 May 2020 22:24:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CABFA203C05AF; Thu, 28 May 2020 22:24:22 +0200 (CEST)
Message-ID: <20200528201937.038455891@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 28 May 2020 22:19:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, luto@amacapital.net, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        sean.j.christopherson@intel.com, andrew.cooper3@citrix.com,
        daniel.thompson@linaro.org
Subject: [PATCH 0/6] x86/entry: disallow #DB more
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches disallow #DB during NMI/#MC and allow removing a lot of fugly code.

Patch #6 should probably wait until we've got the KGDB situation sorted
because applying that makes a bad situation worse.


