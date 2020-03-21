Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A876FC4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 10:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F27A206F9
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 10:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgCUKT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 06:19:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37946 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgCUKT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 06:19:29 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jFbDt-0001PS-Al; Sat, 21 Mar 2020 11:19:21 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id CDD53FFC8D; Sat, 21 Mar 2020 11:19:20 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     syzbot <syzbot+46f513c3033d592409d2@syzkaller.appspotmail.com>,
        davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com
Subject: Re: WARNING: ODEBUG bug in tcindex_destroy_work (3)
In-Reply-To: <000000000000742e9e05a10170bc@google.com>
References: <000000000000742e9e05a10170bc@google.com>
Date:   Sat, 21 Mar 2020 11:19:20 +0100
Message-ID: <87a74arown.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot <syzbot+46f513c3033d592409d2@syzkaller.appspotmail.com> writes:
> syzbot has found a reproducer for the following crash on:
>
> HEAD commit:    74522e7b net: sched: set the hw_stats_type in pedit loop
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=14c85173e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b5acf5ac38a50651
> dashboard link: https://syzkaller.appspot.com/bug?extid=46f513c3033d592409d2
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17bfff65e00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+46f513c3033d592409d2@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> ODEBUG: free active (active state 0) object type: work_struct hint: tcindex_destroy_rexts_work+0x0/0x20 net/sched/cls_tcindex.c:143
...
>  __debug_check_no_obj_freed lib/debugobjects.c:967 [inline]
>  debug_check_no_obj_freed+0x2e1/0x445 lib/debugobjects.c:998
>  kfree+0xf6/0x2b0 mm/slab.c:3756
>  tcindex_destroy_work+0x2e/0x70 net/sched/cls_tcindex.c:231

So this is:

	kfree(p->perfect);

Looking at the place which queues that work:

tcindex_destroy()

   if (p->perfect) {
        if (tcf_exts_get_net(&r->exts))
            tcf_queue_work(&r-rwork, tcindex_destroy_rexts_work);
        else
            __tcindex_destroy_rexts(r)
   }

   .....
   
   tcf_queue_work(&p->rwork, tcindex_destroy_work);
   
So obviously if tcindex_destroy_work() runs before
tcindex_destroy_rexts_work() then the above happens.

Thanks,

        tglx
