Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269E1C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFCD7206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L9mXACcr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgEELgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 07:36:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35913 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725766AbgEELgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 07:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588678579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x2FjQAZY3rz08zRV+CTT5963v5ngAxHKCBr7Wo/WiIQ=;
        b=L9mXACcrHHgeMQitfRYzNJm9ZUCrDW6KJkhLP4OOAQ1LPS3WDmFjBcLaTI4FNpZDTceGH2
        MJ3RybjPPm3klNH2q9BbnzabrRldLX4h1da6KQX1hzoP3Dw/shQgfxENUHUUqcyZASjlPw
        gEMQ+n7KgQk5E6yZIdE9X2SEEvkmkpg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-FmW_YfCEPiSnfCkK8GoHag-1; Tue, 05 May 2020 07:36:18 -0400
X-MC-Unique: FmW_YfCEPiSnfCkK8GoHag-1
Received: by mail-wr1-f70.google.com with SMTP id h12so1056469wrr.19
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 04:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x2FjQAZY3rz08zRV+CTT5963v5ngAxHKCBr7Wo/WiIQ=;
        b=d8ZLoiClPREh9QHKcHKzx3R/c0FIN9xZHLEEBAYe7/Yn4KlcIcgH4QlMeHh08uOuHc
         uTiln2BvIJ1MHBqRQSAlON320C0hvWHXRhHM3jvFi/FLWAceFm5K8itsE6rNWIMOVavl
         tDiA/Ft5Ld5+w8kenpX9sHFAYlwZxJPwCcw2VOabFHMHXLxFSgPhr5pJPX0HBh7ubQH4
         ivLjnkWD3UUHuDa8Umb3HmPwjVEjx8WXWzJcWyiA0NzkKQNtManb/9EAA2jQEmFS19Ta
         LWYdWa8uGI6DlBvPdYAIqCaP7xpNPRqah9PZjAcJmqUzJFj3TCMEK0iaaq8fPza8JHP6
         72Pg==
X-Gm-Message-State: AGi0PuaXIqJftUTCLFsNt7BSTs3aaDe1nwu/tPYFyxityeLbiEesWfu7
        VUKCyCpXwBjpr1K+aG1cvRVKXVLukUqugEriBqPCUmN9qNYmG3QfBYrxd9AzbuOgZRhEnCZVkIH
        qRlhutE5r+sX1MyBrHXX38Vsj
X-Received: by 2002:a5d:5112:: with SMTP id s18mr3415013wrt.426.1588678576954;
        Tue, 05 May 2020 04:36:16 -0700 (PDT)
X-Google-Smtp-Source: APiQypJl60n9MQpiFkNCbieDx9axKTRmRnusJD4ycTvR5+jsKe4L9ARtHDkdV2u7AzEdxcAHwg3gog==
X-Received: by 2002:a5d:5112:: with SMTP id s18mr3414988wrt.426.1588678576724;
        Tue, 05 May 2020 04:36:16 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.132.175])
        by smtp.gmail.com with ESMTPSA id t16sm3262550wmi.27.2020.05.05.04.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 04:36:16 -0700 (PDT)
Subject: Re: [PATCH 0/3] KVM: x86: cleanup and fixes for debug register
 accesses
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20200504155558.401468-1-pbonzini@redhat.com>
 <20200504185530.GE6299@xz-x1>
 <06dcafe8-8278-a818-ad76-36f3bbbcc0a2@redhat.com>
 <20200504234904.GG6299@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d09671ef-0a9d-c854-7715-d3077e09e734@redhat.com>
Date:   Tue, 5 May 2020 13:36:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200504234904.GG6299@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/20 01:49, Peter Xu wrote:
>> The guest debugging test would basically cover the gdbstub case, which
>> is different from kvm-unit-tests.  It would run similar tests to
>> kvm-unit-tests, but #DB and #BP exceptions would be replaced by
>> KVM_EXIT_DEBUG, and MOVs to DR would be replaced by KVM_SET_GUEST_DEBUG.
>>
>> It could also cover exception payload support in KVM_GET_VCPU_EVENTS,
>> but that is more complicated because it would require support for
>> exceptions in the selftests.
>
> Yep, I guess the in-guest debug test will still need the exception support,
> though I also guess we don't need that when we have the kvm unit test

We can still use it in order to test for example live migration with
pending debug exceptions (KVM_GET_VCPU_EVENTS), but it's less important
indeed.

Paolo

