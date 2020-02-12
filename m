Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE8AC3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2738D20675
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb-com.20150623.gappssmtp.com header.i=@scylladb-com.20150623.gappssmtp.com header.b="uEMcigeg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgBLKyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:54:37 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:51380 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgBLKyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:54:37 -0500
Received: by mail-wm1-f54.google.com with SMTP id t23so1631961wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 02:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=u0hbtEe40WtjYd4Z3cF7cNzYLzfg1k4LAZeLlhEhqPc=;
        b=uEMcigegIefRrGr+eDX7uy0nV0LzCM5v2XSBfBZS60IkGfAg+JqGCP3rP15GsFBN6z
         MU0ABFdW877uVg1il17ntz+OhuLlWoevBQV2K7LFOEM7T7w4p8Qi+uHob7okQxAmHbNm
         hgRx8WKev5+DGFUT0kmeErmLPVF84rDsi6fyRHjDb7p/mTIBsLNaB3mJgF+46HfXPx71
         SdWHbStfhb2v9U09D34BBuDFRWvoot5kD/7gkFO+vtjXfwcCuIrz9PAEhQ+MCOmzTrSY
         Z9iUNfR8rVyJhfx619Wmir+mMd7kveGe1OL47f2SjMtNbx7dkplbITUg8jUeEa4cwhkL
         FEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=u0hbtEe40WtjYd4Z3cF7cNzYLzfg1k4LAZeLlhEhqPc=;
        b=WXOy3BC/eIPHyWuEBRKOw+jrZZsyk8/i09prC1QXHOCm4j4WRNIQbVCoR5nPvwC/Wr
         MKkWP8N1hlBCVJikux7NJ3S+CwKb5ly8chVDguCFTUw73TV/D/0nrJ4tbBbdAA7mTfzt
         hNUR/tsTqcCMgsSkB+Isnya+7gPzgujqSRX9/0XBp2pBnqxLYP6+Ktrep8J5SyyGfwkv
         sfIkWTJMiFC5yTcnVCQuyVOfE5NsdCAig3gnva9LBwdlIlrYrEwM93cQMB46/2emnHzT
         y0fPwGPMWjyAi/JrJkyDKaiCCqk3SGZ1byzRr/WG+MIfWpi8XoGLRzi9AZT0myIdD+oW
         nT0Q==
X-Gm-Message-State: APjAAAUzXfG0jcPMmdYaaaSlnJ6VPIzW7szj845utM92458EclGQOo5A
        bA4FfYsPIeX03Oc2/sipNeXnXA==
X-Google-Smtp-Source: APXvYqzYXtkZvCRJnNbFl2gXB2hBpm//tPq+iQ3d9s3L2TXBxnpsoSkLEFvY0Sp+AYMiw6a8HLYDrg==
X-Received: by 2002:a1c:7712:: with SMTP id t18mr3942812wmi.32.1581504873707;
        Wed, 12 Feb 2020 02:54:33 -0800 (PST)
Received: from [10.0.0.1] (system.cloudius-systems.com. [199.203.229.89])
        by smtp.gmail.com with ESMTPSA id f11sm242610wml.3.2020.02.12.02.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 02:54:32 -0800 (PST)
Subject: Re: [RFC] eventfd: add EFD_AUTORESET flag
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@gmail.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Davide Libenzi <davidel@xmailserver.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20200129172010.162215-1-stefanha@redhat.com>
 <66566792-58a4-bf65-6723-7d2887c84160@redhat.com>
 <20200212102912.GA464050@stefanha-x1.localdomain>
 <156cb709-282a-ddb6-6f34-82b4bb211f73@redhat.com>
From:   Avi Kivity <avi@scylladb.com>
Organization: ScyllaDB
Message-ID: <cadb4320-4717-1a41-dfb5-bb782fd0a5da@scylladb.com>
Date:   Wed, 12 Feb 2020 12:54:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <156cb709-282a-ddb6-6f34-82b4bb211f73@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/02/2020 12.47, Paolo Bonzini wrote:
> On 12/02/20 11:29, Stefan Hajnoczi wrote:
>> On Wed, Feb 12, 2020 at 09:31:32AM +0100, Paolo Bonzini wrote:
>>> On 29/01/20 18:20, Stefan Hajnoczi wrote:
>>>> +	/* Semaphore semantics don't make sense when autoreset is enabled */
>>>> +	if ((flags & EFD_SEMAPHORE) && (flags & EFD_AUTORESET))
>>>> +		return -EINVAL;
>>>> +
>>> I think they do, you just want to subtract 1 instead of setting the
>>> count to 0.  This way, writing 1 would be the post operation on the
>>> semaphore, while poll() would be the wait operation.
>> True!  Then EFD_AUTORESET is not a fitting name.  EFD_AUTOREAD or
>> EFD_POLL_READS?
> Avi's suggestion also makes sense.  Switching the event loop from poll()
> to IORING_OP_POLL_ADD would be good on its own, and then you could make
> it use IORING_OP_READV for eventfds.
>
> In QEMU parlance, perhaps you need a different abstraction than
> EventNotifier (let's call it WakeupNotifier) which would also use
> eventfd but it would provide a smaller API.  Thanks to the smaller API,
> it would not need EFD_NONBLOCK, unlike the regular EventNotifier, and it
> could either set up a poll() handler calling read(), or use
> IORING_OP_READV when io_uring is in use.
>

Just to be clear, for best performance don't use IORING_OP_POLL_ADD, 
just IORING_OP_READ. That's what you say in the second paragraph but the 
first can be misleading.


