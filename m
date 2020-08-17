Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B8AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F144420578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CgyWaklZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbgHQS4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:56:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21532 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731516AbgHQS42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 14:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597690585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P+SWVW+pjg81S9WWqotQ3smvkOJqzR+CExLaQMZK0Pw=;
        b=CgyWaklZe6AsBRIFWF/a9yoBbRsG6/1Bpj3dShckOTgWs+/SBRkLuOP2cxzNeRrq4KwHio
        i3U+ayLUSAwP5lhLP3LJOf6mnCbzlJN9bSmeSP+Bcp2NcJCnK1f53N4hVxgelb1UFWq9HJ
        Q2Zkt8WYltes/XUGNJL7ur+/u/MwJ/k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-lcST15SbNZKSqziC_7eAEA-1; Mon, 17 Aug 2020 14:56:23 -0400
X-MC-Unique: lcST15SbNZKSqziC_7eAEA-1
Received: by mail-wr1-f71.google.com with SMTP id t12so7415826wrp.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 11:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P+SWVW+pjg81S9WWqotQ3smvkOJqzR+CExLaQMZK0Pw=;
        b=HfCeUKEUiOv7nTH+FtVEVWtQ2OIUOd8kQn/LFCjBS1QlGzeo834KEADtkz5stQaaLf
         UfXWU9/5V/F3Y55m7xB83ZLHEaO+dGuk0ezXljoVZQEosDTjC54CH+3LT+ReT739vlYB
         T/d1eKIemJ5Mmu3Gwl0edcHeE4GrBlI/qg8j4D/VfYq+mBAjc09/k10eSfvTV3B0cE0P
         RUV4ssheOA/zT9TkPnc0+UpY+C2hZGqfNVlnxOtlVwCpb+bW7KfwM50y5C/1zAXY3xay
         9qlklhg6P9c7bhPkUMDyrCTs5KChnPEqnreeLr97z5VLO4Il/rvDXBdkrYXrbLdAzXdK
         4MFQ==
X-Gm-Message-State: AOAM531SMKP+RarGATtKXLlwH34DZGM9ucHWFPhx4h3rUDaoWvvvMbPX
        96GY7GpuI4G0/7sEo+LnJJdEgWRsqPHRIwPv1d8VY5RwatJazlTtBmyRR8oDwhvMtIphkc6ouO7
        k6SfrdShe/DJrqUQBXGIZ4+ah
X-Received: by 2002:adf:c64d:: with SMTP id u13mr17359823wrg.114.1597690582795;
        Mon, 17 Aug 2020 11:56:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGUy0KGjJ9kvMSrkyDxzgiWSlEfsMpPG6GXCMoIUDIQxE8HoMxA0+bqfacNF2voEz97rN3kA==
X-Received: by 2002:adf:c64d:: with SMTP id u13mr17359814wrg.114.1597690582593;
        Mon, 17 Aug 2020 11:56:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0d1:fc42:c610:f977? ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
        by smtp.gmail.com with ESMTPSA id d21sm31344948wmd.41.2020.08.17.11.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 11:56:21 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: fix access code passed to gva_to_gpa
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20200817180042.32264-1-pbonzini@redhat.com>
 <20200817184226.GJ22407@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2f1dd99d-f19d-fec2-bbe1-53b8861bfe9e@redhat.com>
Date:   Mon, 17 Aug 2020 20:56:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200817184226.GJ22407@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/20 20:42, Sean Christopherson wrote:
> 
> Don't suppose you'd be in the mood to kill the bare 'unsigned'?
> 
>   WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

u32 is even better.

> Alternatively, what about capturing the result in a new variable (instead of
> defining the mask) to make the wrap suck less (or just overflow like the
> current code), e.g.:
> 
>         u32 access = error_code &
>                      (PFERR_WRITE_MASK | PFERR_FETCH_MASK | PFERR_USER_MASK);
> 
>         if (!(error_code & PFERR_PRESENT_MASK) ||
>             vcpu->arch.walk_mmu->gva_to_gpa(vcpu, gva, access, &fault) != UNMAPPED_GVA) {

Sure, that's better.

Paolo

