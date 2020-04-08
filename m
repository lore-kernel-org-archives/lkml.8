Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B957C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BCFC20768
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgDHJAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 05:00:16 -0400
Received: from goliath.siemens.de ([192.35.17.28]:56619 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgDHJAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 05:00:16 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 0388x3im022750
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Apr 2020 10:59:03 +0200
Received: from [167.87.145.84] ([167.87.145.84])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 0388wrid023153;
        Wed, 8 Apr 2020 10:58:54 +0200
Subject: Re: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hch@infradead.org, sean.j.christopherson@intel.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kenny@panix.com, jeyu@kernel.org, rasmus.villemoes@prevas.dk,
        fenghua.yu@intel.com, xiaoyao.li@intel.com, nadav.amit@gmail.com,
        thellstrom@vmware.com, tony.luck@intel.com,
        gregkh@linuxfoundation.org, jannh@google.com,
        keescook@chromium.org, David.Laight@aculab.com,
        dcovelli@vmware.com, mhiramat@kernel.org,
        Wolfgang Mauerer <wolfgang.mauerer@oth-regensburg.de>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.429362016@infradead.org>
 <20200407174824.5e97a597@gandalf.local.home>
 <137fe245-69f3-080e-5f2b-207cd218f199@siemens.com>
 <0ed2739b-6961-c476-be2d-020e855796dc@redhat.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <2aed2b96-c726-1357-44bb-649ec0a809ad@siemens.com>
Date:   Wed, 8 Apr 2020 10:58:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <0ed2739b-6961-c476-be2d-020e855796dc@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.04.20 10:03, Paolo Bonzini wrote:
> On 08/04/20 07:58, Jan Kiszka wrote:
>>>>
>>>>    +        if (insn_is_mov_CRn(&insn) || insn_is_mov_DRn(&insn)) {
>>>> +            pr_err("Module writes to CRn or DRn, please use the
>>>> proper accessors: %s\n", mod->name);
>>>> +            return -ENOEXEC;
>>>> +        }
>>>
>>> Hmm, wont this break jailhouse?
>>
>> Yes, possibly. We load the hypervisor binary via request_firmware into
>> executable memory and then jump into it. So most of the "suspicious"
>> code is there - except two cr4_init_shadow() calls to propagate the
>> non-transparent update of VMXE into that shadow. We could hide that CR4
>> flag, but that could mislead root Linux to try to use VMX while in jail.
> 
> Why not contribute the Jailhouse loader into Linux?
> 

Definitely planned. But right now it would add the burden of managing 
the interface between loader and hypervisor carefully. Currently it is 
internal to Jailhouse and maintained in lock-step, without any backward 
compatibility.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
