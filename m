Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37DDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 05:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE2F2207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 05:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbgEYFD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 01:03:57 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53000 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgEYFD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 01:03:56 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 04P53sDK065057;
        Mon, 25 May 2020 14:03:54 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp);
 Mon, 25 May 2020 14:03:54 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 04P53rFU065032
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 25 May 2020 14:03:53 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] twist: allow converting pr_devel()/pr_debug() into
 printk(KERN_DEBUG)
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20200524145034.10697-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <d65ee15211aa69a815bdc7cc4fc9e7c2e1bcba43.camel@perches.com>
 <CAFqZXNthJE0a3KkgZFXYSFArwRs0H_20KjT6KfAkiMo6WTp1rw@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <94f7ce4f-74fb-bccc-2e87-749e0c8da92c@i-love.sakura.ne.jp>
Date:   Mon, 25 May 2020 14:03:48 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAFqZXNthJE0a3KkgZFXYSFArwRs0H_20KjT6KfAkiMo6WTp1rw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/05/25 4:18, Ondrej Mosnacek wrote:
> I'm also not sure if this is really worth it... It would help localize
> the bug in this specific case, but there is nothing systematic about
> it. Are there that many debug print statements that dereference
> pointers that are later passed to functions, but not dereferenced
> otherwise? Maybe yes, but it seems to be quite an optimistic
> assumption... I don't consider it such a big problem that a bug in
> function X only manifests itself deeper in the callchain. There will
> always be such bugs, no matter how many moles you whack.

There are about 1400 pr_debug() callers. About 1000 pr_debug() callers seem
to pass plain '%p' (which is now likely useless for debugging purpose due to
default ptr_to_id() conversion inside pointer()), and about 400 pr_debug()
callers seem to pass '%p[a-zA-Z]' (which does some kind of dereference inside
pointer()). Thus, we might find some bugs by evaluating '%p[a-zA-Z]'.



On Sun, May 24, 2020 at 7:38 PM Joe Perches <joe@perches.com> wrote:
> While I think this is rather unnecessary,
> what about dev_dbg/netdev_dbg/netif_dbg et al ?

Maybe a good idea, for there are about 24000 *dev_dbg() callers, and
479 callers pass '%p[a-zA-Z]'. But we can defer to another patch, in
case this patch finds crashes before fuzz testing process starts.

