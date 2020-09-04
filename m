Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD02C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17E56206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 06:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgIDGdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 02:33:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:55850 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgIDGc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 02:32:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 05A0DB5D8;
        Fri,  4 Sep 2020 06:32:58 +0000 (UTC)
Subject: Re: [PATCH] mm/memory_hotplug: drain per-cpu pages again during
 memory offline
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
References: <20200901124615.137200-1-pasha.tatashin@soleen.com>
 <20200902140851.GJ4617@dhcp22.suse.cz>
 <CA+CK2bBZdN56fmsC2jyY_ju8rQfG2-9hForf1CEdcUVL1+wrrA@mail.gmail.com>
 <74f2341a-7834-3e37-0346-7fbc48d74df3@suse.cz>
 <20200902151306.GL4617@dhcp22.suse.cz>
 <e6bf05cb-044c-47a9-3c65-e41b1e42b702@suse.cz>
 <20200903063806.GM4617@dhcp22.suse.cz>
 <c6b11905-2456-52a0-3b15-d4ceae6e7f54@redhat.com>
 <CA+CK2bBTfmhTWNRrxnVKi=iknqq-iZxNZSnwNA9C9tWAJzRxmw@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <adb59e82-d760-5ed1-bf20-817cc200aff7@suse.cz>
Date:   Fri, 4 Sep 2020 08:32:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CA+CK2bBTfmhTWNRrxnVKi=iknqq-iZxNZSnwNA9C9tWAJzRxmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/20 8:23 PM, Pavel Tatashin wrote:
>>
>> As expressed in reply to v2, I dislike this hack. There is strong
>> synchronization, just PCP is special. Allocating from MIGRATE_ISOLATE is
>> just plain ugly.
>>
>> Can't we temporarily disable PCP (while some pageblock in the zone is
>> isolated, which we know e.g., due to the counter), so no new pages get
>> put into PCP lists after draining, and re-enable after no pageblocks are
>> isolated again? We keep draining the PCP, so it doesn't seem to be of a
>> lot of use during that period, no? It's a performance hit already.
>>
>> Then, we would only need exactly one drain. And we would only have to
>> check on the free path whether PCP is temporarily disabled.
> 
> Hm, we could use a static branches to disable it, that would keep
> release code just as fast, but I am worried it will make code even
> uglier. Let's see what others in this thread think about this idea.

Maybe we could just set pcp->high = 0 or something, make sure the
pcplist user only reads this value while irqs are disabled. Then the the
IPI in drain_all_pages() should guarantee there's nobody racing freeing
to pcplist. But careful to not introduce bugs like the one fixed with
[1]. And not sure if this guarantee survives when RT comes and replaces
the disabled irq's with local_lock or something.

[1]
https://lore.kernel.org/linux-mm/1597150703-19003-1-git-send-email-charante@codeaurora.org/


> Thank you,
> Pasha
> 

