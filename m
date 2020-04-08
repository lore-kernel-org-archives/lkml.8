Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D96C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701B420787
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgDHKvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 06:51:37 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:35027 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbgDHKvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 06:51:37 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 038AoJ0I018419
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Apr 2020 12:50:19 +0200
Received: from [139.22.119.141] ([139.22.119.141])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 038AoHjp031142;
        Wed, 8 Apr 2020 12:50:18 +0200
Subject: Re: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        sean.j.christopherson@intel.com, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, kenny@panix.com, jeyu@kernel.org,
        rasmus.villemoes@prevas.dk, pbonzini@redhat.com,
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
 <20200408085138.GQ20713@hirez.programming.kicks-ass.net>
 <20200408091306.GN20760@hirez.programming.kicks-ass.net>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <3751b1d5-113e-4a5c-da3b-fd1afbdba2ae@siemens.com>
Date:   Wed, 8 Apr 2020 12:50:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200408091306.GN20760@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.04.20 11:13, Peter Zijlstra wrote:
> On Wed, Apr 08, 2020 at 10:51:38AM +0200, Peter Zijlstra wrote:
>> On Wed, Apr 08, 2020 at 07:58:53AM +0200, Jan Kiszka wrote:
>>> On 07.04.20 23:48, Steven Rostedt wrote:
>>
>>>> Hmm, wont this break jailhouse?
>>
>> Breaking it isn't a problem, it's out of tree and it should be fixable.
>>
>>> Yes, possibly. We load the hypervisor binary via request_firmware into
>>> executable memory and then jump into it. So most of the "suspicious" code is
>>
>> W.T.H. does the firmware loader have the ability to give executable
>> memory? We need to kill that too. /me goes find.
> 
> AFAICT the firmware loader only provides PAGE_KERNEL_RO, so how do you
> get it executable?

memcpy(ioremapped_exec_region, firmware_image)

We only use the loader for getting the blob, not for running it. It has 
to be put at a location that Linux will lose control over anyway.

> 
> I'm thinking the patches Christoph has lined up will take care of this.
> 

It would make sense from a certain POV...

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
