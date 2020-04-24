Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55016C55191
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3494A20700
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LPZP+4T/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgDXP2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727016AbgDXP2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:28:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A96AC09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 08:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lDf/A3ovuzNt2KEhRlfv8ja1JM5mX8+ysQPOwQf9ito=; b=LPZP+4T/v/UchGnKt5lr3AdAIk
        +PTe+BNwaHRkGqFMCxOhWOMOKERajrsCzk3Mz75ALxUvcGF25CAHZr9Fug/39kLumfHxfKcVmuVnW
        ghSezW7kAZI54iPFVVisYjuhdHNAZWccycCfH0ydk8HZFZEvoUExhhr4N4IgtV3t00wKNIEfV5+iw
        5FPJvTTUUyREUGwUIoy27wv4bm8E1NbTw8nb9WcFKQOJJVZ7Z+hA+hvDimQ8mQ/qyKLZQ9RjZLSw/
        GPvtrwo4WAsxLYJlbHEZyukiFtqBYiajv0nco2Mi3d8xk/YnNd+V4LgJ+0KlwlEdh4aAx5CQHxhqP
        T8dTMItg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jS0Fb-000131-D0; Fri, 24 Apr 2020 15:28:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A311E3010C8;
        Fri, 24 Apr 2020 17:28:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7D4EA2013C457; Fri, 24 Apr 2020 17:28:20 +0200 (CEST)
Date:   Fri, 24 Apr 2020 17:28:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: `calibrate_APIC_clock()` takes 100 ms on AMD systems
Message-ID: <20200424152820.GA13558@hirez.programming.kicks-ass.net>
References: <d6d50a65-59bc-aaa0-3f15-01d71496ef89@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6d50a65-59bc-aaa0-3f15-01d71496ef89@molgen.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 04:59:21PM +0200, Paul Menzel wrote:
> Do AMD devices feature an alternatives like for Intel?

https://developer.amd.com/resources/developer-guides-manuals/

Let us know if you find something...
