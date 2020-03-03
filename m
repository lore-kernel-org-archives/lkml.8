Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE651C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA6620828
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ake5qf4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbgCCPki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 10:40:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37366 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727079AbgCCPki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 10:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583250037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SrF8JSKjOdBJZVRt/AXRACdTMcBXv4bNXWLtdukx5fQ=;
        b=ake5qf4iJ5jxHmd1J7hRGtVEzIDn6XA0+wLFNCyeYBMbU4WYWBmhmSAyzDRV6MJuzDm0Im
        ExpCDkj0Lo5ecEfYAUmQn5HCNREQz65B6Yl2C8u0z/mcQqwVAe/s/w+AQjvVnxAZG/52OM
        MaYgzisT1/VVXA4SGeLEJ9YUchoa/W4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-0R4BpxVwN7yklL9ZTu8A_w-1; Tue, 03 Mar 2020 10:40:36 -0500
X-MC-Unique: 0R4BpxVwN7yklL9ZTu8A_w-1
Received: by mail-wr1-f71.google.com with SMTP id p5so1369940wrj.17
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 07:40:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SrF8JSKjOdBJZVRt/AXRACdTMcBXv4bNXWLtdukx5fQ=;
        b=cZZWoa3Xb5mcZXwYecVcBl187p7jMICtayeX7UFlIJpydy5FiOn/Ki2P84R03huvcA
         j3LK6h2Xv16Cq+oNTMi23lwrgvS3WITz6twXkhkzLykshF21/IXI2UGNPZlAOoy8URPN
         ajWI2Oeg29M21FKE508TkGN0G+3Wp/kpgw50f6osrc0rFAOi6NQeZ1/nIdUYF2YNr71r
         XeF2Kw1/2APgX+qMaH+aQknJurHuScBxPjmAxCoteF78bpeRuhMRK5qfcUpiJqOE2+0Q
         AxjcgDHBeC0zjLpw5QLfUBGpcEhBGLygIicxaLr90JaAQAIEd4MH7Mzim6A6dvO1iV2b
         Qf8w==
X-Gm-Message-State: ANhLgQ1fKmFKHAPnJgHnnUrxRRR67qACjF6DiEIieYqKzRTLyfWPbB/4
        EvIHxFf/8zfD+7bsV/KSCzf5+sRv1NUv++iLik0Dd2PL9A3H15Qpu2ne9klay3KPkjult651lDs
        3+E54LkJtnGpd3bNvbA0nbQJG
X-Received: by 2002:a7b:c446:: with SMTP id l6mr4718638wmi.94.1583250034918;
        Tue, 03 Mar 2020 07:40:34 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsIy7f/SKdW2QFW2LYYoV1RsOjaZ70eCj2/ll6a/OC6f6S6aofvunS899Akpq0Wiy7IoguI/Q==
X-Received: by 2002:a7b:c446:: with SMTP id l6mr4718619wmi.94.1583250034726;
        Tue, 03 Mar 2020 07:40:34 -0800 (PST)
Received: from [192.168.178.40] ([151.20.254.94])
        by smtp.gmail.com with ESMTPSA id z10sm4378147wmk.31.2020.03.03.07.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 07:40:34 -0800 (PST)
Subject: Re: [PATCH v2 36/66] KVM: x86: Handle GBPAGE CPUID adjustment for EPT
 in VMX code
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
References: <20200302235709.27467-1-sean.j.christopherson@intel.com>
 <20200302235709.27467-37-sean.j.christopherson@intel.com>
 <90df7276-e586-9082-3d80-6b45e0fb4670@redhat.com>
 <20200303153550.GC1439@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c789abc9-9687-82ae-d133-bd3a6d838ca5@redhat.com>
Date:   Tue, 3 Mar 2020 16:40:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303153550.GC1439@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/20 16:35, Sean Christopherson wrote:
> Oof, that took me a long time to process.  You're saying that KVM can
> allow the guest to use GBPAGES when shadow paging is enabled because KVM
> can effectively emulate GBPAGES.  And IIUC, you're also saying that
> cpuid.GBPAGES should never be influenced by EPT restrictions.
> 
> That all makes sense.

Yes, exactly.

Paolo

