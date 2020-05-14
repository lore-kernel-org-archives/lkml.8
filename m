Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B16C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11A1F20727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ewvng4bG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgENNfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 09:35:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28371 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726128AbgENNfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 09:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589463303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OMrvXzbHxIHtlTr7OrPCuHaO6zs7j1Kvj33xIsqdLqw=;
        b=Ewvng4bGssK+hRHNVXaR3ObQY/SZrEzgxtiKOIcXiRSnTfrxM5IboFyh6J5semFN0JQZV+
        ggnnkx9OTqDzxd3rwSMbbY4WErAN2DEmhyQ3QizNPTOTflHjS0KJZa6GcRKS6x4ulppHMG
        27Mr7VmxGI//M8aPg7mHp7q1taYJIqc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-PDDfF_coNhmZIgqbXrX5cQ-1; Thu, 14 May 2020 09:34:57 -0400
X-MC-Unique: PDDfF_coNhmZIgqbXrX5cQ-1
Received: by mail-ed1-f69.google.com with SMTP id df5so1178606edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 06:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OMrvXzbHxIHtlTr7OrPCuHaO6zs7j1Kvj33xIsqdLqw=;
        b=cmw6GT/NnoS1hWzZboUoS0DnRO7uFJ8a8HQuSAh9PkbUNqm/9sl2BV+2ucGTap3Yzu
         XV8m/jdRt24oTM+lTZv4NEplxPofSdjxBikgJOXcb2zDz+i1hekZkc6UJHi64qYPoQnw
         67Gy6FOgcNbnkiPr8VZNR5FKVPTSoR5cBV/Q/Ggoh9hvEWqSwZZeIvvmkzghifqVYLcs
         CSez12GTL8wlAwSGxkMH2SfkjHsZHN2xP0CsjtwA3CmpIfJ24M2Ngu8uyckDZYin1PkQ
         91oGebG/0HpPfqinx1YLkiZjywBpAJ9Ogqm0hWU2L5Opjp9YOfi1vSEZ6QderGVfI3QQ
         HHog==
X-Gm-Message-State: AOAM5310EtV6efLftcap9bI+lUwktcGU5gCCsiubQozprlMrGzdhDovU
        KQz/H9omweqKuHFvy1EfWEqs+Cxcgq2t1XfDwDUw41nWAoCye05loYT1PKGWRldn7GeZ9LkmXW7
        HbSrt2jR6ZUi3WNt15fbtrDeEYm1QLW7lS3huqCrO
X-Received: by 2002:a50:cb85:: with SMTP id k5mr4141711edi.152.1589463296510;
        Thu, 14 May 2020 06:34:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6HCo/Mwy8BGcIwwFh1GYMRgc0wPWftjgR/KqFfbQNlVBW9tnOqgd0duz/dtqSl+5jNGmew1ye9UH26nid8Cg=
X-Received: by 2002:a50:cb85:: with SMTP id k5mr4141685edi.152.1589463296298;
 Thu, 14 May 2020 06:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAE4VaGCDTeE16nNmSS8fGzCBvHsO=qkJAW6yDiORAxgsPi-Ziw@mail.gmail.com>
 <20200508092212.GE3758@techsingularity.net> <CAE4VaGC_v6On-YvqdTwAWu3Mq4ofiV0pLov-QpV+QHr_SJr+Rw@mail.gmail.com>
 <CAE4VaGDQWPePtmtCZP=ROYW1KPxtPhGDrxqy2QbirHGJdwk4=w@mail.gmail.com>
 <20200513153023.GF3758@techsingularity.net> <CAE4VaGBq5+ucS4p+0AzFsNP7YDsg7dLZ73dzuhBerHiM4EYP_Q@mail.gmail.com>
 <20200514095055.GG3758@techsingularity.net> <CAE4VaGCGUFOAZ+YHDnmeJ95o4W0j04Yb7EWnf8a43caUQs_WuQ@mail.gmail.com>
 <20200514100814.GH3758@techsingularity.net> <CAE4VaGBwFvduqOyn8pQnN3U4ozuB=4DVx6i1vheAg-2PegvE9Q@mail.gmail.com>
 <20200514115050.GI3758@techsingularity.net>
In-Reply-To: <20200514115050.GI3758@techsingularity.net>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Thu, 14 May 2020 15:34:45 +0200
Message-ID: <CAE4VaGCf0s0m6VdX=jPPOpB1xc5mLwdHaakNOsUppy+Pqxsj-g@mail.gmail.com>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Douglas Shakshober <dshaks@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Joe Mario <jmario@redhat.com>, Bill Gray <bgray@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

THANK YOU!


On Thu, May 14, 2020 at 1:50 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Thu, May 14, 2020 at 12:22:05PM +0200, Jirka Hladky wrote:
> > Thanks!
> >
> > Do you have a link? I cannot find it on github
> > (https://github.com/gormanm/mmtests, searched for
> > config-network-netperf-cstate-small-cross-socket)
> >
>
> https://github.com/gormanm/mmtests/blob/master/configs/config-network-netperf-cstate-small-cross-socket
>
> --
> Mel Gorman
> SUSE Labs
>


-- 
-Jirka

