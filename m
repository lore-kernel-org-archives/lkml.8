Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E52C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05EFE20757
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3jXwt47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgD2Rk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:40:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49762 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726822AbgD2Rk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 13:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588182056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ifxZyJaIcgDMF24Z/FnGdjxceJQS9w7pXlbPKDemc0=;
        b=Q3jXwt47s/rLcW65RCo4z8AFPM7E7U8cxtTpYwJddsT8t+gWSu+DJiNR+A1SF0KL04BYsh
        7z/4DAzWtZQ4x5PGKLDg45nkL6OLw4lFUIoK6vQr5F2AQY4SZsMof1APlCSMZF6EpcAXrq
        0pDFZ4/q9qq9JDpcH6rxPZ1/uKyhvwA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-dtlrjSQBNNWyFAZH5nv2vA-1; Wed, 29 Apr 2020 13:40:55 -0400
X-MC-Unique: dtlrjSQBNNWyFAZH5nv2vA-1
Received: by mail-wr1-f69.google.com with SMTP id y10so2118234wrn.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 10:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+ifxZyJaIcgDMF24Z/FnGdjxceJQS9w7pXlbPKDemc0=;
        b=n2YQob6EE0eWNMvxR9u9k4yHYj1s9Fp7kFzYkmY4P93aE+T8887kSQ5/0nWcMZH05B
         eWdcbC3V+ySYaq1A7HyvjBJEKuzLXTpg7sVAM0pcPour2CWeSOkSBsSWi3B9eBDyfmjP
         22uvOVRDaoMkocnyrregdrvlM6aaKDPACRp6LgUF3EcFLlTTfFvaTKOLVb21cR6sUpet
         Di4mUPdkCd3+xOhpYXKMbDeS76Jw+EqzwH4hCfnXZzxXjzO1zb9h8GMNRPr/jn3lRhj5
         +CTAm8Mw1IlZyBZe8fqJV9A5WvAuMyO8PO+5HjuhCd1xmbXNKVh1ET9kdn0WnvZtwq5R
         2UUg==
X-Gm-Message-State: AGi0PubEwt1FTmukfvjUJ0aMIggjKUzAWSv59PACEPGsPRKKukVKyye6
        mh2QsYh0lcqk+48YBJMz2bLJ/rYMPQSDXRlfqJWfAbU4K7YYZKoOCOIT3YGxPGJG2mAQKGf3uTE
        8sOyMDPS6lIJfUE9xKWi1x+L7
X-Received: by 2002:a1c:1d92:: with SMTP id d140mr4387554wmd.67.1588182054031;
        Wed, 29 Apr 2020 10:40:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypKJurOLijS7qOB8eqd6TzSPyHSGOpNFHCTkIqRnaycYuXvYCsf9epD1BeOSFaygjfwcKqsDRA==
X-Received: by 2002:a1c:1d92:: with SMTP id d140mr4387530wmd.67.1588182053727;
        Wed, 29 Apr 2020 10:40:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2c8e:3b22:4882:7794? ([2001:b07:6468:f312:2c8e:3b22:4882:7794])
        by smtp.gmail.com with ESMTPSA id n6sm33498690wrs.81.2020.04.29.10.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 10:40:53 -0700 (PDT)
Subject: Re: [PATCH RFC 4/6] KVM: x86: acknowledgment mechanism for async pf
 page ready notifications
To:     Andy Lutomirski <luto@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     X86 ML <x86@kernel.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>
References: <20200429093634.1514902-1-vkuznets@redhat.com>
 <20200429093634.1514902-5-vkuznets@redhat.com>
 <CALCETrXEzpKNhNJQm+SshiEfyHjYkB7+1c+7iusZy66rRsWunA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0de4a809-e965-d0ad-489f-5b011aa5bf89@redhat.com>
Date:   Wed, 29 Apr 2020 19:40:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CALCETrXEzpKNhNJQm+SshiEfyHjYkB7+1c+7iusZy66rRsWunA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/20 19:28, Andy Lutomirski wrote:
> This seems functional, but I'm wondering if it could a bit simpler and
> more efficient if the data structure was a normal descriptor ring with
> the same number slots as whatever the maximum number of waiting pages
> is.  Then there would never need to be any notification from the guest
> back to the host, since there would always be room for a notification.

No, it would be much more complicated code for a slow path which is
already order of magnitudes slower than a vmexit.  It would also use
much more memory.

> It might be even better if a single unified data structure was used
> for both notifications.

That's a very bad idea since one is synchronous and one is asynchronous.
 Part of the proposal we agreed upon was to keep "page not ready"
synchronous while making "page ready" an interrupt.  The data structure
for "page not ready" will be #VE.

Paolo

