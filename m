Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22BEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A555D21548
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ioNAQOyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389702AbgE1MJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 08:09:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52798 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388719AbgE1L4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590666984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G6bfws9MwiCCMvZrWzAJyuiNns7YUWzpHu60JOrsU/o=;
        b=ioNAQOyAk3Nvh4QkzR9TsE/eZ4ArnhV+SbravI0D11VUtU8XxidrQU3SRkSUNoOzm0PZpq
        9OT1YIzOpLXC46huL3kR03ueZlyGUhVQM9VbjqA7RuvEq9LNNV028FKMqohbfgZT1lSHO+
        74iraG9KhcTY/0DSlGcTaKzY0FEhQUA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-WdqUe5YLP1Od-t-09kMlbQ-1; Thu, 28 May 2020 07:56:23 -0400
X-MC-Unique: WdqUe5YLP1Od-t-09kMlbQ-1
Received: by mail-wm1-f69.google.com with SMTP id u15so887658wmm.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 04:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G6bfws9MwiCCMvZrWzAJyuiNns7YUWzpHu60JOrsU/o=;
        b=Nsgp2vrhYvld0edhf0hDl9+xwUq/AsxiypO+c9Zgzzh+8Nz/i7D9RZPkPRDd2pPzYo
         2mGYdCRU08JD+MJbW0j94iVgzheIEWUa/sTmBrakZwNKQw5WqwrkI1K3f+N7jZFv9Eq0
         ACDYyEmK3hrq1+NinTjcIh6Stl5C3ZqyJdOs+rL8Nk49OjqUKs3842WdmoXWEdp9cHsU
         WNTqRauaFi+Lt9L8gKajuj8u9alc6qk7ofmfqOa/UN9Xm5Hyas0I0Lp8W09zXybZ/owU
         m9ZjKvl8gyOyigf9f0rVqzq6GyuL+6MQhOMFocOgRuyxZuNxdeHpM36628ba9Jqz0u67
         sssg==
X-Gm-Message-State: AOAM531LCBp4w3eZTfuVR8MPCiBeHdzWOBmlqASAcqzlw/K+TePG2W2u
        J0MqzsLKf9khaMryiOgh6E9tn/jqsvSTRd2SFezpYZxvf6bPQPNcJFTKFlZ2wS/xClUJafGluo2
        CCBIl+0VjRfYTzR/guP+OfCwc
X-Received: by 2002:a05:600c:146:: with SMTP id w6mr2984000wmm.97.1590666981590;
        Thu, 28 May 2020 04:56:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJbHKuC/6XBtiV1KUuSLpUmiBDD5SLecdb26n6zIP6TbQf3zEubqSsXxt97G1Deyo1noUmFA==
X-Received: by 2002:a05:600c:146:: with SMTP id w6mr2983988wmm.97.1590666981329;
        Thu, 28 May 2020 04:56:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8? ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
        by smtp.gmail.com with ESMTPSA id h74sm5853862wrh.76.2020.05.28.04.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 04:56:20 -0700 (PDT)
Subject: Re: [PATCH] KVM: selftests: Add .gitignore entry for
 KVM_SET_GUEST_DEBUG test
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200528021624.28348-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ce6a5284-e09b-2f51-8cb6-baa29b3ac5c3@redhat.com>
Date:   Thu, 28 May 2020 13:56:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200528021624.28348-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/20 04:16, Sean Christopherson wrote:
> Add the KVM_SET_GUEST_DEBUG test's output binary to .gitignore.
> 
> Fixes: 449aa906e67e ("KVM: selftests: Add KVM_SET_GUEST_DEBUG test")
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  tools/testing/selftests/kvm/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> index 222e50104296a..d0079fce1764f 100644
> --- a/tools/testing/selftests/kvm/.gitignore
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -3,6 +3,7 @@
>  /s390x/resets
>  /s390x/sync_regs_test
>  /x86_64/cr4_cpuid_sync_test
> +/x86_64/debug_regs
>  /x86_64/evmcs_test
>  /x86_64/hyperv_cpuid
>  /x86_64/mmio_warning_test
> 

Queued, thanks.

Paolo

