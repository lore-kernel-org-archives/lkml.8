Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28062C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 22:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C89B20739
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 22:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgGQWjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 18:39:45 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33226 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgGQWjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 18:39:45 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id B20D82A01B5
Subject: Re: [RESEND PATCH 3/4] futex: Remove unused or redundant includes
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Cc:     mingo@redhat.com, dvhart@infradead.org, kernel@collabora.com,
        krisman@collabora.com
References: <20200702202843.520764-1-andrealmeid@collabora.com>
 <20200702202843.520764-4-andrealmeid@collabora.com>
 <875zalrf03.fsf@nanos.tec.linutronix.de>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <7b7270f6-636a-0b72-8fae-a181d1dfc3e2@collabora.com>
Date:   Fri, 17 Jul 2020 19:39:37 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <875zalrf03.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/20 6:46 PM, Thomas Gleixner wrote:
> André Almeida <andrealmeid@collabora.com> writes:
> 
>> Since 82af7aca ("Removal of FUTEX_FD"), some includes related to file
>> operations aren't needed anymore. More investigation around the includes
>> showed that a lot of includes aren't required for compilation, possible
>> due to redundant includes. Simplify the code by removing unused
>> includes.
>>
>> Signed-off-by: André Almeida <andrealmeid@collabora.com>
>> ---
>> To test this code, I compiled with different configurations (x86_64,
>> i386, with x32 ABI supported enabled/disabled), and ran futex
>> selftests.
> 
> I agree fully with the FD related ones, but are you sure that all of the
> others are included on all architectures magically? x86 is just one
> piece of the puzzle. We'll see ...
> 

I just retested compiling tip/locking/core, and it seems something
changed the last time I wrote the patch. Removing <linux/compat.h> will
indeed break the compilation now, the patch bellow should fix it. Sorry
for the noise.

-- >8 --

Subject: [PATCH 1/1] futex: Add compat include

Commit 38aa3c15b3a4 removed includes that seemed to be unused.
However, removing <linux/compat.h> makes the compilation fail if the
build configuration supports compatibility ABIs. Fix that by
reinserting the include.

Fixes: 38aa3c15b3a4 ("futex: Remove unused or redundant includes")
Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 kernel/futex.c | 1 +
 1 file changed, 1 insertion(+)


=======================================

diff --git a/kernel/futex.c b/kernel/futex.c
index f483bc52dbac..4616d4ad609d 100644

--- a/kernel/futex.c

+++ b/kernel/futex.c

@@ -31,6 +31,7 @@

 31 *  "The futexes are also cursed."
 32 *  "But they come in a choice of three flavours!"
 33 */
+34#include <linux/compat.h>
 35#include <linux/jhash.h>
 36#include <linux/pagemap.h>
 37#include <linux/syscalls.h>

-- 




