Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE060C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B29EC205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LVG/t3uj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgETNeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 09:34:00 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43584 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgETNd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 09:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=khD7IwQGXAJ9eP3budqJrl0fOr73NVefQ4qY+eMsteM=; b=LVG/t3uj+BR9wqtvbVwDWeIzQ5
        Elx0ctQSChldKrgx1TarV3++eNCNAU0Z2yeJ/jPN2fFkOHKxrqoy7ieA1eSovpieSKexchF1tcg3j
        sllLEQzu4ztMSpct4bA8Gb9NQqxciS+29KUbn6tuBIWhTUc2gIY2JbwZDIRpd6cDvuPjJhYXvqePS
        YlaZ0D1yytEwPg7MzEcqKc9TF3Usbw2kbdHD+U2tz42kMjnLSxr2HGUmqNVZXzQzE+7clTHyVWbyM
        20e7ZsqYT+DXfmvCs+Rt5uPwbJO4/EYe/LSN1DTKLZog6E+gv9MtP6IHZ//kkh9H1MgIuEuCWObsM
        QbH7jCPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbOr1-0001Tc-GP; Wed, 20 May 2020 13:33:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 427133007CD;
        Wed, 20 May 2020 15:33:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 32EE529DB50F7; Wed, 20 May 2020 15:33:50 +0200 (CEST)
Date:   Wed, 20 May 2020 15:33:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wojciech Kudla <wk.kernel@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] smp: generic ipi_raise tracepoint
Message-ID: <20200520133350.GN317569@hirez.programming.kicks-ass.net>
References: <02b57f31-fc0c-df35-57bf-e0a297a7e6c4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02b57f31-fc0c-df35-57bf-e0a297a7e6c4@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 02:17:21PM +0100, Wojciech Kudla wrote:
> Preliminary discussion: https://lkml.org/lkml/2020/5/13/1327

We have bright shiny links like: https://lkml.kernel.org/r/$MSG-ID for
that. they allow me to go find the email in my local archive without
having to use a browser.

> This patch avoids introducing arch-specific trace points by leveraging
> existing definition for ipi_raise.


> +static const char *ipi_reason_missing __tracepoint_string = "";

That is a pretty crap reason ;-)
