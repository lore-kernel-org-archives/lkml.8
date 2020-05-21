Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE45C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E3742072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590081919;
	bh=vAo4QzwpoFgYhFQKi8shN2DAw/GCIUkoAg0u7koid4w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=HIEAowAcymGhToh8pORDZFlG3eX9JTZSCp9m90JNbTyH2WshvfQBuafdUfyQ0dked
	 HFvNhj7SjQEuawBmUQttcDsBS1n6EpJNR3BbVpvR+hcSmnUPlFpIcHIsSZOO95grt0
	 gKx5Aww1x9klQ5Yq+fBpSdTEiAtOJWA8oOGjCfgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgEURZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 13:25:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:48236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728553AbgEURZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 13:25:18 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C7CB2067B;
        Thu, 21 May 2020 17:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590081918;
        bh=vAo4QzwpoFgYhFQKi8shN2DAw/GCIUkoAg0u7koid4w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Mma1o5WsQIScc1MuikrJ4qDvMkMce5c94pM4GHrfjLEFjwHZiw8Az6j6QUZVGH59i
         4q6XkBQfVqhPj8dJl7DwHwbbj8poVnhg5KeZ7Bof8mUSpfWEt8GUMDUeboX3glfqsR
         ChAPSWW2rvzhmYqzPZHoTmLe5d+TdEVzhFZO/sOE=
Date:   Thu, 21 May 2020 10:25:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michel Lespinasse <walken@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v6 12/12] mmap locking API: convert mmap_sem comments
Message-Id: <20200521102516.01dbc9fcc539baba96224c3f@linux-foundation.org>
In-Reply-To: <CANN689GXWS9yHTw0aN-tAkd9tyA-vRn0GbJgC+Td=1r13KBZzA@mail.gmail.com>
References: <20200520052908.204642-1-walken@google.com>
        <20200520052908.204642-13-walken@google.com>
        <e01060e9-6f00-7fa8-5da0-c9250c951d10@suse.cz>
        <CANN689GXWS9yHTw0aN-tAkd9tyA-vRn0GbJgC+Td=1r13KBZzA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020 00:50:56 -0700 Michel Lespinasse <walken@google.com> wrote:

> > >   * Must be called holding task's alloc_lock to protect task's mems_allowed
> > > - * and mempolicy.  May also be called holding the mmap_semaphore for write.
> > > + * and mempolicy.  May also be called holding the mmap_lockaphore for write.
> > >   */
> > >  static int mpol_set_nodemask(struct mempolicy *pol,
> > >                    const nodemask_t *nodes, struct nodemask_scratch *nsc)
> >
> > :)
> 
> Haha, good catch !

aww, you're all so cruel.  The world would be a better place if Linux
had lockaphores!
