Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956FAC3B194
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 02:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747902082F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 02:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgBNCQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 21:16:32 -0500
Received: from gentwo.org ([3.19.106.255]:41500 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728052AbgBNCQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 21:16:32 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 94F033EC23; Fri, 14 Feb 2020 02:16:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 942983E871;
        Fri, 14 Feb 2020 02:16:31 +0000 (UTC)
Date:   Fri, 14 Feb 2020 02:16:31 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Wen Yang <wenyang@linux.alibaba.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Xunlei Pang <xlpang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: Detach node lock from counting free objects
In-Reply-To: <20200212145615.3518e29ec90d580817c14dc8@linux-foundation.org>
Message-ID: <alpine.DEB.2.21.2002140214480.4786@www.lameter.com>
References: <20200201031502.92218-1-wenyang@linux.alibaba.com> <5373ce28-c369-4e40-11dd-b269e4d2cb24@linux.alibaba.com> <alpine.DEB.2.21.2002082138070.21534@www.lameter.com> <20200212145615.3518e29ec90d580817c14dc8@linux-foundation.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020, Andrew Morton wrote:

> : reading "/proc/slabinfo" can possibly block the slab allocation on
> : another CPU for a while, 200ms in extreme cases
>
> That was bad of us.  It would be good to stop doing this.

The count is not needed for any operations. Just for the slabinfo output.
The value has no operational value for the allocator itself. So why use
extra logic to track it in potentially performance critical paths?

One could estimate the number of objects from the number of allocated
slabs instead?

