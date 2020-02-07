Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6D8C04EB5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B822464E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgBGPCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 10:02:46 -0500
Received: from gecko.sbs.de ([194.138.37.40]:51940 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgBGPCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 10:02:45 -0500
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 017F2DFG005561
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Feb 2020 16:02:13 +0100
Received: from [139.25.68.37] ([139.25.68.37])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 017F2B6K000816;
        Fri, 7 Feb 2020 16:02:11 +0100
Subject: Re: [PATCH] x86: pat: Do not compile stubbed functions when X86_PAT
 is off
To:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86 <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <198c94a8-12ea-88e7-6f08-b3456473e5c3@siemens.com>
 <87r1z6xxh5.fsf@nanos.tec.linutronix.de>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a2788ff7-c524-52de-3f45-82613410f872@siemens.com>
Date:   Fri, 7 Feb 2020 16:02:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87r1z6xxh5.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.02.20 15:50, Thomas Gleixner wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Those are already provided by linux/io.h as stubs.
>>
>> The conflict remains invisible until someone would pull {linux,asm}/io.h
>> into memtype.c.
> 
> Err. memtype.c includes asm/io.h already. So it's just the PAT=n case
> which is broken.

Ah, right, my comment must read "until someone would pull linux/io.h"
because only that header carries the stubs.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
