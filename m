Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AC8C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 11:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A9A24671
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 11:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbgAOLJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 06:09:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:55544 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgAOLJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 06:09:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BAB13AC81;
        Wed, 15 Jan 2020 11:09:51 +0000 (UTC)
Subject: Re: [PATCH v1 1/4] kasan: introduce set_pmd_early_shadow()
To:     Sergey Dyasli <sergey.dyasli@citrix.com>
Cc:     xen-devel@lists.xen.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        George Dunlap <george.dunlap@citrix.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200108152100.7630-1-sergey.dyasli@citrix.com>
 <20200108152100.7630-2-sergey.dyasli@citrix.com>
 <96c2414e-91fb-5a28-44bc-e30d2daabec5@citrix.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <6f643816-a7dc-f3bb-d521-b6ac104918d6@suse.com>
Date:   Wed, 15 Jan 2020 12:09:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <96c2414e-91fb-5a28-44bc-e30d2daabec5@citrix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.01.20 11:54, Sergey Dyasli wrote:
> Hi Juergen,
> 
> On 08/01/2020 15:20, Sergey Dyasli wrote:
>> It is incorrect to call pmd_populate_kernel() multiple times for the
>> same page table. Xen notices it during kasan_populate_early_shadow():
>>
>>      (XEN) mm.c:3222:d155v0 mfn 3704b already pinned
>>
>> This happens for kasan_early_shadow_pte when USE_SPLIT_PTE_PTLOCKS is
>> enabled. Fix this by introducing set_pmd_early_shadow() which calls
>> pmd_populate_kernel() only once and uses set_pmd() afterwards.
>>
>> Signed-off-by: Sergey Dyasli <sergey.dyasli@citrix.com>
> 
> Looks like the plan to use set_pmd() directly has failed: it's an
> arch-specific function and can't be used in arch-independent code
> (as kbuild test robot has proven).
> 
> Do you see any way out of this other than disabling SPLIT_PTE_PTLOCKS
> for PV KASAN?

Change set_pmd_early_shadow() like the following:

#ifdef CONFIG_XEN_PV
static inline void set_pmd_early_shadow(pmd_t *pmd, pte_t *early_shadow)
{
	static bool pmd_populated = false;

	if (likely(pmd_populated)) {
		set_pmd(pmd, __pmd(__pa(early_shadow) | _PAGE_TABLE));
	} else {
		pmd_populate_kernel(&init_mm, pmd, early_shadow);
		pmd_populated = true;
	}
}
#else
static inline void set_pmd_early_shadow(pmd_t *pmd, pte_t *early_shadow)
{
	pmd_populate_kernel(&init_mm, pmd, early_shadow);
}
#endif

... and move it to include/xen/xen-ops.h and call it with
lm_alias(kasan_early_shadow_pte) as the second parameter.


Juergen
