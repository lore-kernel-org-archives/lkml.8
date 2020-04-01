Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A3AC2D0E8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 00:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DCF20787
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 00:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ek2hrAHc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731553AbgDAAfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 20:35:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56215 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729514AbgDAAfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 20:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585701339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nUYw2tAk2ElDzMusCcbVaLfYkke7kPKvnnUATst9aPY=;
        b=ek2hrAHcUHA0w0cTgSM7Dfn1kh+joOfUleB0FDjaUPtNyr6eRAzr+ME0v9D3k77SiWWpFx
        VcbdZwK/RaGVAzfNuWm5/mBi6GOnyAqxfmXcEfUiZuWFSE/5hi4Lo/6KmCuzFNBYxHzfVZ
        OD8uPYQNNVoajwlc3K5mgOMgcEg4dG4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-KPhDReGPMu24VIfo0neQTg-1; Tue, 31 Mar 2020 20:35:36 -0400
X-MC-Unique: KPhDReGPMu24VIfo0neQTg-1
Received: by mail-wr1-f70.google.com with SMTP id b2so13275946wrq.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 17:35:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nUYw2tAk2ElDzMusCcbVaLfYkke7kPKvnnUATst9aPY=;
        b=mvh2HEeoKhLze2uP/sZ466Bik1vH72Xeo0nLz071A/pcD69g5df9RZHL0sRJis989N
         r/0Y+Q8HrcAonulRiTkZRVVvdOZkXVKwn1jdaAtWUuKaqNbzPJb+gzvnz6FOZzL/9em2
         H+M7wxFSQDZAuPG4F8VtmAwLlWAhbv173/39W3uT8o86VfGAHnP53+gxerZSZW4Yhjik
         bgCnh5W4wHAzgJM/aL5zphc1+A1VZy+xXezecTJDw9GdUPIuXG3sTgXwTrJQgPg4kw3c
         0XRazoXPhG9XLZIUzon38QjITCshnoWr5v12NAY22JU/0jhfIuZ40tAdiG7WYEUQga+o
         mrVw==
X-Gm-Message-State: ANhLgQ3pTD3FH7Xtj5fkkQuty9RLCmLacZJcFRn8ZZI5STMfANv7J5Vx
        bBCdnBwxCvmXntcjmFgKavbnEO7tA0PJRZQWHiBUDvEnjFtbc4CoCF83qLaIJrwH6MSC6+cEchI
        7QHyRjAneS/aX25pIgFf6zRcO
X-Received: by 2002:a5d:6045:: with SMTP id j5mr22859745wrt.401.1585701335108;
        Tue, 31 Mar 2020 17:35:35 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsu1SKpiUOGspGol9SelarOc4faOore5cmYKuXnJXLQ8H5FnAv74R3mri0v4DKf1Dgdrl2WkQ==
X-Received: by 2002:a5d:6045:: with SMTP id j5mr22859728wrt.401.1585701334854;
        Tue, 31 Mar 2020 17:35:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b55d:5ed2:8a41:41ea? ([2001:b07:6468:f312:b55d:5ed2:8a41:41ea])
        by smtp.gmail.com with ESMTPSA id i21sm400563wmb.23.2020.03.31.17.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 17:35:34 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] KVM: LAPIC: Don't need to clear IPI delivery
 status in x2apic mode
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1585700362-11892-1-git-send-email-wanpengli@tencent.com>
 <1585700362-11892-2-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6de1a454-60fc-2bda-841d-f9ceb606d4c6@redhat.com>
Date:   Wed, 1 Apr 2020 02:35:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1585700362-11892-2-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/20 02:19, Wanpeng Li wrote:
> -		/* No delay here, so we always clear the pending bit */
> -		val &= ~(1 << 12);
> +		/* Immediately clear Delivery Status in xAPIC mode */
> +		if (!apic_x2apic_mode(apic))
> +			val &= ~(1 << 12);

This adds a conditional, and the old behavior was valid according to the
SDM: "software should not assume the value returned by reading the ICR
is the last written value".

Paolo

