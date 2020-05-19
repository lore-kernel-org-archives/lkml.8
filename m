Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE962C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 07:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 882A7207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 07:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YYwqJC50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgESHna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 03:43:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48124 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725996AbgESHna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 03:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589874208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aSV85razz1Rc4JqqUlLx4UQgTj6rcAUYgNELv+Wensw=;
        b=YYwqJC504kOMfGSoQdCxpuzK4FOJdEAHrSghnUsiwu5gzZwSKu4xJj0qjYPXkfDa94LB94
        hD9uF0seqZmWsRLA7yPMt7tDQNQrdeYE10mL4R8u1YXJrSe+jTKD3JCk5o4767GFW+6YHn
        h3f2BeF460By9zbz94f5XiTUtMpKJBk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-7ykAGuTqP_S9i88RA2Y9Pw-1; Tue, 19 May 2020 03:43:24 -0400
X-MC-Unique: 7ykAGuTqP_S9i88RA2Y9Pw-1
Received: by mail-wr1-f72.google.com with SMTP id r7so6860722wrc.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 00:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aSV85razz1Rc4JqqUlLx4UQgTj6rcAUYgNELv+Wensw=;
        b=odkgbBJzpNP62rDUkigOLhHtFxUV4K791jEqaAZBPwrfrDQlMnkSf3hwtb0o2XVm+/
         /708W+vkABjwRBByPUe6m/0zFq7BZncwsun7BFO8x+CwDOGNq4ZnMBP+JqNOP4LfNQ1d
         ri+GtG09H0/J4A1yu7druUL+J/hMSKIf7omD0dBIcgJBJ0ueK0fafmPde6zbML4zXg5d
         1MXXyxK+pNZi2rooJOCWnFE3hQtExexGQP0SzdIyACNLF8KgqrmKXVn5uFfOjuSgk+1w
         0V9f8OcLXUTL7wEpTkjHeWTNMqlYoohi4s1uxIIah/b3+BeHASKqSjaQrbOxpEhW6zEI
         XTSg==
X-Gm-Message-State: AOAM531XB+0diBLwdoq5m3JSB3MTogIITIqYrI7faz+2rxVLvAVTqPR6
        +AQqV+Y+YJiZPViIBFN0WF6gFzD/d7YZ7YbGMSNT6TKnba74ejEmvhpHnaf7CVWHbCzmMSpYUGY
        avXFjBaPqzibGCT+lNz04fAm8
X-Received: by 2002:a1c:7212:: with SMTP id n18mr4098581wmc.129.1589874203202;
        Tue, 19 May 2020 00:43:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8GRjgb3f8R3kAm3Heb975rE9BxAKC8bK/LvdYYJYtF6FtCJi2JJlcLHOiftg/zz7TPwK3Gw==
X-Received: by 2002:a1c:7212:: with SMTP id n18mr4098544wmc.129.1589874202866;
        Tue, 19 May 2020 00:43:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:80b4:c788:c2c5:81c2? ([2001:b07:6468:f312:80b4:c788:c2c5:81c2])
        by smtp.gmail.com with ESMTPSA id b12sm2845053wmj.0.2020.05.19.00.43.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 00:43:22 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: emulate reserved nops from 0f/18 to 0f/1f
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20200515161919.29249-1-pbonzini@redhat.com>
 <20200518160720.GB3632@linux.intel.com>
 <57d9da9b-00ec-3fe0-c69a-f7f00c68a90d@redhat.com>
 <20200519060156.GB4387@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <60c2c33c-a316-86d2-118a-96b9f4770559@redhat.com>
Date:   Tue, 19 May 2020 09:43:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200519060156.GB4387@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/20 08:02, Sean Christopherson wrote:
> On Mon, May 18, 2020 at 07:37:08PM +0200, Paolo Bonzini wrote:
>> On 18/05/20 18:07, Sean Christopherson wrote:
>>> On Fri, May 15, 2020 at 12:19:19PM -0400, Paolo Bonzini wrote:
>>>> Instructions starting with 0f18 up to 0f1f are reserved nops, except those
>>>> that were assigned to MPX.
>>> Well, they're probably reserved NOPs again :-D.
>>
>> So are you suggesting adding them back to the list as well?
> 
> Doesn't KVM still support MPX?
> 
>>>> These include the endbr markers used by CET.
>>> And RDSPP.  Wouldn't it make sense to treat RDSPP as a #UD even though it's
>>> a NOP if CET is disabled?  The logic being that a sane guest will execute
>>> RDSSP iff CET is enabled, and in that case it'd be better to inject a #UD
>>> than to silently break the guest.
>>
>> We cannot assume that guests will bother checking CPUID before invoking
>> RDSPP.  This is especially true userspace, which needs to check if CET
>> is enable for itself and can only use RDSPP to do so.
> 
> Ugh, yeah, just read through the CET enabling thread that showed code snippets
> that do exactly this.
> 
> I assume it would be best to make SHSTK dependent on unrestricted guest?
> Emulating RDSPP by reading vmcs.GUEST_SSP seems pointless as it will become
> statle apart on the first emulated CALL/RET.

Running arbitrary code under the emulator is problematic anyway with
CET, since you won't be checking ENDBR markers or updating the state
machine.  So perhaps in addition to what you say we should have a mode
where, unless unrestricted guest is disabled, the emulator only accepts
I/O, MOV and ALU instructions.

Paolo

