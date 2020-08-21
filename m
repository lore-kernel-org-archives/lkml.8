Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55548C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EB872087D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JOi1CDS9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgHUJFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 05:05:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20338 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725965AbgHUJFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 05:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598000729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a2gI9Nvwoet4V714YdL5zCr/MsTRTl+MoaZaV7VgHD8=;
        b=JOi1CDS9CY8VAci2TMLmtUyWLaaPZIkpz9cT1yT78BdjoynH+WhfTmZQGPac3RgJbmVnGS
        z0jLY0upRatcUtUWDD24IQeWM1nK/19+MxuCiLdQxIRopKxXYYpUQz2Rawnrl3Ub1JdGoJ
        7DzZ+oCOS5wxnTZOqBHaGT83cVYkfhI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-az-GgATLPgiL1O5fTX61kA-1; Fri, 21 Aug 2020 05:05:27 -0400
X-MC-Unique: az-GgATLPgiL1O5fTX61kA-1
Received: by mail-wr1-f70.google.com with SMTP id t3so350031wrr.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 02:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a2gI9Nvwoet4V714YdL5zCr/MsTRTl+MoaZaV7VgHD8=;
        b=gQ1HliPRSMTf+uuPR4oa+oHGvXxKtinZ5GF3vNXpBaEnXn7uxZHdLFWY6psLrnNKVh
         hxHoWYljiuNqa3Be3uEeAbrSP+M54wlg4G43qby0MRexzqUrSkYF1cIbVFFmDzMcYYwy
         kxl/0I4M6qeyjBIYdPejXtTiKk7u524QjYpO6uhwgIxvym2Vz9hH8Uy0pMAkd7GbFGJz
         a5nmAusLVjs5AjBi8wphlQmtixIlUZAVb+qB+I4XuAkVcJ+RaPwKAOy4KLGl13p0gQ3f
         Ux73Bxc7GCjUYznYJIldf2fBCqUZ4pNuEEdKkc4ylRvniywlF9nR8b2e3zbMJZ3h7GTm
         7YsQ==
X-Gm-Message-State: AOAM5308IGJpoS7ELQpEw4F3518rSh7HQ3kshFRd0676PEN2gdEGxla4
        88kMOF6IaigSR1pj7h4Icaq5zq2kbYfVxVLUBgFC1GeAdiXJRUo8FOibsbIz90GSyD60+uovVxd
        o6S/Q5IP4/tiWeGW1FMvCx3zd
X-Received: by 2002:adf:e550:: with SMTP id z16mr1804422wrm.329.1598000726214;
        Fri, 21 Aug 2020 02:05:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtSmPRNO2v5XZHoE+3AgJHTVtEt5bRlbkV6IO+RvvNhGsNxv9/jNAWd+Cs2dM5XrePLC4Q+A==
X-Received: by 2002:adf:e550:: with SMTP id z16mr1804395wrm.329.1598000725944;
        Fri, 21 Aug 2020 02:05:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745? ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
        by smtp.gmail.com with ESMTPSA id d7sm3123948wra.29.2020.08.21.02.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 02:05:25 -0700 (PDT)
Subject: Re: [PATCH] x86/entry/64: Disallow RDPID in paranoid entry if KVM is
 enabled
To:     Borislav Petkov <bp@alien8.de>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Chang Seok Bae <chang.seok.bae@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20200821025050.32573-1-sean.j.christopherson@intel.com>
 <20200821074743.GB12181@zn.tnic>
 <3eb94913-662d-5423-21b1-eaf75635142a@redhat.com>
 <20200821081633.GD12181@zn.tnic>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3b4ba9e9-dbf6-a094-0684-e68248050758@redhat.com>
Date:   Fri, 21 Aug 2020 11:05:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200821081633.GD12181@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/20 10:16, Borislav Petkov wrote:
> On Fri, Aug 21, 2020 at 10:09:01AM +0200, Paolo Bonzini wrote:
>> One more MSR *is* a big deal: KVM's vmentry+vmexit cost is around 1000
>> cycles, adding 100 clock cycles for 2 WRMSRs is a 10% increase.
> 
> The kernel uses TSC_AUX so we can't reserve it to KVM either.

KVM only uses TSC_AUX while in kernel space, because the kernel hadn't
used it until now.  That's for a good reason:

* if possible, __this_cpu_read(cpu_number) is always faster.

* The kernel can just block preemption at its will and has no need for
the atomic rdtsc+vgetcpu provided by RDTSCP.

So far, the kernel had always used LSL instead of RDPID when
__this_cpu_read was not available.  In one place, RDTSCP is used as an
ordered rdtsc but it discards the TSC_AUX value.  RDPID is also used in
the vDSO but it isn't kernel space.

Hence the assumption that KVM makes (and has made ever since TSC_AUX was
introduced.  What is the difference in speed between LSL and RDPID?  I
don't have a machine that has RDPID to test it, unfortunately.

Paolo

