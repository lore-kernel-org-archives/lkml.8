Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AAFC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89C75206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 16:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AsoVVWdB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgDUQTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 12:19:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43371 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725963AbgDUQTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 12:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587485963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OMcMRkM6CTuHPozam45N2SC6f9ykAvtZFSzHRVou/uA=;
        b=AsoVVWdBWRH9cesQdRTu4ouK+9eHzMPngDf4Wme+bgYVFv7xn0WmI/GdCFumsk8u1N9iMr
        MJSu+XAhIaJZ41duAnEriFm69xyxcCS6N+4fwYqk+84QY16H/2WkSAAu34Kc4eI9biON4r
        BQ+dhkAUF+UDM1Q593WHMj41+IJGM8g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-Gj5_K_4hOPOnqKI3PX4JEQ-1; Tue, 21 Apr 2020 12:19:18 -0400
X-MC-Unique: Gj5_K_4hOPOnqKI3PX4JEQ-1
Received: by mail-wr1-f69.google.com with SMTP id y10so2620270wrn.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 09:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OMcMRkM6CTuHPozam45N2SC6f9ykAvtZFSzHRVou/uA=;
        b=R45whyDyeDnPWZ/Iz9xwLaS9rUzpd8nrf9k5NFRkefdFOIJ9+gsicY8cZ7YOhzgd5N
         49HIPQuIr+nXlpfg3F9X09mEx4Hnk83R36LSZtsutE59DBcup14YHCYzF00RnYZ1QmSD
         LGeMzU+Z58xNzq14TBAyhWGvi17DgiqvacQ0jkBsuT70B8bydTXapxANvJjjaLhvEaWt
         /gW3nSIUZFeRquP3KrnPvlGFBLndDtN6Zab5EKdb3CYtu+Oi+PB9n0rV3n8+oLtEIP+E
         ZLxtm+RMESViTJ1QSVz0o0qsk9GtlgDUqWVkjjJgeSXuFUvN+GINNsQ92nRB5QKxPC9S
         eIaA==
X-Gm-Message-State: AGi0PubLcLahJaIgA2hQS2hieAFzHj9homlRlvxSFgw5i6OwBa17rqzY
        eVeUNO9RPw+PG3KYcZ9K+zVbzI8zZz3vTJFm3S7qFNyy3G1CGzYL7og+pWZTUMFcWPw/likbC4z
        n5p2umZa5ZPRTVdxJmLoRqd9I
X-Received: by 2002:a5d:6504:: with SMTP id x4mr26598662wru.164.1587485957603;
        Tue, 21 Apr 2020 09:19:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypLBExtm46kFG/q5uOgEqHEeaUuSrp481aTEfOfkh5uRE39whBLwSFtgA3GXRG/Qo3jvvfG+iQ==
X-Received: by 2002:a5d:6504:: with SMTP id x4mr26598644wru.164.1587485957403;
        Tue, 21 Apr 2020 09:19:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f43b:97b2:4c89:7446? ([2001:b07:6468:f312:f43b:97b2:4c89:7446])
        by smtp.gmail.com with ESMTPSA id s8sm4112831wru.38.2020.04.21.09.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 09:19:16 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] KVM: VMX: Unionize vcpu_vmx.exit_reason
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
References: <20200421075328.14458-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bcf9cbba-6cce-f10b-da94-232403a3f7f6@redhat.com>
Date:   Tue, 21 Apr 2020 18:19:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200421075328.14458-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/20 09:53, Sean Christopherson wrote:
> Minor fixup patch for a mishandled conflict between the vmcs.INTR_INFO
> caching series and the union series, plus the actual unionization patch
> rebased onto kvm/queue, commit 604e8bba0dc5 ("KVM: Remove redundant ...").
> 
> Sean Christopherson (2):
>   KVM: nVMX: Drop a redundant call to vmx_get_intr_info()
>   KVM: VMX: Convert vcpu_vmx.exit_reason to a union
> 
>  arch/x86/kvm/vmx/nested.c | 39 ++++++++++++++---------
>  arch/x86/kvm/vmx/vmx.c    | 65 ++++++++++++++++++++-------------------
>  arch/x86/kvm/vmx/vmx.h    | 25 ++++++++++++++-
>  3 files changed, 83 insertions(+), 46 deletions(-)
> 

Thanks, I queued patch 1.  I am not too enthusiastic about patch 2, but
when SGX comes around it may be a better idea.

Paolo

