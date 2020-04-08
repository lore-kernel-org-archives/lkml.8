Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CB0C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 11:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A477720780
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 11:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgDHLOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 07:14:20 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:38373 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728321AbgDHLOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 07:14:20 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 038BDMIQ019751
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Apr 2020 13:13:22 +0200
Received: from [139.22.119.141] ([139.22.119.141])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 038BDHA3003063;
        Wed, 8 Apr 2020 13:13:18 +0200
Subject: Re: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
To:     David Laight <David.Laight@ACULAB.COM>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kenny@panix.com" <kenny@panix.com>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "xiaoyao.li@intel.com" <xiaoyao.li@intel.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "thellstrom@vmware.com" <thellstrom@vmware.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jannh@google.com" <jannh@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dcovelli@vmware.com" <dcovelli@vmware.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        Wolfgang Mauerer <wolfgang.mauerer@oth-regensburg.de>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.429362016@infradead.org>
 <20200407174824.5e97a597@gandalf.local.home>
 <137fe245-69f3-080e-5f2b-207cd218f199@siemens.com>
 <20200408085138.GQ20713@hirez.programming.kicks-ass.net>
 <aa7a2547-9670-d04f-4ca0-ab52abf30441@siemens.com>
 <a426788d340b477f8cc87a173a251fcb@AcuMS.aculab.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c51317cf-2026-22f8-6763-b3efd2c661d7@siemens.com>
Date:   Wed, 8 Apr 2020 13:13:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <a426788d340b477f8cc87a173a251fcb@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.04.20 11:25, David Laight wrote:
> From: Jan Kiszka
>> Sent: 08 April 2020 09:59
> ...
>> At the risk of cutting our own branch off: That's not the firmware
>> loader, it's ioremap with PAGE_KERNEL_EXEC.
> 
> You could link the 'blob' into the .text part of a normal
> kernel module and then load that.

Sure, also possible. Was just more convenient so far to replace the 
hypervisor binary without having to recompile the driver module.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
