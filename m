Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A00C2BB86
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 02:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E093320768
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 02:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586830539;
	bh=jf+A5BOVOt2DrD15bo3uMAmUl8iVMb/SY+JfZlmUKnA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=XDQsnXdAFJ76c2LUNqQV+A1pRCoL3bmS4TIpRfno4lu4YXR8BloGGxJxZ6wvH3RlW
	 8802c6CbVpUXlMF0ayo5thfPyt/KYYuGi6Xyu6Y/YtKqb7OpfCujNm1dv7rvVuPHiG
	 cG7dTCmy9oYmtCbW8OQFr+J94b3OVgqKM0VszPcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404040AbgDNCPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 22:15:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403967AbgDNCPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 22:15:33 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AB2A2072D;
        Tue, 14 Apr 2020 02:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586830532;
        bh=jf+A5BOVOt2DrD15bo3uMAmUl8iVMb/SY+JfZlmUKnA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iv3CEqU1ivakHxCxU9TGDqQnv1OHMGi48YIRuRnWsPWVUKwVJjTmhfCvk3OVLkOtC
         ZWqG1ZckUNOqWjpjcJvcVAYnKucUZMBQKXORY0MtQPKOSudQYbj9sJWVpDt2/Zb0wL
         U8AXxbLZTa+CTIio8Ky1EpGdd1ulfgenE8C6Pe/M=
Date:   Mon, 13 Apr 2020 19:15:32 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@kernel.org>, NeilBrown <neilb@suse.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: clarify __GFP_MEMALLOC usage
Message-Id: <20200413191532.6b234b50caea9134fb95a151@linux-foundation.org>
In-Reply-To: <efbdbe8f-f4fe-cfc8-4f15-1e19ee0bf416@nvidia.com>
References: <20200403083543.11552-1-mhocko@kernel.org>
        <20200403083543.11552-2-mhocko@kernel.org>
        <alpine.DEB.2.21.2004031238571.230548@chino.kir.corp.google.com>
        <87blo8xnz2.fsf@notabene.neil.brown.name>
        <20200406070137.GC19426@dhcp22.suse.cz>
        <4f861f07-4b47-8ddc-f783-10201ea302d3@nvidia.com>
        <alpine.DEB.2.21.2004061626540.45667@chino.kir.corp.google.com>
        <efbdbe8f-f4fe-cfc8-4f15-1e19ee0bf416@nvidia.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I've rather lost the plot with this little patch.  Is the below
suitable, or do we think that changes are needed?


From: Michal Hocko <mhocko@suse.com>
Subject: mm: clarify __GFP_MEMALLOC usage

It seems that the existing documentation is not explicit about the
expected usage and potential risks enough.  While it is calls out that
users have to free memory when using this flag it is not really apparent
that users have to careful to not deplete memory reserves and that they
should implement some sort of throttling wrt.  freeing process.

This is partly based on Neil's explanation [1].

Let's also call out that a pre allocated pool allocator should be
considered.

[1] http://lkml.kernel.org/r/877dz0yxoa.fsf@notabene.neil.brown.name

[akpm@linux-foundation.org: coding style fixes]
Link: http://lkml.kernel.org/r/20200403083543.11552-2-mhocko@kernel.org
Signed-off-by: Michal Hocko <mhocko@suse.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neil Brown <neilb@suse.de>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>
[mhocko@kernel.org: update]
  Link: http://lkml.kernel.org/r/20200406070137.GC19426@dhcp22.suse.cz
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/gfp.h |    5 +++++
 1 file changed, 5 insertions(+)

--- a/include/linux/gfp.h~mm-clarify-__gfp_memalloc-usage
+++ a/include/linux/gfp.h
@@ -110,6 +110,11 @@ struct vm_area_struct;
  * the caller guarantees the allocation will allow more memory to be freed
  * very shortly e.g. process exiting or swapping. Users either should
  * be the MM or co-ordinating closely with the VM (e.g. swap over NFS).
+ * Users of this flag have to be extremely careful to not deplete the reserve
+ * completely and implement a throttling mechanism which controls the
+ * consumption of the reserve based on the amount of freed memory.
+ * Usage of a pre-allocated pool (e.g. mempool) should be always considered
+ * before using this flag.
  *
  * %__GFP_NOMEMALLOC is used to explicitly forbid access to emergency reserves.
  * This takes precedence over the %__GFP_MEMALLOC flag if both are set.
_

