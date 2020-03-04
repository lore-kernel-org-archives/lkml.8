Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E5EC3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B322166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgCDIPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 03:15:37 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:52574 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725271AbgCDIPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 03:15:36 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TrcoXXb_1583309623;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TrcoXXb_1583309623)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 Mar 2020 16:13:44 +0800
Subject: Re: [PATCH v9 04/20] mm/thp: move lru_add_page_tail func to
 huge_memory.c
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     cgroups@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
 <1583146830-169516-5-git-send-email-alex.shi@linux.alibaba.com>
 <20200304074719.e6unbgdop2r3jhk2@box>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <3b18a429-25fd-df28-1bf3-57bcd38c6cd8@linux.alibaba.com>
Date:   Wed, 4 Mar 2020 16:13:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304074719.e6unbgdop2r3jhk2@box>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/3/4 ÏÂÎç3:47, Kirill A. Shutemov Ð´µÀ:
> On Mon, Mar 02, 2020 at 07:00:14PM +0800, Alex Shi wrote:
>> The func is only used in huge_memory.c, defining it in other file with a
>> CONFIG_TRANSPARENT_HUGEPAGE macro restrict just looks weird.
>>
>> Let's move it close user.
> 
> I don't think it's strong enough justification. I would rather keep all
> lru helpers in one place.
> 

Thanks for comments, Kirill,

If it's a common used func, yes.

But if you look into details of this func, it's thp used only func. 

Thanks
Alex
