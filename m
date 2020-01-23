Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BACC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 12:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B09217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 12:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OIHqybvz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgAWMRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 07:17:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21181 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726026AbgAWMRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 07:17:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579781821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eh4yN5hoXKIHr0Y4kKL2j19glvafCP0ncaEOaLM+6RU=;
        b=OIHqybvzlTzyp+dl7Qlc3mq4wr9yakzV8RgHfDgbYDCp6uTlNKOX1yiLU0ntwtD8zH9BiD
        smOr0uXKX0TuvJOs+fTtDm8TaQyzOxmFr5jizMsyTKdm08lduUT2Hnx9kRlGERAwYdRQ5Q
        LkvdKCihnR6ALUGBTygkBontmg7v1Ho=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-rXMdXEbtPJCxpziHqwzLPw-1; Thu, 23 Jan 2020 07:16:58 -0500
X-MC-Unique: rXMdXEbtPJCxpziHqwzLPw-1
Received: by mail-wr1-f71.google.com with SMTP id f15so1633960wrr.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 04:16:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eh4yN5hoXKIHr0Y4kKL2j19glvafCP0ncaEOaLM+6RU=;
        b=fUU0r5dDVLc824EQTc4PUdUudILQLiLvVA3o9oN9rVO3rkT4JqXlNdC01THF3PcLOg
         rzQ7VYCtOhPnXdrNLrN0BzMpPpW5LB5QzSZHFRSJyljbq6jrdKw+Cb9+B5XQqLY0cPGo
         k1WAUkhrQBU5X+Pp+wR0UBX3Fm+UdewGjgZKOCbVteb2HmoWl9lS41M9htIUQ7gecMco
         f8u8mvJ3vqShrgTBLLz1vLls1ALBfZr95ujRVOK3xbWlo7CvqCNckOUv6ENwXtQMS8sW
         NNkC6mWOKwa2l1bTcVt9nGu8o+EmmlDSroo8fLKUkVtr3BFPlwG9wFHVjCsjIoqodE90
         Oy+g==
X-Gm-Message-State: APjAAAVUY4IvTahQ9oxApybVzL9BgcReO562yoQ4NErm32KgVRQvttwI
        qmf1WRY0zeJhENxWGjVn4OUTJWgLVfZsIpm4XBg7VLp+yNEyWh0jQtb/LUNaxPag0nzIPw62x6Q
        w1zUTTEukhTNIXHQwUI5Ktasu
X-Received: by 2002:a05:600c:210b:: with SMTP id u11mr3888525wml.43.1579781817255;
        Thu, 23 Jan 2020 04:16:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqwjrSg8QS3n58Hsbb+jpFpGNeljke+sE5P4DKFi46EAMGGsbNN5r4mMO0nv0ERsa+/0bhSuTA==
X-Received: by 2002:a05:600c:210b:: with SMTP id u11mr3888510wml.43.1579781817032;
        Thu, 23 Jan 2020 04:16:57 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059? ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
        by smtp.gmail.com with ESMTPSA id t25sm2489035wmj.19.2020.01.23.04.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 04:16:56 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: fix overlap between SPTE_MMIO_MASK and
 generation
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <1579623061-47141-1-git-send-email-pbonzini@redhat.com>
 <CANgfPd8fq7pWe00fKm7QEiOAVFuubSQ-jJxEM1sCKzqJk9rSzw@mail.gmail.com>
 <20200121210405.GA12692@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <533d3dd4-aa8e-07d0-2e8a-991fa758a366@redhat.com>
Date:   Thu, 23 Jan 2020 13:16:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200121210405.GA12692@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/20 22:04, Sean Christopherson wrote:
>> Alternatively, BUILD_BUG_ON((MMIO_SPTE_GEN_HIGH_MASK |
>> MMIO_SPTE_GEN_LOW_MASK) & SPTE_(MMIO and/or SPECIAL)_MASK)
> Or add both BUILD_BUG_ONs.

In the end I decided to revert MMIO_SPTE_GEN_HIGH_START to
PT64_SECOND_AVAIL_BITS_SHIFT (it makes sense since we use it for
shadow_acc_track_saved_bits_shift, and whether to use
shadow_acc_track_saved_bits_shift or MMIO_SPTE_GEN_HIGH_START depends on
the SPTE_SPECIAL_MASK bits) and use Ben's suggested BUILD_BUG_ON.

Paolo

