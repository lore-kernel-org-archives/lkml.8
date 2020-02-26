Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEC3C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 07:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E66A2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 07:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ov82jrDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbgBZHWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 02:22:07 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45381 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgBZHWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 02:22:07 -0500
Received: by mail-lj1-f195.google.com with SMTP id e18so1794214ljn.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 23:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0M6EtJg4ZSjY6Oxjrmkg1KX+Te8MK2AsJq370rGDenk=;
        b=Ov82jrDatD8bWboohqMvsOAhZba+htl2ve7n0JeExu/+R09MMPxYS8aCRiX8VMo2HH
         1DaJDem20tq/u8lJmwbugF+0esSVoiVlaw+Sl481MfG4YVZo3DmdRQ/LvY43wAqAoaLQ
         0FfVCi8a3XiAfJHgLv2TKiuv3kzoWwyZ3l4UgbXX71u7Y6J2uaPJS6gpVMXNTeRavdu8
         y2cjQBVVsePfXE/TUVFTxPBoN0tiaQcveksMQ3bf6Y8WXkMCG6+EVIl96fNrkJxReWg0
         TL0wbMgW0DZVh/pbs3FktPSDEHYqScVQONLxzLvvhrtsbpxKlt1UlmGIY8vnuVdmWUeW
         Rc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0M6EtJg4ZSjY6Oxjrmkg1KX+Te8MK2AsJq370rGDenk=;
        b=PwtKvKuaP8+QiNZW0WsfYqFhyryOtfh7eNh+SEQVqomMjEQVHv0KIZwOOFkLxXjq4M
         I6LeoxM9/A/WuU7Ns2apGTnBKeuThuDL1XuMVGcs3xS6lyJD4LVanzpS6V0DqfCOYtOw
         TeOgTXwM6S88g9KUKe4dNjn0eDtNLyGdQhOjRnxur4QhCrCnHSIgtyyqdD0LetTku8gS
         A5CHv8u84eOFRttM3yd1H+ROphgrRgK4/iDMEaZS5NhqgA11TrIyFHL8q0I5AGx85IZc
         IsZx8y+gESKkAVI2UONl7RSHide4gTHEgd7lPu8tsBOuBeG/ZDknqHoJ78jUlpMjUfPH
         +o3Q==
X-Gm-Message-State: APjAAAVHsu94dSrHDDd0JvdrFjxoLnAzUplkIaruHwcWus0ICId3+fn+
        cW5uNBtflKfkDeU73yLDwHYRSwKhtx4OqVnqDss=
X-Google-Smtp-Source: APXvYqyNJOdKgXaZXUYJZgmE/vqQKBmjsDbREcfsT7PXr3AiwDonTA+XBWndu65ROlWYY/xkFx0ZavPDc8Vi+tLTYxA=
X-Received: by 2002:a2e:9d89:: with SMTP id c9mr2039039ljj.212.1582701724994;
 Tue, 25 Feb 2020 23:22:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1572437285.git.vpillai@digitalocean.com>
 <5e3cea14-28d1-bf1e-cabe-fb5b48fdeadc@linux.intel.com> <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com>
 <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com>
 <e322a252-f983-e3f3-f823-16d0c16b2867@linux.intel.com> <20200212230705.GA25315@sinkpad>
 <29d43466-1e18-6b42-d4d0-20ccde20ff07@linux.intel.com> <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com>
 <20200225034438.GA617271@ziqianlu-desktop.localdomain> <CANaguZD205ccu1V_2W-QuMRrJA9SjJ5ng1do4NCdLy8NDKKrbA@mail.gmail.com>
In-Reply-To: <CANaguZD205ccu1V_2W-QuMRrJA9SjJ5ng1do4NCdLy8NDKKrbA@mail.gmail.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Wed, 26 Feb 2020 15:21:53 +0800
Message-ID: <CAERHkrscBs8WoHSGtnH9mVsN3thfkE0CCQYPRE=XFUWWkQooQQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Aaron Lu <aaron.lwe@gmail.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dario Faggioli <dfaggioli@suse.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 4:51 AM Vineeth Remanan Pillai
<vpillai@digitalocean.com> wrote:
>
> I have a quick patch
> which might fix this. The idea is that, we allow migration if p's
> hierarchical load or estimated utilization is more than dest_rq->curr.
> While thinking about this fix, I noticed that we are not holding the
> dest_rq lock for any of the migration patches. Migration patches would
> probably need a rework. Attaching my patch down, but it also does not
> take the dest_rq lock. I have also added a case of dest_core being
> forced_idle. I think that would be an opportunity to migrate. Ideally
> we should check if the forced idle task has the same cookie as p.
>
> https://gist.github.com/vineethrp/887743608f42a6ce96bf7847b5b119ae
>

Hi Vineeth,

Thanks for the quick fix. I guess this patch should work for Aaron's case
because it almost removed the cookie checking here. Some comments
below:

+ if (rq->core->core_forceidle)
+         return true;

We check cookie match during load balance to avoid two different
cookie tasks on the same core. If one cpu is forced idle, its sibling should
be running a non-idle task, not sure why we can return true directly here.
And if we need to check cookie, with this forced idle case, why it's special
to be picked up?

+ if (task_h_load(p) > task_h_load(rq->curr))
+         return true;
+ if (task_util_est(p) > task_util_est(rq->curr))
+         return true;

These two need to exclude rq->curr == rq->idle case?
otherwise idle balance always return true?

Thanks,
-Aubrey
