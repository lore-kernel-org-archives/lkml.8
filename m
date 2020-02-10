Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74450C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 21:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F09C20733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 21:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgBJVjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 16:39:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:33576 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbgBJVjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 16:39:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 49E93ABD7;
        Mon, 10 Feb 2020 21:39:23 +0000 (UTC)
Date:   Mon, 10 Feb 2020 13:28:32 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, alex.williamson@redhat.com,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/5] lib/rbtree: introduce linked-list rbtree interface
Message-ID: <20200210212832.2i2i3kbybhk2rcee@linux-p48b>
References: <20200207180305.11092-1-dave@stgolabs.net>
 <20200207180305.11092-2-dave@stgolabs.net>
 <20200210200712.GM11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200210200712.GM11244@42.do-not-panic.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2020, Luis Chamberlain wrote:

>I think including the word "branchless" does injustice to the
>optimization, just O(1) sells it to me more to how I read the code.
>Why is the "branchless" prefix needed here?

Yes, compared to regular rb_next() 'branchless' would be unnecessary.

However compared to other node representations that are easier on
the memory footprint (parent pointers or threaded trees) also have
O(1) but still have branches - but most importantly, these approaches
incur in higher overhead for modifications to the tree.

>
>> access to the first node as well as
>> both its in-order successor and predecessor. This is done at the cost of higher
>> memory footprint: mainly additional prev and next pointers for each node. Such
>> benefits can be seen in this table showing the amount of cycles it takes to
>> do a full tree traversal:
>>
>>    +--------+--------------+-----------+
>>    | #nodes | plain rbtree | ll-rbtree |
>>    +--------+--------------+-----------+
>>    |     10 |          138 |        24 |
>>    |    100 |        7,200 |       425 |
>>    |   1000 |       17,000 |     8,000 |
>>    |  10000 |      501,090 |   222,500 |
>>    +--------+--------------+-----------+
>
>Sold, however I wonder if we can have *one new API* where based on just one
>Kconfig you either get the two pointers or not, the performance gain
>then would only be observed if this new kconfig entry is enabled. The
>benefit of this is that we don't shove the performance benefit down
>all user's throughts but rather this can be decided by distributions
>and system integrators.

I don't think we want an all or nothing approach as different users in the
kernel have different needs and some users are simply unable to deal with
enlarging data structures, while others have no problem.

>...

>> +Inserting data into a Linked-list rbtree
>> +----------------------------------------
>> +
>> +Because llrb trees can exist anywhere regular rbtrees, the steps are similar.
>> +The search for insertion differs from the regular search in two ways. First
>> +the caller must keep track of the previous node,
>
>can you explain here why, even though its clear in the code: its because
>we need to pass it as a parameter when the new node is inserted into the
>rb tree.

Right. We piggyback from the node info we already have available ie when user
iterates down the tree to find a point of insertion.

>
>Also, what about a selftest for this?

So we have lib/rbtree_test.c which does functional+latency testing - which I am
planning on updating if this series is merged. I first have some patches that
improve the overall module that are unrelated to this series and therefore
did not send it.

>
>Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

Thanks,
Davidlohr
