Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4DCC352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 18:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7766C20848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 18:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581532010;
	bh=n7uPnQHK86C/yR98ahD+dw8Skc2Kfc8eoGeK4vmmpQM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=JrtJI/vptgiFRmqULq/6gu7dJkYoAZUgY/D2duvhp83aPu4JqdTfnRZN1LgWC8LYY
	 SCfZq6caX1EedBl0//qnh6Ijin08Ah6uWxn+8VWlyGOEQsXK+JXm4XsT8MYRRQI3U4
	 V6/5CFmowVlMuHkdO4PVkMRdl2Lg1DCbk7uNd0cM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgBLS0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 13:26:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:51458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727361AbgBLS0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 13:26:49 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EAD320714;
        Wed, 12 Feb 2020 18:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581532008;
        bh=n7uPnQHK86C/yR98ahD+dw8Skc2Kfc8eoGeK4vmmpQM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QAybABBdKYt0FzNsknY7TWmD/KpadhC97etcMMqZr2El8wcj7/EMLTUVl9rUaAKwa
         LVm97Saban54y9pGkZJqPXEV8uUcVkZdP9LRd+DL9uKFN0MLpGqEuSH3U88j/TJoql
         r66kO3t8IshxI+a/zQndlbA5LXeXF4NaLEP+nU7s=
Date:   Wed, 12 Feb 2020 10:26:45 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Rik van Riel <riel@surriel.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, kernel-team@fb.com
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker
 LRU
Message-Id: <20200212102645.7b2e5b228048b6d22331e47d@linux-foundation.org>
In-Reply-To: <20200212163540.GA180867@cmpxchg.org>
References: <20200211175507.178100-1-hannes@cmpxchg.org>
        <29b6e848ff4ad69b55201751c9880921266ec7f4.camel@surriel.com>
        <20200211193101.GA178975@cmpxchg.org>
        <20200211154438.14ef129db412574c5576facf@linux-foundation.org>
        <20200212163540.GA180867@cmpxchg.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020 11:35:40 -0500 Johannes Weiner <hannes@cmpxchg.org> wrote:

> Since the cache purging code was written for highmem scenarios, how
> about making it specific to CONFIG_HIGHMEM at least?

Why do I have memories of suggesting this a couple of weeks ago ;)

> That way we improve the situation for the more common setups, without
> regressing highmem configurations. And if somebody wanted to improve
> the CONFIG_HIGHMEM behavior as well, they could still do so.
> 
> Somethig like the below delta on top of my patch?

Does it need to be that complicated?  What's wrong with

--- a/fs/inode.c~a
+++ a/fs/inode.c
@@ -761,6 +761,10 @@ static enum lru_status inode_lru_isolate
 		return LRU_ROTATE;
 	}
 
+#ifdef CONFIG_HIGHMEM
+	/*
+	 * lengthy blah
+	 */
 	if (inode_has_buffers(inode) || inode->i_data.nrpages) {
 		__iget(inode);
 		spin_unlock(&inode->i_lock);
@@ -779,6 +783,7 @@ static enum lru_status inode_lru_isolate
 		spin_lock(lru_lock);
 		return LRU_RETRY;
 	}
+#endif
 
 	WARN_ON(inode->i_state & I_NEW);
 	inode->i_state |= I_FREEING;
_

Whatever we do will need plenty of testing.  It wouldn't surprise me
if there are people who unknowingly benefit from this code on
64-bit machines.
