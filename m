Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D78C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB46F2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgGPL1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 07:27:24 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:61068 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgGPL1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 07:27:24 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 06GBRL97041795;
        Thu, 16 Jul 2020 20:27:21 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp);
 Thu, 16 Jul 2020 20:27:21 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 06GBRLEi041792
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 16 Jul 2020 20:27:21 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2] fbdev: Detect integer underflow at "struct
 fbcon_ops"->clear_margins.
To:     Daniel Vetter <daniel@ffwll.ch>
References: <adff5d10-fe35-62d4-74c5-182958c5ada7@i-love.sakura.ne.jp>
 <20200715015102.3814-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200715094836.GD2571@kadam>
 <9e6eac10-c5c3-f518-36cc-9ea32fb5d7fe@i-love.sakura.ne.jp>
 <b50f85c7-80e5-89c5-0aca-31d8e9892665@i-love.sakura.ne.jp>
 <20200715151220.GE2571@kadam>
 <adfa8720-c411-dfe6-6b0f-7591dd95396c@i-love.sakura.ne.jp>
 <20200716100006.GN3278063@phenom.ffwll.local>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-fbdev@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        syzbot <syzbot+e5fd3e65515b48c02a30@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        George Kennedy <george.kennedy@oracle.com>,
        Jiri Slaby <jslaby@suse.com>,
        Dmitry Vyukov <dvyukov@google.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <b202b74b-6a7b-e2be-2350-72144331303b@i-love.sakura.ne.jp>
Date:   Thu, 16 Jul 2020 20:27:21 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716100006.GN3278063@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/07/16 19:00, Daniel Vetter wrote:
> On Thu, Jul 16, 2020 at 12:29:00AM +0900, Tetsuo Handa wrote:
>> On 2020/07/16 0:12, Dan Carpenter wrote:
>>> I've complained about integer overflows in fbdev for a long time...
>>>
>>> What I'd like to see is something like the following maybe.  I don't
>>> know how to get the vc_data in fbmem.c so it doesn't include your checks
>>> for negative.
>>
>> Yes. Like I said "Thus, I consider that we need more sanity/constraints checks." at
>> https://lore.kernel.org/lkml/b1e7dd6a-fc22-bba8-0abb-d3e779329bce@i-love.sakura.ne.jp/ ,
>> we want basic checks. That's a task for fbdev people who should be familiar with
>> necessary constraints.
> 
> I think the worldwide supply of people who understand fbdev and willing to
> work on it is roughly 0. So if someone wants to fix this mess properly
> (which likely means adding tons of over/underflow checks at entry points,
> since you're never going to catch the driver bugs, there's too many and
> not enough people who care) they need to fix this themselves.

But I think we can enforce reasonable constraint which is much stricter than Dan's basic_checks()
(which used INT_MAX). For example, do we need to accept var->{xres,yres} >= 1048576, for
"32768 rows or cols" * "32 pixels per character" = 1045876 and vc_do_resize() accepts only
rows and cols < 32768 ?

> 
> Just to avoid confusion here.
> 
>> Anyway, my two patches are small and low cost; can we apply these patches regardless
>> of basic checks?
> 
> Which two patches where?

[PATCH v3] vt: Reject zero-sized screen buffer size.
 from https://lkml.kernel.org/r/20200712111013.11881-1-penguin-kernel@I-love.SAKURA.ne.jp

[PATCH v2] fbdev: Detect integer underflow at "struct fbcon_ops"->clear_margins.
 from https://lkml.kernel.org/r/20200715015102.3814-1-penguin-kernel@I-love.SAKURA.ne.jp
