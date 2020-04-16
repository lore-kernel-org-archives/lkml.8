Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A188C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 00:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F5142054F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 00:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405105AbgDPAtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 20:49:16 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:63420 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405058AbgDPAtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 20:49:03 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 03G0lT8E089337;
        Thu, 16 Apr 2020 09:47:29 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp);
 Thu, 16 Apr 2020 09:47:29 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 03G0lSiB089331
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 16 Apr 2020 09:47:28 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v3] Add kernel config option for tweaking kernel behavior.
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
References: <20200413063317.7164-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <CAHk-=wgbMi2+VBN0SCEw9GeoiWgui034AOBwbt_dW9tdCa3Nig@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <5a72a7e8-f7fe-4560-0145-02d5570efa34@i-love.sakura.ne.jp>
Date:   Thu, 16 Apr 2020 09:47:24 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgbMi2+VBN0SCEw9GeoiWgui034AOBwbt_dW9tdCa3Nig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/04/14 3:13, Linus Torvalds wrote:
> On Sun, Apr 12, 2020 at 11:34 PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> Existing kernel config options are defined based on "whether you want to
>> enable this module/feature or not". And such granularity is sometimes
>> too rough-grained for fuzzing tools which try to find bugs inside each
>> module/feature.
> 
> I still detest making this a hardcoded build-time config option.

But I think that starting from build-time config option is the better.

> 
> A kernel parameter that sets a flag seems much simpler. More
> importantly, having it be something sanely named, and something you
> can set independently some other way, would allow a regular kernel to
> then run a fuzzer as root.

We can't beforehand determine how many kernel parameters will be needed.

I don't think the number of kernel parameters is "one". You said "I'd *much*
rather see some way to just lock down certain things individually.". Also,
different fuzzing mechanisms may want different set of things (e.g.
current->do_not_emit_warning_string for syzkaller described bottom).

But will the number of kernel parameters be "a few" ? "a dozen" ?
"some dozen" ? "some hundreds" ? "one thousand" ?

Of course, I'm not expecting "one thousand". But I can't say how many kernel
parameters will be needed. The number of kernel parameters can be determined
only after we identify what "things" we need to tweak. The first step is to
identify which operation should be tweaked, and it will take *very long time*.
I don't think that it is realistic to update userspace programs to support that
flag whenever a new flag was added (with sane name and explanation for users
who are not interested in running fuzzers on their kernels) in the kernel side.

> 
> Some kind of "not even root" flag, which might be per-process and not
> possible to clear once set (so that your _normal_ system binaries
> could still do the root-only stuff, but then you could start a fuzzing
> process with that flag set, knowing that the fuzzing process - and
> it's children - are not able to do things).

I don't think that fuzzing mechanisms is clever enough to distinguish which
process (fuzz tests or _normal_ system binaries) is causing the unwanted
result (e.g. shutting down the system). If administrator's proper operation
(e.g. freezing a filesystem for maintenance purpose) caused a warning (e.g.
khungtaskd complains that file write operation cannot be completed), fuzzing
mechanisms (e.g. monitoring kernel messages printed to consoles) will consider
it as "crash". Since who did "dangerous operation" is irrelevant, who can do
"dangerous operation" (e.g. use of per-process flags) is irrelevant. Doing

--- a/security/tomoyo/util.c
+++ b/security/tomoyo/util.c
@@ -1078,10 +1078,9 @@ bool tomoyo_domain_quota_is_ok(struct tomoyo_request_info *r)
                domain->flags[TOMOYO_DIF_QUOTA_WARNED] = true;
                /* r->granted = false; */
                tomoyo_write_log(r, "%s", tomoyo_dif[TOMOYO_DIF_QUOTA_WARNED]);
-#ifndef CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING
-               pr_warn("WARNING: Domain '%s' has too many ACLs to hold. Stopped learning mode.\n",
-                       domain->domainname->name);
-#endif
+               if (current->do_not_emit_warning_string)
+                       pr_warn("WARNING: Domain '%s' has too many ACLs to hold. Stopped learning mode.\n",
+                               domain->domainname->name);
        }
        return false;
 }

is pointless for syzkaller; syzkaller will treat as "crash" as soon as _normal_
system binaries hit this path. Use of build-time config option is simpler.
