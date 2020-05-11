Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22755C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04CB820801
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbgEKKbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 06:31:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:46204 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbgEKKbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 06:31:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B6600AD11;
        Mon, 11 May 2020 10:31:32 +0000 (UTC)
Subject: Re: [PATCH] kernel/watchdog.c: convert {soft/hard}lockup boot
 parameters to sysctl aliases
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        keescook@chromium.org, yzaikin@google.com, mcgrof@kernel.org,
        kernel@gpiccoli.net
References: <20200507214624.21911-1-gpiccoli@canonical.com>
 <20200507160618.43c2825e49dec1df8db30429@linux-foundation.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <f2273ab4-d2fc-cee5-61ed-8148d4a76709@suse.cz>
Date:   Mon, 11 May 2020 12:31:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507160618.43c2825e49dec1df8db30429@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/20 1:06 AM, Andrew Morton wrote:
> On Thu,  7 May 2020 18:46:24 -0300 "Guilherme G. Piccoli" <gpiccoli@canonical.com> wrote:
> 
>> After a recent change introduced by Vlastimil's series [0], kernel is
>> able now to handle sysctl parameters on kernel command line; also, the
>> series introduced a simple infrastructure to convert legacy boot
>> parameters (that duplicate sysctls) into sysctl aliases.
>> 
>> This patch converts the watchdog parameters softlockup_panic and
>> {hard,soft}lockup_all_cpu_backtrace to use the new alias infrastructure.
>> It fixes the documentation too, since the alias only accepts values 0
>> or 1, not the full range of integers. We also took the opportunity here
>> to improve the documentation of the previously converted hung_task_panic
>> (see the patch series [0]) and put the alias table in alphabetical order.
> 
> We have a lot of sysctls.  What is the motivation for converting these
> particular ones?

It's not converting sysctls, it's converting legacy boot parameters that have a
sysctl counterpart. There's not a lot of those, and new ones shouldn't be added
with the generic infrastructure in place. I would have converted them myself if
I found them :)
