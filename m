Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0B1C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF7B720704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G4PCXCZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387755AbgAXOhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:37:15 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35988 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387676AbgAXOhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:37:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so1925289wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 06:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dzsZn5YGBm3wUhQPoMDUJ14zEU+MEc78x4rzaBDLSP0=;
        b=G4PCXCZvqK2HNyrqpe/9EKycb+jQXw97AZkRxWS9FasZLV3pYn+fkJ1xa1QmczUANh
         PZQWXmEaQFOnW9EpzrRP/J7zOtCN7iy2MIdoGWSpUPdIoxynMQ3KWZh6W9fxM1w55urS
         oCRqjJmrd9DrJRcfO1teS8g8zNr/5XJJycB8t40LS4sHy9sVgls/wyDfKwVPK8sq4PbD
         Z/n+2MMHuoCSzBI6hRHHirCQyy33Axe6x/gM7tn+Q96IKsdn7lOSybmec5hqZ29PRzSt
         J4J3bpoBYjTnNWrT9kMH6N08+3+irqZ547Dx1GLy99S0ZVBl7v4cdRzBAvCaZYbKTJC6
         NasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dzsZn5YGBm3wUhQPoMDUJ14zEU+MEc78x4rzaBDLSP0=;
        b=IQ/CRyflM3WGmsrPFn0+BDO6trCfyLAdWhXBEjZDn+QRebXreCpq2r4yeyMgFA30XE
         t3EtSqmdl0DqUoeV7vZsMroeOyKlYW8P3qjKzXVWaExd4oqQveHakKhvYlxjc2xahBwl
         AC1NIjca146wJcQA6/Y1Tjk1SQpz0SPonwxYTyyYELbVuhVlc3lanKwxv1PHcnYhsJE3
         yHWxVqVORJg9kaQgKcSUdxX6y/8qWREtqEXrW42cKPJ3JRwOjJy5YCt7ixCYQ1//WzVr
         Yt8uC6jFPipn0CcnvI6cSwRsLIpGh2/KHutntV0JJBuenXcTd4i2FgUrwPQtYCHa2yKZ
         FHMg==
X-Gm-Message-State: APjAAAUpCdWUYsbadK6HEubMl9cqD3QWbj2J4/PQfzlU11OlCVhwFLok
        WGARNsvr1jF01Cu1mCyme3cPe7oV9UrwTQ==
X-Google-Smtp-Source: APXvYqyMVfaMhToiGNn5b34BkYqDXlqLtMg4JBeFdVJpPM+zLlKRZ/0/+kA99MsGFZbIep1CF9uRPA==
X-Received: by 2002:a1c:9602:: with SMTP id y2mr3569784wmd.23.1579876628063;
        Fri, 24 Jan 2020 06:37:08 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id s19sm6831173wmj.33.2020.01.24.06.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:37:07 -0800 (PST)
Date:   Fri, 24 Jan 2020 14:37:04 +0000
From:   Quentin Perret <qperret@google.com>
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v4 3/6] sched/cpufreq: Hook em_pd_get_higher_power()
 into get_next_freq()
Message-ID: <20200124143704.GA215244@google.com>
References: <20200122173538.1142069-1-douglas.raillard@arm.com>
 <20200122173538.1142069-4-douglas.raillard@arm.com>
 <20200123161644.GA144523@google.com>
 <5a2af4e7-f9eb-4f23-908a-fab2c7395a99@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a2af4e7-f9eb-4f23-908a-fab2c7395a99@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 Jan 2020 at 17:52:53 (+0000), Douglas Raillard wrote:
> We can't really move the call to em_pd_get_higher_freq() into
> cpufreq_driver_resolve_freq() since that's a schedutil-specific feature,
> and we would loose the !sg_policy->need_freq_update optimization.

Depends how you do it. You could add a new method to cpufreq_policy that
is defined only for sugov or something along those lines. And you'd call
that instead of cpufreq_frequency_table_target() when that makes sense.

> Maybe we can add a flag to cpufreq_driver_resolve_freq() that promises
> that the frequency is already a valid one. We have to be careful though,
> since a number of things can make that untrue:
>  - em_pd_get_higher_freq() will return the passed freq verbatim if it's
> higher than the max freq, so em_pd_get_higher_freq() will have to set
> the flag itself in case that logic changes.
>  - policy limits can change the value
>  - future things could tinker with the freq and forget to reset the flag.
> 
> If you think it's worth it I can make these changes.

The thing is, not only with the current patch we end up iterating the
frequencies twice for nothing, but also I think it'd be interesting to
use the EM for consistency with EAS. It'd be nice to use the same data
structure for the predictions we do in compute_energy() and for the
actual request.

Thoughts ?

Quentin
