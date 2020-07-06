Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C62CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 04:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 729982067D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 04:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgGFEPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 00:15:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:33316 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgGFEPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 00:15:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2F9E7AD81;
        Mon,  6 Jul 2020 04:15:36 +0000 (UTC)
Subject: Re: [tip: x86/urgent] x86/entry/32: Fix XEN_PV build dependency
To:     Andy Lutomirski <luto@amacapital.net>, linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>
References: <159397824429.4006.6604251447325788449.tip-bot2@tip-bot2>
 <5B8B5845-1145-43BC-B790-B1D1A7B42B28@amacapital.net>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <88031c06-ebef-8290-fa0b-695859c1a40e@suse.com>
Date:   Mon, 6 Jul 2020 06:15:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <5B8B5845-1145-43BC-B790-B1D1A7B42B28@amacapital.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.07.20 22:24, Andy Lutomirski wrote:
> 
> 
>> On Jul 5, 2020, at 12:44 PM, tip-bot2 for Ingo Molnar <tip-bot2@linutronix.de> wrote:
>>
>> ﻿The following commit has been merged into the x86/urgent branch of tip:
>>
>> Commit-ID:     a4c0e91d1d65bc58f928b80ed824e10e165da22c
>> Gitweb:        https://git.kernel.org/tip/a4c0e91d1d65bc58f928b80ed824e10e165da22c
>> Author:        Ingo Molnar <mingo@kernel.org>
>> AuthorDate:    Sun, 05 Jul 2020 21:33:11 +02:00
>> Committer:     Ingo Molnar <mingo@kernel.org>
>> CommitterDate: Sun, 05 Jul 2020 21:39:23 +02:00
>>
>> x86/entry/32: Fix XEN_PV build dependency
>>
>> xenpv_exc_nmi() and xenpv_exc_debug() are only defined on 64-bit kernels,
>> but they snuck into the 32-bit build via <asm/identry.h>, causing the link
>> to fail:
>>
>>   ld: arch/x86/entry/entry_32.o: in function `asm_xenpv_exc_nmi':
>>   (.entry.text+0x817): undefined reference to `xenpv_exc_nmi'
>>
>>   ld: arch/x86/entry/entry_32.o: in function `asm_xenpv_exc_debug':
>>   (.entry.text+0x827): undefined reference to `xenpv_exc_debug'
>>
>> Only use them on 64-bit kernels.
> 
> Jürgen, can you queue a revert for when PV32 goes away?

Yes, will do.


Juergen
