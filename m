Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD1EC4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95A88214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hv5WI99E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgD0TKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:10:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49653 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgD0TKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588014630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I0hVk/6G0HDWyNl0uhimzd8WziWxl6KqqJxBVaLL5oQ=;
        b=Hv5WI99EVG9PbL1gSwidJYL6t6VS/Y1P1Skqq5aW8euIyC5x4rTLvCjxIpu9DLgXrs2kE3
        CwTRIp7LXY/d8EgGm09711mgIGKKIm6pGS+Lb1U+HxUV9m3tjI5akgTzLSzNW8kzyY+JTA
        pYDuYA7G/7UlSxsuOANO86WvGJiN9hE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-8NES2kblOu-E-gvS6EWDdQ-1; Mon, 27 Apr 2020 15:10:29 -0400
X-MC-Unique: 8NES2kblOu-E-gvS6EWDdQ-1
Received: by mail-wm1-f72.google.com with SMTP id j5so45656wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 12:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I0hVk/6G0HDWyNl0uhimzd8WziWxl6KqqJxBVaLL5oQ=;
        b=CXq4s/wDu48peiZR1NZxRR9Lr3cVVv72TakV2GJ311TowECeGH43vCis4UGNjShjA9
         lAvi9XsMVBxly8Ldc66Odaz9sDH+r1J1Ro0bhGwsFXghyXPPR0h8QPuE7u8n/gq+m1/b
         ldUZsbMPssfLb4zqvQuzvUtrlA/1OzuiKEVhpuuSmyBXMQx4op14D+WawsTNoQAXup5X
         7P4Q2rpd3DA+EE0L5GdMNa5T3+39UXqOlrR/o3dw78ZRldtHw+5cgT7vACrRI4oIrUw1
         Un08bQaxQwKv1qxIB+PPgZIxS9yx6xKZo0iSdzF4pwzuOwySnE51s19qyVxSO4C9YMqf
         Brgw==
X-Gm-Message-State: AGi0PuapNi4pJwQC9HUW5ZG6veYJO9lMs6+2OsIe73nWHdAQeEEyA/4b
        8IIQxHnqVtdga9pAuOmATXlZkVQOhcNsslkZyjNzpjhKJ3RJQzHG2OwHoh8CD4V+PV2oy027DoQ
        bFYRke3P8w+zDdh/O2vvDzhG0
X-Received: by 2002:adf:cd04:: with SMTP id w4mr30392815wrm.357.1588014628249;
        Mon, 27 Apr 2020 12:10:28 -0700 (PDT)
X-Google-Smtp-Source: APiQypIILVoJz/qNWYWE3ErDemAwYqp/nA424nLm5ZyRRhg+ICEM+y/HKkvpU9uy47Xz8+V0QcM6PQ==
X-Received: by 2002:adf:cd04:: with SMTP id w4mr30392803wrm.357.1588014628029;
        Mon, 27 Apr 2020 12:10:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac19:d1fb:3f5f:d54f? ([2001:b07:6468:f312:ac19:d1fb:3f5f:d54f])
        by smtp.gmail.com with ESMTPSA id k9sm23532061wrd.17.2020.04.27.12.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 12:10:27 -0700 (PDT)
Subject: Re: [PATCH] [RFC] kvm: x86: emulate APERF/MPERF registers
To:     Jim Mattson <jmattson@google.com>,
        "Li,Rongqing" <lirongqing@baidu.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <1587704935-30960-1-git-send-email-lirongqing@baidu.com>
 <20200424100143.GZ20730@hirez.programming.kicks-ass.net>
 <20200424144625.GB30013@linux.intel.com>
 <CALMp9eQtSrZMRQtxa_Z5WmjayWzJYhSrpNkQbqK5b7Ufxg-cMA@mail.gmail.com>
 <ce51d5f9-aa7b-233b-883d-802d9b00e090@redhat.com>
 <fd2a8092edf54a85979e5781dc354690@baidu.com>
 <CALMp9eQrGuqzy_ZRu+qU3A7PRkoi8JHWFRpm---cMhp9+J4j8A@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f3c2cc31-6388-f7b5-48fd-fb19d059eea3@redhat.com>
Date:   Mon, 27 Apr 2020 21:10:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eQrGuqzy_ZRu+qU3A7PRkoi8JHWFRpm---cMhp9+J4j8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/20 19:30, Jim Mattson wrote:
>>>> I would like to see performance data before enabling this
>>>> unconditionally.
>>> I wouldn't want this to be enabled unconditionally anyway,
>>> because you need to take into account live migration to and from
>>> processors that do not have APERF/MPERF support.
>>> 
>>> Paolo
>> I will add a kvm parameter to consider whether enable MPERF/APERF
>> emulations, and make default value to false
>
> Wouldn't it be better to add a per-VM capability to enable this
> feature?

Yes, you it would be better to use KVM_ENABLE_CAP indeed.

Paolo

