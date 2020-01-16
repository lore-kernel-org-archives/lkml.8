Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2A7C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 07:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A4920748
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 07:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbgAPHzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 02:55:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:43758 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbgAPHzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 02:55:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4D021AC2C;
        Thu, 16 Jan 2020 07:55:00 +0000 (UTC)
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
 <6f643816-a7dc-f3bb-d521-b6ac104918d6@suse.com>
 <c116cc6c-c56c-13a5-6dce-ecbb9cf80b3a@citrix.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <c0e6f3a8-85b1-ba92-7379-bdf5f1225ff5@suse.com>
Date:   Thu, 16 Jan 2020 08:54:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <c116cc6c-c56c-13a5-6dce-ecbb9cf80b3a@citrix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.01.20 17:32, Sergey Dyasli wrote:
> On 15/01/2020 11:09, Jürgen Groß wrote:
>> On 15.01.20 11:54, Sergey Dyasli wrote:
>>> Hi Juergen,
>>>
>>> On 08/01/2020 15:20, Sergey Dyasli wrote:
>>>> It is incorrect to call pmd_populate_kernel() multiple times for the
>>>> same page table. Xen notices it during kasan_populate_early_shadow():
>>>>
>>>>       (XEN) mm.c:3222:d155v0 mfn 3704b already pinned
>>>>
>>>> This happens for kasan_early_shadow_pte when USE_SPLIT_PTE_PTLOCKS is
>>>> enabled. Fix this by introducing set_pmd_early_shadow() which calls
>>>> pmd_populate_kernel() only once and uses set_pmd() afterwards.
>>>>
>>>> Signed-off-by: Sergey Dyasli <sergey.dyasli@citrix.com>
>>>
>>> Looks like the plan to use set_pmd() directly has failed: it's an
>>> arch-specific function and can't be used in arch-independent code
>>> (as kbuild test robot has proven).
>>>
>>> Do you see any way out of this other than disabling SPLIT_PTE_PTLOCKS
>>> for PV KASAN?
>>
>> Change set_pmd_early_shadow() like the following:
>>
>> #ifdef CONFIG_XEN_PV
>> static inline void set_pmd_early_shadow(pmd_t *pmd, pte_t *early_shadow)
>> {
>>      static bool pmd_populated = false;
>>
>>      if (likely(pmd_populated)) {
>>          set_pmd(pmd, __pmd(__pa(early_shadow) | _PAGE_TABLE));
>>      } else {
>>          pmd_populate_kernel(&init_mm, pmd, early_shadow);
>>          pmd_populated = true;
>>      }
>> }
>> #else
>> static inline void set_pmd_early_shadow(pmd_t *pmd, pte_t *early_shadow)
>> {
>>      pmd_populate_kernel(&init_mm, pmd, early_shadow);
>> }
>> #endif
>>
>> ... and move it to include/xen/xen-ops.h and call it with
>> lm_alias(kasan_early_shadow_pte) as the second parameter.
> 
> Your suggestion to use ifdef is really good, especially now when I
> figured out that CONFIG_XEN_PV implies X86. But I don't like the idea
> of kasan code calling a non-empty function from xen-ops.h when
> CONFIG_XEN_PV is not defined. I'd prefer to keep set_pmd_early_shadow()
> in mm/kasan/init.c with the suggested ifdef.

Fine with me.


Juergen
