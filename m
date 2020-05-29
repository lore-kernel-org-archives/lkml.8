Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6682AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4050C2077D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGgSVxCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgE2TCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 15:02:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34272 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727952AbgE2TCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 15:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590778967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wJMaCzfWpvw3lORFlgEXivBUbl9HW4vSaSwT9Obtnms=;
        b=FGgSVxCQKDlRbkG4jhfsi0O8XGCfSqh6ug1hjVEJ2+qNZtqCKXuY1zqjdc59l2Jjlha9e8
        JFavf3BV9A5qzXg5N46URfNIJ92RYm5rUFnRQsLPBBbLVLQtB9ZcQc9rMLyARNCiyYogue
        8e7vxJFYbfSVRl8fua7QhyNhAWt435o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-sL28ZZPtP_CqjeeB7nJDfw-1; Fri, 29 May 2020 15:02:41 -0400
X-MC-Unique: sL28ZZPtP_CqjeeB7nJDfw-1
Received: by mail-wr1-f71.google.com with SMTP id y7so1403812wrd.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wJMaCzfWpvw3lORFlgEXivBUbl9HW4vSaSwT9Obtnms=;
        b=O8NjvaoIBQUQZQtu4QO/OIpogxhsLxixxYuKdJsIdxoga2gPMNpqMJNaSEexiKzoDT
         HiuWA6YauuqrTxUQaRoqFSTclMuIxcBbrIRr8U+EqWgsWSUSxy7eDN5u5D3vSrWZnovN
         3wIJrfB9zSXnZHACb0ENydm3V9sQ8RdSvDQv3c9XW3S4VEf6N/08VZW0j0nU/PFcNAtY
         colF0Jl3CB2eSVncNXk9mt053rwn6n8OcSaIBOoOdxrky0soiIBOz2Dnvz8rRbqEQn1k
         LuA3zXGr/pNRC0EB5jMZCthVDRlU+KP/cjkx/1Pb3fPct7lRlmZRcDbKSvzmx7+lNfP5
         V+6g==
X-Gm-Message-State: AOAM533fmHpsBNZzEH97DGjeG4uCioxmjgaI0xXqheENFOw0gpRoffrJ
        mq6Q5gYWv3hOpFVvEhaMBBwGOXjD8Tm8Eeg0Vc3bc84xztS3kqqd0xdLpoWXmdZUanh80gGub9Q
        8PWA9L0NIZIPAsUgcAheEkGAt
X-Received: by 2002:a1c:2d14:: with SMTP id t20mr10121033wmt.28.1590778960678;
        Fri, 29 May 2020 12:02:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBYHA7k+z98Qk2WF3wdHLqhx+6XZ6IgNBwtrzlyMkD9FmEfDC9CoCtymAamfD32bH24wEoUQ==
X-Received: by 2002:a1c:2d14:: with SMTP id t20mr10121011wmt.28.1590778960374;
        Fri, 29 May 2020 12:02:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8? ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
        by smtp.gmail.com with ESMTPSA id l17sm452722wmi.3.2020.05.29.12.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 12:02:39 -0700 (PDT)
Subject: Re: [PATCH 10/30] KVM: nSVM: extract preparation of VMCB for nested
 run
To:     Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20200529153934.11694-1-pbonzini@redhat.com>
 <20200529153934.11694-11-pbonzini@redhat.com>
 <bf123ad6-3313-351c-a7b8-e55cefb53f63@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0f866ffb-625c-e577-bed2-c489aa42782c@redhat.com>
Date:   Fri, 29 May 2020 21:02:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <bf123ad6-3313-351c-a7b8-e55cefb53f63@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/20 20:27, Krish Sadhukhan wrote:
>>
>> +static void nested_prepare_vmcb_save(struct vcpu_svm *svm, struct
>> vmcb *nested_vmcb)
> 
> 
> Not a big deal, but I feel that it helps a lot in readability if we keep
> the names symmetric. This one could be named prepare_nested_vmcb_save to
> match load_nested_vmcb_control that you created in the previous patch.
> Or load_nested_vmcb_control could be renamed to nested_load_vmcb_control
> to match the name here.

This is actually intended: while load_nested_vmcb_control loads the
members of nested_vmcb->control into svm->nested, the two functions in
this patch prepare the svm->vmcb.  A couple patches later,
nested_prepare_vmcb_control will not use nested_vmcb anymore.

I could use nested_load_nested_vmcb_control, but that is just too ugly!
 Instead, the best thing to do would be to use the vmcb01/vmcb02/vmcb12
names as in nVMX, in which case the functions would become
nested_load_vmcb12_control and nested_prepare_vmcb02_{save,control}.
However this is a bit hard to do right now because the svm->vmcb acts as
both vmcb01 and vmcb02 depending on what is running.

Thanks,

Paolo

