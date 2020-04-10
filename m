Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608E3C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 13:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7D42078E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 13:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgDJNMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 09:12:19 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:64761 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgDJNMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 09:12:19 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 03ADCHwq022769;
        Fri, 10 Apr 2020 22:12:17 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp);
 Fri, 10 Apr 2020 22:12:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 03ADC9vC022655
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 10 Apr 2020 22:12:16 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Qian Cai <cai@lca.pw>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <CAHk-=wjfngA7nHAsie7bW_JmKBhUyV9oV7zmDbZuchkJK3sR1w@mail.gmail.com>
 <AFD0DADD-0558-463F-B219-5F098E6C2EDF@lca.pw>
 <CAHk-=wgFn4rHZM8ttPWvdSzV3pL1nS3EDcAh+83OObObkot4-g@mail.gmail.com>
 <9C21961E-24D3-4C97-A5AB-B70451E4F952@lca.pw>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <76e8bbed-21d1-22e1-4148-5a5766652c0d@I-love.SAKURA.ne.jp>
Date:   Fri, 10 Apr 2020 22:12:04 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9C21961E-24D3-4C97-A5AB-B70451E4F952@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/04/10 6:14, Qian Cai wrote:
> 
> 
>> On Apr 9, 2020, at 2:06 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>
>> On Thu, Apr 9, 2020 at 10:58 AM Qian Cai <cai@lca.pw> wrote:
>>>
>>> Agree to make a big deal part. My point is that when kicking trees of linux-next, it also could reduce the exposure of many patches (which could be bad) to linux-next and miss valuable early testing either from robots or human.
>>
>> Sure. But I'd want to be notified when something gets kicked out, so
>> that I then know not to pull it.
>>
>> So it would reduce the exposure of patches, but it would also make
>> sure those patches then don't make it upstream.
>>
>> Untested patches is fine - as long as nobody else has to suffer through them.
> 
> Excellent. It now very much depends on how Stephen will notify you when
> a tree, a patchset or even a developer should be blacklisted for some time
> to make this a success.
> 

Since patch flow forms tree structure, I don't know whether maintainers can
afford remembering which tree, patchset or developer should be blacklisted
when problems come from leaf git trees.



By the way...

Removing problematic trees might confuse "#syz test:" request, for
developers might ask syzbot to test proposed patches on a kernel which
does not contain problematic trees. In lucky case, test request fails
as patch failure or build failure. But in unlucky case, syzbot fails to
detect that proposed patch was tested on a kernel without problematic
trees. A bit related to https://github.com/google/syzkaller/issues/1609 .
