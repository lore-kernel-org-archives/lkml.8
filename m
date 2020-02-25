Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E10FC35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A182084E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dea58rsr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730879AbgBYOy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:54:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53962 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730427AbgBYOy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:54:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582642467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mK3STqvNpT3jDn9vLwtg+cXgS2sGksMMsz4/c3rFMHk=;
        b=dea58rsrPeKNMLm/+yu2kyQLKbyYLaXJdgMbVNSBpt9KdFXsqPDo7gQ3RA4ByX4/WajWKu
        ECIn5WwcrjJCWRqd7zwlYBbsXGCWOwY8r/V39tb3CKsqTTuTHSiOxkCL28GdFSKH0Kvsqw
        5uNJB76rewjOPbDgj7X7Aqu5SBEYZJg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-ykiP9e4xPd-14i41ZdN55A-1; Tue, 25 Feb 2020 09:54:24 -0500
X-MC-Unique: ykiP9e4xPd-14i41ZdN55A-1
Received: by mail-wm1-f70.google.com with SMTP id f66so960939wmf.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 06:54:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mK3STqvNpT3jDn9vLwtg+cXgS2sGksMMsz4/c3rFMHk=;
        b=WOgs+vSgl3qdWnCPgnIhYobJceBPsXReRBZs5awasZPrR3AxLSP3KUafEgVJzu+qHR
         RldSqiSGzH+MBNbBwTfJBB5mIt2DEUuqtXc5IH+kdAlQsYVJdfTa48uuCCRJww0V9AAI
         kRBwMISOkhbhEjeKh2xqljP+zpFQIsqhY9Mxxjdxot+pzCbYf36kHVGVrPwv9gLTkaJo
         4eHqCnP8skVTachukjIUREVCdTpQoJ6DbXzX2gmywfkRNVMF+sjcgtguyXkwhBm4zX2k
         5JbsABx7tfrpO6qPNXzB9QdtL79Nsnc95BHS9BzmuoTQRB/92DwNhzSLD9+WC7A4F5hs
         S/GA==
X-Gm-Message-State: APjAAAUpT6q3/+kswTpvUK7vBdKNR3dDgAWAtspSh1yt3PAubL1vNF+Q
        X8GuCpiJhGe6jK/GRxNsQUH1Egh9UE98yzpKsokRXqAXajyRahyJG3oOY88Zelb9pO61jw/vf58
        zBLc8KE0sEhsrNC4za51xIT5s
X-Received: by 2002:adf:ef8e:: with SMTP id d14mr15574551wro.316.1582642462672;
        Tue, 25 Feb 2020 06:54:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqxNJivnFuLmBEUDYNzro50QPxzSsCchDfqLX6sY7HTC6bfACS5U6cknWPDlWhgge0XEZWwm3A==
X-Received: by 2002:adf:ef8e:: with SMTP id d14mr15574535wro.316.1582642462449;
        Tue, 25 Feb 2020 06:54:22 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:3577:1cfe:d98a:5fb6? ([2001:b07:6468:f312:3577:1cfe:d98a:5fb6])
        by smtp.gmail.com with ESMTPSA id q3sm4200422wmj.38.2020.02.25.06.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 06:54:21 -0800 (PST)
Subject: Re: [PATCH 19/61] KVM: VMX: Add helpers to query Intel PT mode
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200201185218.24473-1-sean.j.christopherson@intel.com>
 <20200201185218.24473-20-sean.j.christopherson@intel.com>
 <87pne8q8c0.fsf@vitty.brq.redhat.com>
 <20200224221807.GM29865@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <33a4d99d-98da-0bd8-0f9c-fc04bef54350@redhat.com>
Date:   Tue, 25 Feb 2020 15:54:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224221807.GM29865@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/20 23:18, Sean Christopherson wrote:
>>>  {
>>>  	u32 vmexit_ctrl = vmcs_config.vmexit_ctrl;
>>> -	if (pt_mode == PT_MODE_SYSTEM)
>>> +	if (vmx_pt_mode_is_system())
>> ... and here? I.e. to cover the currently unsupported 'host-only' mode.
> Hmm, good question.  I don't think so?  On VM-Enter, RTIT_CTL would need to
> be loaded to disable PT.  Clearing RTIT_CTL on VM-Exit would be redundant
> at that point[1].  And AIUI, the PIP for VM-Enter/VM-Exit isn't needed
> because there is no context switch from the decoder's perspective.

How does host-only mode differ from "host-guest but don't expose PT to
the guest"?  So I would say that host-only mode is a special case of
host-guest, not of system mode.

Paolo

