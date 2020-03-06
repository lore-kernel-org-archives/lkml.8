Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7925AC3F2D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 04:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF022072D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 04:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgCFEmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 23:42:11 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:44164 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726251AbgCFEmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 23:42:10 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0TrnYBhg_1583469723;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TrnYBhg_1583469723)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 Mar 2020 12:42:04 +0800
Subject: Re: [failures] mm-vmscan-remove-unnecessary-lruvec-adding.patch
 removed from -mm tree
To:     Hugh Dickins <hughd@google.com>, Qian Cai <cai@lca.pw>
Cc:     Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, aarcange@redhat.com,
        daniel.m.jordan@oracle.com, hannes@cmpxchg.org,
        khlebnikov@yandex-team.ru, kirill@shutemov.name,
        kravetz@us.ibm.com, mhocko@kernel.org, mm-commits@vger.kernel.org,
        tj@kernel.org, vdavydov.dev@gmail.com, yang.shi@linux.alibaba.com,
        linux-mm@kvack.org
References: <20200306025041.rERhvnYmB%akpm@linux-foundation.org>
 <211632B1-2D6F-4BFA-A5A0-3030339D3D2A@lca.pw>
 <20200306033850.GO29971@bombadil.infradead.org>
 <97EE83E1-FEC9-48B6-98E8-07FB3FECB961@lca.pw>
 <alpine.LSU.2.11.2003052008510.3016@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <9eb3efe1-f203-c3b1-679d-5e158fd8639f@linux.alibaba.com>
Date:   Fri, 6 Mar 2020 12:42:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2003052008510.3016@eggly.anvils>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/3/6 下午12:17, Hugh Dickins 写道:
> On Thu, 5 Mar 2020, Qian Cai wrote:
>>> On Mar 5, 2020, at 10:38 PM, Matthew Wilcox <willy@infradead.org> wrote:
>>>
>>> On Thu, Mar 05, 2020 at 10:32:18PM -0500, Qian Cai wrote:
>>>>> On Mar 5, 2020, at 9:50 PM, akpm@linux-foundation.org wrote:
>>>>> The patch titled
>>>>>    Subject: mm/vmscan: remove unnecessary lruvec adding
>>>>> has been removed from the -mm tree.  Its filename was
>>>>>    mm-vmscan-remove-unnecessary-lruvec-adding.patch
>>>>>
>>>>> This patch was dropped because it had testing failures
>>>> Andrew, do you have more information about this failure? I hit a bug
>>>> here under memory pressure and am wondering if this is related
>>>> which might save me some time digging…
> Very likely related.
> 

Hi all,

Apologize for the trouble!
And Many thanks for you all for the report!
Obviously, I missed memory stress testing which I should do. Apologize again!

Qian Cai,
Which test case are you using? Could you share the reproduce steps for me?

Hugh,
Many thanks for help! I will seek some memory stress case and waiting for your case.


Thank you all!
Alex
