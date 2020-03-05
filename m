Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88574C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FD02072A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZceD2kVf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgCEMd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 07:33:57 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33305 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgCEMd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 07:33:57 -0500
Received: by mail-wr1-f66.google.com with SMTP id x7so6829796wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 04:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=c2NZidu/XfP238PgxESEOhsM3U/bfZuSadvz2JgdbrA=;
        b=ZceD2kVfOPzIJE42Phmlpyjz1zkTnjQ9+itU4ux5cKgZvRTJmkflfZImsmWKVBcaVn
         FuBVG5q9f7QIRxBQHNLtixMF6SJebATDJsUUAeOvY23F2T289Dxr4xC0cnLrSRnLCooj
         cnSAaxlB7Hki08FXsCXjpFOCqijmdBWQHkPBDT6m+9bLmjBwPuQyIqsdANu/qyC+9RBD
         nw+D+nDquSWLtz1W7J+3Qv2mLDFdNgodASWSnSvg/Vn4Rt/RMB4Q4KyU2JITF5KcK0Xy
         mvvgnf5PM42VhqbpKww1UzdVyOMf9UYsLr+rLIdb90rrrIM15yqJhgiiSfobfviNFks9
         qWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=c2NZidu/XfP238PgxESEOhsM3U/bfZuSadvz2JgdbrA=;
        b=RnY+btYY1w0RlhtW4SGDX138NxofUJjGinE0Fm3rVc+XroT8gTtN34ImdsMN+lzI52
         tjF4dWJO+Vss3SnZKS2y8/NsZF+WfyIIejOTbnr4JP6T1IsWoTfNUxbxOjPPo+0WURhf
         4pwSrzzt6laB2kJtFkvIpcmC/A/7NI6SFonW5pDa9ps6YP0qvLA2o1zPKrQd9P2Vivi3
         dPa9M3oxC1Az0mPP+opyfnEo49Hn1a+qk4W8FMu0I5dzTTQriNHOwzP7W9Khsel3vwnb
         ywrIfUJCq1bCWe774+D72fuZ7GBgjMxlNQR0zFpVYRrZXzBLZw04zlCuc9p85Vdo3igB
         lGog==
X-Gm-Message-State: ANhLgQ1v5Kq+nfYptnP+2mGoEwJXwuod6pNSdIshjPE23+8i1ogEJlkW
        3bht0WxuRESDiJrZ9pmgnMopmQ==
X-Google-Smtp-Source: ADFU+vsK6D/1L7OmoCPDxzACgnkNLhBHt8mW2vtuwtpmnm6jVx+uN2vOaadHIENNY+5sABhplNg/cQ==
X-Received: by 2002:adf:80af:: with SMTP id 44mr3918044wrl.241.1583411634802;
        Thu, 05 Mar 2020 04:33:54 -0800 (PST)
Received: from vingu-book ([2a01:e0a:f:6020:3151:b3b6:32b9:e36c])
        by smtp.gmail.com with ESMTPSA id q1sm2589800wrx.19.2020.03.05.04.33.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Mar 2020 04:33:53 -0800 (PST)
Date:   Thu, 5 Mar 2020 13:33:51 +0100
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 5.6-rc3: WARNING: CPU: 48 PID: 17435 at kernel/sched/fair.c:380
 enqueue_task_fair+0x328/0x440
