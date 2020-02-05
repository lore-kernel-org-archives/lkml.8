Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDD0C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0115720702
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b66O2XCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgBEObu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:31:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24328 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727641AbgBEObr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:31:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580913107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QIiDr7UauS84w6lC6LqITX2nEatUYOv8rB4hqu0Dq30=;
        b=b66O2XCqu0UlQ/sSznHtpXED3yGUI+R/adU+lDrPnTm1zKI9G/i+8Y+Z5VmnwJAuKuh2Af
        z2TZWgOBKRRh7U+AL7V5jV4B90MK2dN0Lqw85uQikYOLDqfhx9XoN/+6jmW9GdLaVZDy3H
        NvKuydJCU5oUdNf1CIB7heTPAUU4kvg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-tFpvzv6iNaqYFmsJgp3jyQ-1; Wed, 05 Feb 2020 09:31:45 -0500
X-MC-Unique: tFpvzv6iNaqYFmsJgp3jyQ-1
Received: by mail-wr1-f72.google.com with SMTP id f10so1269309wro.14
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 06:31:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QIiDr7UauS84w6lC6LqITX2nEatUYOv8rB4hqu0Dq30=;
        b=cOvFjINso/rvJgxJ/I4/4ezb0XwfIsa1d24FQTy2kdIhwedNW7tCwOrL98B3xbefgU
         nCYeAW8Lix7ajduBxa3FHPdFe/aessrrnYCB0KXz8Rl4rQ+fSTVStMvJ+VA1EAfkvTSl
         O3ri8G83u/gRJIKftjkYi0gqRLs62I0llJQikJgEIw5CGrkiHIDI1yWS/rtB3SEuA8uB
         8/Lpzkf6819B4l3MCxc0AqjFz4wMg1qRDkSo2w5xkppO+J9ufGxZaXrnmOy+Yx41ceF7
         Jj7R/+xbLkQgf6WZU2/1hIuDUCGYiRNuQvcdwLXxmZeDSS0zHvJXMntD2FkzYirl1nw8
         p2Gg==
X-Gm-Message-State: APjAAAWucYyeBju8bxPiUBFat1/d7RBurNUl2ByyZLOr3RZajduXicz+
        y3c9lhlvylt8yYpGOLOr71d5h+o0SssuNn+Hg5Me2Mn9ja3pNEQIeFh3RahLEWLn0Vfqn6Lgpvm
        JpIjCIDBoULowNswcvt64ppVF
X-Received: by 2002:a5d:4584:: with SMTP id p4mr30912465wrq.25.1580913104332;
        Wed, 05 Feb 2020 06:31:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqwP0pkVzTlW7EakEH9j7lzRpVa9D9kKCf5FqXxuVWuaCLr+/ZECn4MulgA/XKImX0nVCcCOYA==
X-Received: by 2002:a5d:4584:: with SMTP id p4mr30912440wrq.25.1580913104144;
        Wed, 05 Feb 2020 06:31:44 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56? ([2001:b07:6468:f312:a9f0:cbc3:a8a6:fc56])
        by smtp.gmail.com with ESMTPSA id g128sm8189827wme.47.2020.02.05.06.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 06:31:43 -0800 (PST)
Subject: Re: [PATCH] KVM: nVMX: Remove stale comment from
 nested_vmx_load_cr3()
To:     Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200204153259.16318-1-sean.j.christopherson@intel.com>
 <dcee13f5-f447-9ab4-4803-e3c4f42fb011@oracle.com>
 <20200204203607.GB5663@linux.intel.com>
 <14d6b39b-b907-d1f3-8f15-9b1df0718082@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c1952c6a-40ce-00c1-d145-21085ea5a982@redhat.com>
Date:   Wed, 5 Feb 2020 15:31:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <14d6b39b-b907-d1f3-8f15-9b1df0718082@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/20 23:01, Krish Sadhukhan wrote:
>>
>> /*
>>   * Load guest's/host's cr3 at nested entry/exit.  @nested_ept is true
>> if we are
>>   * emulating VM-Entry into a guest with EPT enabled.  On failure, the
>> expected
>>   * Exit Qualification (for a VM-Entry consistency check VM-Exit) is
>> assigned to
>>   * @entry_failure_code.
>>   */
> It  works.
> 
> With that,
> 
> Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>

Thanks, I folded in the change.

Paolo

