Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD06C2BBC7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 08:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C14521473
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 08:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBfS9qoF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgDHIDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 04:03:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35211 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726436AbgDHIDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 04:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586333022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=edweZzkcUUEqT+LhRV7IQOwxosyO1yq1XXUOfWRxf6s=;
        b=gBfS9qoFJEzmu+3kUGtidyIMrz3hhf5njenwr+hX1KOsN/BBwsTXS2DxIkXBlvHVhwJ+9C
        1AWsRSTc8K6NXRkgZIHYs780NpNqhvVRTvKo3yWxEwGTrHGDo5eSIS1bYuPD20myQ49mO1
        wXO6roSz2Q7y5Y+zLjkdQNKa6c+p78U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-fK_7cskMPzabw7kE3D8sRA-1; Wed, 08 Apr 2020 04:03:40 -0400
X-MC-Unique: fK_7cskMPzabw7kE3D8sRA-1
Received: by mail-wm1-f69.google.com with SMTP id f9so2021893wme.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 01:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=edweZzkcUUEqT+LhRV7IQOwxosyO1yq1XXUOfWRxf6s=;
        b=Im3mWNSMhxeQxLCsbn9fB/FZ/rqsd+kcKCcsNgXH3r+0cnuRA8oDe4CVne6gKsR15H
         Hrp3y6FuID7jGi7FURBh2d4RITu1Zk8ie71QNdO7GwxAZJ8B/k0+sy0aW/tmn195a9PF
         U+flZvmH/IA5LJwDKjZrz4CvJHF5bdDhJv/X1Nl3Rfw/N5WglocEFkvwFopLRl52n0tv
         l9TfTOagoGruBM+idHEsXVXbrxOFgKhv+v9WLqUx6X81x0WlPCLI01eLTjPMG8XwNJy2
         JbcUJUlR4quqre9OUYLK6t3eqH8hQ2Hy3AU1CTDpW8pn09K++dmAZvPqqsf2BwIUqNVe
         NFrA==
X-Gm-Message-State: AGi0PuY42moygR/TEkkCLupD52370Vphe9FYtkTFNQcFqwDJzKazPj9S
        hBacYEbC6Y4dOm4oU/1l91G1YABiwEJbZLuNIOLR3p3X96ldUbAWzR0ownkvMCgbvXxjOyqwbSo
        ZF96Vbpdg1TKBXEtjHQMZ0oEX
X-Received: by 2002:adf:fb0a:: with SMTP id c10mr6923337wrr.272.1586333019291;
        Wed, 08 Apr 2020 01:03:39 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ+ntn14SYKRydGfMhfPl7s8cCfvT8wtzYAMJBnexLMbuXQusyLBYTAepUs8YwriSCpcYaZKw==
X-Received: by 2002:adf:fb0a:: with SMTP id c10mr6923298wrr.272.1586333019070;
        Wed, 08 Apr 2020 01:03:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:bd61:914:5c2f:2580? ([2001:b07:6468:f312:bd61:914:5c2f:2580])
        by smtp.gmail.com with ESMTPSA id t16sm5774974wmi.27.2020.04.08.01.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 01:03:38 -0700 (PDT)
Subject: Re: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hch@infradead.org, sean.j.christopherson@intel.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kenny@panix.com, jeyu@kernel.org, rasmus.villemoes@prevas.dk,
        fenghua.yu@intel.com, xiaoyao.li@intel.com, nadav.amit@gmail.com,
        thellstrom@vmware.com, tony.luck@intel.com,
        gregkh@linuxfoundation.org, jannh@google.com,
        keescook@chromium.org, David.Laight@aculab.com,
        dcovelli@vmware.com, mhiramat@kernel.org,
        Wolfgang Mauerer <wolfgang.mauerer@oth-regensburg.de>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.429362016@infradead.org>
 <20200407174824.5e97a597@gandalf.local.home>
 <137fe245-69f3-080e-5f2b-207cd218f199@siemens.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0ed2739b-6961-c476-be2d-020e855796dc@redhat.com>
Date:   Wed, 8 Apr 2020 10:03:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <137fe245-69f3-080e-5f2b-207cd218f199@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/20 07:58, Jan Kiszka wrote:
>>>
>>>   +        if (insn_is_mov_CRn(&insn) || insn_is_mov_DRn(&insn)) {
>>> +            pr_err("Module writes to CRn or DRn, please use the
>>> proper accessors: %s\n", mod->name);
>>> +            return -ENOEXEC;
>>> +        }
>>
>> Hmm, wont this break jailhouse?
> 
> Yes, possibly. We load the hypervisor binary via request_firmware into
> executable memory and then jump into it. So most of the "suspicious"
> code is there - except two cr4_init_shadow() calls to propagate the
> non-transparent update of VMXE into that shadow. We could hide that CR4
> flag, but that could mislead root Linux to try to use VMX while in jail.

Why not contribute the Jailhouse loader into Linux?

Paolo

