Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB792C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 13:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BFE620714
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 13:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OEMTf0Vs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgDYN0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 09:26:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56924 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726092AbgDYN0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 09:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587821196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cfzDwm7LQsMeQjoNJKbPO8B9JT/oMVW7lxfykeUko+0=;
        b=OEMTf0VsvLTX+jm+guEZ0jYYI89/znM46veQnYPpUQawvym1AOAGw6WbTD7jWPaQRhepUr
        PASmhtKwAzlaR3Q+40oAnLTJAwE5WzXvLMqhvWEmZsRosl3Ce0Wk7Av8DoGBDDidluhn/g
        Ss/A1Kn3W+diqqxJT75dG/bGlWLLHq4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-C_HBNby0MeaZQwNG8djcSw-1; Sat, 25 Apr 2020 09:26:35 -0400
X-MC-Unique: C_HBNby0MeaZQwNG8djcSw-1
Received: by mail-wm1-f69.google.com with SMTP id 71so5849094wmb.8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 06:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cfzDwm7LQsMeQjoNJKbPO8B9JT/oMVW7lxfykeUko+0=;
        b=l7aFWZrXdaEFVbb517PkLkYA4y+58VsC6pf1gizIA31IYatzCLAyLKRAw2DX8fwUk0
         ouqf/cM9qhUaG/gWqkgB40opVbEc3WhBaagn/zaLKFyNCOSC8qRiTYRRYYXaJo3PiCoz
         iqmSfA3Ius6RwWZmHKHFgjexT8cGP14q75H1GUHlFX2y0usQ1dqNaUzYeLvTaiD0sYmx
         teV4a2AE1vpAt1vuJH/m5MUOGVh+eYe57cmFTw41koctae7tyIlYdCaDrYGA0Z9VBBsi
         7GRelZppqp0+9KEfrYOUWNXqDKR7PJ32IaNHaG2o5fHlElaUWUwPuD/mtS95663DhxNW
         jBBw==
X-Gm-Message-State: AGi0PubaJeQ0pbQPANpxUfk+JBSf+mtGws6QkcllK63BbjBD7zPCHmfW
        FhsHj+C3rFXfoAyofXnitg0HwN1wd9yKl5STs7BpzHeod5WgiNB+9OzSrWP0xALRJTrYSA+rtnT
        Th7sCvZjFA8buB1cl3DHnrM4a
X-Received: by 2002:adf:e403:: with SMTP id g3mr17253248wrm.121.1587821193967;
        Sat, 25 Apr 2020 06:26:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypLF6eS81g1PIpJQKW71U4aeqAQqhpZHvv0qiPSVt+hRrX0IsXtReOkrHjuTuk2sr3eqBaHMSg==
X-Received: by 2002:adf:e403:: with SMTP id g3mr17253227wrm.121.1587821193691;
        Sat, 25 Apr 2020 06:26:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d0a0:f143:e9e4:2926? ([2001:b07:6468:f312:d0a0:f143:e9e4:2926])
        by smtp.gmail.com with ESMTPSA id a10sm1922597wrg.32.2020.04.25.06.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2020 06:26:33 -0700 (PDT)
Subject: Re: [PATCH v11 2/9] KVM: VMX: Set guest CET MSRs per KVM and host
 configuration
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Yang Weijiang <weijiang.yang@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmattson@google.com, yu.c.zhang@linux.intel.com
References: <20200326081847.5870-1-weijiang.yang@intel.com>
 <20200326081847.5870-3-weijiang.yang@intel.com>
 <20200423162749.GG17824@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d92b9fea-95b6-73ce-c3b5-47dad95c5d42@redhat.com>
Date:   Sat, 25 Apr 2020 15:26:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200423162749.GG17824@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/20 18:27, Sean Christopherson wrote:
>>  
>> +static bool is_cet_mode_allowed(struct kvm_vcpu *vcpu, u32 mode_mask)
> CET itself isn't a mode.  And since this ends up being an inner helper for
> is_cet_supported(), I think __is_cet_supported() would be the way to go.
> 
> Even @mode_mask is a bit confusing without the context of it being kernel
> vs. user.  The callers are very readable, e.g. I'd much prefer passing the
> mask as opposed to doing 'bool kernel'.  Maybe s/mode_mask/cet_mask?  That
> doesn't exactly make things super clear, but at least the reader knows the
> mask is for CET features.

What about is_cet_state_supported and xss_states?

Paolo

>> +{
>> +	return ((supported_xss & mode_mask) &&
>> +		(guest_cpuid_has(vcpu, X86_FEATURE_SHSTK) ||
>> +		guest_cpuid_has(vcpu, X86_FEATURE_IBT)));
>> +}

