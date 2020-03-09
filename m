Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE18FC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB022072A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgCIJc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 05:32:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:40514 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbgCIJc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 05:32:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3CEF8ACBD;
        Mon,  9 Mar 2020 09:32:55 +0000 (UTC)
Subject: Re: [patch part-III V2 00/23] x86/entry: Consolidation - Part III
 (simple exceptions)
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
References: <20200308231410.905396057@linutronix.de>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <9763700c-1f8f-f065-60b3-2a25e166fac1@suse.com>
Date:   Mon, 9 Mar 2020 10:32:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200308231410.905396057@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.03.20 00:14, Thomas Gleixner wrote:
> Hi!
> 
> This is the second version of the entry consolidation work part III
> covering simple exceptions. V1 can be found here:
> 
>    https://lore.kernel.org/r/20200225221606.511535280@linutronix.de
> 
> It applies on top of part II which is available here
> 
>    https://lore.kernel.org/r/20200308222359.370649591@linutronix.de
> 
> and is also available from git (including part II):
> 
>      git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel entry-v2-part3
> 
> The changes vs. V1:
> 
>    - Remove #BP (int3) conversion as this needs extra care vs. kprobes (Peter)
> 
>    - Fixup the FOOF bug do_invalid_op() call in fault.c
> 
>    - Address the few review comments (mostly changelog and comment improvements)
> 
>    - Picked up Reviewed-by and Acked-by tags

FWIW: tested to be bootable as Xen dom0 (at least when adding commit
bba42affa732d6fd5b).


Juergen
