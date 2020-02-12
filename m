Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC854C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0D020675
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XgqXDyTc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgBLLnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:43:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28180 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728147AbgBLLnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 06:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581507793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IEsa1BUq0bWPEOZUtW+wdRfon7IBIMbGMK3y3jxH0WI=;
        b=XgqXDyTci9kc+rOUxebQ3foyNSJg5XWv6WzUhLjx7aMnxOrJhRSm7kkN3GTnYNT8C9wPE/
        vrO1BrQ2atawpUuQY+f1q0r9gvTdIwt5dEZNpZ9kXI0gxOoYLSnQpraiGOjllOA3VD0069
        TJdO7x9SIFBg9kb9kzrKqZAiE0SO8WE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-r6i-q6JRP8KvGRX-35u-cg-1; Wed, 12 Feb 2020 06:43:11 -0500
X-MC-Unique: r6i-q6JRP8KvGRX-35u-cg-1
Received: by mail-wr1-f71.google.com with SMTP id u8so705805wrp.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 03:43:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IEsa1BUq0bWPEOZUtW+wdRfon7IBIMbGMK3y3jxH0WI=;
        b=iEQp0hZEctv5Xo1K7ZPRkuNlXW9JwRKzyl+Ercz7Yh+VrFquV9twukubBkeWE/sye7
         9AmTRoUd9fBGwYdg3PKb9fAOpDfWHYcUTJkH0B8iOya1DeOE57eYH/1T22K7iTeZG0Bi
         ueGWkgLyH6rS0Dxy1Af9zj4F5nItfeHAT47HrKOWBH9JGaKKNt/TcMHlTG6kudNSUHgE
         aBkdEpKfEiq1GRzItS+0/QEMM0E9cE0JEE61Mq7PPIAtsXS/nUFYWuHIlS0qP7uqaNCt
         NzHvEmYfIoeiNZwfcvcw8zKJMDhTK+D/YIdWzaxSNQoQijArTUjTjz990R7b6QRLxCRW
         R+CA==
X-Gm-Message-State: APjAAAV8YWEauKzYKv9Tac0P5/V4Juzrb5a6Jrzdujpl7phrTOq4WNzK
        Lsr0w0SVNo5VjwpC7joQF8milkuxscCkhAA5ictpCrUdGuyd5uO2hoeuRMdyzDGhPzA14fuBD6+
        TTRpCvnqagJyGTaDiaAtbH1IX
X-Received: by 2002:a7b:c0c7:: with SMTP id s7mr13029513wmh.129.1581507790624;
        Wed, 12 Feb 2020 03:43:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqyvvGB6t9rTwkD5wOcWPzS3g4rf1aL3jnLVeGk4ga2e33TJdyaD2AbO4OgPZgsH90lWZaY+4Q==
X-Received: by 2002:a7b:c0c7:: with SMTP id s7mr13029498wmh.129.1581507790434;
        Wed, 12 Feb 2020 03:43:10 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:652c:29a6:517b:66d9? ([2001:b07:6468:f312:652c:29a6:517b:66d9])
        by smtp.gmail.com with ESMTPSA id n3sm389509wmc.27.2020.02.12.03.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 03:43:08 -0800 (PST)
Subject: Re: [PATCH v4 3/3] selftests: KVM: SVM: Add vmcall test
To:     Auger Eric <eric.auger@redhat.com>, Wei Huang <wei.huang2@amd.com>
Cc:     eric.auger.pro@gmail.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, vkuznets@redhat.com, thuth@redhat.com,
        drjones@redhat.com
References: <20200206104710.16077-1-eric.auger@redhat.com>
 <20200206104710.16077-4-eric.auger@redhat.com>
 <20200206173931.GC2465308@weiserver.amd.com>
 <130c32bc-7533-1b4e-b913-d9596ed4e94d@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7f9c89b5-c1df-011f-917d-89d2e880049d@redhat.com>
Date:   Wed, 12 Feb 2020 12:43:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <130c32bc-7533-1b4e-b913-d9596ed4e94d@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/20 11:15, Auger Eric wrote:
>> Probably rename the file to svm_nested_vmcall_test.c. This matches with
>> the naming convention of VMX's nested tests. Otherwise people might not know
>> it is a nested one.
> From what I understand, all the vmx_* (including vmx_tsc_adjust_test for
> instance) are related to nested. So I'd rather leave svm_ prefix for
> nested SVM.

That is not strictly necessary, as there could be tests for Intel or
AMD-specific bugs or features.  But in practice you are right, "vmx_"
right now means it's testing nested.  We can rename all of them to
"nvmx_*" and "nsvm_*", but in the meanwhile your patch does not
introduce any inconsistency.

Queued, thanks!

Paolo

