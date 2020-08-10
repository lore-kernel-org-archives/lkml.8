Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56986C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30CEA22B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgHJSmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 14:42:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:35330 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728151AbgHJSmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 14:42:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D34E6AB55;
        Mon, 10 Aug 2020 18:43:12 +0000 (UTC)
Subject: Re: [PATCH v3 4/7] x86/paravirt: remove 32-bit support from
 PARAVIRT_XXL
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20200807083826.16794-1-jgross@suse.com>
 <20200807083826.16794-5-jgross@suse.com>
 <a1073b86-ebd5-68b6-7761-99669dd93e1c@oracle.com>
 <4c5fb964-6acb-6bb8-4eff-0bcb67d922f2@suse.com>
 <8506b0cd-6f7e-7505-d9b9-e1468cefa4ec@oracle.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <c0917f5a-ffec-d422-bf8b-8c8859ea4312@suse.com>
Date:   Mon, 10 Aug 2020 20:42:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8506b0cd-6f7e-7505-d9b9-e1468cefa4ec@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.08.20 18:53, Boris Ostrovsky wrote:
> On 8/10/20 12:39 AM, Jürgen Groß wrote:
>> On 09.08.20 04:34, Boris Ostrovsky wrote:
>>> On 8/7/20 4:38 AM, Juergen Gross wrote:
>>>> @@ -377,10 +373,7 @@ static inline pte_t __pte(pteval_t val)
>>>>    {
>>>>        pteval_t ret;
>>>>    -    if (sizeof(pteval_t) > sizeof(long))
>>>> -        ret = PVOP_CALLEE2(pteval_t, mmu.make_pte, val, (u64)val >>
>>>> 32);
>>>> -    else
>>>> -        ret = PVOP_CALLEE1(pteval_t, mmu.make_pte, val);
>>>> +    ret = PVOP_CALLEE1(pteval_t, mmu.make_pte, val);
>>>>          return (pte_t) { .pte = ret };
>>>
>>>
>>> Can this now simply return (pte_t) ret?
>>
>> I don't think so, but I can turn it into
>>
>>    return native_make_pte(PVOP_CALLEE1(...));
> 
> 
> I thought that since now this is only built for 64-bit we don't have to
> worry about different pte_t definitions and can do what we do for
> example, for __pgd()?

Yes, I did that:

  return (pte_t) { ret };


Juergen

