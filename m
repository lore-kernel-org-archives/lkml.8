Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3067EC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057A224649
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394661AbgBNRRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:17:54 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:42649 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390394AbgBNRRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 12:17:44 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TpzUUPH_1581700648;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TpzUUPH_1581700648)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 15 Feb 2020 01:17:30 +0800
Subject: Re: [v2 PATCH] mm: shmem: allow split THP when truncating THP
 partially
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Hugh Dickins <hughd@google.com>, kirill.shutemov@linux.intel.com,
        aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1575420174-19171-1-git-send-email-yang.shi@linux.alibaba.com>
 <alpine.LSU.2.11.1912041601270.12930@eggly.anvils>
 <00f0bb7d-3c25-a65f-ea94-3e2de8e9bcdd@linux.alibaba.com>
 <33768a7e-837d-3bcd-fb98-19727921d6fd@linux.alibaba.com>
 <cd21f6a6-32a5-7d31-3bcd-4fc3f6cc0a84@linux.alibaba.com>
 <20200214154021.kgeon6i76yfdbaa5@box>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <a6ee0597-dc5f-6aaf-4651-f588cc62599c@linux.alibaba.com>
Date:   Fri, 14 Feb 2020 09:17:26 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200214154021.kgeon6i76yfdbaa5@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/20 7:40 AM, Kirill A. Shutemov wrote:
> On Thu, Feb 13, 2020 at 04:38:01PM -0800, Yang Shi wrote:
>> Hi Kirill,
>>
>>
>> Would you please help review this patch? I don't know why Hugh didn't
>> response though I pinged him twice.
> I have not noticed anything wrong with the patch.
>
> But the function gets ugly beyond the reason. Any chance you could
> restructure it to get somewhat maintainable? (It's not easy, I know).

Yes, those goto looks not neat. I'm going to give it a try. Any 
suggestion is absolutely welcome.

>

