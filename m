Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43277C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076502082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581373535;
	bh=CtdhHC1Qr5iTDCFHIc5/DA+BWzeBhnScPuY8t1E6Bs8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=D3NtMZ4xH7xTK7rU18SJTFLGWP7FQX52QYP/wjyMpIzmuIEuhWUsGHjUlmxr3351I
	 ACDpCPNOl4l7jDplrppaOUI8NnfYWTQq0f0zXBBNEBGurDue5bwlYzqMRGUX9ocoWd
	 qFL1vJ3qVDRttq9OHRB6unBfSjpoKiSLiQuHz5vs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbgBJWZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:25:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:52866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727422AbgBJWZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 17:25:34 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EC9120733;
        Mon, 10 Feb 2020 22:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581373533;
        bh=CtdhHC1Qr5iTDCFHIc5/DA+BWzeBhnScPuY8t1E6Bs8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gK/iJZQ68Op11Qoj7NGPIIttOIV81mWZiEsEnCvLp4oB3rGhadw8b24qrByIJzMjX
         nfSA5AhuywXuz2Ejfh+Ez0VSN+pNaBbiIwd52jtqKFm0mpt3ZWuivxeBCdrEJZi/II
         iKVQp6AoIxkJlOTYUV7MqC1xAQiwbEGOdBU74HUM=
Date:   Mon, 10 Feb 2020 14:25:32 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] checkpatch: Remove email address comment from email
 address comparisons
Message-Id: <20200210142532.432a0900bbacd6087349efe4@linux-foundation.org>
In-Reply-To: <ebaa2f7c8f94e25520981945cddcc1982e70e072.camel@perches.com>
References: <20200131124531.623136425@infradead.org>
        <20200131125403.882175409@infradead.org>
        <CAMuHMdWa8R=3fHLV7W_ni8An_1CwOoJxErnnDA3t4rq2XN+QzA@mail.gmail.com>
        <20200207113417.GG14914@hirez.programming.kicks-ass.net>
        <CAMuHMdW8hWpSsf31P0hC=b23GCx4oFwfaVYKQ1qrZfwFCPK5-Q@mail.gmail.com>
        <20200207123035.GI14914@hirez.programming.kicks-ass.net>
        <20200207123334.GT14946@hirez.programming.kicks-ass.net>
        <ebaa2f7c8f94e25520981945cddcc1982e70e072.camel@perches.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2020 10:52:16 -0800 Joe Perches <joe@perches.com> wrote:

> About 2% of the last 100K commits have email addresses that include an
> RFC2822 compliant comment like:
> 
> 	Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> checkpatch currently does a comparison of the complete name and address
> to the submitted author to determine if the author has signed-off and
> emits a warning if the exact email names and addresses do not match.

Yes, I've seen this a few times.

> Unfortunately, the author email address can be written without the comment
> like:
> 
> 	Peter Zijlstra <peterz@infradead.org>
> 
> Add logic to compare the comment stripped email addresses to avoid this
> warning.

Where "stripped" means "after removing stuff in parentheses"?

Why do we consider the display name at all?  It's the
"peterz@infradead.org" part which matters for comparison purposes?
