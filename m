Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1CEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B040220DD4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgGMWqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 18:46:45 -0400
Received: from ms.lwn.net ([45.79.88.28]:37274 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbgGMWqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 18:46:45 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 668602E2;
        Mon, 13 Jul 2020 22:46:44 +0000 (UTC)
Date:   Mon, 13 Jul 2020 16:46:43 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     torvalds@linux-foundation.org, f4bug@amsat.org, cyphar@cyphar.com,
        davej@codemonkey.org.uk, geert+renesas@glider.be,
        ribalda@kernel.org, luis.f.correia@gmail.com,
        paulburton@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CREDITS: Replace HTTP links with HTTPS ones
Message-ID: <20200713164643.3185c9c5@lwn.net>
In-Reply-To: <8469428d-39de-7b87-383f-aeb88355540f@al2klimov.de>
References: <20200710154630.31521104@lwn.net>
        <20200711055127.92418-1-grandmaster@al2klimov.de>
        <20200713114321.783f0ae6@lwn.net>
        <8469428d-39de-7b87-383f-aeb88355540f@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020 00:12:09 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

> I'm sorry. I've just read your complies
> https://lore.kernel.org/lkml/20200710154630.31521104@lwn.net/
> and thought that's all.
> 
> Is that link plus the email I'm responding right now to all?

I don't know, I have not checked them all.

The point I am trying to make is that, with this sort of mechanical
conversion, you are making work for other people.  If you are changing a
link in a document, *you* really should maybe take a look at it and make
sure that it makes sense.  It shouldn't be necessary for others to point
these things out to you.

Thanks,

jon
