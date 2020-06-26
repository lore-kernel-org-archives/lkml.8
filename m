Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E96C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 02:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE8922070A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 02:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H2TZ2Zav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgFZCcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 22:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728105AbgFZCcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 22:32:25 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2730DC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 19:32:25 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bh7so3696328plb.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 19:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sMIkTEY7xPHCqbn5JKjvRxEVOX+Rdd4R46yFsFdge5A=;
        b=H2TZ2Zavm132TIF8kv/1qMkgUjcXDU9hqjRnSmHgwOjAq7BbOdbWyxlLmnF/CcbuSZ
         XE4B1hNibOuLzFzrwkaqBgaIK6yEhnbL6Xv9XoGXyOpjO3KA71h82XQUVVMR/80L1/I+
         X7wY2+/c70DpnE6YMj6U1kekSqKVpAl0+1qoMR3IQ0tQfo5wD5mRiNdpeIyqzLAi6t0V
         kqrWt/BfTz8yvRfXjI/l0ApUnsM/mAyoiAiCvJ+IV5hJPcMTOl7hQfzKidM/tVR57jwT
         YWZyWkaoROvm2JByKSqT2sww40xFchead619IWL70+SYCcFBP4iyYE3n8t12qODhxE1t
         watQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sMIkTEY7xPHCqbn5JKjvRxEVOX+Rdd4R46yFsFdge5A=;
        b=Uge63FD3zwAN62IE3p9x7GG5xQjz1IPtyULnEWDyjdVJJgFoOMzMmVDj9M2WMtfPli
         fJcaFa92rZGtHLcOQJbbhsf4Rqa2n9VbBHcPvtqp5Yd9On0LLIQ817DLhev7F+uDoMgK
         v2ctE/z58hoTgD9cHx5TH0mDZwV9VjRm94FwRYb4ANifrtEbAZ/mch/dZVkqUA5RU50f
         G2yf4Go6yaqtYSrF6LwWOtqw7f7SBiFXpetIBV1nFvKw6214rVJXZ7PBtgHp6rfcXbU6
         moPHoDgSma/fVBB/mc2nPNuHqRhVYWHX4BQtEc2gFdl9wNv6Be7j0sgIecc8YtDMABtZ
         mcTQ==
X-Gm-Message-State: AOAM533ljP8obPFelfkxavL6JzfBOgnmYMsscZdFDpUilVcq2a3BSub7
        hm/9wWxC5ORK2MpkGw8UGKgQrw==
X-Google-Smtp-Source: ABdhPJzrj+FEH83auCDK23gzg/oJyu7O4OeQbSNw4yaoRmnsjr7tx6t6EiJ7qvLKnaR5ZvdTFvKQlg==
X-Received: by 2002:a17:902:ab8d:: with SMTP id f13mr674057plr.119.1593138744407;
        Thu, 25 Jun 2020 19:32:24 -0700 (PDT)
Received: from localhost ([122.172.127.76])
        by smtp.gmail.com with ESMTPSA id gq13sm6079747pjb.7.2020.06.25.19.32.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2020 19:32:23 -0700 (PDT)
Date:   Fri, 26 Jun 2020 08:02:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wei Wang <wvw@google.com>
Cc:     Wei Wang <wei.vince.wang@gmail.com>, dsmythies@telus.net,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: schedutil: force frequency update when limits
 change
Message-ID: <20200626023219.wvhzomwzlw24bzrv@vireshk-i7>
References: <20200625064614.101183-1-wvw@google.com>
 <20200625102305.gu3xo4ovcqyd35vd@vireshk-i7>
 <CAGXk5yrA=oXZs9KAaELsO7+ex7xCggEwdWSC_KXrUWQnvKEpWQ@mail.gmail.com>
 <20200626021428.tnecyy3wt42slvik@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626021428.tnecyy3wt42slvik@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-06-20, 07:44, Viresh Kumar wrote:
> On 25-06-20, 13:47, Wei Wang wrote:
> > On Thu, Jun 25, 2020 at 3:23 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > I am sorry but I am not fully sure of what the problem is. Can you
> > > describe that by giving an example with some random frequency, and
> > > tell the expected and actual behavior ?
> > >
> > The problem is sugov thought next_freq already updated (but actually
> > skipped by the rate limit thing) and all following updates will be
> > skipped.

The rate-limiting thing is specific to android and not present in
mainline. Even in android I see next_freq getting updated only after
rate-limiting is verified.

I think you maybe trying to fix an android only problem in mainline,
which may not be required at all. And I am not sure if Android has a
problem as well :)

> I am sorry, can you please give a detailed example with existing
> frequency and limits, then the limits changed to new values, then what
> exactly happens ?
> 
> > Actually this is specifically for Android common kernel 4.19's issue
> > which has sugov_up_down_rate_limit in sugov_update_next_freq, let's
> > continue discussion there.
> 
> If it is a mainline problem, we will surely get it fixed here. Just
> that I am not able to understand the problem yet. Sorry about that.

-- 
viresh
