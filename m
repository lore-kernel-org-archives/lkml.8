Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB335C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4D72051A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbgBJMrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:47:53 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:62282 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730260AbgBJMrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:47:02 -0500
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 01ACkE6E048428;
        Mon, 10 Feb 2020 21:46:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav104.sakura.ne.jp);
 Mon, 10 Feb 2020 21:46:14 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav104.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 01ACkDpn048358
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 10 Feb 2020 21:46:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: task hung in wdm_flush
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
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <ebc7b5e0-e968-0bdb-d75d-346e0b763d14@i-love.sakura.ne.jp>
Date:   Mon, 10 Feb 2020 21:46:11 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CACT4Y+ZWDMkOmnXpBXFhU8XcHA_-ZcHdZpfrXcCWHRzcbQ39Gg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/02/10 19:09, Dmitry Vyukov wrote:
> You may also try on the exact commit the bug was reported, because
> usb-fuzzer is tracking branch, things may change there.

OK. I explicitly tried

  #syz test: https://github.com/google/kasan.git e5cd56e94edde38ca4dafae5a450c5a16b8a5f23

but syzbot still cannot reproduce this bug using the reproducer...

On 2020/02/10 21:02, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger crash:
> 
> Reported-and-tested-by: syzbot+854768b99f19e89d7f81@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         e5cd56e9 usb: gadget: add raw-gadget interface
> git tree:       https://github.com/google/kasan.git
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c372cdb7140fc162
> dashboard link: https://syzkaller.appspot.com/bug?extid=854768b99f19e89d7f81
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Note: testing is done by a robot and is best-effort only.
> 

Anyway, I'm just suspecting that we are forgetting to wake up all waiters
after clearing WDM_IN_USE bit because sometimes multiple threads are reported
as hung.

On 2020/02/10 15:27, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger crash:
> 
> Reported-and-tested-by: syzbot+854768b99f19e89d7f81@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         e5cd56e9 usb: gadget: add raw-gadget interface
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c372cdb7140fc162
> dashboard link: https://syzkaller.appspot.com/bug?extid=854768b99f19e89d7f81
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=117c3ae9e00000
> 
> Note: testing is done by a robot and is best-effort only.
> 

On 2020/02/10 15:55, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger crash:
> 
> Reported-and-tested-by: syzbot+854768b99f19e89d7f81@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         e5cd56e9 usb: gadget: add raw-gadget interface
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c372cdb7140fc162
> dashboard link: https://syzkaller.appspot.com/bug?extid=854768b99f19e89d7f81
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=13b3f6e9e00000
> 
> Note: testing is done by a robot and is best-effort only.
> 

On 2020/02/10 16:21, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger crash:
> 
> Reported-and-tested-by: syzbot+854768b99f19e89d7f81@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         e5cd56e9 usb: gadget: add raw-gadget interface
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c372cdb7140fc162
> dashboard link: https://syzkaller.appspot.com/bug?extid=854768b99f19e89d7f81
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=115026b5e00000
> 
> Note: testing is done by a robot and is best-effort only.
> 

On 2020/02/10 16:44, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger crash:
> 
> Reported-and-tested-by: syzbot+854768b99f19e89d7f81@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         e5cd56e9 usb: gadget: add raw-gadget interface
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c372cdb7140fc162
> dashboard link: https://syzkaller.appspot.com/bug?extid=854768b99f19e89d7f81
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=17285431e00000
> 
> Note: testing is done by a robot and is best-effort only.
> 

On 2020/02/10 17:05, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger crash:
> 
> Reported-and-tested-by: syzbot+854768b99f19e89d7f81@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         e5cd56e9 usb: gadget: add raw-gadget interface
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c372cdb7140fc162
> dashboard link: https://syzkaller.appspot.com/bug?extid=854768b99f19e89d7f81
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Note: testing is done by a robot and is best-effort only.
> 

