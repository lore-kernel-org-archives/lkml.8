Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE571C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946D82067D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G3iP1uQl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbgBRQbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 11:31:14 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26791 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726557AbgBRQbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 11:31:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582043471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1wux/ShdRZLS6eqfJ1i2bb+05bcGXuWlAmnT6X3Ge3Y=;
        b=G3iP1uQlW8oxKIQdN6bVlx605MVQ0K+Ld9qEIduHcQj64krHjUC8j5u5rvOc5tFcbV3x0h
        9XxYgxuScuGHj7YQtZzbjQEpOwrhCA6wtO5zSVwXASQi0CRy3XR21ZmujKKJ8vMR3Fzpx0
        pxBLyT4ZFzkf3gIYaXVnd6NMPXQ2N2E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-PV7vvRLNMn6yMlwRiqpgTg-1; Tue, 18 Feb 2020 11:31:06 -0500
X-MC-Unique: PV7vvRLNMn6yMlwRiqpgTg-1
Received: by mail-wm1-f69.google.com with SMTP id u11so286487wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 08:31:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1wux/ShdRZLS6eqfJ1i2bb+05bcGXuWlAmnT6X3Ge3Y=;
        b=Oi9fLPMvv/X6D6xn3bfD8fWJl13cl5IK+3blym7/8NnlJHLKC8qkF+CK/JIvxO6zLO
         kyhcFO4UwZIFCwZQd76GtmlXACN76UQmQcmX2wKbmMrGK5zlfGuVizsvo1KZ8T6SLIi3
         oFjTWrpkun+bKBCrfqZmzoh+Pt/OP/PLG0P0MOGXUzJoOJvh2DUVSSbyRDKIhDAs6FeM
         whmyDtEVSdmAEdaXX1ZuhqPzUz+n3g0QhLIHLSBT+G6IBa8s3aDI+wbbMf8gWgRRuVmr
         +zAH67l0yKFbT5Mya1lV3oDL3LjqaGozyT7rx4Qwl5lK7E35/76oH3hKvtTp0u/UasKc
         BtvQ==
X-Gm-Message-State: APjAAAX4lZ4sk3Z0PU0rd6KolGPBlXCRKLLktHGaozH3Jb9WCDHUZkpL
        phi4n1X7f/i8kqUVibGIMSm3OM6+hrdjz0tzRdtLx3bsM5zFtWZN82cF9s1YXVOlmcx5kwmfrEj
        C6dWFzdV5URbNKP0TDynfehwX
X-Received: by 2002:a1c:8055:: with SMTP id b82mr4053688wmd.127.1582043465300;
        Tue, 18 Feb 2020 08:31:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqxcbLjDdl8yYBOLssLztWaiKZt1qolfF/drqUpVyQbR31GyH51q/Z7meOxgMs3aCiblWpkLYA==
X-Received: by 2002:a1c:8055:: with SMTP id b82mr4053661wmd.127.1582043465086;
        Tue, 18 Feb 2020 08:31:05 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:59c7:c3ee:2dec:d2b4? ([2001:b07:6468:f312:59c7:c3ee:2dec:d2b4])
        by smtp.gmail.com with ESMTPSA id e6sm4179931wme.3.2020.02.18.08.31.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 08:31:04 -0800 (PST)
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
 <e6caee13-f8f7-596c-fb37-6120e7c25f99@redhat.com>
 <87mu9f97uv.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8804030e-db83-d212-d712-807833f9fd7e@redhat.com>
Date:   Tue, 18 Feb 2020 17:31:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87mu9f97uv.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/20 17:29, Vitaly Kuznetsov wrote:
>> No, it executes after 5 minutes.  I agree that the patch shouldn't be
>> really necessary, though you do save on cacheline bouncing due to
>> test_and_set_bit.
> 
> True, but the changelog should probably be updated then.

Yes, I agree.

Paolo

