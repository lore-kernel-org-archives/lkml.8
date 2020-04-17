Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F392DC38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD29320857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGz82LSs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgDQPrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:47:46 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50129 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728593AbgDQPrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:47:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587138464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3Xs2MTxwh0vGINYZy+SUAAgyKrJ71vVJoo8S0VhtPvQ=;
        b=iGz82LSsKyMCFTalm0Kemrk3Ol/PM+TJz9lzVgzcYEQNv+x5aDA56tK/CJYMVcA508C2mX
        4Wer9XzeAU9KPCTGNczmkfOwmJqIWSh6fkJzfqYA1vqt3BJuYTe682bTveUiTQoY89ngxP
        brQoNhu+WDR4IJe7u19qcv/YMfSlyD4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-rxra0e0AOEq3sKmCQ_iYrg-1; Fri, 17 Apr 2020 11:47:42 -0400
X-MC-Unique: rxra0e0AOEq3sKmCQ_iYrg-1
Received: by mail-wm1-f69.google.com with SMTP id o5so1163271wmo.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 08:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Xs2MTxwh0vGINYZy+SUAAgyKrJ71vVJoo8S0VhtPvQ=;
        b=VgyTAbpaQEtMxRSRnESg5lA+K95ER3MHTtdLThw1U/H7KQCzHf0c1vwRsDp8J+q9AE
         KZ+HAJnmKIWjIpygw8z11Adj2zNAjV7O/UAp5TCZow5LfXKDSnciKFmvFQqCm9PJV0GO
         6jQs4fpVOAGWpprLBoaEuVolwuE6rZO2Fg7FjypaTSYmMqnlfhumU4M3ipf0lh5hSHyf
         kdEZq92zXU1r+6vCvuZ/88r0TYSSE4tltKEeAE1FGDtye8gJfUC6W8jmxdkYBsmt2/cQ
         WEx0iBQS+snAxAxTTyl/XB7p0ZQt9TMd6FDOToMBe3ZITTC98k6z4HBzZqqvSi8aXI9b
         gzRg==
X-Gm-Message-State: AGi0PubzZ5USL7Wr9Dl5dv8reqciYI+64x1QjCzj/KbYm4b3APvZGc6d
        zFSP0Pz7Ei7KivJROCAUsm9Dju5GdElM8MWgF6RHQDgA9bubX6/ReSKSHeADGZH6IQ51ibnzGsC
        h2uwSEZjeBD3NpTBDTiOSLa34
X-Received: by 2002:a5d:464e:: with SMTP id j14mr4663329wrs.339.1587138461668;
        Fri, 17 Apr 2020 08:47:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypKHgdSMaCkIB8C4WyYSD+8NUOeqt2aHefzWSED0khK7iwiUADjeUg7GRnvEL6zHl3wkorIMHA==
X-Received: by 2002:a5d:464e:: with SMTP id j14mr4663292wrs.339.1587138461352;
        Fri, 17 Apr 2020 08:47:41 -0700 (PDT)
Received: from localhost.localdomain ([151.29.194.179])
        by smtp.gmail.com with ESMTPSA id 145sm8553032wma.1.2020.04.17.08.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 08:47:40 -0700 (PDT)
Date:   Fri, 17 Apr 2020 17:47:38 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        luca abeni <luca.abeni@santannapisa.it>,
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
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] sched/deadline: Improve admission control for
 asymmetric CPU capacities
Message-ID: <20200417154738.GT9767@localhost.localdomain>
References: <20200408095012.3819-1-dietmar.eggemann@arm.com>
 <20200408095012.3819-3-dietmar.eggemann@arm.com>
 <jhjeesyw96u.mognet@arm.com>
 <20200408153032.447e098d@nowhere>
 <jhjblo2vx60.mognet@arm.com>
 <31620965-e1e7-6854-ad46-8192ee4b41af@arm.com>
 <20200417121945.GM9767@localhost.localdomain>
 <8734b37e-5602-79dc-c7a8-c41fd9eb86b5@arm.com>
 <20200417150828.GS9767@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417150828.GS9767@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/20 17:08, Juri Lelli wrote:
> On 17/04/20 16:55, Dietmar Eggemann wrote:
> > On 17.04.20 14:19, Juri Lelli wrote:
> > > On 09/04/20 19:29, Dietmar Eggemann wrote:
> > 
> > [...]
> > 
> > >> Maybe we can do a hybrid. We have rd->span and rd->sum_cpu_capacity and
> > >> with the help of an extra per-cpu cpumask we could just
> > > 
> > > Hummm, I like the idea, but
> > > 
> > >> DEFINE_PER_CPU(cpumask_var_t, dl_bw_mask);
> > >>
> > >> dl_bw_cpus(int i) {
> > > 
> > > This works if calls are always local to the rd we are interested into
> > > (argument 'i' isn't used). Are we always doing that?
> > 
> > I thought so. The existing dl_bw_cpus(int i) implementation already
> > assumes this by using:
> > 
> >     struct root_domain *rd = cpu_rq(i)->rd;
> 
> Hummm, can't dl_task_can_attach() call it with a dest_cpu different from
> this_cpu?
> 
> Current implementation uses 'i' argument to get to the right root_domain
> (e.g., when moving tasks between execlusive set).
> 
> >     ...

Bah, forget that. If everything else stays the same (get rd using 'i')
this should work ok.

