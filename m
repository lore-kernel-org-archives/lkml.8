Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC6BC8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B52AA205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfLDdMcT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgD3Mpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 08:45:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53420 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726520AbgD3Mpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 08:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588250733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Cb5HHKbQwivw+27kErpeaVpuk6fg8e7FOLW1l12fCc=;
        b=GfLDdMcTZ0juKuTCnm8BNOYrgkEdq0wYYLxnaBowclMo8qUSvQ/jdtQfFSjvYm3J4IM0hL
        jh1gaTi1CPpD9T6xMSNvZO5bfGfxFcZpFlMKb9mWvpyita2o1pSBLS0+FMNsKQPLzYJ+XS
        mF6b4pyeYi8NOVlKsVLD9bQUNH6/Yc0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-Gjilz1DZNGmErwor0gFowA-1; Thu, 30 Apr 2020 08:45:31 -0400
X-MC-Unique: Gjilz1DZNGmErwor0gFowA-1
Received: by mail-wr1-f69.google.com with SMTP id a12so645363wrv.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 05:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Cb5HHKbQwivw+27kErpeaVpuk6fg8e7FOLW1l12fCc=;
        b=A78HE2+vBu6AddVPrasN9yrxq6tUPTQxTudTp8Em+a30Cuewkeob9vykYJdUmjCOQT
         Y1rUOu3IMRpX0+wruIo4e4EAfoPBcHliASd3uEAmy0dJnNh7dtyocb6NakyufE1tkMc0
         9KVNd8pTzs/IC4OOXnmtgQynPsLRsg6A6VKSOrgb3V4XOoU5+ieu65mf8MuzBFqgkArM
         O7iT1USs4lU+HB1haHq+pbRrAxbKfahZU5zBIO8dKDv7hFP8KnIFJVqUMI5euYo6+jyJ
         GMLCOXqcjjxBrCSLtTuEUjeBZRgDVUfV5fYAf1eMhSVL/s2wNnx6wSsxsb5FAtHVNsiw
         4scQ==
X-Gm-Message-State: AGi0PuZM4x25TzdLZQpYP61gIXjxJLWFK3GmQ4RWQyxyADTLDQs2o1cr
        o0I+mvv+SKMwzGpsi2bQPvWRKXd/Viudiyn3UIXNlaYQEdRtKjqnsNQoaefDtMP2nNMpuYJJiFk
        Z4SBG3G9bf1T2EAXdwY7+7IIs
X-Received: by 2002:a1c:6787:: with SMTP id b129mr2890868wmc.165.1588250729955;
        Thu, 30 Apr 2020 05:45:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypJHyik7w72yZvX6PX+sEPiltOuJ0kE1Z2Mjczffq8o7emZek2HBnjq6JmtiOcFDW1lscPKysw==
X-Received: by 2002:a1c:6787:: with SMTP id b129mr2890837wmc.165.1588250729563;
        Thu, 30 Apr 2020 05:45:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac19:d1fb:3f5f:d54f? ([2001:b07:6468:f312:ac19:d1fb:3f5f:d54f])
        by smtp.gmail.com with ESMTPSA id t20sm11667993wmi.2.2020.04.30.05.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 05:45:29 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: handle wrap around 32-bit address space
To:     David Laight <David.Laight@ACULAB.COM>,
        'Jim Mattson' <jmattson@google.com>
Cc:     'LKML' <linux-kernel@vger.kernel.org>,
        'kvm list' <kvm@vger.kernel.org>,
        'Sean Christopherson' <sean.j.christopherson@intel.com>,
        'Joerg Roedel' <joro@8bytes.org>,
        "'everdox@gmail.com'" <everdox@gmail.com>
References: <20200427165917.31799-1-pbonzini@redhat.com>
 <CALMp9eTBs=deSYu1=CMLwZcO8HTpGM2JsgDxvFR1Y220tdUQ3w@mail.gmail.com>
 <c3ac5f4c9e3a412cb57ea02df19dd2d2@AcuMS.aculab.com>
 <91c76eb0edcd4f1a9d5bc541d35f8ade@AcuMS.aculab.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2f471fbc-99fb-1a85-8f9f-c276c897f518@redhat.com>
Date:   Thu, 30 Apr 2020 14:45:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <91c76eb0edcd4f1a9d5bc541d35f8ade@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/20 10:56, David Laight wrote:
>>>> +               if (unlikely(((rip ^ orig_rip) >> 31) == 3) && !is_64_bit_mode(vcpu))
>> Isn't the more obvious:
>> 	if (((rip ^ orig_rip) & 1ull << 32) ...
>> equivalent?

This one would not (it would also detect carry on high memory addresses,
not just 0x7fffffff to 0x80000000)...

> Actually not even being clever, how about:
> 	if (orig_rip < (1ull << 32) && unlikely(rip >= (1ull << 32)) && ...

... but yes this one would be equivalent.

Paolo

