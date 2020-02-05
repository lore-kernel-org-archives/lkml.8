Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C33C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF7DB217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Don0MEq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgBEO5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:57:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51450 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727104AbgBEO5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580914619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QK9rDhAQMTvm/4oE1owAxCKM6SK1FUKWk+UU1I8wspU=;
        b=Don0MEq7VPayXQ1EBvjikjF+rsRCs2LLY/yrP6gleLjkH4wCTWjmyZHZiWxf9iXWjORz87
        4HUR/IPGT63h8lBeczHKuq+TdJHBvQqSuBh04OSB55GyXGVkgIa1rXhXaeuIJgSGFrBdPP
        K1zr0hn0sGi7CWPAEpbRFp+9kNYkin4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-DNBfUdS7N8CoqCrZ_es0eg-1; Wed, 05 Feb 2020 09:56:57 -0500
X-MC-Unique: DNBfUdS7N8CoqCrZ_es0eg-1
Received: by mail-wr1-f70.google.com with SMTP id u8so1302646wrp.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 06:56:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QK9rDhAQMTvm/4oE1owAxCKM6SK1FUKWk+UU1I8wspU=;
        b=eXPYOSzmalt9S0mWdOSicHCg+tLuqkXQjfTGpBcFQHwi1thFtZIDXvp+7nzd+e22hu
         qxdTEeJY8pK+4gru2OYRNEnohDUFGKqusyfC0wFz8JWg3Zut7VMArkk2Q3gQNSVyt6pv
         QJWsd8P6XjGGZfQMj0Yfwz3DPtysdlYRBzvd5k7UNTs7iHKs1tWeO1L4swAk1qZKjxWy
         BUJAR/pz7i2BArCxYB7zZZPH1o1tpoPTE3YUlBq52AvezE38aZvJQDRpgFDsyBRm2VUY
         o4xHCc4eDtyvYdrRcejNC1M59TjHlIB9TM2MpnIR0uYbovO8KV8RNevHQoVrIGW9r5F5
         nZGw==
X-Gm-Message-State: APjAAAUBY/WvGWOYoVCCd8O3+AKBV31MhnDrz4IhhLGitqEHLchiQchB
        FlNa7c74VLYRfoHhU698vGINdKVlk7jtCGJa/57/zdKTTvJr0/9aG3pypMML0htmU3KFaN9frPU
        AgMeDchtuaH9vUwh/cl7Q5aDO
X-Received: by 2002:adf:e984:: with SMTP id h4mr29308653wrm.275.1580914616566;
        Wed, 05 Feb 2020 06:56:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqz9qVZf32IzPnrUnSW4dGxh2PrlWaXwxprYQ5Jf4CLVaSlHpYNNxo2ZuvnMLVpXaD/j4TWLmA==
X-Received: by 2002:adf:e984:: with SMTP id h4mr29308639wrm.275.1580914616383;
        Wed, 05 Feb 2020 06:56:56 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56? ([2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56])
        by smtp.gmail.com with ESMTPSA id f127sm8396652wma.4.2020.02.05.06.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 06:56:55 -0800 (PST)
Subject: Re: [kvm-unit-tests PATCH] x86: pmu: Test WRMSR on a running counter
To:     Eric Hankland <ehankland@google.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20200204012504.9590-1-ehankland@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ab91afac-baca-d901-67a7-04979bfcbbfa@redhat.com>
Date:   Wed, 5 Feb 2020 15:56:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200204012504.9590-1-ehankland@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/20 02:25, Eric Hankland wrote:
> Ensure that the value of the counter was successfully set to 0 after
> writing it while the counter was running.
> 
> Signed-off-by: Eric Hankland <ehankland@google.com>
> ---
>  x86/pmu.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/x86/pmu.c b/x86/pmu.c
> index cb8c9e3..8a77993 100644
> --- a/x86/pmu.c
> +++ b/x86/pmu.c
> @@ -419,6 +419,21 @@ static void check_rdpmc(void)
>  	report_prefix_pop();

Queued, thanks.

Paolo

