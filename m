Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD566C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B47F020756
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgEOSWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 14:22:11 -0400
Received: from foss.arm.com ([217.140.110.172]:60726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgEOSWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 14:22:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF2591063;
        Fri, 15 May 2020 11:22:07 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB72E3F71E;
        Fri, 15 May 2020 11:22:06 -0700 (PDT)
Subject: Re: [PATCH v2 09/10] x86/resctrl: Add arch_has_sparse_bitmaps to
 explain AMD/Intel CAT difference
To:     Babu Moger <babu.moger@amd.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>
References: <20200430170400.21501-1-james.morse@arm.com>
 <20200430170400.21501-10-james.morse@arm.com>
 <8383ddd9-5849-d948-c391-aeb0cc927423@intel.com>
 <980a693a-b823-96e1-9b4f-d7bbf4f09714@amd.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <a16561f5-e8e9-7d23-e332-38c5cbdfcfc8@arm.com>
Date:   Fri, 15 May 2020 19:21:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <980a693a-b823-96e1-9b4f-d7bbf4f09714@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On 13/05/2020 21:03, Babu Moger wrote:
>> From: Reinette Chatre <reinette.chatre@intel.com>
>> On 4/30/2020 10:03 AM, James Morse wrote:
>>> Intel expects the cache bitmap provided by user-space to have on a
>>> single span of 1s, whereas AMD can support bitmaps like 0xf00f.
>>> Arm's MPAM support also allows sparse bitmaps.
>>>
>>> To move resctrl out to /fs/ we need to explain platform differences
>>> like this. Add a resource property arch_has_sparse_bitmaps. Test this
>>> around the 'non-consecutive' test in cbm_validate().
>>>
>>> Merging the validate calls causes AMD top gain the min_cbm_bits test

top -> to

>>> needed for Haswell, but as it always sets this value to 1, it will
>>> never match.
>>>
>>> CC: Babu Moger <Babu.Moger@amd.com>
>>> Signed-off-by: James Morse <james.morse@arm.com>
>>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>>
>> The Intel bits do indeed look good to me but we should check the AMD
>> portion ... I peeked at the AMD spec [1] and found "If an L3_MASK_n
>> register is programmed with all 0’s, that COS will be prevented from
>> allocating any lines in the L3 cache" ... so AMD does allow bitmasks of
>> all 0's (Intel does not).
>>
>> Does MPAM also allow all 0's? Perhaps "arch_has_sparse_bitmaps" can be
>> used to indicate that also?

It does...


> That is right. AMD allows  L3 mask be all 0s.  I will be great if this
> property can be indicated it here. Thanks

Ah, this is a bug I didn't intend to introduce!

Intel has:
|       if (val == 0 || val > r->default_ctrl) {

Whereas AMD:
|       if (val > r->default_ctrl) {


So this empty bitmap is permitted today with resctrl. (and, its another try-it-and-see).

I'll add an 'arch_has_empty_bitmaps', I don't think overloading 'sparse' to mean 'sparse
and empty' is a good idea.


Thanks!

James
