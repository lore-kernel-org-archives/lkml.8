Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4593AC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C432468E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dy70itIE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgCBIML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:12:11 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45800 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgCBIML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:12:11 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so5178966pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 00:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uiixe7VTNTZjkUXMFLMDS3Y2pxtxz+Vh1/ihMtzRMVI=;
        b=dy70itIEAmsCXfVzSU650FzvkKJIOE5y7NgZ20qW+FcP3TMQoXjNc4LKo1uoaGAjOG
         XQr00jxsE1FYlOikWvxQ+JdGKnZsY6Oe8nTptzDegixpcrCTQt8JVdZgWo1M4nIjvOm/
         1M5sNFKs5l2TFEc3D3vzGRFgXBCapHNzI4mRLN/rQHmOgTIDXx6rTxuOvhu3DE2ujvuQ
         5mMjG9xWRNFfo1NPFFelDNebQUJLc1TcDljcE+Cb7VbwsesYfMzipP1IszHEsj0WPYNo
         25FfPMb4quuCAB2u2oU8eDPLyyqjkZUopZZ3bu21vrad2b9H1+/4odT0geHvtywDaoxT
         CfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uiixe7VTNTZjkUXMFLMDS3Y2pxtxz+Vh1/ihMtzRMVI=;
        b=jJpzcO1DtO6g+40mwMVkAm4DUuF0uNKmk6h3Qb57K6vgST6hdswf32wyrYtB4Sj3J2
         6EyWe9D/mQ7Fw4YsUwOkJ1IBBwFNurzTB2nJ1ZQnG6OrThKXqNdrv0mCmWpgtxnc31qb
         9zOkyhYi4YDp/VvvOWptjlVrh/bGXM/8uTNRdHWBX2sD6XAuhF/Yhuo4yiGjx79qkwwm
         AIgk3/Y+vX433KV/MLBzVqOXxROitNRP6QgMkSkVLYmkvN2L/Ph7cO7eKb0uIExNs5DA
         jz9PYVorG2y+EuAYKLHj3h6I/9Rbmni+YhnRCyzq4c0vVqcfIWxRBChVwTSaTzRcR3sq
         i46A==
X-Gm-Message-State: APjAAAVnhOnl9HiMojYz77btsOZEN1vZmNPE9gtoLbeNYMOKg/jX/C+Q
        j/b9Ft5vo/b2u9KnYJmKV993CA==
X-Google-Smtp-Source: APXvYqwPqXg9y4z1RZRMwnewbFTvr4F0/qjs0khbEDYRPehQH4P/51Sz/t9mRLOPFtgea4hWxFraaA==
X-Received: by 2002:a63:4555:: with SMTP id u21mr18083511pgk.66.1583136730489;
        Mon, 02 Mar 2020 00:12:10 -0800 (PST)
Received: from localhost ([122.167.24.230])
        by smtp.gmail.com with ESMTPSA id x4sm15178437pgi.76.2020.03.02.00.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2020 00:12:09 -0800 (PST)
Date:   Mon, 2 Mar 2020 13:42:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] KVM: X86: Fix dereference null cpufreq policy
Message-ID: <20200302081207.3kogqwxbkujqgc7z@vireshk-i7>
References: <1583133336-7832-1-git-send-email-wanpengli@tencent.com>
 <ab51f6c9-a67d-0107-772a-7fe57a2319cf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab51f6c9-a67d-0107-772a-7fe57a2319cf@redhat.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-03-20, 08:55, Paolo Bonzini wrote:
> On 02/03/20 08:15, Wanpeng Li wrote:
> > From: Wanpeng Li <wanpengli@tencent.com>
> > 
> > cpufreq policy which is get by cpufreq_cpu_get() can be NULL if it is failure,
> > this patch takes care of it.
> > 
> > Fixes: aaec7c03de (KVM: x86: avoid useless copy of cpufreq policy)
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> 
> My bad, I checked kobject_put but didn't check that kobj is first in
> struct cpufreq_policy.
> 
> I think we should do this in cpufreq_cpu_put or, even better, move the
> kobject struct first in struct cpufreq_policy.  Rafael, Viresh, any
> objection?
> 
> Paolo
> 
> >  		policy = cpufreq_cpu_get(cpu);
> > -		if (policy && policy->cpuinfo.max_freq)
> > -			max_tsc_khz = policy->cpuinfo.max_freq;
> > +		if (policy) {
> > +			if (policy->cpuinfo.max_freq)
> > +				max_tsc_khz = policy->cpuinfo.max_freq;
> > +			cpufreq_cpu_put(policy);
> > +		}

I think this change makes sense and I am not sure why should we even
try to support cpufreq_cpu_put(NULL).

-- 
viresh
