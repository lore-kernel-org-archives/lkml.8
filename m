Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2744CC3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF5C120838
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AG67bF89"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbgCCPgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 10:36:03 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38241 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729987AbgCCPgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 10:36:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583249761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ujsLLzVuYTRYMxSwdOvoebiKOIVvxP1nddRp1hnsi8w=;
        b=AG67bF89heOsL1VOxmx+RKzO58Y4PQc2BFbieZ4+s2hESivstalqS8H+dozQl9cpmSi3lE
        uoGywm0ZLdWRDd4EleEUzZxVtmPtj2lppjKzMuzac1m5j6rfY1V02a2W0bnN8m9JyZb7cP
        vk3tkJrBhpItIGdyl5Pbtg5pg8SLBc8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-ysY8uv4rOeeJQAduU8OgHQ-1; Tue, 03 Mar 2020 10:36:00 -0500
X-MC-Unique: ysY8uv4rOeeJQAduU8OgHQ-1
Received: by mail-wr1-f69.google.com with SMTP id j32so1377349wre.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 07:35:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ujsLLzVuYTRYMxSwdOvoebiKOIVvxP1nddRp1hnsi8w=;
        b=G7kYUc1Em2C6OmqRueEmL4zw1odIjeEvemDkYNRybaq5aeqCxtRaaDxIVY+kd3RtXQ
         A6VYYGwVGep2/gVqc+cWVN1QhSpYno8sIgxzl51DtPCDPZg1zA1lHlzGZF9ro7tpbrws
         lHfRo89rgHUD6tf9/SSp3wrgf+HRYshMxqZ86Uu+s3ioAVc5Pq2WGwKvmp37P6736Dgg
         SzkB55xFJvss8qbz2ner7KRvEZkFgq1ZO0J8WOuE5BxmdTy9fkHBM0WzIOU9nNoiymdd
         6z4alNcMU6gKXqaS2er6UL9Jmyz3DqFAI88SoEWWhOCam4jZxSfYXzDDxX0mpPJA8/fl
         6yaQ==
X-Gm-Message-State: ANhLgQ0E8n64vi2o3ctPn+InHz8Iy3xo/NsrqqooFjM28cPydFBEKAcS
        b/64bgMzo/XeIExypvlqLB1V7p4+8Hi8ohVLUS/vdpsOFNNQSEGKQ+AHOcUoYlXLxfS60yGJ9qH
        vvA1X3Lf9WVEUuofqWB/SKrS9
X-Received: by 2002:adf:fa0f:: with SMTP id m15mr6386526wrr.392.1583249758943;
        Tue, 03 Mar 2020 07:35:58 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtXOdsBuRFJDRHIa5TRjfWnThT4qNW6T0BPy5J15OWGLpEe3lKOi93Q21PvbTbxna5Yu0DsqQ==
X-Received: by 2002:adf:fa0f:: with SMTP id m15mr6386514wrr.392.1583249758741;
        Tue, 03 Mar 2020 07:35:58 -0800 (PST)
Received: from [192.168.178.40] ([151.20.254.94])
        by smtp.gmail.com with ESMTPSA id f3sm3777601wrs.26.2020.03.03.07.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 07:35:58 -0800 (PST)
Subject: Re: [PATCH v2 66/66] KVM: x86: Move nSVM CPUID 0x8000000A handing
 into common x86 code
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
References: <20200302235709.27467-1-sean.j.christopherson@intel.com>
 <20200302235709.27467-67-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9d2b5256-5c00-54d2-8f73-c78d54b23552@redhat.com>
Date:   Tue, 3 Mar 2020 16:35:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200302235709.27467-67-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/20 00:57, Sean Christopherson wrote:
> +	case 0x8000000A:
> +		if (!kvm_cpu_cap_has(X86_FEATURE_SVM)) {
> +			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
> +			break;
> +		}
> +		entry->eax = 1; /* SVM revision 1 */
> +		entry->ebx = 8; /* Lets support 8 ASIDs in case we add proper
> +				   ASID emulation to nested SVM */
> +		entry->ecx = 0; /* Reserved */
> +		/* Note, 0x8000000A.EDX is managed via kvm_cpu_caps. */;

... meaning this should do

                cpuid_entry_override(entry, CPUID_8000_000A_EDX);

shouldn't it?

Paolo

> +		break;

