Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4764AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC852070C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DckzPWGi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgATPHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 10:07:19 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36246 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgATPHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 10:07:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T/cpQD/zbDsi8Y9ri+v+0mcbKKUYlsn8Knn3mtIwVJ0=; b=DckzPWGitgftKtAtwS4LlmEX9
        ZuSZtfcESSP5zj74FXV4O78Www2YVMKhgNuohr1R2RE/Y7iPH7ayAC2Fl508famKqyvGK/BJUKHNt
        Y3XCF0d/NZdbCdMgfQl5Y29seEbvGfk+lbnTU3diovjI0ADbjwYNMzvcwOzpQJFqvJ5i43wvI1O9h
        Y6cNWJYLUHPLAkhd84utU3mAQ/NZzthmP7d+GRAY9r6po6NNVXBHzo2Xu1iPs2Xv8kWJHvbGPEUIA
        BwTLqvCAEcu6d1TGvb1BpEx+8vjjdLkFHilmS1PT1PRn4JP34Q5xnnA7xmM9VsM4JaUfxkOXTL9tA
        s5xErLGjA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itYe1-0007LW-8o; Mon, 20 Jan 2020 15:07:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D7426305E4E;
        Mon, 20 Jan 2020 16:05:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6580C28B86E62; Mon, 20 Jan 2020 16:07:11 +0100 (CET)
Date:   Mon, 20 Jan 2020 16:07:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jpoimboe@redhat.com, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org
Subject: Re: [RFC v5 00/57] objtool: Add support for arm64
Message-ID: <20200120150711.GD14897@hirez.programming.kicks-ass.net>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 04:02:03PM +0000, Julien Thierry wrote:
> In the mean time, any feedback on the current state is appreciated.
> 
> * Patches 1 to 18 adapts the current objtool code to make it easier to
>   support new architectures.

In the interrest of moving things along; I've looked through these
and 1-14,16 look good to me, 17,18 hurt my brain.

Josh, what say you?
