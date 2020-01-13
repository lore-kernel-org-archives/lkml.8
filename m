Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF76C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 01:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD16F21556
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 01:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732869AbgAMBek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 20:34:40 -0500
Received: from gentwo.org ([3.19.106.255]:55568 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730100AbgAMBej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 20:34:39 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id EEB3C3ED6B; Mon, 13 Jan 2020 01:34:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id ED43E3ED4F;
        Mon, 13 Jan 2020 01:34:38 +0000 (UTC)
Date:   Mon, 13 Jan 2020 01:34:38 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     Vlastimil Babka <vbabka@suse.cz>, Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [FIX] slub: Remove kmalloc under list_lock from list_slab_objects()
 V2
In-Reply-To: <e0ed44ae-8dae-e8db-9d14-2b09b239af8e@i-love.sakura.ne.jp>
Message-ID: <alpine.DEB.2.21.2001130132580.1578@www.lameter.com>
References: <20191108193958.205102-1-yuzhao@google.com> <20191108193958.205102-2-yuzhao@google.com> <alpine.DEB.2.21.1911092024560.9034@www.lameter.com> <20191109230147.GA75074@google.com> <alpine.DEB.2.21.1911092313460.32415@www.lameter.com>
 <20191110184721.GA171640@google.com> <alpine.DEB.2.21.1911111543420.10669@www.lameter.com> <alpine.DEB.2.21.1911111553020.15366@www.lameter.com> <20191130150908.06b2646edfa7bdc12a943c25@linux-foundation.org> <alpine.DEB.2.21.1912021511250.15780@www.lameter.com>
 <20191207220320.GA67512@google.com> <e9f26cbd-593b-116e-2e4a-f8e0e16c23fc@suse.cz> <e0ed44ae-8dae-e8db-9d14-2b09b239af8e@i-love.sakura.ne.jp>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jan 2020, Tetsuo Handa wrote:

> On 2020/01/10 23:11, Vlastimil Babka wrote:
> Hmm, this one? Even non-ML destinations are sometimes rejected (e.g.
>   554 5.7.1 Service unavailable; Client host [202.181.97.72] blocked using b.barracudacentral.org; http://www.barracudanetworks.com/reputation/?pr=1&ip=202.181.97.72
> ). Anyway, I just worried whether it is really safe to do memory allocation
> which might involve memory reclaim. You MM guys know better...

We are talking about a call to destroy the kmem_cache. This is not done
under any lock. The lock was taken inside that function before the call to
list_slab_objects. That can be avoided.
