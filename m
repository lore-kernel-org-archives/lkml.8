Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87808C18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A41C20674
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ifovaK/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgCIJHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 05:07:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45998 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbgCIJHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 05:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=ovwAOrod+pcHugf+bHywQDDeJcz0ScIRA7A9zSI+2vM=; b=ifovaK/kO8/X67kmI3vvmgEMFF
        FRSpZQLKfdun9jAgIFz5xMpIbEQmoH41eGKCSSh1F6bXXTZUqrzvxgkB6MR9siuaACaSXzRB8gXVV
        Ddy7r00J7jM5rnenJgxdYK754Vmg1vbuV9cO8I/GOeu6BK+NpAlw9+tr9GNvOArkHMjPMTRQBZ4OW
        cuNZfFIN5WE47Vsrr9kAx877r+CBW1CDcn80mrcumxiRjtgmU+/obDicBiUc1JftwOWOIHIjLEhNj
        wJJH9keSms1ln6ufyZZVdcSmFiRJO5nS1vW7yIOtlM23aQcpgf1BjOs560IsOYwmGMjxg06N53Mnc
        YslE+Hzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jBENB-0001JG-PJ; Mon, 09 Mar 2020 09:06:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F295030066E;
        Mon,  9 Mar 2020 10:06:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D590225F2C26C; Mon,  9 Mar 2020 10:06:50 +0100 (CET)
Date:   Mon, 9 Mar 2020 10:06:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-doc@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 0/3] docs: a few improvements for atomic_ops.rst
Message-ID: <20200309090650.GF12561@hirez.programming.kicks-ass.net>
References: <20200308195618.22768-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200308195618.22768-1-j.neuschaefer@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 08, 2020 at 08:56:15PM +0100, Jonathan Neuschäfer wrote:
> Hi,
> 
> this is a short series of unrelated fixes that make the atomic
> operations documentation look and read a bit better.
> 
> Jonathan Neuschäfer (3):
>   docs: atomic_ops: Remove colons where they don't make sense
>   docs: atomic_ops: Move two paragraphs into the warning block above
>   docs: atomic_ops: Steer readers towards using refcount_t for reference
>     counts
> 
>  Documentation/core-api/atomic_ops.rst         | 24 ++++++++++++-------

FWIW, I consider this a dead document. I've written
Documentation/atomic_t.txt and Documentation/atomic_bitops.txt as a
replacement. If there is anything in atomic_ops you feel is missing from
those two, please tell as I'm planing to delete atomic_ops soon.
