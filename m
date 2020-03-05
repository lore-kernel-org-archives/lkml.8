Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506A0C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238F520848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V12JsjHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgCEP6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:58:40 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29948 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726143AbgCEP6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:58:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583423919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vcmbPSG7Ns1BCQM6qMZvbDUeuBY81aAMlv0waXN9f5o=;
        b=V12JsjHTImEGtUWIvsWV9HLWkNDzBEKSGyTp82xGobfleUqg149FBO/KyA+MWks4nVlzj8
        V0wDetNxi2fmDjDucbXxigscxiUbEtowV2YB2gTguESik5KLjXsX+D7xAZLj0RGl0idpT/
        9TVy38AU7yIcCA8Ywgyml+UOfN64ToE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-PIHivq34MQeIWEw2WWR3zQ-1; Thu, 05 Mar 2020 10:58:37 -0500
X-MC-Unique: PIHivq34MQeIWEw2WWR3zQ-1
Received: by mail-wm1-f71.google.com with SMTP id d129so2259628wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 07:58:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=vcmbPSG7Ns1BCQM6qMZvbDUeuBY81aAMlv0waXN9f5o=;
        b=RtG3y3j92+nDH4S7eLy+dtLvO6HfIU/mIlPrbawOcXwJzZkUB1wGS2Z9Ly7I5WOaAu
         n3Z6LXYkAZwgHNd2Qwufw6S+wxpgbs6umUuatSt8zTIyXAKxqUmG5qcboOT84zlN/1nN
         fWE/xXXKEwm907GUqBlSm1bJH1jPJUDDPbKJTjMngqwg7KIQpCsrJHNBXgN81yw9bm2X
         uT9e8g53HZpXzrQSGFWWTmzTSYBbc8zStCYhI1c2rp0cETwz9+5+jk+6yuqb4iGJq4lK
         jFJl8ey8x87KjALkexF7srTqBrasMzcJWtiYtwlO+0EvAo9bqp+tkzUauDuIwZ3ehwOm
         UJfA==
X-Gm-Message-State: ANhLgQ3JIREiLLyFfN30koiok7Nti6jGdX7Id0V4emgdjSEsA+N8/6Zz
        5qE3Wi94G3CRurdIkzQc/IbgPWk8Y52nZouTZVgepUQr6g+ny6tF+8gkh2gUuI8AIdQ6UN8w0LL
        J3tIKsfexQLElE694bGxefu6m
X-Received: by 2002:a5d:630a:: with SMTP id i10mr10613139wru.273.1583423916362;
        Thu, 05 Mar 2020 07:58:36 -0800 (PST)
X-Google-Smtp-Source: ADFU+vs2tnnfpQubkBdyyW38Ps48EoLmLBMqtqEn0LHkSSBuz/+LpaZRPiwmvos+UYZioFDdZJfdLg==
X-Received: by 2002:a5d:630a:: with SMTP id i10mr10613126wru.273.1583423916167;
        Thu, 05 Mar 2020 07:58:36 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id d203sm9339731wmd.37.2020.03.05.07.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 07:58:35 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: x86: VMX: rename 'kvm_area' to 'vmxon_region'
In-Reply-To: <20200305153623.GA11500@linux.intel.com>
References: <20200305100123.1013667-1-vkuznets@redhat.com> <20200305100123.1013667-2-vkuznets@redhat.com> <20200305153623.GA11500@linux.intel.com>
Date:   Thu, 05 Mar 2020 16:58:35 +0100
Message-ID: <875zfig5ec.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Super nit: can I convince you to use "KVM: VMX:" instead of "KVM: x86: VMX:"?
>
>   $ glo | grep -e "KVM: x86: nVMX" -e "KVM: x86: VMX:" | wc -l
>   8
>   $ glo | grep -e "KVM: nVMX" -e "KVM: VMX:" | wc -l
>   1032
>
> I'm very conditioned to scan for "KVM: *VMX:", e.g. I was about to complain
> that this used the wrong scope :-)   And in the event that Intel adds a new
> technology I'd like to be able to use "KVM: Intel:" and "KVM: ***X:"
> instead of "KVM: x86: Intel:" and "KVM: x86: Intel: ***X:" for code that is
> common to Intel versus specific to a technology.

What if someone else adds VMX instead? :-)

Point taken, will use 'KVM: VMX:' in the future (and I'm in no way
object to changing this in the queue if it's not too late).

-- 
Vitaly

