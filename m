Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A59C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 13:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27FA4221E2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 13:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgHGNCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 09:02:44 -0400
Received: from gentwo.org ([3.19.106.255]:35074 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgHGNCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 09:02:44 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 459743EA6D; Fri,  7 Aug 2020 13:02:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 43B3F3EA37;
        Fri,  7 Aug 2020 13:02:43 +0000 (UTC)
Date:   Fri, 7 Aug 2020 13:02:43 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Pekka Enberg <penberg@gmail.com>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        Xunlei Pang <xlpang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 1/2] mm/slub: Introduce two counters for the partial
 objects
In-Reply-To: <CAOJsxLHX62P0yvHZcXdje41zm_2demzTraqvHXAvfhVPp2HKsA@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2008071258020.55871@www.lameter.com>
References: <1593678728-128358-1-git-send-email-xlpang@linux.alibaba.com> <a53f9039-5cba-955b-009e-12e8c5ffb345@suse.cz> <CAOJsxLHX62P0yvHZcXdje41zm_2demzTraqvHXAvfhVPp2HKsA@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Aug 2020, Pekka Enberg wrote:

> I think we can just default to the counters. After all, if I
> understood correctly, we're talking about up to 100 ms time period
> with IRQs disabled when count_partial() is called. As this is
> triggerable from user space, that's a performance bug whatever way you
> look at it.


Well yes under extreme conditions and this is only happening for sysfs
counter retrieval.

There could be other solutions to this. This solution here is penalizing
evertu hotpath slab allocation for the sake of relatively infrequently
used counter monitoring. There the possibility of not traversing the list
ande simply estimating the value based on the number of slab pages
allocated on that node.

> Christoph, others, any objections?

Obviously .... ;-)

