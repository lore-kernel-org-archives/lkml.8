Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57B8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 23:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B429B2065C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 23:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSDPEJk2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgEOXe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 19:34:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24134 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726183AbgEOXe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 19:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589585696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ww8QLIiQQKmoFAR3z2a2VR3cY+JHw4PRCxc1cMKOHAQ=;
        b=DSDPEJk2Emr0l0ICn+mG9I7tG9tXQg4qB7Wx6kiry57dsHhuQkSomSYkjjq9Mdy3GnB9FD
        QhbZu6Qf00e+Cbn8KWZ0Sb0AuVzuByLfGCPYcB+f2aOgwqTTQfl+/k5i8g8fBaQbI4clix
        R2pVDscNitfk5htzXW79GuMdKBvfc34=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-8wFSVA_3PHSjZbm7dFg3KQ-1; Fri, 15 May 2020 19:34:54 -0400
X-MC-Unique: 8wFSVA_3PHSjZbm7dFg3KQ-1
Received: by mail-wm1-f71.google.com with SMTP id p24so224727wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 16:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ww8QLIiQQKmoFAR3z2a2VR3cY+JHw4PRCxc1cMKOHAQ=;
        b=rrEB+ZfaTTVAYAeRLTdemzJ+CsuhR+8VbOgfNDeRMvP6+5EG1g9b16cQcIxnZc/5t8
         z9qVqdM4Pl/aRoE/R5ffqeCsdY8TCYFh2lGWpV1UIgzJg5X1UVEKZSimqRicPh4IpbcD
         J+iUJW0/rgddDe/dfjNjq3Qj+uRq1oMnXPIw4HjeAQlXwzZ+N0ysfldWrCpPZ7SKgNos
         VIlEEpq2hMlnorW2vN7AF4ZnaGlv0xSAPNufGEIzLRVdPLnZJ0buTmieA/6Wcg+pEB+E
         mddV2ll6FSjeSuFf19/uDDl2TDu5nqc3fJ8YXMiXv1dZsxa1kJHGvME4829CtGst9J7l
         ROTA==
X-Gm-Message-State: AOAM531HBXvW2wXNIdIiWYfLJ9kpNQQCDEbgHsZOswGimQjacrE+4pOo
        bDTcJfa3pYarOtmBF/wxS9izxIU227z7n9Mu1BwV22KRPo2SJEwg6FDfKbqbnc30ySMR83W2xfI
        mBzjICy8FDyL0H1N++eb3GDeG
X-Received: by 2002:a1c:ed08:: with SMTP id l8mr1418343wmh.169.1589585693134;
        Fri, 15 May 2020 16:34:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZj4YIhP4GuREU6k+98WfW4UHnwqCGWraIeCdKfv4yBPRiAOC6oBDMvet8oEbXMM0EmskY5A==
X-Received: by 2002:a1c:ed08:: with SMTP id l8mr1418324wmh.169.1589585692860;
        Fri, 15 May 2020 16:34:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7012:d690:7f40:fd4e? ([2001:b07:6468:f312:7012:d690:7f40:fd4e])
        by smtp.gmail.com with ESMTPSA id b65sm5934467wmc.30.2020.05.15.16.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 16:34:52 -0700 (PDT)
Subject: Re: [PATCH 2/7] KVM: SVM: extract load_nested_vmcb_control
To:     Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Cathy Avery <cavery@redhat.com>,
        Liran Alon <liran.alon@oracle.com>,
        Jim Mattson <jmattson@google.com>
References: <20200515174144.1727-1-pbonzini@redhat.com>
 <20200515174144.1727-3-pbonzini@redhat.com>
 <73188a11-8208-cac6-4d30-4cf67a5d89bc@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7cfb8bc6-72ca-f86b-f0c5-9c53b6914713@redhat.com>
Date:   Sat, 16 May 2020 01:34:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <73188a11-8208-cac6-4d30-4cf67a5d89bc@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/20 01:09, Krish Sadhukhan wrote:
>>
>>   }
>>   +static void load_nested_vmcb_control(struct vcpu_svm *svm, struct
>> vmcb *nested_vmcb)
> 
> 
> This function only separates a subset of the controls. If the purpose of
> the function is to separate only the controls that are related to
> migration, should it be called something like
> load_nested_state_vmcb_control or something like that ?

This function loads into svm->nested.  The others are loaded into
svm->vmcb.  They will be moved to this function later in the series,
when we add fields to svm->nested for all the controls that have to be
serialized in KVM_GET/SET_NESTED_STATE.

Paolo

