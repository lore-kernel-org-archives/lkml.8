Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF66C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF2AD20735
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 14:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iN3hDyKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgD0OEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 10:04:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23467 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727010AbgD0OEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 10:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587996273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BrvrKt3lcgt1HQz9prUBfez1RAn+QDtDA7uo58Xxz4g=;
        b=iN3hDyKaAbbM/buM24gYCsI6pFLkDO+Hvkq905UhwFX4DOCQcRhEfX/JKkvP7lr9ppGhte
        n74AY/GpRq5D5ZcgxqScs74zWh+OOnYncJC7aYGUkeU3L11lmprSvTP0VRHfEgOtSWkSCW
        +ElEzKH7AUrwmEdSmub55Rp3RHedd6U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-lMyUJ7p-OxWJ3NiqnYZZIg-1; Mon, 27 Apr 2020 10:04:31 -0400
X-MC-Unique: lMyUJ7p-OxWJ3NiqnYZZIg-1
Received: by mail-wr1-f70.google.com with SMTP id o8so10060073wrm.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 07:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BrvrKt3lcgt1HQz9prUBfez1RAn+QDtDA7uo58Xxz4g=;
        b=smG4EdFNnYGmrvJvtZd9Fz8kbrEI0ame9FJOjnNUfaQ16V6yp9r6NAFuFXn5VNzqJV
         UaXuKjH99thT2DrZKDeDBfvvm82f8pfCYuj9NMn6ZvKKEMO+81vOr6tsc0e90T/VrKqE
         OPFQGmFWVm2+N5x/3OeKPNzbbM4FQF63PfHVp7ns4/gXK/bEZL+AXr62RTUmWahtDvm1
         Obvl98ie7qhwRlGVDabmLqPeiVtut+UDSkr9pLut+JiUztB6Hiq4UwzJwi5dnYL33IPu
         I3IK9FoLX7vyJrxQFUUGhUr3NZQ5DHwMSdA4kenPSPfpopqVvbe+VqHhk7mKqDoQ8gv4
         rWfw==
X-Gm-Message-State: AGi0PuZvxKwrX0C0S/Yy4uA0venoP9Nbx86u3/SqMmQ5yz18p7sVvD2+
        fU/emOqaqlZR6DQuRE69Z9xV5vhhbQZuHzJF2DMO8BJiBcgo9/EkdZAr1sk1iwiqvp8UfT/enY3
        HCh8kPTKnfaNaSMyyMkv8T7Md
X-Received: by 2002:a05:6000:14c:: with SMTP id r12mr26619594wrx.62.1587996270622;
        Mon, 27 Apr 2020 07:04:30 -0700 (PDT)
X-Google-Smtp-Source: APiQypKQDLpBQhVqSDdEDXl6KFsiycuukhP26/pM6x5dap/F9Yshz4GKOD6lHlwRJje3RKxH/H6HIg==
X-Received: by 2002:a05:6000:14c:: with SMTP id r12mr26619567wrx.62.1587996270350;
        Mon, 27 Apr 2020 07:04:30 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id x18sm20892100wrv.12.2020.04.27.07.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 07:04:29 -0700 (PDT)
Subject: Re: [PATCH v11 7/9] KVM: X86: Add userspace access interface for CET
 MSRs
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sean.j.christopherson@intel.com, jmattson@google.com,
        yu.c.zhang@linux.intel.com
References: <20200326081847.5870-1-weijiang.yang@intel.com>
 <20200326081847.5870-8-weijiang.yang@intel.com>
 <08457f11-f0ac-ff4b-80b7-e5380624eca0@redhat.com>
 <20200426152355.GB29493@local-michael-cet-test.sh.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f6f8cedf-26ce-70b4-2906-02806698d81b@redhat.com>
Date:   Mon, 27 Apr 2020 16:04:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200426152355.GB29493@local-michael-cet-test.sh.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/20 17:23, Yang Weijiang wrote:
> What's the purpose of the selftest? Is it just for Shadow Stack SSP
> state transitions in various cases? e.g., L0 SSP<--->L3 SSP,
> L0 SSP1<--->L0 SSP2?

No, it checks that the whole state can be extracted and restored from a
running VM.  For example, it would have caught immediately that the
current SSP could not be saved and restored.

> We now have the KVM unit-test for CET functionalities,
> i.e., Shadow Stack and Indirect Branch Tracking for user-mode, I can put the
> state test app into the todo list as current patchset is mainly for user-mode
> protection, the supervisor-mode CET protection is the next step.

What are the limitations?  Or are you referring to the unit test?

Paolo

