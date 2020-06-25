Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4FDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B275E207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HG1in60a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406301AbgFYSo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 14:44:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38353 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406166AbgFYSoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 14:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593110664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bz0DcoUt/GEkUm1L3M53l7xA0v5o3+zCrwD/K63P38U=;
        b=HG1in60aaUSr+Vbr9DVPtbzc0H1AwYyRRVPv8UFT+vvVTSxJT+1SoPUVJaFEz3ULuZqgQL
        kB1CnF6ZxvLIm2Ep8mCYTev8Fe1KJzaQn7H7jnWwItB0/T5fH9UJMTr4uK7GEyrGN8OKgP
        9zl7fPrpyzFC7gqQEZIjADI2NzOcfIU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-r0XMf83yNgys7QV88A5ixg-1; Thu, 25 Jun 2020 14:44:22 -0400
X-MC-Unique: r0XMf83yNgys7QV88A5ixg-1
Received: by mail-wr1-f69.google.com with SMTP id p10so7675164wrn.19
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 11:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bz0DcoUt/GEkUm1L3M53l7xA0v5o3+zCrwD/K63P38U=;
        b=qKpdEkgvXXJF+BmfZqZjsEQiGmyVpCco2M+pP1R+J5MyH3hwrie121O2VIOvu0wyfo
         7zTwPhhL41aossY3dbefsE9ryDLwsd3YSXAjDa1z23AYnLNGzg5aRxJtIs/IUU07hIx8
         QPAEBh5c+RCi7etPDDcJx5dKi2ABE61CLDjOGwLl5QNTyn8bbPsMG/VY8zz7Ka4lTOh3
         O1eQU+qDobR5Hp/4igC1FfyDHygRItD9CrH53eipVw+y8H9R3e9UPndcxLTE3vFQ92c0
         9nnaoME5nGYWyLuOc5R3xouKznXeIAPxew37FxE/d0xC+29kCfN+USoMEgLdu+VxoG5q
         YIuA==
X-Gm-Message-State: AOAM533ltpqYw2c0Thc3ig5I43PeVOxMtXDmM3/WMFj2czs+FPyzEcyb
        ThN5VmF/1dNt4HSizrFuTOvfYbhWesdGEj3NALc3H73KYQWmx8U2t5bX6rlI+2jUyx2zgIj09Ov
        YR5mszi8vZiXiJisf+FmIHmXB
X-Received: by 2002:adf:ea06:: with SMTP id q6mr32695720wrm.69.1593110660855;
        Thu, 25 Jun 2020 11:44:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrgg/PEY410CP4hdZskO+84trrFvrrZMUq4hsvdqChoqu2wlgLOz4Hq4TsNc62TvpFAkj7ZA==
X-Received: by 2002:adf:ea06:: with SMTP id q6mr32695701wrm.69.1593110660616;
        Thu, 25 Jun 2020 11:44:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:91d0:a5f0:9f34:4d80? ([2001:b07:6468:f312:91d0:a5f0:9f34:4d80])
        by smtp.gmail.com with ESMTPSA id c17sm11175701wmd.10.2020.06.25.11.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 11:44:19 -0700 (PDT)
Subject: Re: [PATCH 1/2] KVM: X86: Move ignore_msrs handling upper the stack
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20200622220442.21998-1-peterx@redhat.com>
 <20200622220442.21998-2-peterx@redhat.com>
 <20200625061544.GC2141@linux.intel.com>
 <1cebc562-89e9-3806-bb3c-771946fc64f3@redhat.com>
 <20200625162540.GC3437@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <df859fb0-a665-a82a-0cf1-8db95179cb74@redhat.com>
Date:   Thu, 25 Jun 2020 20:44:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200625162540.GC3437@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/20 18:25, Sean Christopherson wrote:
> I get the "what" of the change, and even the "why" to some extent, but I
> dislike the idea of supporting/encouraging blind reads/writes to MSRs.
> Blind writes are just asking for problems, and suppressing warnings on reads
> is almost guaranteed to be suppressing a KVM bug.

Right, that's why this patch does not just suppress warnings: it adds a
different return value to detect the case.

> TSC_CTRL aside, if we insist on pointing a gun at our foot at some point,
> this should be a dedicated flavor of MSR access, e.g. msr_data.kvm_initiated,
> so that it at least requires intentionally loading the gun.

With this patch, __kvm_get_msr does not know about ignore_msrs at all,
that seems to be strictly an improvement; do you agree with that?  What
would you think about adding warn_unused_result to __kvm_get_msr?

Paolo

