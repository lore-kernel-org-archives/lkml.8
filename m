Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7454EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 15:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4700A2075D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 15:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g5IlGoKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgHGPGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 11:06:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47195 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726644AbgHGPGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 11:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596812803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JhwrzTXfET2LA1451/hxvE9hVV0gEaq7zNxUuYFQSI8=;
        b=g5IlGoKExUtQVeyoHGEn5nSGIW/q/0bAdRAUU2MdcozPRC4Vff/E6LUyiQu6C8RKS1V3we
        DBWFp9s66WfJpx6QaM3v+Pc7hSRIvtyXWU24PhDpak+TvVIS63MydpAXQwjypn86sdqo/Q
        BqwzZCzjTpEdBIulKFCvUcp4720Dk0Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-3SRreF7pNmajAVbbhYJYHw-1; Fri, 07 Aug 2020 11:06:39 -0400
X-MC-Unique: 3SRreF7pNmajAVbbhYJYHw-1
Received: by mail-wm1-f71.google.com with SMTP id q15so898856wmj.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 08:06:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JhwrzTXfET2LA1451/hxvE9hVV0gEaq7zNxUuYFQSI8=;
        b=iHtRY6FgBvq/FXYCF2E3DYnfKWgoQ4yBa52Il3ASk5ln7YJsqM2w1HCVP0Ct63QYlP
         iex9ORIUgbqaLM1pL8cvUmdSLqecEx+nsnUW/DKJ96/FiRlwrs+T2RiJ8Zy0sQBMG10w
         GGb95sFgPx+TT4+n32Iw8sDUGlAi3unOygiHVgGS8zNAda111VEy67HBsEKA9rZcdVoa
         xGXpWUUPmZiKI1c7FTbwPXY9W+/kyFhSB9nPEjvL6zkJr9+oUhAUFgnsD57W420uZ5bj
         jlz6sPa0Xkt5ugfy6JM3e2eiTRagDRlSoqHwShDf+wWgkMTIknmlVL9htEYDr5yqVw+d
         YDyg==
X-Gm-Message-State: AOAM531gGdrHTNmvrz3g3xTin4gG6iDg0utGLKI3XpHCToXUTB88hP/s
        DH0LakCTFr5zCppzzVQFxt98q+0GA2ngaeW9tt2YMVhHULNgMKifJREZa5ckU6s6ISS6P5MxPtZ
        idIQ1P2QIvqmYLBgJxtuD44CY
X-Received: by 2002:a1c:4944:: with SMTP id w65mr12628671wma.169.1596812798543;
        Fri, 07 Aug 2020 08:06:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzz3bB8s79VoyLMKdQfTDQFEefXwjmaE+HQ1FHOTgL6uERRqtI+zyNDHX21bOJoliJQoT+/NQ==
X-Received: by 2002:a1c:4944:: with SMTP id w65mr12628654wma.169.1596812798313;
        Fri, 07 Aug 2020 08:06:38 -0700 (PDT)
Received: from localhost.localdomain ([151.29.36.84])
        by smtp.gmail.com with ESMTPSA id l1sm11111868wrb.12.2020.08.07.08.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 08:06:37 -0700 (PDT)
Date:   Fri, 7 Aug 2020 17:06:35 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org
Cc:     luca abeni <luca.abeni@santannapisa.it>, mingo@redhat.com,
        rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com,
        dietmar.eggemann@arm.com, linux-rt-users@vger.kernel.org,
        mtosatti@redhat.com, williams@redhat.com,
        valentin.schneider@arm.com
Subject: Re: [RFC PATCH v2 6/6] sched/fair: Implement starvation monitor
Message-ID: <20200807150635.GU42956@localhost.localdomain>
References: <20200807095051.385985-1-juri.lelli@redhat.com>
 <20200807095604.GO42956@localhost.localdomain>
 <20200807152832.591f462e@nowhere>
 <20200807134353.GR42956@localhost.localdomain>
 <20200807141346.GL2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807141346.GL2674@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/20 16:13, peterz@infradead.org wrote:
> On Fri, Aug 07, 2020 at 03:43:53PM +0200, Juri Lelli wrote:
> 
> > Right, but I fear we won't be able to keep current behavior for wakeups:
> > RT with highest prio always gets scheduled right away?
> 
> If you consider RT throttling, that's already not the case. We can
> consider this fair server to be just another way to implement that.
> 
> At some point, we'll have have to preempt higher priority tasks, that's
> the entire point of the thing after all.
> 

Ah, indeed. But I was thinking we might try to do a little "better" wrt
to RT Throttling while we are at it. :-)

This proposal has the potential to be more flexible and to kick in only
when really needed.

