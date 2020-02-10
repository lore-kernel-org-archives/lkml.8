Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904F9C2BA83
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 01:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3DD214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 01:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581299195;
	bh=Y/a7kDN56rMD+1WLqPqN+7Z3YFOjfEIzGOm3VH3cENo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Efx14oIvIFVy9lgYgIgxjrnPnlMnFI4PccJTQ41YwPQhypE9JR4AI18+QprZuF44/
	 l+kKTkM/4Ll1wjTW4kaOndxf1XlkQhUmLM94JIdC7b+ewudyJ+Y8fMeyQ5FLAF0kaS
	 /F+A1N04DgzZURD26QYchLdOsj/cRCPZWw5WKDAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgBJBqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 20:46:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:37702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgBJBqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 20:46:34 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49DFF20838;
        Mon, 10 Feb 2020 01:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581299193;
        bh=Y/a7kDN56rMD+1WLqPqN+7Z3YFOjfEIzGOm3VH3cENo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=v+ShQy1ieLFZnd8zebV6Xon3bdfr/CVqiQZzCB5BXvSonplc3K/uLYRtgBDtFtxF6
         0VKo1ML0U6fJgHfrZ/NgPICWwcBfss3d4xpxoVcrd5U9wLvG97GIDPWibJHgtF9tQH
         /DWBWWN1daYWERPmEGYwGMck3h8zd9Mqfjz3imyU=
Date:   Sun, 9 Feb 2020 17:46:32 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        broonie@kernel.org, alex.williamson@redhat.com
Subject: Re: [PATCH -next 0/5] rbtree: optimize frequent tree walks
Message-Id: <20200209174632.9c7b6ff20567853c05e5ee58@linux-foundation.org>
In-Reply-To: <20200207180305.11092-1-dave@stgolabs.net>
References: <20200207180305.11092-1-dave@stgolabs.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Feb 2020 10:03:00 -0800 Davidlohr Bueso <dave@stgolabs.net> wrote:

> This series introduces the ll_rbtree interface to optimize rbtree users
> that incur in frequent in-order tree iterations (even full traversals).
> This can be seen as an abstraction to what is already done for dealing
> with VMAs (albeit non-augmented trees).
> 
> Mainly, it trades off higher per-node memory footprint (two extra pointers)
> for minimal runtime overhead to gain O(1) brachless next and prev node
> pointers. See patch 1 for full details, but, for example, the following
> tables show the benefits vs the costs of using this new interface.
> 
>    +--------+--------------+-----------+
>    | #nodes | plain rbtree | ll-rbtree |
>    +--------+--------------+-----------+
>    |     10 |          138 |        24 |
>    |    100 |        7,200 |       425 |
>    |   1000 |       17,000 |     8,000 |
>    |  10000 |      501,090 |   222,500 |
>    +--------+--------------+-----------+
> 
> While there are other node representations that optimize getting such pointers
> without bloating the nodes as much, such as keeping a parent pointer or threaded
> trees where the nil prev/next pointers are recycled; both incurring in higher
> runtime penalization for common modification operations as well as any rotations.
> The overhead of tree modifications can be seen in the following table, comparing
> cycles to insert+delete:
> 
>    +--------+--------------+------------------+-----------+
>    | #nodes | plain rbtree | augmented rbtree | ll-rbtree |
>    +--------+--------------+------------------+-----------+
>    |     10 |          530 |              840 |       600 |
>    |    100 |        7,100 |           14,200 |     7,800 |
>    |   1000 |      265,000 |          370,000 |   205,200 |
>    |  10000 |    4,400,000 |        5,500,000 | 4,200,000 |
>    +--------+--------------+------------------+-----------+
> 
> 
> Patch 1 introduces the ll_rbtree machinery.
> 
> Patches 2-5 convert users that might benefit from the new interface.
> 
> Full details and justifications for the conversion are in each
> individual patch.
> 
> I am Cc'ing some of the maintainers of the users I have converted to the whole
> series such that it can the numbers and interface details can be easily seen.
> 
> Please consider for v5.7.

Seems that all the caller sites you've converted use a fairly small
number of rbnodes, so the additional storage shouldn't be a big
problem.  Are there any other sites you're eyeing?  If so, do you expect
any of those will use a significant amount of memory for the nodes?

And...  are these patches really worth merging?  Complexity is added,
but what end-user benefit can we expect?
