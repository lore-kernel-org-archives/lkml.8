Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DE0C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E9BB217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/4D2sVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895128AbgDPNTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:19:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37247 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895029AbgDPNTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587043184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rtsrb+mX+YQpZoHIv9A5wAzihBkDRNbltom382I4FVo=;
        b=b/4D2sVYvaBHjfhi9cDI55/+O7BHHFKEy2S4Ui+hPBRKGtn8kqdDYZgeIE4sm4L1t8BqRM
        9/D3UTVXlLHEi/d2ItHuDgfoeY3KTh2Pvc/JHoDb6zSW9ZCTB2k94Tg90sZvu2BdmgwaB5
        2V4OpiygFsadZ2+MLzczXWomRCg1oyY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-kK-LLeTzNYWmW-uqBJS6Ng-1; Thu, 16 Apr 2020 09:19:43 -0400
X-MC-Unique: kK-LLeTzNYWmW-uqBJS6Ng-1
Received: by mail-wm1-f70.google.com with SMTP id b203so1169990wmd.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 06:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rtsrb+mX+YQpZoHIv9A5wAzihBkDRNbltom382I4FVo=;
        b=hzmWFu4TeBdA6SS8maIxlj5fNY1ooKhCVisCbS4uMiMjYhhPEetgP29PseenPUklIt
         KgabnDuWk2dyD8FbC29+Eb+gcQWxaU0oCKDqVzNqfITL62SDsctV3kIWNiXq8Cf6Cdrq
         dwI2TTDZKcNt1bK8BlKI7LVEuqWmjsmYVrVI1rMxRAsNqtcivYUzSiXuMj3+cYBL6kQa
         CSjoaKnI15ZzPK5JKUwxiLmEjSv8317+6DPRq7NY7ZBuyak26WKx96QXpyGHZw3W63mh
         HHihE1OaOtif8oVbhP0tvN2pU89K8m0h26onTRlG381XfaWv291p0Da+6nOkIkso73l2
         HGiQ==
X-Gm-Message-State: AGi0Pub2e/e5xaxJlvGTPLig1l47YE3OF8q8/p5vyTIoYAEvfqVkzf1x
        Kn0JCBSiyJbDqO8+HcQYqNh4DJNUumdrAq4qyRW907f73MlNzfkkDi20bfy4fY2Az8K8o70nLD4
        wyWEIB17OazqtNonaCpQFoQmJ
X-Received: by 2002:a5d:6a92:: with SMTP id s18mr32571175wru.50.1587043181734;
        Thu, 16 Apr 2020 06:19:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypInMTm0ADcKGayHy0kpPUJt4fUN6vRuVG+L1mF2beKaIwUX3YBq6e3HBy2ozeJggoxMt8Uf+A==
X-Received: by 2002:a5d:6a92:: with SMTP id s18mr32571156wru.50.1587043181443;
        Thu, 16 Apr 2020 06:19:41 -0700 (PDT)
Received: from localhost.localdomain ([151.29.194.179])
        by smtp.gmail.com with ESMTPSA id l15sm3543650wmi.48.2020.04.16.06.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 06:19:40 -0700 (PDT)
Date:   Thu, 16 Apr 2020 15:19:38 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] sched/deadline: Make DL capacity-aware
Message-ID: <20200416131938.GI9767@localhost.localdomain>
References: <20200408095012.3819-1-dietmar.eggemann@arm.com>
 <20200408095012.3819-4-dietmar.eggemann@arm.com>
 <20200410125253.GE14300@localhost.localdomain>
 <f0e74500-77d7-a42c-410e-bc5d4d2ecdfb@arm.com>
 <20200415132004.GF9767@localhost.localdomain>
 <20200415184203.50862783@sweethome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415184203.50862783@sweethome>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/20 18:42, luca abeni wrote:
> Hi Juri,
> 
> On Wed, 15 Apr 2020 15:20:04 +0200
> Juri Lelli <juri.lelli@redhat.com> wrote:
> [...]
> > > > I'm thinking that, while dl_task_fits_capacity() works well when
> > > > selecting idle cpus, in this case we should consider the fact
> > > > that curr might be deadline as well and already consuming some of
> > > > the rq capacity.
> > > > 
> > > > Do you think we should try to take that into account, maybe using
> > > > dl_rq->this_bw ?  
> > > 
> > > So you're saying that cpudl_find(..., later_mask) could return 1 (w/
> > > best_cpu (cp->elements[0].cpu) in later_mask).
> > > 
> > > And that this best_cpu could be a non-fitting CPU for p.
> > > 
> > > This could happen if cp->free_cpus is empty (no idle CPUs) so we
> > > take cpudl_find()'s else path and in case p's deadline <
> > > cp->elements[0] deadline.
> > > 
> > > We could condition the 'return 1' on best_cpu fitting p.
> > > 
> > > But should we do this for cpudl_find(..., NULL) calls from
> > > check_preempt_equal_dl() as well or will this break GEDF?  
> > 
> > So, even by not returning best_cpu, as above, if it doesn't fit p's bw
> > requirement, I think we would be breaking GEDF, which however doesn't
> > take asym capacities into account.
> 
> Well, gEDF could take asymmetric capacities into account by scheduling
> the earliest deadline task on the fastest CPU (and the task with the
> second earliest deadline on the second fastest CPU, and so on...)
> 
> But this could cause a lot of unneeded migrations (I tried to discuss
> this issue in a previous OSPM presentation). My original approach to
> work around this issue was to schedule a task on the slowest core on
> which the task can fit (some experiments revealed that this heuristic
> can approximate the gEDF behaviour without causing too many
> migrations)... But this patch is not included on the current patchset,
> and will be proposed later, after the most important patches have been
> merged.

OK, makes sense to me. And I'm ok also with a 2 steps approach. Asym
idle now and asym busy with a later series.

Best,

Juri

