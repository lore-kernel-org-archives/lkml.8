Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705B0C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 14:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43325217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 14:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJqwgD7V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgAUOOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 09:14:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22647 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727255AbgAUOOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 09:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579616082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DQ31pQ6K/s0UNFG5JNDkqQ8k3Ifm3vetwfPhGftFwbs=;
        b=WJqwgD7VPIcMnFEerTsmDWPJSpJGBJjJxbomt7L7gZlMWGT+U9aWp9IpMrGUwd/YM09S45
        v3oI3OU2ko2IQCqfwWQXJe/b2xSc91aX4u554yEbnrdYDUvuoR9sFMRU2ZjR3VJGWceKq9
        SbTev2wA0BIpOnGq+czh8awTN6tUWM0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-PlOvxmHOPACNSmQz9bnTgA-1; Tue, 21 Jan 2020 09:14:41 -0500
X-MC-Unique: PlOvxmHOPACNSmQz9bnTgA-1
Received: by mail-wm1-f70.google.com with SMTP id b9so665831wmj.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 06:14:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DQ31pQ6K/s0UNFG5JNDkqQ8k3Ifm3vetwfPhGftFwbs=;
        b=TvFCdk9tNv2wsypuRj49U763fPhHuB8S2qxZe3iFBRi+c/h0EOM9vUWNGy5Kr6Sexn
         4I3fuMHNblccl0qDUDk5LAPKwBLh0K9Ok9lOEZ5IDfLF4K20NbkIs+BO27kH1p6v9yOP
         pPQPcRvNSObASRoYemlr/d96wXvnAPlMrSBkp8xf8hmwWD75kv+7xbviEAZlIeaoG+J7
         nMipHC/n3N3TA9rx/dXN+Mqa1S8aozZyDn7iCJl/po1pK9vvn3Nfg5sIUgyEOJk42tJE
         VWS91OkNZYCSWvitGnQq/ll7l0gm6mgcOZU0JnqBSBJKbahAM9QYfPg523zLXySRKEeB
         zHlw==
X-Gm-Message-State: APjAAAVr9D0vtHTDv6LAEvpGb6NbwylWxRQlkGYZFBTYY5EV1NiXX/EO
        sFnFcjgjWVS+SGldVvZlwG+mW/VP2jAC3d1m11cfmUtH4LDrGmN6X38kE/yqiNAan20tyCnNhSP
        bqzQcyn+BW6iXzpDJjQeM1SWw
X-Received: by 2002:a05:600c:211:: with SMTP id 17mr4557549wmi.60.1579616080493;
        Tue, 21 Jan 2020 06:14:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqzmQNd6Xh5t04lNELXN8HOSVTkFien80RItl+KAQNTRyeAzyC9Sukn1Pl3DvEeDCSZvMzCMlQ==
X-Received: by 2002:a05:600c:211:: with SMTP id 17mr4557510wmi.60.1579616080183;
        Tue, 21 Jan 2020 06:14:40 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b509:fc01:ee8a:ca8a? ([2001:b07:6468:f312:b509:fc01:ee8a:ca8a])
        by smtp.gmail.com with ESMTPSA id b68sm4162860wme.6.2020.01.21.06.14.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 06:14:39 -0800 (PST)
Subject: Re: [RESEND PATCH v10 06/10] vmx: spp: Set up SPP paging table at
 vmentry/vmexit
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Yang Weijiang <weijiang.yang@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmattson@google.com, yu.c.zhang@linux.intel.com,
        alazar@bitdefender.com, edwin.zhai@intel.com
References: <20200102061319.10077-1-weijiang.yang@intel.com>
 <20200102061319.10077-7-weijiang.yang@intel.com>
 <20200110180458.GG21485@linux.intel.com>
 <20200113081050.GF12253@local-michael-cet-test.sh.intel.com>
 <20200113173358.GC1175@linux.intel.com>
 <20200114030820.GA4583@local-michael-cet-test.sh.intel.com>
 <20200114185808.GI16784@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5d4118d9-c501-6c59-82cc-50e317be195c@redhat.com>
Date:   Tue, 21 Jan 2020 15:14:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200114185808.GI16784@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/20 19:58, Sean Christopherson wrote:
> I'm not convinced the instruction length needs to be provided to userspace
> for this case.  Obviously it's not difficult to provide the info, I just
> don't understand the value added by doing so.  As above, RIP shouldn't
> need to be unwound, and blindly skipping an instruction seems like an odd
> thing for a VMI engine to do.
> 

The reason to introduce the instruction length was so that userspace
could blindly use SPP to emulate ROM behavior.  Weijiang's earlier
patches in fact _only_ provided that behavior, and I asked him to change
it so that, by default, using SPP and not handling it will basically
cause an infinite loop of SPP violations.

One possibility to clean things up is to change "fault_handled" and
fast_page_fault's return value from bool to RET_PF* (false becomes
RET_PF_INVALID, true becomes RET_PF_RETRY).  direct_page_fault would
also have to do something like

	r = fast_page_fault(vcpu, gpa, level, error_code))
	if (r != RET_PF_INVALID)
		return r;

Then fast_page_fault can just return RET_PF_USERSPACE, and this ugly
case can go away.

+		if (vcpu->run->exit_reason == KVM_EXIT_SPP)
+			r = RET_PF_USERSPACE;
+

Thanks,

Paolo

