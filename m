Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D37C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 13:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7074822CA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 13:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KnYgm9Uc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgHGNoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 09:44:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52147 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726205AbgHGNoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 09:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596807839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E3ELIvI6TpDrr/hDE1zUqdW6bJnAxebAFwCmn25rdY8=;
        b=KnYgm9UcTkgv2XGf+6BrtGj38z7/MNfKECoeqjE9TGyaGZCTfITCZU/efvh7Jn5p4Yyvz5
        Nc/cogAQuXCF808or5mQHjY2BNvLw8DXHoBDnnionx1VIZdfRGg1Z8d2UBhaIy3ynFg2QN
        zWtgbqpqfDMXuJBkW129bLIi464ZWmg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-e8jqETsdNDONK89N4iSQmA-1; Fri, 07 Aug 2020 09:43:57 -0400
X-MC-Unique: e8jqETsdNDONK89N4iSQmA-1
Received: by mail-wr1-f72.google.com with SMTP id f14so763899wrm.22
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 06:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E3ELIvI6TpDrr/hDE1zUqdW6bJnAxebAFwCmn25rdY8=;
        b=pJV3o23N8N+szIeDt2h4mo1XXPCnGwxlnl++xxD9zLR/OqavJPJ6fsvTKSqn44/B6w
         0H3IHyA/7ahfdV3d5KsnYmhuCar0knrPrzHpiEvNLywQ6pNPHmgKo+i0Wrkq+TUxJx36
         ESe3wsqpzCjNuZ+QnZbFB+Gh3j2sz4AO0fd2D0Sqd3GdcoQRtiJZ6k9h2phq6Erds9uW
         fjcJXvIF3SJbCWabNyqParTuY+CltD/pjag7vmNszScLyS0iC5ACd5NwewIrkhZwOa1W
         mdPUJF4t2zpk0UGtRDwfidMfjxTBdl8Ax9nzBUvGXEHxauI8wn2l2ACIphbfAc2+13Qw
         lW3w==
X-Gm-Message-State: AOAM533Qmid+YEnbemH9FO7FAdz+EN7Z5kcqktqeFGef4Z4mVk0cbyHH
        CQg7IzhStUUwVVUVCN9fPp8oOO0qT8iCnJ16eMSLrFx4Xc4tC+INjtUuPc0jr8oDznvlpN4LfGM
        wZApQxmxu9fXv71d4/msaWfjC
X-Received: by 2002:a5d:4ad1:: with SMTP id y17mr13061439wrs.132.1596807836356;
        Fri, 07 Aug 2020 06:43:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5UZXlHxGMHcXSoixKUQYiEtbcK+V2fCweYqEOIb9g4sqOfVUxrdVbtco9HHswxN7U0ixwBw==
X-Received: by 2002:a5d:4ad1:: with SMTP id y17mr13061415wrs.132.1596807836136;
        Fri, 07 Aug 2020 06:43:56 -0700 (PDT)
Received: from localhost.localdomain ([151.29.36.84])
        by smtp.gmail.com with ESMTPSA id j2sm11156302wrp.46.2020.08.07.06.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 06:43:55 -0700 (PDT)
Date:   Fri, 7 Aug 2020 15:43:53 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, dietmar.eggemann@arm.com,
        linux-rt-users@vger.kernel.org, mtosatti@redhat.com,
        williams@redhat.com, valentin.schneider@arm.com
Subject: Re: [RFC PATCH v2 6/6] sched/fair: Implement starvation monitor
Message-ID: <20200807134353.GR42956@localhost.localdomain>
References: <20200807095051.385985-1-juri.lelli@redhat.com>
 <20200807095604.GO42956@localhost.localdomain>
 <20200807152832.591f462e@nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807152832.591f462e@nowhere>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/20 15:28, luca abeni wrote:
> Hi Juri,
> 
> On Fri, 7 Aug 2020 11:56:04 +0200
> Juri Lelli <juri.lelli@redhat.com> wrote:
> 
> > Starting deadline server for lower priority classes right away when
> > first task is enqueued might break guarantees
> 
> Which guarantees are you thinking about, here? Response times of fixed
> priority tasks?

Response time, but also wakeup latency (which, for better or worse, is
another important metric).

> If fixed priority tasks are also scheduled through deadline servers,
> then you can provide response-time guarantees to them even when
> lower-priority/non-real-time tasks are scheduled through deadline
> servers.

Right, but I fear we won't be able to keep current behavior for wakeups:
RT with highest prio always gets scheduled right away?

