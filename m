Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A965CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 16:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8552421532
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 16:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5v2IyoB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404943AbgE1QPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 12:15:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56954 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404932AbgE1QPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 12:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590682538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VBsBl0zv2+hfAxIShtc2kJO5XBzn0N2aNFybtxxAii0=;
        b=G5v2IyoBQDlI1tBaOzarLZEZQApvZTWnGtdkQe+7TGMU4JVLyTkFVrU5pdjaUdG/DW0/iC
        KPEAbBAa8mfIGYIpdhQGVe4btanxQsXCcxE7Rf3z8uLK9hK7cJNT09Ej9MzkVuWqBSNE6o
        19M78r6vctuT3+PSckjgP6e3ygczFd8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-iC3Oau4vNSiJfIccKIRtRg-1; Thu, 28 May 2020 12:15:35 -0400
X-MC-Unique: iC3Oau4vNSiJfIccKIRtRg-1
Received: by mail-wr1-f70.google.com with SMTP id f4so10092033wrp.21
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 09:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VBsBl0zv2+hfAxIShtc2kJO5XBzn0N2aNFybtxxAii0=;
        b=eBxJflF6v6vANXkLZ5kXAA7PItBOh2Ib+15VUPt5CcOY3QXcA6jXu4PNif0ctXyXk0
         xt3M74NRO8g25F8Maxlj5yrauf+o48eKL37wQkphCOtZMVaUaM/Q/petXDe3lEnx0qc/
         kqlul/DlDLiOusQEMhgZM8+fYJ2qkYEcIphQbKdTLVIyf8q203fLYJDXL31UmuF9c9af
         FV3XUSRETDLimiY3Fx1AXJzME29SKII/5Nz5Bk7tdNn+0vSMyOfhrmwv6sZIGETJX+ct
         4bDbLLOuEdbNxKr8ueo7tjTev6ZsnzNmGAaJsydotS9yI/bbmSvt8aTaoMYYK7EAN85Z
         K+Xw==
X-Gm-Message-State: AOAM533LPN7p70F8V3koKrY61K35XpN2oMCkD8q+sphwNdBrToDKO6O+
        TXVaNGlbZYGO8WOzN6p9LNABJ30N2qZfska0pM+1rmVLbLmAvmcOcTkN3xycdSWf7INcGTxUBWL
        OWs1TzGR8wuekMfrADLrSpuEW
X-Received: by 2002:a05:6000:4c:: with SMTP id k12mr4161809wrx.215.1590682534396;
        Thu, 28 May 2020 09:15:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwX/wz1XR6Etg3y5Gvk2TtGqcrXI2toGUfxGEMY4rCCjnLMCWyXlwJw/FTBx3W2SauZLjDnYQ==
X-Received: by 2002:a05:6000:4c:: with SMTP id k12mr4161789wrx.215.1590682534164;
        Thu, 28 May 2020 09:15:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8? ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
        by smtp.gmail.com with ESMTPSA id q1sm6458345wmc.12.2020.05.28.09.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 09:15:32 -0700 (PDT)
Subject: Re: [PATCH] KVM: X86: Call kvm_x86_ops.cpuid_update() after CPUIDs
 fully updated
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
References: <20200528151927.14346-1-xiaoyao.li@intel.com>
 <b639a333-d7fe-74fd-ee11-6daede184676@redhat.com>
 <1f45de43-af43-24da-b7d3-00b9d2bd517c@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5d8bc1da-f866-4741-7746-1fa2a3cfbafd@redhat.com>
Date:   Thu, 28 May 2020 18:15:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1f45de43-af43-24da-b7d3-00b9d2bd517c@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/20 17:40, Xiaoyao Li wrote:
>>
>>> kvm_x86_ops.cpuid_update() is used to update vmx/svm settings based on
>>> updated CPUID settings. So it's supposed to be called after CPUIDs are
>>> fully updated, not in the middle stage.
>>>
>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>
>> Are you seeing anything bad happening from this?
> 
> Not yet.
> 
> IMO changing the order is more reasonable and less confusing.

Indeed, I just could not decide whether to include it in 5.7 or not.

Paolo

