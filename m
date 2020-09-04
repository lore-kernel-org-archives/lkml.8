Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B25C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 269F0206D4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbgIDMKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 08:10:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47732 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729297AbgIDMKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 08:10:38 -0400
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-Cn97xyOrOra3qYujChnSCg-1; Fri, 04 Sep 2020 08:10:36 -0400
X-MC-Unique: Cn97xyOrOra3qYujChnSCg-1
Received: by mail-qv1-f72.google.com with SMTP id y2so3700206qvs.14
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 05:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yHX2Sa8QO/EKwhwtG2EiPez2l3fHMgkqZKzE7jlZ7kg=;
        b=h5sd2eokhxd0oPatl0WD5ezaZ+j1d+m2kfhV7E8N2igXf0CesLY0H56i7p1ZM0Su6c
         geCh0YOpOJqDT6IO5JJa0DpLptWntF0OsRPhskg8KL1sbAfduF9W+B7oZDUV/Uq3zrZ0
         7h2N4dHHe2yeoZfczU/j/EegqMCzs1iSgDYCdeTT2+IrjybwOlf/iCsVcoAPCvoJAxiP
         FDZFpwYeYyaAUdl6uqqtbbLOnPZtKeqNyRjrKNnKRb0w13xEes6WiqPYndS2ZelaHrDI
         hYjtYg2JfoQm4WzY/bWklfXLVQG9+8wUrTwpoBEcCzHH2xNn2aZ/YsRVrYNly8iSP3ur
         6xuw==
X-Gm-Message-State: AOAM531+fFOnQrzxbbqRundY8dmpH2KBLKPYpWcPM5BIXjioj1ZKdD7C
        pxIu8MgBkiLdt3xOenlpxxr82sDLQM+pjdsC12AQSVfbSWZCd3fgGOTUn5KFXyYBktWnD2TWDWY
        P951aqzLuywlgebqPEQpF7rlh
X-Received: by 2002:ac8:1c16:: with SMTP id a22mr870600qtk.85.1599221435766;
        Fri, 04 Sep 2020 05:10:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQ/ToKGjfWPPvMX480i/fWT9ELVvA3RV+f3pJwGlkpeuHNyi37ymapPwBuVqsbZR8eokPQJw==
X-Received: by 2002:ac8:1c16:: with SMTP id a22mr870588qtk.85.1599221435591;
        Fri, 04 Sep 2020 05:10:35 -0700 (PDT)
Received: from x1.bristot.me (host-79-46-196-168.retail.telecomitalia.it. [79.46.196.168])
        by smtp.gmail.com with ESMTPSA id z37sm4509939qtz.67.2020.09.04.05.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 05:10:34 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Add myself as SCHED_DEADLINE reviewer
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
References: <4476a6da70949913a59dab9aacfbd12162c1fbd7.1599146667.git.bristot@redhat.com>
 <20200904095316.GR16601@localhost.localdomain>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <f117f3fe-426a-d715-70e4-39480e32ab60@redhat.com>
Date:   Fri, 4 Sep 2020 14:10:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904095316.GR16601@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/20 11:53 AM, Juri Lelli wrote:
> Thanks for the help Daniel!

My pleasure!

Thanks, Juri!
-- Daniel

