Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4236C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BDA20870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbgBKN4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:56:24 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:62562 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729928AbgBKN4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:56:22 -0500
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 01BDtXDV028263;
        Tue, 11 Feb 2020 22:55:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp);
 Tue, 11 Feb 2020 22:55:33 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 01BDtS6W028248
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 11 Feb 2020 22:55:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: task hung in wdm_flush
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Oliver Neukum <oneukum@suse.de>,
        syzbot <syzbot+854768b99f19e89d7f81@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        yuehaibing@huawei.com, =?UTF-8?Q?Bj=c3=b8rn_Mork?= <bjorn@mork.no>
References: <0000000000003313f0058fea8435@google.com>
 <8736ek9qir.fsf@miraculix.mork.no> <1574159504.28617.5.camel@suse.de>
 <87pnho85h7.fsf@miraculix.mork.no>
 <CACT4Y+YgLm2m0JG6qKKn9OpyXT9kKEPeyLSVGSfLbUukoCnB+g@mail.gmail.com>
 <CACT4Y+ZjiCDgtGVMow3WNzjuqBLaxy_KB4cM10wbfUnDdjBYfQ@mail.gmail.com>
 <CACT4Y+ZWDMkOmnXpBXFhU8XcHA_-ZcHdZpfrXcCWHRzcbQ39Gg@mail.gmail.com>
 <ebc7b5e0-e968-0bdb-d75d-346e0b763d14@i-love.sakura.ne.jp>
 <CACT4Y+bDNjj_RGLtvRCaV3k9+QX4eENyKyWWAbsHcbwR7CDrWQ@mail.gmail.com>
 <CACT4Y+ZaNNAiRvKCMJ9t4H+H23OcjSd5haAcXkG68L8F6Mq6Wg@mail.gmail.com>
 <bbf26ea3-c11c-1cd2-0072-b78634ae9579@i-love.sakura.ne.jp>
Message-ID: <c00063bc-cd0d-2469-5a72-d4d84c9abf3a@i-love.sakura.ne.jp>
Date:   Tue, 11 Feb 2020 22:55:25 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <bbf26ea3-c11c-1cd2-0072-b78634ae9579@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/02/11 0:21, Tetsuo Handa wrote:
> On 2020/02/11 0:06, Dmitry Vyukov wrote:
>>> On Mon, Feb 10, 2020 at 4:03 PM Tetsuo Handa
>>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>>
>>>> On 2020/02/10 21:46, Tetsuo Handa wrote:
>>>>> On 2020/02/10 19:09, Dmitry Vyukov wrote:
>>>>>> You may also try on the exact commit the bug was reported, because
>>>>>> usb-fuzzer is tracking branch, things may change there.
>>>>>
>>>>> OK. I explicitly tried
>>>>>
>>>>>   #syz test: https://github.com/google/kasan.git e5cd56e94edde38ca4dafae5a450c5a16b8a5f23
>>>>>
>>>>> but syzbot still cannot reproduce this bug using the reproducer...
>>>>
>>>> It seems that there is non-trivial difference between kernel config in dashboard
>>>> and kernel config in "syz test:" mails. Maybe that's the cause...
>>
>>
>> syzkaller runs oldconfig when building any kernels:
>> https://github.com/google/syzkaller/blob/master/pkg/build/linux.go#L56
>> Is that difference what oldconfig produces?
>>
> 
> Here is the diff (with "#" lines excluded) between dashboard and "syz test:" mails.
> I feel this difference is bigger than what simple oldconfig would cause.
> 

I explicitly tried a commit as of the first report (instead of the latest report)

  #syz test: https://github.com/google/kasan.git e96407b497622d03f088bcf17d2c8c5a1ab066c8

and syzbot reproduced this bug using the reproducer. Therefore, it seems that differences
in the kernel config used for "syz test:" was inappropriate but "syz test:" failed to detect
it. Since there might be changes which fixed different bugs (and in order to confirm that
proposed patch cleanly applies to the current kernel without causing other problems), I guess
that people tend to test using the latest commit (instead of a commit as of the first report).

I suggest "syz test:" to retest without proposed patch when proposed patch did not reproduce
the bug. If retesting without proposed patch did not reproduce the bug, we can figure out that
something is wrong (maybe the bug is difficult to reproduce, maybe the bug was already fixed,
maybe kernel config was inappropriate, maybe something else).



Regarding the bug for this report, debug printk() reported that WDM_IN_USE was not cleared
for some reason. While we need to investigate why WDM_IN_USE was not cleared, I guess that
wdm_write() should clear WDM_IN_USE upon error
( https://syzkaller.appspot.com/x/patch.diff?x=17ec7ee9e00000 ) so that we will surely
wake up somebody potentially waiting on WDM_IN_USE.

[   38.587596][ T2807] wdm_flush: file=ffff8881d488bb80 flags=2
[   40.214039][ T2807] wdm_flush: file=ffff8881d63fb400 flags=2
[   40.304390][ T2842] wdm_flush: file=ffff8881d5e22500 flags=0
[   40.371742][ T2869] wdm_flush: file=ffff8881d4964c80 flags=0
[   40.429954][ T2844] wdm_flush: file=ffff8881d5937b80 flags=0
[   40.461538][ T2858] wdm_flush: file=ffff8881d488b400 flags=0
[   40.464909][ T2863] wdm_flush: file=ffff8881d488ea00 flags=0
[   41.576761][ T2896] wdm_flush: file=ffff8881d43dea00 flags=2
[   41.949941][ T2909] wdm_flush: file=ffff8881d63c3b80 flags=2
[   43.760828][ T2899] wdm_flush: file=ffff8881d3d7a000 flags=2
[   43.857364][ T2911] wdm_flush: file=ffff8881d63c2000 flags=2
[   43.857501][ T2904] wdm_flush: file=ffff8881d3d7a280 flags=2
[   43.866560][ T2906] wdm_flush: file=ffff8881d5ce4780 flags=2
[   43.876210][ T2897] wdm_flush: file=ffff8881d385db80 flags=2
[   72.308895][ T2909] INFO: task syz-executor.0:2909 blocked for more than 30 seconds.
[   72.316860][ T2909] wdm_flush: file=ffff8881d63c3b80 flags=2
[   74.228916][ T2906] INFO: task syz-executor.1:2906 blocked for more than 30 seconds.
[   74.228921][ T2911] INFO: task syz-executor.3:2911 blocked for more than 30 seconds.
[   74.228935][ T2911] wdm_flush: file=ffff8881d63c2000 flags=2
[   74.236949][ T2906] wdm_flush: file=ffff8881d5ce4780 flags=2
[   74.236991][ T2904] INFO: task syz-executor.4:2904 blocked for more than 30 seconds.
[   74.245459][ T2897] INFO: task syz-executor.2:2897 blocked for more than 30 seconds.
[   74.251305][ T2904] wdm_flush: file=ffff8881d3d7a280 flags=2
[   74.257129][ T2897] wdm_flush: file=ffff8881d385db80 flags=2
[   74.257951][ T2899] INFO: task syz-executor.5:2899 blocked for more than 30 seconds.
[   74.294465][ T2899] wdm_flush: file=ffff8881d3d7a000 flags=2

