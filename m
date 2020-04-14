Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EECCC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7509206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LzQG83K8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502228AbgDNMpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2502239AbgDNMpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:45:09 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04DDC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 05:45:08 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k11so13536157wrp.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 05:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uTBz1rbbgL6zk5oCQB/8KyAsL8UQNJVuo57K9Wkbz4A=;
        b=LzQG83K8MK4ps2g8QyylKFIm0zrpVxZ0gGgLuWPGJNzanHJLR6yhAvZ3af7IPdx3iU
         Ist9HfBU/+k/yAfW72b4eSM5iw04G5QVw6ajNtZGE/m4JmTfSMEdGRLwlmyej9M+k/o+
         kZQQJU8o1ugvCOocCHNWa+s73R667pZPNhWF3RNvkGe18BQLsCVDWey9wiMoNoU/bnpG
         kBiPnLJYOcrp2uHgXa0Fauxa7pJXA+afj8739cXgkktdzL2k41uOyE6lv85B4t/MsMrv
         0q7XdUwn9y+pRc+Htso4Ob43Mfs0jbpg0fLZZL5xjYZ8kUiqz8U6RpXAa1wJwb4wAUkA
         pHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uTBz1rbbgL6zk5oCQB/8KyAsL8UQNJVuo57K9Wkbz4A=;
        b=i7/Jl4WpIZt3EcukHhdxlHbgubgub0++iFGRiewHQzQzG+xABsdcLONRAiGjqASCrL
         x+BfB2TIBhG7b5r0/O8wM2icQ97DnQwnWqmTXMk0vL5GTFDqDysXbRzdxWKEeCqoxZpO
         Hj7OdOnqA8iWLr9575fs9CE5uHnHz4AmhDRG4CjKeMn96C6wzeLZ0VFVRv3G5uwteYua
         l490zuqO8tUNIUy1abZiXoTG+J+snRLCf+qzFT+NYeZh0gurM8ad/23kaF16s14RwFQ8
         uvOHvZurZc65NSeFX0+luU9VJq2NtgCXSIHkfAxAqt4N344VhmUgNfdNFA4wbPFP14lY
         U31Q==
X-Gm-Message-State: AGi0PubqmYEbEsl3qRAASDkpqoqJvKtMAFbw3FAHDg8/VNR7HgVpFTB0
        8r3l3AQSOd5/7VcbkxXE7bGb/w==
X-Google-Smtp-Source: APiQypKRb+CFYDfsTFYIe7zfSiE/zNZrGOikaKbMQD6kDitZTlDMmkPQlX5DYuFnR8Zd2CVNocUpww==
X-Received: by 2002:a5d:4843:: with SMTP id n3mr23406079wrs.7.1586868307403;
        Tue, 14 Apr 2020 05:45:07 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id o9sm18957634wru.29.2020.04.14.05.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 05:45:06 -0700 (PDT)
Date:   Tue, 14 Apr 2020 13:45:03 +0100
From:   Quentin Perret <qperret@google.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] sched/topology: Store root domain CPU capacity sum
Message-ID: <20200414124503.GA236568@google.com>
References: <20200408095012.3819-1-dietmar.eggemann@arm.com>
 <20200408095012.3819-2-dietmar.eggemann@arm.com>
 <CAKfTPtC4_+dTddLdoFMdzUvsXwWyi3bUOXcg9kstC8RzZS_a+A@mail.gmail.com>
 <42cc3878-4c57-96ba-3ebd-1b4d4ef87fae@arm.com>
 <CAKfTPtDS_qwPH+TwoFWPz6QRzG1N=t46ZvGN=w6zbOtnGAdOeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDS_qwPH+TwoFWPz6QRzG1N=t46ZvGN=w6zbOtnGAdOeQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 Apr 2020 at 19:03:57 (+0200), Vincent Guittot wrote:
> Or we can do the opposite and only use capacity_orig_of()/rq->cpu_capacity_orig.
> 
> Is there a case where the max cpu capacity changes over time ? So I
> would prefer to use cpu_capacity_orig which is a field of scheduler
> instead of always calling an external arch specific function

Note however that using arch_scale_cpu_capacity() would be more
efficient, especially on non-arm/arm64 systems where it is a
compile-time constant.

It's probably a matter of personal taste, but I find rq->cpu_capacity_orig
superfluous. It wastes space without actually giving you anything no?
Anybody remembers why it was introduced in the first place?

Thanks,
Quentin
