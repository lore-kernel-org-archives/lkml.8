Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB929C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 20:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 890CB20724
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 20:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598043313;
	bh=lFPj1Yo752ipcEnQysJGQoRPKTfWhUtUxBkOy91w4Yo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=JrOEOTym4AkZXJE++6Lk3t5MuJT0ii9RgC/NCGLsQk2fyRvfMoRk+XfWxQoezoOF3
	 MsUwPMpOobm2H9G/hk1gukwL+xcGOHNq4/tVa6EXh34NRqmKwj5Geqif4mz750Q0Y9
	 MGRu/ujipGehhhHxwSjRGotnBa6qwmp3NsD0EWzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgHUUzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 16:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbgHUUzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 16:55:09 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22FAA20724;
        Fri, 21 Aug 2020 20:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598043308;
        bh=lFPj1Yo752ipcEnQysJGQoRPKTfWhUtUxBkOy91w4Yo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2rw4RRpEhcqRsgt+VQ4jfF+2tRRhajw6yJRuUnhFQsLTtoFnaRW6qqDqAr5/uXXEw
         +d+C4ucs0OPpmEOAxsGMX3KgECAuC7XRSkLBNhGUVUGd4rztm3r7KuadavCpY7CNco
         HFfp93yR2RGpqbDsS/6IyB8pLajVOEUu/lqSJpYc=
Date:   Fri, 21 Aug 2020 13:55:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        Baoquan He <bhe@redhat.com>, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v5 0/6] mm / virtio-mem: support ZONE_MOVABLE
Message-Id: <20200821135507.cc20edbdd11205257cfd86e5@linux-foundation.org>
In-Reply-To: <bb7cad5a-daa3-132e-1bc1-19110476b55e@redhat.com>
References: <20200816125333.7434-1-david@redhat.com>
        <552a2a55-6082-d286-1cd4-7f7e368eebb4@redhat.com>
        <bb7cad5a-daa3-132e-1bc1-19110476b55e@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Aug 2020 10:45:33 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 21.08.20 10:31, David Hildenbrand wrote:
> > On 16.08.20 14:53, David Hildenbrand wrote:
> >> For 5.10. Patch #1-#4,#6 have RBs or ACKs, patch #5 is virtio-mem stuff
> >> maintained by me. This should go via the -mm tree.
> >>
> > 
> > @Andrew, can we give this a churn if there are no further comments? Thanks!
> 
> ... I just spotted the patches in -next, strange I didn't get an email
> notification. Thanks :)

https://lore.kernel.org/mm-commits/20200819025501.gJhZlolfC%25akpm@linux-foundation.org/

akpm!=spam :)
