Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E24AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DFF12074B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YOIB9wIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgE2TEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 15:04:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38183 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726487AbgE2TEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 15:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590779084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4OeTMYt6ooRGykihY8xeTFwVI+iDEW21APbq0fnA8RY=;
        b=YOIB9wIfem9/El29z9coyvhJrsAZn2tu9hQlZ4WNjXfikFreefBasbSIxW6/r/N/wicXKe
        SrrTaluP1jMRVSxBRkYN+rQJNfWgIhf3wqnOYCk1wKHFy7gw+tvb0E46GdcASfVvJwejAx
        MUr33qtcJ/gKekWTS6Hxign0dVuCPYU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-ofytyLCAN1uCjH2e1IU9Hg-1; Fri, 29 May 2020 15:04:42 -0400
X-MC-Unique: ofytyLCAN1uCjH2e1IU9Hg-1
Received: by mail-wr1-f69.google.com with SMTP id e1so1419602wrm.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4OeTMYt6ooRGykihY8xeTFwVI+iDEW21APbq0fnA8RY=;
        b=T3G6hNZwNyew+MsjSjZ59Ej24aL6Q0qMEz7OmdhM0tt7WPUZnuQ5bpet2vSHU15SQl
         3UTEIgRYMdZerU9T7HLYurQqK8WOZZjGf9p9fdboopmAg538HIbXq6ZpK/P5m1uTQPbn
         3PJGpyzmuOfrp5m1xFYDbqriSgxpeP2KPum1Cb7SgiVnt3/VjsJtgl/Y82X2tv3dPZeg
         4EyqrP54kJaNH68EuNUFipleP1R11IqcXDTgtcS3pIv6KxFUwUtJypcwI+SjA6e3vtGA
         N1Bl/ZMGaCKgQGaSefhVPBCPppjnQ+q3OV5fBX2bIZ4+fkOZN03/PLccLPuN4/l7XMqU
         3Dgw==
X-Gm-Message-State: AOAM532GEoNM9jW1kHzXk+BHA8OQglOgdeJVo4MFToyH7QsEPyZEgCSF
        rs9vyO/xDUgoL+e5TkyjGdzRdOPy68Bt1hTFnvqhJZFJZLC1AnTyaZMTHe4W0bqQb2pj/SGKu+b
        +vXgAhilI48GQrKCZdG9cSfqF
X-Received: by 2002:a5d:558a:: with SMTP id i10mr10606867wrv.207.1590779081007;
        Fri, 29 May 2020 12:04:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHdmQQkz93toiXqZdPVAnmv6hSnFkVo4RzDmNklVZHcwM5g9a4XgHHpwpiB3KDSDJPzUHZ/A==
X-Received: by 2002:a5d:558a:: with SMTP id i10mr10606850wrv.207.1590779080699;
        Fri, 29 May 2020 12:04:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8? ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
        by smtp.gmail.com with ESMTPSA id b185sm1033474wmd.3.2020.05.29.12.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 12:04:40 -0700 (PDT)
Subject: Re: [PATCH 08/30] KVM: nSVM: move map argument out of
 enter_svm_guest_mode
To:     Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20200529153934.11694-1-pbonzini@redhat.com>
 <20200529153934.11694-9-pbonzini@redhat.com>
 <f7946509-ff69-03e3-ec43-90a04714afe3@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5fa0a52e-3b67-b545-d74a-7e4050e64559@redhat.com>
Date:   Fri, 29 May 2020 21:04:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <f7946509-ff69-03e3-ec43-90a04714afe3@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/20 20:10, Krish Sadhukhan wrote:
>> Unmapping the nested VMCB in enter_svm_guest_mode is a bit of a wart,
>> since the map is not used elsewhere in the function.  There are
>> just two calls, so move it there.
> 
> The last sentence sounds bit incomplete.

Good point---more precisely, "calls" should be "callers".  "It" refers
to "unmapping".

> Also, does it make sense to mention the reason why unmapping is not
> required before we enter guest mode ?

Unmapping is a host operation and is not visible by the guest; is this
what you mean?

Paolo

