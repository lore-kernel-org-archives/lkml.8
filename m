Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1880C2BA80
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8279220747
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbgDHKqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 06:46:51 -0400
Received: from gecko.sbs.de ([194.138.37.40]:51379 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbgDHKqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 06:46:51 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 038AjcX2030694
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Apr 2020 12:45:38 +0200
Received: from [139.22.119.141] ([139.22.119.141])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 038AjUJ4023951;
        Wed, 8 Apr 2020 12:45:30 +0200
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
 <2aed2b96-c726-1357-44bb-649ec0a809ad@siemens.com>
 <2fe38887-adba-5b4c-8514-5f0925470623@redhat.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d6e9cc21-c848-1565-6868-4659ebfbec3a@siemens.com>
Date:   Wed, 8 Apr 2020 12:45:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2fe38887-adba-5b4c-8514-5f0925470623@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.04.20 11:04, Paolo Bonzini wrote:
> On 08/04/20 10:58, Jan Kiszka wrote:
>>> Why not contribute the Jailhouse loader into Linux?
>>
>> Definitely planned. But right now it would add the burden of managing
>> the interface between loader and hypervisor carefully. Currently it is
>> internal to Jailhouse and maintained in lock-step, without any backward
>> compatibility.
> 
> How often does that change?

Not often, but right now we are at a critical point, starting to explore 
booting Jailhouse before Linux [1]. That may actually help to settle the 
interface and move things forward.

Another to-do is overcoming the need for having to map the hypervisor at 
a fixed location into the kernel address space. Not needed on arm64, 
still required on 32-bit ARM (well...) and x86 (more important). I would 
dislike pushing such legacy to upstream.

Jan

[1] 
https://www.mail-archive.com/jailhouse-dev@googlegroups.com/msg08389.html

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
