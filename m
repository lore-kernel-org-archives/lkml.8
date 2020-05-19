Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E153CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B382720709
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 08:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iL+Qn5Z0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgESIGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 04:06:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28062 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728237AbgESIG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 04:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589875588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zTmYRJOomIgyr1GJva/MlpDq9Augv2jVYca4cwH5sKk=;
        b=iL+Qn5Z0J+WHVt3JMr/mkNOvADuyNKQHRq3itOjjENlToxic/agFtc3Lb2SfQ7+b/FMgVr
        Ldvo8VZLa97PZGwzm017/hCOTZWFKh4bFbzNZydXx+nqjBpWGXQXQQ9lbf6hzk9QLXws2E
        8HodqzMl0gkN86Ht7vSyGyIVnH60k28=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-gJEQ8IhONVuOb8cBca9WkQ-1; Tue, 19 May 2020 04:06:26 -0400
X-MC-Unique: gJEQ8IhONVuOb8cBca9WkQ-1
Received: by mail-wm1-f71.google.com with SMTP id f9so1048979wml.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 01:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zTmYRJOomIgyr1GJva/MlpDq9Augv2jVYca4cwH5sKk=;
        b=HTpKxUN21ZWBORtiHrL4+lcU7ieeCft10PkFfGeKoy5nSXe6AB8o1/hkoGyvJz9kLt
         1Lgm4Bnin3l5laJX7sx7ebIC4PglDRADbdKdVdksl/ibu8tXI3vVHqagIAi2hisTJ7Lj
         P2fXT2DFfgQB51Hv6ZBm4X2SPZ9gjCzxK/pfshVaiMSS1K0PFWw4qgu616vak/Iao6yV
         RFVQgV78u0ZXZE2BT+ed91gnXeOGtLDRPcXBJd9b7I1PlNAt1IejyOuf5RLrDWXxCZdg
         ZBr3HIDFzggwmZoZY2Kz33/5epuolUidxa+xDpwEVKmEWkpsFLK9okW3XdfWM6UpGu7P
         1R6Q==
X-Gm-Message-State: AOAM531Dwoskkg5cITipFKSbpQ1kyPRgE2eU3kRFUwgfGdTk0lG8AqMr
        T0ipls8XTe4gUdbTgPyFa3hw99NLRJI1N+2D9/9F6Zzs5TVQXVbCcFysbKI9z03pXWKKupWbU8f
        5C4PWtSdbTI0oOXRGR6+Uma6P
X-Received: by 2002:a5d:6412:: with SMTP id z18mr23601139wru.290.1589875585441;
        Tue, 19 May 2020 01:06:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVAwBqypNVb4EjZNBJe4pBgTmmFmS0JdNUPvJrHnft87IHXaujmvYBQ95BfBP1tYlNKUignw==
X-Received: by 2002:a5d:6412:: with SMTP id z18mr23601118wru.290.1589875585187;
        Tue, 19 May 2020 01:06:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:80b4:c788:c2c5:81c2? ([2001:b07:6468:f312:80b4:c788:c2c5:81c2])
        by smtp.gmail.com with ESMTPSA id r2sm20095577wrg.84.2020.05.19.01.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 01:06:24 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: emulate reserved nops from 0f/18 to 0f/1f
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20200515161919.29249-1-pbonzini@redhat.com>
 <20200518160720.GB3632@linux.intel.com>
 <57d9da9b-00ec-3fe0-c69a-f7f00c68a90d@redhat.com>
 <20200519060156.GB4387@linux.intel.com>
 <60c2c33c-a316-86d2-118a-96b9f4770559@redhat.com>
 <20200519075523.GE5189@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <be7fa327-51b9-1f95-454d-f4f9c15a1b63@redhat.com>
Date:   Tue, 19 May 2020 10:06:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200519075523.GE5189@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/20 09:55, Sean Christopherson wrote:
>> Running arbitrary code under the emulator is problematic anyway with
>> CET, since you won't be checking ENDBR markers or updating the state
>> machine.  So perhaps in addition to what you say we should have a mode
>> where, unless unrestricted guest is disabled, the emulator only accepts
>> I/O, MOV and ALU instructions.
>
> Doh, I forgot all about those pesky ENDBR markers.  I think a slimmed down
> emulator makes sense?

Or just slimmed down opcode tables.

> Tangentially related, isn't the whole fastop thing doomed once CET kernel
> support lands?

Why?  You do need to add endbr markers and some of the fastop handlers
won't fit in 8 bytes, but that should be it.

Paolo

