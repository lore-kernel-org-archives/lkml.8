Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB6CC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA6E207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="haCEa77l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgA2KpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 05:45:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59030 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgA2KpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 05:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=we/4Fl/l94slaz/GSOPIlS4lUUi9W+pKMjbWxf4YQWU=; b=haCEa77lyvI7dbf2bAz/aEnPY
        RCmjnMorFr5kPIs8k4hbfw7gdVZVgxzGXAtyR1LzWamrOUXE7kSkk8cw9DSPK8yHL8ACbc+iMp3MF
        oZW+kyABFwzhfVXhSiyzin0d+K8HbpvI9FAFpgf8/FpwClaq6/qIka2uhu3ffgL0QkF3AL4t979RP
        +WpGq9gjdsL2e9Ai9inaSmxIUNe55IyapYFyA3zheS2Mq7Z0Dt1n5is9sy8T7fQ3HEP4nd3rB/ey2
        Fki5GyiRcMXRCkAN1qtNKm8N7Q7R9haXVZTHlz8QI9GooAGuBtaMHtHUHj6oZ8zB8NWomJgMHEi/T
        32tQa3RfQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwkqM-0001DW-Ox; Wed, 29 Jan 2020 10:45:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C0BCA300606;
        Wed, 29 Jan 2020 11:43:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7CEA62B2E7F2E; Wed, 29 Jan 2020 11:45:07 +0100 (CET)
Message-Id: <20200129103941.304769381@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 29 Jan 2020 11:39:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/5] Rewrite Motorola MMU page-table layout
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

In order to faciliate Will's READ_ONCE() patches:

  https://lkml.kernel.org/r/20200123153341.19947-1-will@kernel.org

we need to fix m68k/motorola to not have a giant pmd_t. These patches do so and
are tested using ARAnyM/68040.

It would be very good if someone can either test or tell us what emulator to
use for 020/030.

Please consider.

