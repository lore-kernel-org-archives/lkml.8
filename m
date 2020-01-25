Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A21C35242
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 09:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730942070A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 09:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQgN+UN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgAYJje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 04:39:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29893 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725945AbgAYJje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 04:39:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579945173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tSakUTi8biBaDO4JGr8rcWBisLF05BHEM8+vn5mJmsg=;
        b=EQgN+UN6Y3h081mR+63On/k5A7TcdvMpOWbQhiIX2gPu1j7MqprntgE7zMtFdhVOxGNmdQ
        Wxj4mkFcVPJP1btQ+JbCJBW+J40siyQxVqOtC4Ami+5NdmvCwDVrboSzXv/8BX/uHEMp3d
        hn9eBPo1gS/OWxwyqCw3iQczxzsi4LE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-31lPr5QoP2CtWIaxWU6ENw-1; Sat, 25 Jan 2020 04:39:24 -0500
X-MC-Unique: 31lPr5QoP2CtWIaxWU6ENw-1
Received: by mail-wr1-f69.google.com with SMTP id j13so2739778wrr.20
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 01:39:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tSakUTi8biBaDO4JGr8rcWBisLF05BHEM8+vn5mJmsg=;
        b=incdLuIzaK5frPK+9ADjWp5753Fn021IR3ObqJ/03kXZMmx2B7A531H01smC0gLP8G
         r5UcV+QHIfMUgWeGpcvZX5Es0vQceXMCvp3N9fq13BYZ5lOlp2SHOX8OwSmf8pC55LIx
         otBBIyJn7dDSWc+oT3rK+ckN7QRoOio4q0xW1Mn0PapgtNkBf/q40IX3NMOdYPEwopRq
         J5ddcPiNpmE7lCG+NX6Jz7DvWn24oEgOsmQD/tVWDhU4kBKkbafVHc9fojTsd5ke/XiI
         aNofEOf4GMiSPI/HVYBQbxsI1aRxUNKsL0TBPI+q48+RlUP7q2NPazkWjRi3r6hF7LWU
         Oifw==
X-Gm-Message-State: APjAAAXlQqQxG5hcRnt+L48mEs0ijTqklUXRCAZY8V4KSTOTdUTJMUKJ
        R56Q+vFXpZCP21gqDQ04s72YPWQpTIiD3vsxGZ+Q3SrKouYHY4k9jJdAtVcJaYI3+zBhyWJiwru
        u8JA6ZnuMQbvJw9O4aEhIw1be
X-Received: by 2002:a7b:c450:: with SMTP id l16mr3501977wmi.166.1579945163413;
        Sat, 25 Jan 2020 01:39:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqxXHzToOxP0s/Db+4GnkirH83ip6eSuf/6sQnScHphAbo+jbh853oEfOBR31PKwD5KTWSeosQ==
X-Received: by 2002:a7b:c450:: with SMTP id l16mr3501951wmi.166.1579945163182;
        Sat, 25 Jan 2020 01:39:23 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id f1sm11276551wro.85.2020.01.25.01.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2020 01:39:22 -0800 (PST)
Subject: Re: [PATCH v4 07/10] KVM: selftests: Support multiple vCPUs in demand
 paging test
To:     Andrew Jones <drjones@redhat.com>, Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>
References: <20200123180436.99487-1-bgardon@google.com>
 <20200123180436.99487-8-bgardon@google.com>
 <20200124104943.6abkjzegmewnoeiv@kamzik.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <df86f0da-366d-bb20-d1d0-125697c660a8@redhat.com>
Date:   Sat, 25 Jan 2020 10:39:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200124104943.6abkjzegmewnoeiv@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/20 11:49, Andrew Jones wrote:
>> +
>> +	/*
>> +	 * Reserve twice the ammount of memory needed to map the test region and
>> +	 * the page table / stacks region, at 4k, for page tables. Do the
>> +	 * calculation with 4K page size: the smallest of all archs. (e.g., 64K
>> +	 * page size guest will need even less memory for page tables).
>> +	 */
>> +	pages += (2 * pages) / PTES_PER_4K_PT;
>> +	pages += ((2 * vcpus * vcpu_memory_bytes) >> PAGE_SHIFT_4K) /
>> +		 PTES_PER_4K_PT;
> pages needs to be rounded up to the next multiple of 16 in order for this
> to work on aarch64 machines with 64k pages.

I think this is best done with a generic function that does the rounding
and an arch-specific function that returns the page size.  Can you send
a patch to implement this?

Thanks,

Paolo

