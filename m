Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291D7C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFF52468E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sEJi1F7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgB1Qfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:35:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55894 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgB1Qfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:35:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so3802736wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 08:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HcG/EOqr8+CrfwSO/n77ulX+/pcSO4hIkOvdzBU4ykI=;
        b=sEJi1F7K5C+WPjvqrp9HyIGTw2H29ojkfm6wa2Y8BrBZ6IDEgfpQX014Yj00Hjp3am
         D0ndUXBuV8xdg7vnbJea8LEch/4ncITWTbIIbTh0B9FPLPJyK/WxgkI15BHguHlIFb1U
         iL8c1dGxMO1t0uauBjyIgLI2lKgUbxiJh/MsHbQKt/aqowgM8b24xmeDQim/Utq+i0ty
         IOD6/gFjloEH9FTzrkpHXzb5+oDNK9nxvQ9QxsXPSCj3/lNZSvpk2jwerbx97hK/m4/J
         BJVxgIjNVMk5xD6u30d3PZ2mPJDn9jR8XMc1CrljcD45WvV/NQ50UICwJ7uYxZFXYjST
         zhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HcG/EOqr8+CrfwSO/n77ulX+/pcSO4hIkOvdzBU4ykI=;
        b=t3am9KSohgCJUGr41jMJgPMlBTpjllTIzgLe5tiWYBQFAiXXz7tIVri9O12/QaW4Cn
         NbONO6p8b0FGH11oETWqQotdQUEXcWcdDAYg0IyTf2NtRSW8fxLTKlRkkNen9ZtIRjh3
         6TP5938sbIklnqp64diXKiM1kpZwhFi3qXBgy0ScXiFbmTWsUsixYgVZzsTrgKANBfsb
         B85UNQazmqh82f7SuH22lmKILxXDeaaWIeiDGG3jFooUWV+NiFZqZrsqPBL1SUrsNw/Q
         7ivHko1mAk/gQwmzg/QkeAoXwM5XykEbZjn/El/JHAqFvJJc9Rr2DHYtUshRghp8ZFAX
         VFlg==
X-Gm-Message-State: APjAAAVc6wJHN9GJuFD3m3VtmE4iyXFLJhgpUj30rulxpgd1bH/jbIP4
        TB1CzIdoLBdm83o6CsFniQEOng==
X-Google-Smtp-Source: APXvYqxGJidQ2k3iW7VpU0ESuoj1p6lTJ5v2plfr2HD4Loc/kWeaZpO3URuGldRyIxcAcgk6NjvbPQ==
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr5343325wmi.37.1582907748312;
        Fri, 28 Feb 2020 08:35:48 -0800 (PST)
Received: from vingu-book ([2a01:e0a:f:6020:9522:3a6c:498:7b7d])
        by smtp.gmail.com with ESMTPSA id r6sm13392923wrq.92.2020.02.28.08.35.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Feb 2020 08:35:47 -0800 (PST)
Date:   Fri, 28 Feb 2020 17:35:45 +0100
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 5.6-rc3: WARNING: CPU: 48 PID: 17435 at kernel/sched/fair.c:380
 enqueue_task_fair+0x328/0x440
Message-ID: <20200228163545.GA18662@vingu-book>
References: <ace7327f-0fd6-4f36-39ae-a8d7d1c7f06b@de.ibm.com>
 <afacbbd1-3d6b-c537-34e2-5b455e1c2267@de.ibm.com>
 <CAKfTPtBikHzpHY-NdRJFfOFxx+S3=4Y0aPM5s0jpHs40+9BaGA@mail.gmail.com>
 <b073a50e-4b86-56db-3fbd-6869b2716b34@de.ibm.com>
 <1a607a98-f12a-77bd-2062-c3e599614331@de.ibm.com>
 <CAKfTPtBZ2X8i6zMgrA1gNJmwoSnyRc76yXmLZEwboJmF-R9QVg@mail.gmail.com>
 <b664f050-72d6-a483-be0a-8504f687f225@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b664f050-72d6-a483-be0a-8504f687f225@de.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 28 févr. 2020 à 16:42:27 (+0100), Christian Borntraeger a écrit :
> 
> 
> On 28.02.20 16:37, Vincent Guittot wrote:
> > On Fri, 28 Feb 2020 at 16:08, Christian Borntraeger
> > <borntraeger@de.ibm.com> wrote:
> >>
> >> Also happened with 5.4:
> >> Seems that I just happen to have an interesting test workload/system size interaction
> >> on a newly installed system that triggers this.
> > 
> > you will probably go back to 5.1 which is the version where we put
> > back the deletion of unused cfs_rq from the list which can trigger the
> > warning:
> > commit 039ae8bcf7a5 : (Fix O(nr_cgroups) in the load balancing path)
> > 
> > AFAICT, we haven't changed this since
> 
> So you do know what is the problem? If not is there any debug option or
> patch that I could apply to give you more information?

No I don't know what is happening. Your test probably goes through an unexpected path

Would it be difficult for me to reproduce your test env ?

There is an optimization in the code which could generate problem if assumption is not
true. Could you try the patch below ?

---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3c8a379c357e..beb773c23e7d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4035,8 +4035,8 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		__enqueue_entity(cfs_rq, se);
 	se->on_rq = 1;
 
+	list_add_leaf_cfs_rq(cfs_rq);
 	if (cfs_rq->nr_running == 1) {
-		list_add_leaf_cfs_rq(cfs_rq);
 		check_enqueue_throttle(cfs_rq);
 	}
 }
-- 
2.17.1



> 
