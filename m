Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F42C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3204206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJpzb4u/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgFKP1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:27:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20962 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726497AbgFKP1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 11:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591889272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tubQTvMCayyEO7VGNY1bAGU+lqkLOkwFY6fIG7RPrrg=;
        b=YJpzb4u/oP9uNQoaD+80SoPcW/4wHpLt+V8Cvw8/3l9gAp7p6n52CggsgdEx+5+bz9PQoV
        f7PI63olkdmR/YPEdeWQzwBUIijWdTBaF83ccOjnoeCI1J5d5Px1cORbpNBq+VIomwKyk7
        aeWdhgFP0/t+6MIBDsI2+TUs0oYW5M0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-oopxVVvIOQO_hhNcvPufjA-1; Thu, 11 Jun 2020 11:27:51 -0400
X-MC-Unique: oopxVVvIOQO_hhNcvPufjA-1
Received: by mail-wr1-f69.google.com with SMTP id t5so2673966wro.20
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 08:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tubQTvMCayyEO7VGNY1bAGU+lqkLOkwFY6fIG7RPrrg=;
        b=p5EfGTmRO+/uF8LT4PPz0XWzNu9TbX3XqFxwCYDZ9/ZO5tntejPyLW6lM8Krp7+XC4
         MV4FmJ0MMRyDAlimY9SwgyVDQPa0ebFaLt99jTpJDjVUC8iUhAgcNIAygESqWEnWyQLZ
         PI3pLKOC1b4qB3WoRFtYrfEfY1UvJ4WZZBJ2zu0ZXA5s3R1B4fW7xEH4SVQJooY8SVgP
         mmbgoYRCujXQctu4UA5dqZAA1/Wo1HsiWOUkRI9WV7GuAlE0UZnRdsBLJZtRukUr/Nqf
         TIAs87XaEsROtyfw57mruQWfbgQdU9G8ERsx4/fZtpDj/5eXnAB8GDq4GVoCpsqx+7wG
         CuMA==
X-Gm-Message-State: AOAM532IHjV0HucfjRXv2pkMQxeumF6tiBwk9CgdFLrfsF9VrEE0XeLs
        /XfY6K5nCcFNJ0cym/s0hRpzNjhhQH+XOK6HGWTuTzOdFCTPk6Ibop+rGwEKVbYC8Y41q2NSy10
        2+srhQYHZLmQDqt+6OlFrV79u
X-Received: by 2002:a1c:2183:: with SMTP id h125mr8260907wmh.112.1591889269893;
        Thu, 11 Jun 2020 08:27:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybUgRWiUuIG0MwV8QKdmngDG0hRIBA7dEUisc28nbd4b+WXjrTb/klVvugUgYwmfSnG7C9AA==
X-Received: by 2002:a1c:2183:: with SMTP id h125mr8260888wmh.112.1591889269567;
        Thu, 11 Jun 2020 08:27:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29ed:810e:962c:aa0d? ([2001:b07:6468:f312:29ed:810e:962c:aa0d])
        by smtp.gmail.com with ESMTPSA id l17sm5621237wrq.17.2020.06.11.08.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 08:27:49 -0700 (PDT)
Subject: Re: [PATCH] KVM: check userspace_addr for all memslots
To:     Maxim Levitsky <mlevitsk@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
References: <20200601082146.18969-1-pbonzini@redhat.com>
 <dde19d595336a5d79345f3115df26687871dfad5.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b97854bd-ff63-71ee-3c27-2602326a26b8@redhat.com>
Date:   Thu, 11 Jun 2020 17:27:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <dde19d595336a5d79345f3115df26687871dfad5.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/20 16:44, Maxim Levitsky wrote:
> On Mon, 2020-06-01 at 04:21 -0400, Paolo Bonzini wrote:
>> The userspace_addr alignment and range checks are not performed for private
>> memory slots that are prepared by KVM itself.  This is unnecessary and makes
>> it questionable to use __*_user functions to access memory later on.  We also
>> rely on the userspace address being aligned since we have an entire family
>> of functions to map gfn to pfn.
>>
>> Fortunately skipping the check is completely unnecessary.  Only x86 uses
>> private memslots and their userspace_addr is obtained from vm_mmap,
>> therefore it must be below PAGE_OFFSET.  In fact, any attempt to pass
>> an address above PAGE_OFFSET would have failed because such an address
>> would return true for kvm_is_error_hva.
>>
>> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> I bisected this patch to break a VM on my AMD system (3970X)
> 
> The reason it happens, is because I have avic enabled (which uses
> a private KVM memslot), but it is permanently disabled for that VM,
> since I enabled nesting for that VM (+svm) and that triggers the code
> in __x86_set_memory_region to set userspace_addr of the disabled
> memslot to non canonical address (0xdeadull << 48) which is later rejected in __kvm_set_memory_region
> after that patch, and that makes it silently not disable the memslot, which hangs the guest.
> 
> The call is from avic_update_access_page, which is called from svm_pre_update_apicv_exec_ctrl
> which discards the return value.
> 
> 
> I think that the fix for this would be to either make access_ok always return
> true for size==0, or __kvm_set_memory_region should treat size==0 specially
> and skip that check for it.

Or just set hva to 0.  Deletion goes through kvm_delete_memslot so that
dummy hva is not used anywhere.  If we really want to poison the hva of
deleted memslots we should not do it specially in
__x86_set_memory_region.  I'll send a patch.

Paolo

