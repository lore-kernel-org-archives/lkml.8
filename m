Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD22C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA5A20CC7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbgCCQFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 11:05:05 -0500
Received: from gentwo.org ([3.19.106.255]:43296 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728714AbgCCQFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 11:05:04 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id EACA73F1C0; Tue,  3 Mar 2020 16:05:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id E968E3EECA;
        Tue,  3 Mar 2020 16:05:03 +0000 (UTC)
Date:   Tue, 3 Mar 2020 16:05:03 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Roman Gushchin <guro@fb.com>
cc:     Wen Yang <wenyang@linux.alibaba.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xunlei Pang <xlpang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: improve count_partial() for
 CONFIG_SLUB_CPU_PARTIAL
In-Reply-To: <20200227183519.GA50628@carbon.dhcp.thefacebook.com>
Message-ID: <alpine.DEB.2.21.2003031602460.1537@www.lameter.com>
References: <20200222092428.99488-1-wenyang@linux.alibaba.com> <alpine.DEB.2.21.2002240126190.13486@www.lameter.com> <20200224165750.GA478187@carbon.dhcp.thefacebook.com> <alpine.DEB.2.21.2002261827440.8012@www.lameter.com>
 <20200227183519.GA50628@carbon.dhcp.thefacebook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020, Roman Gushchin wrote:

> 1) Reading /proc/slabinfo can cause latency spikes in concurrent memory allocations.
>    This is the problem which Wen raised initially.

Ok. Maybe cache the values or do not read /proc/slabinfo? Use
/sys/kernel/slab/... instead?

> 2) The number of active objects as displayed in /proc/slabinfo is misleadingly
>    big if CONFIG_SLUB_CPU_PARTIAL is set.

Ok that cou.d be fixed by counting the partial slabs when computing
/proc/slabinfo output but that would increase the times even more.

> Maybe mixing them in a single workaround wasn't the best idea, but what do you
> suggest instead?

Read select values from /sys/kernel/slab/.... to determine the values you
need and avoid reading those that cause latency spikes. Use the number of
slabs for example to estimate the number of objects instead of the number
of objects which requires scanning through all the individual slab pages.

