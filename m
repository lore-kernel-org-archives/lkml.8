Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33BCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C3FA2078A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388320AbgFXBLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 21:11:22 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:49766 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387916AbgFXBLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 21:11:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U0Xwint_1592961078;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U0Xwint_1592961078)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 24 Jun 2020 09:11:18 +0800
Date:   Wed, 24 Jun 2020 09:11:18 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm/spase: never partially remove memmap for early section
Message-ID: <20200624011118.GA9422@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200623094258.6705-1-richard.weiyang@linux.alibaba.com>
 <CAPcyv4ipnZ2jXd-obBk4KMGPNz4DMu0jGXFEEPCnST+A2zR+Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4ipnZ2jXd-obBk4KMGPNz4DMu0jGXFEEPCnST+A2zR+Uw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 05:21:06PM -0700, Dan Williams wrote:
>On Tue, Jun 23, 2020 at 2:43 AM Wei Yang
><richard.weiyang@linux.alibaba.com> wrote:
>>
>> For early sections, we assumes its memmap will never be partially
>> removed. But current behavior breaks this.
>
>Where do we assume that?
>
>The primary use case for this was mapping pmem that collides with
>System-RAM in the same 128MB section. That collision will certainly be
>depopulated on-demand depending on the state of the pmem device. So,
>I'm not understanding the problem or the benefit of this change.

Hi, Dan

There is a discussion in the thread you just replied:

    mm/shuffle: don't move pages between zones and don't read garbage memmaps

Besides this, the comment in section_activate() says:

    * The early init code does not consider partially populated
    * initial sections, it simply assumes that memory will never be
    * referenced.  If we hot-add memory into such a section then we
    * do not need to populate the memmap and can simply reuse what
    * is already there.

Per my understanding, if we hot-add then hot-remove the sub-section, we may
not have a valid memmep for this part sub-section? Because we depopulate it at
hot-remove while we don't populate it when hot-add.

Is my understanding correct?

-- 
Wei Yang
Help you, Help me
