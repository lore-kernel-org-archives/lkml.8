Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0967CC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D13A72070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 19:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tgSIhgTC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgD1TTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728460AbgD1TTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:19:50 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C35C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 12:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-Id:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=oo3F4ycdV+8X3hUQQNbmoBn9z4PcruBrfKQLlDmIMm8=; b=tgSIhgTCVengHYBIB/NZAOGqpH
        HaPy86tqq9DW/Gu5NFI94E7Rmmn4qvIKJmPIOMXWRg8dpa/iSPl0CV6+BTXHy4IWa7+DKiCqvrnZh
        bOMVJ57JJvryNf4JGBaEK2WpyXKHsBTwLSZ1wgJYkjWkVB5CCUFxU0RKNGPP1w5JrnFZrfRHaLHom
        P7mra4rLeYnksxEBWlgcrH19XBlga4vqtZ/lyGtyg+KbgEdHpfM1bYZIJ8Ae/mZXR612Wuh9OrRq+
        Oozsf9ENYTKB9pCTo5CHyezzOed7FAjtkNRHoNhO2gVr4s/+HJ3XzQ4xML77I+LSuz8U8Fi5YVxms
        wufmvJHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTVlP-0007kq-Ug; Tue, 28 Apr 2020 19:19:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 858863074EB;
        Tue, 28 Apr 2020 21:19:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7648925D0130F; Tue, 28 Apr 2020 21:19:26 +0200 (CEST)
Message-Id: <20200428191101.886208539@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 28 Apr 2020 21:11:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, alexandre.chartre@oracle.com
Cc:     linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org, mbenes@suse.cz,
        peterz@infradead.org
Subject: [PATCH v2 00/14] objtool vs retpoline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Based on Alexandre's patches, here's a few that go on top of tip/objtool/core.

With these patches on objtool can completely understand retpolines and RSB
stuffing, which means it can emit valid ORC unwind information for them, which
in turn means we can now unwind through a retpoline.

New since last time:

 - 1-3, alternatives vs ORC unwind
 - 7-9: implement some suggestions from Julien
 - addressed feedback

