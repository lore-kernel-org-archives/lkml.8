Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCEAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EA2720739
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgGPQ3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:29:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33338 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbgGPQ3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 12:29:42 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jw6lI-0001Zl-5G; Thu, 16 Jul 2020 16:29:32 +0000
Date:   Thu, 16 Jul 2020 18:29:31 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve Hjonnevag <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        syzbot <syzbot+e5344baa319c9a96edec@syzkaller.appspotmail.com>,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH v2] binder: Don't use mmput() from shrinker function.
Message-ID: <20200716162931.g3delsp7qmfjup6x@wittgenstein>
References: <0000000000001fbbb605aa805c9b@google.com>
 <5ce3ee90-333e-638d-ac8c-cd6d7ab7aa3b@I-love.SAKURA.ne.jp>
 <20200716083506.GA20915@dhcp22.suse.cz>
 <36db7016-98d6-2c6b-110b-b2481fd480ac@i-love.sakura.ne.jp>
 <20200716135445.GN31089@dhcp22.suse.cz>
 <4ba9adb2-43f5-2de0-22de-f6075c1fab50@i-love.sakura.ne.jp>
 <20200716151756.GO31089@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200716151756.GO31089@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 05:17:56PM +0200, Michal Hocko wrote:
> On Fri 17-07-20 00:12:15, Tetsuo Handa wrote:
> > syzbot is reporting that mmput() from shrinker function has a risk of
> > deadlock [1], for delayed_uprobe_add() from update_ref_ctr() calls
> > kzalloc(GFP_KERNEL) with delayed_uprobe_lock held, and
> > uprobe_clear_state() from __mmput() also holds delayed_uprobe_lock.
> > 
> > Commit a1b2289cef92ef0e ("android: binder: drop lru lock in isolate
> > callback") replaced mmput() with mmput_async() in order to avoid sleeping
> > with spinlock held. But this patch replaces mmput() with mmput_async() in
> > order not to start __mmput() from shrinker context.
> > 
> > [1] https://syzkaller.appspot.com/bug?id=bc9e7303f537c41b2b0cc2dfcea3fc42964c2d45
> > 
> > Reported-by: syzbot <syzbot+1068f09c44d151250c33@syzkaller.appspotmail.com>
> > Reported-by: syzbot <syzbot+e5344baa319c9a96edec@syzkaller.appspotmail.com>
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> 
> Reviewed-by: Michal Hocko <mhocko@suse.com>

Thanks for the careful review Michal!
Does this need a Cc: stable?

Otherwise

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Thanks!
Christian
