Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E88C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EAF62080D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgFQQTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:19:38 -0400
Received: from gentwo.org ([3.19.106.255]:38660 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgFQQTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:19:35 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 043D13E9DB; Wed, 17 Jun 2020 16:19:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 028753E9D1;
        Wed, 17 Jun 2020 16:19:35 +0000 (UTC)
Date:   Wed, 17 Jun 2020 16:19:34 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Muchun Song <songmuchun@bytedance.com>
cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] mm/slub: Fix slabs_node return value
In-Reply-To: <20200614123923.99189-1-songmuchun@bytedance.com>
Message-ID: <alpine.DEB.2.22.394.2006171616190.1574@www.lameter.com>
References: <20200614123923.99189-1-songmuchun@bytedance.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jun 2020, Muchun Song wrote:

> The slabs_node() always return zero when CONFIG_SLUB_DEBUG is disabled.
> But some codes determine whether slab is empty by checking the return
> value of slabs_node(). As you know, the result is not correct. we move
> the nr_slabs of kmem_cache_node out of the CONFIG_SLUB_DEBUG. So we can
> get the corrent value returned by the slabs_node().

Not that all distribution kernels have CONFIG_SLUB_DEBUG enabled. This
does not enable runtime debugging but only compiles the debug code in that
can then be enabled at runtime.

Users of !CONFIG_SLUB_DEBUG do not want to have the debug code included
because they have extreme requirements on memory use.

This patch increases use of memory by enabling fields that were excluded
under !CONFIG_SLUB_DEBUG before!

There is nothing wrong with slab_node's return value if one wants to
sacrifice debugging and consistency checks for a small code build.