Message-ID: <20200305123351.GB32088@vingu-book>
References: <ad0f263a-6837-e793-5761-fda3264fd8ad@de.ibm.com>
 <CAKfTPtCX4padfJm8aLrP9+b5KVgp-ff76=teu7MzMZJBYrc-7w@mail.gmail.com>
 <CAKfTPtD9b6o=B6jkbWNjfAw9e1UjT9Z07vxdsVfikEQdeCtfPw@mail.gmail.com>
 <2108173c-beaa-6b84-1bc3-8f575fb95954@de.ibm.com>
 <7be92e79-731b-220d-b187-d38bde80ad16@arm.com>
 <805cbe05-2424-7d74-5e11-37712c189eb6@de.ibm.com>
 <f28bc5ac-87fa-2494-29db-ff7d98b7372a@de.ibm.com>
 <20200305093003.GA32088@vingu-book>
 <15252de5-9a2d-19ae-607a-594ee88d1ba1@de.ibm.com>
 <ef1be100-2c6a-bcff-69a2-25878589a111@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef1be100-2c6a-bcff-69a2-25878589a111@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 05 mars 2020 à 13:12:39 (+0100), Dietmar Eggemann a écrit :
> On 05/03/2020 12:28, Christian Borntraeger wrote:
> > 
> > On 05.03.20 10:30, Vincent Guittot wrote:
> >> Le mercredi 04 mars 2020 à 20:59:33 (+0100), Christian Borntraeger a écrit :
> >>>
> >>> On 04.03.20 20:38, Christian Borntraeger wrote:
> >>>>
> >>>>
> >>>> On 04.03.20 20:19, Dietmar Eggemann wrote:
> 
> [...]
> 
> > It seems to speed up the issue when I do a compile job in parallel on the host:
> > 
> > Do you also need the sysfs tree?
> 
> [   87.932552] CPU23 path=/machine.slice/machine-test.slice/machine-qemu\x2d18\x2dtest10. on_list=1 nr_running=1 throttled=0 p=[CPU 2/KVM 2662]
> [   87.932559] CPU23 path=/machine.slice/machine-test.slice/machine-qemu\x2d18\x2dtest10. on_list=0 nr_running=3 throttled=0 p=[CPU 2/KVM 2662]
> [   87.932562] CPU23 path=/machine.slice/machine-test.slice on_list=1 nr_running=1 throttled=1 p=[CPU 2/KVM 2662]
> [   87.932564] CPU23 path=/machine.slice on_list=1 nr_running=0 throttled=0 p=[CPU 2/KVM 2662]
> [   87.932566] CPU23 path=/ on_list=1 nr_running=1 throttled=0 p=[CPU 2/KVM 2662]
> [   87.951872] CPU23 path=/ on_list=1 nr_running=2 throttled=0 p=[ksoftirqd/23 126]
> [   87.987528] CPU23 path=/user.slice on_list=1 nr_running=2 throttled=0 p=[as 6737]
> [   87.987533] CPU23 path=/ on_list=1 nr_running=1 throttled=0 p=[as 6737]
> 
> Arrh, looks like 'char path[64]' is too small to hold 'machine.slice/machine-test.slice/machine-qemu\x2d18\x2dtest10.scope/vcpuX' !
>                                                                                                                     ^  
> But I guess that the 'on_list=0' for 'machine-qemu\x2d18\x2dtest10.scope' could be the missing hint?

yes the if (cfs_bandwidth_used()) at the end of enqueue_task_fair is not enough
to ensure that all cfs will be added back. It will "work" for the 1st enqueue
because the throttled cfs will be added and will reset tmp_alone_branch but not
for the next one

Compare to the previous proposed fix, we can optimize it a bit with:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9ccde775e02e..3b19e508641d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4035,10 +4035,16 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
                __enqueue_entity(cfs_rq, se);
        se->on_rq = 1;

-       if (cfs_rq->nr_running == 1) {
+       /*
+        * When bandwidth control is enabled, cfs might have been removed because of
+        * a parent been throttled but cfs->nr_running > 1. Try to add it
+        * unconditionnally.
+        */
+       if (cfs_rq->nr_running == 1 || cfs_bandwidth_used())
                list_add_leaf_cfs_rq(cfs_rq);
+
+       if (cfs_rq->nr_running == 1)
                check_enqueue_throttle(cfs_rq);
-       }
 }

 static void __clear_buddies_last(struct sched_entity *se)




