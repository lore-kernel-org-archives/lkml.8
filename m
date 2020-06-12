Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76EBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 03:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C389020823
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 03:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgFLDJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 23:09:40 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:45496 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726305AbgFLDJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 23:09:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0U.K13Qc_1591931375;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U.K13Qc_1591931375)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 12 Jun 2020 11:09:35 +0800
Subject: Re: [PATCH v12 00/16] per memcg lru lock
To:     Hugh Dickins <hughd@google.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
References: <1591856209-166869-1-git-send-email-alex.shi@linux.alibaba.com>
 <alpine.LSU.2.11.2006111510220.10801@eggly.anvils>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <b645a763-0661-cc14-bc99-57edde19267b@linux.alibaba.com>
Date:   Fri, 12 Jun 2020 11:09:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2006111510220.10801@eggly.anvils>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/6/12 ÉÏÎç6:26, Hugh Dickins Ð´µÀ:
>> ..."
> It was well worth exploring, and may help in a few cases;
> Johannes's memcg swap simplifications have helped a lot more;
> but crashes under rotate_reclaimable_page() show that this series
> still does not give enough protection from mem_cgroup_move_account().
> 
> I'll send a couple of fixes to compaction bugs in reply to this:
> with those in, compaction appears to be solid.
> 

Thanks a lot for fixing. I will look into them and try to merge into
the patchset.

Thanks a lot!
Alex
