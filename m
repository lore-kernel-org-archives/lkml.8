Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025DDC2D0E3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC706208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599243172;
	bh=Id4qhzHOsS6DwGIQ5LVetNXj3LxgcTh1B0kqH3vve5o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=uIgQOsrJOSRSNDETXU0shxQsvEoivnlJgGoNEaWMU/Rn0ZLNA/i5mgtQarxfrrCKN
	 k5qdlZ8EeSbZ2tCESQ/COsWiH0GdIHHV3jfj1pOYOq3jr+9dMg49+YCasX6KKq7ikf
	 i9kkBkDxTeqToh/QjL1dOXgt+Z298on32Qth9XzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgIDSMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 14:12:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgIDSMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 14:12:49 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C8AA208CA;
        Fri,  4 Sep 2020 18:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599243168;
        bh=Id4qhzHOsS6DwGIQ5LVetNXj3LxgcTh1B0kqH3vve5o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=geJYOB2xEbbkF6OnJWiwu7wzHo+MfStfINict1HWGoIhirYFl0er44nUec+OYyT6I
         5bU477LNJafUy+yz95yiwzDBZZFFmKVk1bPChtXZIgy9vdBd3baPfALJQ3DXi4Hau0
         TKowc5PUkqMsVKJpY1vfP72u4k/Ge0C++UwD1M68=
Date:   Fri, 4 Sep 2020 11:12:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     mateusznosek0@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc.c: Clean code by removing unnecessary
 initialization
Message-Id: <20200904111247.371e5bfca967239781e5bf27@linux-foundation.org>
In-Reply-To: <20200904132422.17387-1-mateusznosek0@gmail.com>
References: <20200904132422.17387-1-mateusznosek0@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Sep 2020 15:24:22 +0200 mateusznosek0@gmail.com wrote:

> From: Mateusz Nosek <mateusznosek0@gmail.com>
> 
> Previously variable 'tmp' was initialized, but was not read later
> before reassigning. So the initialization can be removed.
> 
> ...
>
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5637,7 +5637,7 @@ static int find_next_best_node(int node, nodemask_t *used_node_mask)
>  	int n, val;
>  	int min_val = INT_MAX;
>  	int best_node = NUMA_NO_NODE;
> -	const struct cpumask *tmp = cpumask_of_node(0);
> +	const struct cpumask *tmp;
>  
>  	/* Use the local node if we haven't already */
>  	if (!node_isset(node, *used_node_mask)) {

OK.   But we may as well kill tmp altogether?

--- a/mm/page_alloc.c~mm-page_allocc-clean-code-by-removing-unnecessary-initialization-fix
+++ a/mm/page_alloc.c
@@ -5637,7 +5637,6 @@ static int find_next_best_node(int node,
 	int n, val;
 	int min_val = INT_MAX;
 	int best_node = NUMA_NO_NODE;
-	const struct cpumask *tmp;
 
 	/* Use the local node if we haven't already */
 	if (!node_isset(node, *used_node_mask)) {
@@ -5658,8 +5657,7 @@ static int find_next_best_node(int node,
 		val += (n < node);
 
 		/* Give preference to headless and unused nodes */
-		tmp = cpumask_of_node(n);
-		if (!cpumask_empty(tmp))
+		if (!cpumask_empty(cpumask_of_node(n)))
 			val += PENALTY_FOR_NODE_WITH_CPUS;
 
 		/* Slight preference for less loaded node */
_

