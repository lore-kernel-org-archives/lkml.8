Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD82C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 09:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DD35208DB
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 09:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgETJvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 05:51:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:51402 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgETJvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 05:51:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B6D1AAC49;
        Wed, 20 May 2020 09:51:54 +0000 (UTC)
Subject: Re: [PATCH v3 04/19] mm: slub: implement SLUB version of
 obj_to_index()
To:     Roman Gushchin <guro@fb.com>, Christopher Lameter <cl@linux.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20200423000530.GA63356@carbon.lan>
 <alpine.DEB.2.21.2004250208500.7624@www.lameter.com>
 <20200425024625.GA107755@carbon.lan>
 <alpine.DEB.2.21.2004271618340.27701@www.lameter.com>
 <20200427164638.GC114719@carbon.DHCP.thefacebook.com>
 <alpine.DEB.2.21.2004301625490.1693@www.lameter.com>
 <20200430171558.GA339283@carbon.dhcp.thefacebook.com>
 <alpine.DEB.2.22.394.2005022353330.1987@www.lameter.com>
 <20200504182922.GA20009@carbon.dhcp.thefacebook.com>
 <alpine.DEB.2.22.394.2005082130570.65713@www.lameter.com>
 <20200513005741.GA67541@carbon.dhcp.thefacebook.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <88972cc2-2120-4257-ae8d-141e014c54e4@suse.cz>
Date:   Wed, 20 May 2020 11:51:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513005741.GA67541@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/20 2:57 AM, Roman Gushchin wrote:
> 
> Btw, I'm trying to build up a prototype with an embedded memcg pointer,
> but it seems to be way more tricky than I thought. It requires changes to
> shrinkers (as they rely on getting the memcg pointer by an arbitrary
> kernel address, not necessarily aligned to the head of slab allocation),
> figuring out cache merging, adding SLAB support, natural alignment of
> kmallocs etc.

Is the natural alignment of kmallocs a problem right now? As kmalloc()
allocations are AFAIK not kmemcg-accounted? Or does your implementation add
memcg awareness to everything, even if non-__GFP_ACCOUNT allocations just get a
root memcg pointer?

> Figuring out all these details will likely take several weeks, so the whole
> thing will be delayed for one-two major releases (in the best case). Given that
> the current implementation saves ~40% of slab memory, I think there is some value
> in delivering it as it is. So I wonder if the idea of embedding the pointer
> should be considered a blocker, or it can be implemented of top of the proposed
> code (given it's not a user-facing api or something like this)?
> 
> Thanks!
> 

