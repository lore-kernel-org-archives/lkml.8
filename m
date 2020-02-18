Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB84C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 15:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70D021D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 15:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahXKmudh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgBRPd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 10:33:56 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36152 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726373AbgBRPd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 10:33:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582040034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wcuVY7kYjAiaGruZIaqVS5hTIYdIF7Sz5fz0+avlUjQ=;
        b=ahXKmudhq1e/U6+KQ6jgo3dlnGP0+Lo6G/84Dp84SiGEXvs/XqMrqPClRejyYLI9aiUceV
        6T0HODyICvwPtv/0Yu+fEIM5IlLmKTzW3bIdOB/qyIZck0ceZIh9L2gmVHWOwOdV6ZjMFR
        ELv/0EiBO9vT8Qd8QK5lMbtaQuhm5F4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-y-teKex6NDCVJXTomytO6Q-1; Tue, 18 Feb 2020 10:33:48 -0500
X-MC-Unique: y-teKex6NDCVJXTomytO6Q-1
Received: by mail-wr1-f72.google.com with SMTP id t3so10939986wrm.23
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 07:33:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wcuVY7kYjAiaGruZIaqVS5hTIYdIF7Sz5fz0+avlUjQ=;
        b=VQ9lKO9waCR1m+OpDRzWYai5uLfAeCV0w2erhn/nLsg4sO+0MUfjVVlz1N8TxJNsSc
         UjCuR6GkDmY4TIWQ7uSmJkqDCPuCFdfqYufxSenH8yvLd7Cb4mhQ6QFDI33URiiHSC5B
         iwWpPpTuRd8vfxVxtsQPhzzUT32uOVfQY1oNj6qVX8t5rRJ5CjUNaCXqcx0H2XcgPePu
         j9PCmrkMmjnZKu+bZsnssFKW+xFSn7keI7bAaEa798O4aCtn/AG8NbS+E0bab5RGL8JK
         xI4pKJjGG8fNn6CQLVJd30fXxhtBA+aBPWvTcsRRGEtwwA660ITpcWmAeQAyFdmD4iZa
         Esuw==
X-Gm-Message-State: APjAAAXp9G5uKVX1kz6i76LphnKc7ElNNeU+6DyPGo4yNkVqzcGAktzh
        lUsMpG8jxuIG8/9uH0fSb2JeF7R7cSe1NpKlnfpVC4qNxlwqkqSs3SxpI3av8GNnAk3FDT/UZ/o
        O8oI0tlVXHT/jI2RFle9XjkX/
X-Received: by 2002:adf:dc8d:: with SMTP id r13mr30717632wrj.357.1582040027401;
        Tue, 18 Feb 2020 07:33:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqw9u1DnkOPCdRW6cVeA5bmWDKs4XoNSD+yppiDGAQJFcUF0rXlT8L1PPZOthPVch2bV7Rhidg==
X-Received: by 2002:adf:dc8d:: with SMTP id r13mr30717607wrj.357.1582040027200;
        Tue, 18 Feb 2020 07:33:47 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:59c7:c3ee:2dec:d2b4? ([2001:b07:6468:f312:59c7:c3ee:2dec:d2b4])
        by smtp.gmail.com with ESMTPSA id c15sm6405828wrt.1.2020.02.18.07.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 07:33:46 -0800 (PST)
Subject: Re: [PATCH v4 1/2] KVM: X86: Less kvmclock sync induced vmexits after
 VM boots
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <kernellwp@gmail.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <1581988630-19182-1-git-send-email-wanpengli@tencent.com>
 <87r1ys7xpk.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e6caee13-f8f7-596c-fb37-6120e7c25f99@redhat.com>
Date:   Tue, 18 Feb 2020 16:33:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87r1ys7xpk.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/20 15:54, Vitaly Kuznetsov wrote:
>> -	schedule_delayed_work(&kvm->arch.kvmclock_sync_work,
>> -					KVMCLOCK_SYNC_PERIOD);
>> +	if (vcpu->vcpu_idx == 0)
>> +		schedule_delayed_work(&kvm->arch.kvmclock_sync_work,
>> +						KVMCLOCK_SYNC_PERIOD);
>>  }
>>  
>>  void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
> Forgive me my ignorance, I was under the impression
> schedule_delayed_work() doesn't do anything if the work is already
> queued (see queue_delayed_work_on()) and we seem to be scheduling the
> same work (&kvm->arch.kvmclock_sync_work) which is per-kvm (not
> per-vcpu).

No, it executes after 5 minutes.  I agree that the patch shouldn't be
really necessary, though you do save on cacheline bouncing due to
test_and_set_bit.

Paolo

> Do we actually happen to finish executing it before next vCPU
> is created or why does the storm you describe happens?

