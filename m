Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D592C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC5A2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731127AbgBYPuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:50:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:37160 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730666AbgBYPuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 10:50:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B8C17B1AD;
        Tue, 25 Feb 2020 15:50:01 +0000 (UTC)
Subject: Re: [PATCH] mm/slub: improve count_partial() for
 CONFIG_SLUB_CPU_PARTIAL
To:     Roman Gushchin <guro@fb.com>, Christopher Lameter <cl@linux.com>
Cc:     Wen Yang <wenyang@linux.alibaba.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xunlei Pang <xlpang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200222092428.99488-1-wenyang@linux.alibaba.com>
 <alpine.DEB.2.21.2002240126190.13486@www.lameter.com>
 <20200224165750.GA478187@carbon.dhcp.thefacebook.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 mQINBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABtCBWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmN6PokCVAQTAQoAPgIbAwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJcbbyGBQkH8VTqAAoJECJPp+fMgqZkpGoP
 /1jhVihakxw1d67kFhPgjWrbzaeAYOJu7Oi79D8BL8Vr5dmNPygbpGpJaCHACWp+10KXj9yz
 fWABs01KMHnZsAIUytVsQv35DMMDzgwVmnoEIRBhisMYOQlH2bBn/dqBjtnhs7zTL4xtqEcF
 1hoUFEByMOey7gm79utTk09hQE/Zo2x0Ikk98sSIKBETDCl4mkRVRlxPFl4O/w8dSaE4eczH
 LrKezaFiZOv6S1MUKVKzHInonrCqCNbXAHIeZa3JcXCYj1wWAjOt9R3NqcWsBGjFbkgoKMGD
 usiGabetmQjXNlVzyOYdAdrbpVRNVnaL91sB2j8LRD74snKsV0Wzwt90YHxDQ5z3M75YoIdl
 byTKu3BUuqZxkQ/emEuxZ7aRJ1Zw7cKo/IVqjWaQ1SSBDbZ8FAUPpHJxLdGxPRN8Pfw8blKY
 8mvLJKoF6i9T6+EmlyzxqzOFhcc4X5ig5uQoOjTIq6zhLO+nqVZvUDd2Kz9LMOCYb516cwS/
 Enpi0TcZ5ZobtLqEaL4rupjcJG418HFQ1qxC95u5FfNki+YTmu6ZLXy+1/9BDsPuZBOKYpUm
 3HWSnCS8J5Ny4SSwfYPH/JrtberWTcCP/8BHmoSpS/3oL3RxrZRRVnPHFzQC6L1oKvIuyXYF
 rkybPXYbmNHN+jTD3X8nRqo+4Qhmu6SHi3Vq
Message-ID: <f50afb1b-bb63-eae9-4f8c-dbc5f678d43d@suse.cz>
Date:   Tue, 25 Feb 2020 16:49:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200224165750.GA478187@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/20 5:57 PM, Roman Gushchin wrote:
> On Mon, Feb 24, 2020 at 01:29:09AM +0000, Christoph Lameter wrote:
>> On Sat, 22 Feb 2020, Wen Yang wrote:
> 
> Hello, Christopher!
> 
>>
>>> We also observed that in this scenario, CONFIG_SLUB_CPU_PARTIAL is turned
>>> on by default, and count_partial() is useless because the returned number
>>> is far from the reality.
>>
>> Well its not useless. Its just not counting the partial objects in per cpu
>> partial slabs. Those are counted by a different counter it.
> 
> Do you mean CPU_PARTIAL_ALLOC or something else?
> 
> "useless" isn't the most accurate wording, sorry for that.
> 
> The point is that the number of active objects displayed in /proc/slabinfo
> is misleading if percpu partial lists are used. So it's strange to pay
> for it by potentially slowing down concurrent allocations.

Hmm, I wonder... kmem_cache_cpu has those quite detailed stats with
CONFIG_SLUB_STATS. Could perhaps the number of free object be
reconstructed from them by adding up / subtracting the relevant items
across all CPUs? Expensive, but the cost would be taken by the
/proc/slabinfo reader, without blocking anyone.

Then again, CONFIG_SLUB_STATS is disabled by default. But the same
percpu mechanism could be used to create some "stats light" variant that
doesn't count everything, just what's needed to track number of free
objects. Percpu should mean the atomic inc/decs wouldn't cause much
contention...

It's certainly useful to have an idea of slab fragmentation (low inuse
vs total object) from /proc/slabinfo. But if that remains available via
/sys/kernel/slab/ then I guess it's fine... until all continuous
monitoring tools that now read /proc/slabinfo periodically start reading
all those /sys/kernel/slab/ files periodically...
