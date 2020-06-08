Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87722C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 06:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54ED420774
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 06:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbgFHGNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 02:13:47 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:39103 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726929AbgFHGNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 02:13:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0U-uL44M_1591596815;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U-uL44M_1591596815)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 08 Jun 2020 14:13:36 +0800
Subject: Re: [PATCH v11 00/16] per memcg lru lock
To:     Hugh Dickins <hughd@google.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
References: <1590663658-184131-1-git-send-email-alex.shi@linux.alibaba.com>
 <alpine.LSU.2.11.2006072100390.2001@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <31943f08-a8e8-be38-24fb-ab9d25fd96ff@linux.alibaba.com>
Date:   Mon, 8 Jun 2020 14:13:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2006072100390.2001@eggly.anvils>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/6/8 ÏÂÎç12:15, Hugh Dickins Ð´µÀ:
>>  24 files changed, 487 insertions(+), 312 deletions(-)
> Hi Alex,
> 
> I didn't get to try v10 at all, waited until Johannes's preparatory
> memcg swap cleanup was in mmotm; but I have spent a while thrashing
> this v11, and can happily report that it is much better than v9 etc:
> I believe this memcg lru_lock work will soon be ready for v5.9.
> 
> I've not yet found any flaw at the swapping end, but fixes are needed
> for isolate_migratepages_block() and mem_cgroup_move_account(): I've
> got a series of 4 fix patches to send you (I guess two to fold into
> existing patches of yours, and two to keep as separate from me).
> 
> I haven't yet written the patch descriptions, will return to that
> tomorrow.  I expect you will be preparing a v12 rebased on v5.8-rc1
> or v5.8-rc2, and will be able to include these fixes in that.

I am very glad to get your help on this feature! 

and looking forward for your fixes tomorrow. :)

Thanks a lot!
Alex
