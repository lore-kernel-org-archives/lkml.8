Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B793FC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 10:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E55F217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 10:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GYYIrWcG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgBMKr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 05:47:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46878 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgBMKr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 05:47:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P46Gl9kePFHxeW2i2pk4069wZpiHhT83tiM+7F9IPdI=; b=GYYIrWcGAo8ePUcNHlaQ8iUq0w
        o6HiwAKsZQ8Ij4HXs8lbBp3JtGhUvE/aN2sGq8CuVSpulDDAhDS1YuBEryjtCrGSsKY5iVw9+p6U/
        dQbFwFl0WHZ86EgY6pFeFvMFv05fiG5klWS8Kkv/R+0vW2D70YMUJoobbAReQ2nKIKN0/GeLu/U8O
        FsPqJ1NUI0ljNG78PPX5hJuOKviKDU6/0NWschTeJI0pLTCIQgH3YQ6mECxx7CU/Vta80g5nDnbEr
        zQ8OWZTVisY5uCDFcile6/+KAWoVI5mqPJiaz41damUmqSnQFdYTZduUZrdZbv8Y4JDrfwHLvHlhd
        yAHoENVA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j2C1p-0001DE-24; Thu, 13 Feb 2020 10:47:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5350E3013A4;
        Thu, 13 Feb 2020 11:45:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DAC2120206D69; Thu, 13 Feb 2020 11:47:26 +0100 (CET)
Date:   Thu, 13 Feb 2020 11:47:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stefana@xilinx.com
Subject: Re: [PATCH] asm-generic/bitops: Update stale comment
Message-ID: <20200213104726.GO14897@hirez.programming.kicks-ass.net>
References: <20200213093927.1836-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213093927.1836-1-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 09:39:27AM +0000, Will Deacon wrote:
> The comment in 'asm-generic/bitops.h' states that you should "recode
> these in the native assembly language, if at all possible". This is
> pretty crappy advice now that the generic implementation is defined in
> terms of atomic_long_t rather than a spinlock, so update the comment and
> hopefully save future architecture maintainers a bit of work.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Reported-by: Stefan Asserhall <stefana@xilinx.com>
> Signed-off-by: Will Deacon <will@kernel.org>

Thanks Will!
