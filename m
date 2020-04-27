Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1351CC4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB38820B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NpwnMS8K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgD0TJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:09:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21956 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726420AbgD0TJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588014585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fQf0JdKn9fSmRfZbYIguzX8UAvoKyiiMf06OglslXog=;
        b=NpwnMS8Ka/M0/qMumYd8zdwuw3KYblvQaWyjeL1AX5BqCcRJ8so1hzGlz/C6ez4YQUNUbB
        lEsQ2+FcWkHRwjsJRBrBv9jX0Urv1m0z5u7vXSFp17iuzRXRjS9jdUmW8WmZ58tgdlchuH
        kpFbsjJL61PwpXbI/iNtkOq9wMLLATY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-VacSErgFOA6KOodZkj3-FQ-1; Mon, 27 Apr 2020 15:09:43 -0400
X-MC-Unique: VacSErgFOA6KOodZkj3-FQ-1
Received: by mail-wr1-f69.google.com with SMTP id s11so11009144wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 12:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fQf0JdKn9fSmRfZbYIguzX8UAvoKyiiMf06OglslXog=;
        b=LBD6gvaq0gnd9i1Vsgc72BZjyKWBsAapHGeHTCtYEt3u1eIoB2uw7Ftjqo27iP7rIV
         DXMt7OFs/0BE/gKgjPAknX1Go5K9i2T73o+8r7ak4I6gi02mKU0SIYG+ciNcbN8IwQzo
         Xhnk+zt863DxrgxdlMPGpiAyn0FTUrReIg7p48THWVdRO2zsMFXrDgqWXwztHsUgWGnS
         0tuxGybw+0HJ41/lRXg2PXSD3aVCz8HPKKPmE2wdZ7Wyzh1Bb7nXeXUx7vKio/1CbcV8
         NjUVPQJXb80WSx4kSdHTITjzA+Qqa91fG7iQk7DJkKKg/AZbgbGrju3xyA4Rkv7raKC1
         GpMQ==
X-Gm-Message-State: AGi0PuZzyOUQy88PAx71bdx5pfMJZXgKdNwamIoeB83xsQ8C7uZYfJkj
        ACIGjY4LOpnTgW3eLySfheoVa7dIwr+KhMJ75hqkKBJTRfl4egrzCXqPqw7zlhQwgvUzz6ZExH7
        M+U7h20gZ8mFCLOieHRpa2UQ/
X-Received: by 2002:a1c:dc55:: with SMTP id t82mr219660wmg.12.1588014582461;
        Mon, 27 Apr 2020 12:09:42 -0700 (PDT)
X-Google-Smtp-Source: APiQypIZYNBAaiKQGOrg9835xWa2K0IRaCFS4dqVqf5n883HYptUYcWCRGPxH1I/rZd0YeqpukeqPA==
X-Received: by 2002:a1c:dc55:: with SMTP id t82mr219645wmg.12.1588014582249;
        Mon, 27 Apr 2020 12:09:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac19:d1fb:3f5f:d54f? ([2001:b07:6468:f312:ac19:d1fb:3f5f:d54f])
        by smtp.gmail.com with ESMTPSA id n2sm22714476wrq.74.2020.04.27.12.09.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 12:09:41 -0700 (PDT)
Subject: Re: [PATCH] KVM: VMX: Use accessor to read vmcs.INTR_INFO when
 handling exception
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200427171837.22613-1-sean.j.christopherson@intel.com>
 <8123dc4b-a449-a92c-85a1-c255fa2bbbca@redhat.com>
 <20200427173241.GJ14870@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3bad600c-71e6-c094-59a4-f82144adddb4@redhat.com>
Date:   Mon, 27 Apr 2020 21:09:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200427173241.GJ14870@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/20 19:32, Sean Christopherson wrote:
> No, I missed this case in the original patch, and the other fix was for
> incorrect sizing of an exit_qual variable.

Nevermind, I applied it twice and I got an "Already applied" message on
the second invocation.

