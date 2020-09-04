Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1383EC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9C0620791
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbgIDMJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 08:09:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27570 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729930AbgIDMJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 08:09:31 -0400
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-aE5cYYTrP5-UYIoqWD1QDg-1; Fri, 04 Sep 2020 08:09:22 -0400
X-MC-Unique: aE5cYYTrP5-UYIoqWD1QDg-1
Received: by mail-qv1-f72.google.com with SMTP id y12so3682804qva.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 05:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w7W+brtj3uuGfVSYeQIJlID5MT03WDbwEzpyUVxsGTA=;
        b=lDWsefbtB2NUaaUShWlMSyoYV82e1wUpSAmcnDzODMohUoHbxTNWMsZrP5xK8+RzTy
         ehprvChKVPHkHBW19OAtLUrUNjlfpf1z7xBiGHQxzzbXj1dIRSYSOtIrDgzsvGhYTmwX
         FeMogob7Rb9nvjc/bR8r0/VHHyJJxNh6OaKlc0KQXNx7049zj0GrfC5mR+y6OTTWPCFu
         zmU1+NbOXtSbTy645XV6NBaC2T2Y3pp4rVzL9PescfFD4a6mf70lzRLPPSjFygwODfdi
         m7XZA9VJemZ1DugTDcFvhQ2DdRVoV/3js1IVqsM5PUjXu0L/9oE0I3VPwxLkyEavJj9I
         wx7g==
X-Gm-Message-State: AOAM530R2PyCRZQeBUPgeYhHpxosGFM7uXOw2THNRs45GwtpsDXeT0UG
        rpdWZrV2XSnkqUT3nnSV911nYaovyqAk6M2gL9CdilOQoGLlfICTDhZ5l3i/EvbQiJcMbNIcgF5
        g/gwXtVpA9ZxoYqHiCEt5DvUg
X-Received: by 2002:a05:620a:1266:: with SMTP id b6mr5130546qkl.371.1599221361256;
        Fri, 04 Sep 2020 05:09:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaOtdCCoazwafWAH5kyLIB9aNYeU2KWnD1aKhwTJuXh+DBp8KRLStyNlIPYzuBWSxQHIoy6A==
X-Received: by 2002:a05:620a:1266:: with SMTP id b6mr5130526qkl.371.1599221361018;
        Fri, 04 Sep 2020 05:09:21 -0700 (PDT)
Received: from x1.bristot.me (host-79-46-196-168.retail.telecomitalia.it. [79.46.196.168])
        by smtp.gmail.com with ESMTPSA id o7sm4275424qkd.64.2020.09.04.05.09.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 05:09:20 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Add myself as SCHED_DEADLINE reviewer
To:     peterz@infradead.org
Cc:     Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
References: <4476a6da70949913a59dab9aacfbd12162c1fbd7.1599146667.git.bristot@redhat.com>
 <20200904093943.GI1362448@hirez.programming.kicks-ass.net>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <51578858-6c92-87b5-aeb5-fc682273f4b8@redhat.com>
Date:   Fri, 4 Sep 2020 14:09:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904093943.GI1362448@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/20 11:39 AM, peterz@infradead.org wrote:
> Absolutely, great to have you looking over that!

Thanks Peter :-)

-- Daniel

