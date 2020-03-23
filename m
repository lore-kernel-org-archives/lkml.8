Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDD1C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 23:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88AE120409
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 23:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8EsLZBz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbgCWXrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 19:47:00 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:21116 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727054AbgCWXq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 19:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585007218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tSyvbG0jRJgoukd8LcpY1HnHy+eiw9SXpaYRxe+R7cU=;
        b=U8EsLZBzxkOeC+eNCMRZderVA7HFHYE9n6DVSwPywY1bBEXwwQS7n3qI/zdNBPXqpfL32c
        Zp4mHc8s+iZ/HV6LiY9Ax2tiFbSY/6szRj4txZj0gO3YxrrnTCfxH2t0l9/mTwY/amNV2T
        8gp84P5CPl1px9jxEYz0fIxJUDKEaUs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-vdCmVAKHOn6YMK90IfvWDQ-1; Mon, 23 Mar 2020 19:46:56 -0400
X-MC-Unique: vdCmVAKHOn6YMK90IfvWDQ-1
Received: by mail-wm1-f69.google.com with SMTP id f8so606551wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 16:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tSyvbG0jRJgoukd8LcpY1HnHy+eiw9SXpaYRxe+R7cU=;
        b=Q57N+ekXsamYav+0Yo+nNsMBjus1n9aiD4VA+C6CwfVRZ9fUFtKWT/eS9OFW1/u7bf
         xaoVOExS94xMb2PStFGjvY+BX3WkrzNVLYED8yX5IQLGF2BzjOni1bCJGXN7XmoQOrj3
         eIONJXC+Zlbm5zOueU+B+pypobIE3yOPqhUaTmSNr+oyzUOLIngYhcbzcNt9I2wda8o9
         fXKNXR8/nbQCrG1ACYMJA7vqnOXl9pLsQmbQBSnmY3+zNV8ssIz98B5fznaQELYInO9z
         4XmrQ9Jyiv43BwGfsOvA3Huk2ciKlFCrar11zsZsK5N0PGpkUNTAnzhxwsxj9vqHAbZK
         Ct9g==
X-Gm-Message-State: ANhLgQ2W34YAYVwq8i+Hy/c0tOO+Vw2A+H5ae39WYd9uqLktsz43uVNP
        8RFaSvX9Yg3tkQFhl4sEr0v86snXLS1sKZhMjP8eOJxhxMkBuKvhmeYtmaExcmNKd9GFeTZPrlM
        AvbMm8yK5C118tRRSxNlG7yHX
X-Received: by 2002:adf:f7cb:: with SMTP id a11mr23524113wrq.79.1585007215284;
        Mon, 23 Mar 2020 16:46:55 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvZlGwBX5VRkEHJbRyonc3teesA7wqRwm+dtkXJfD8MCIKgHyy5njk4cisOjUOk59hS+iM0yg==
X-Received: by 2002:adf:f7cb:: with SMTP id a11mr23524089wrq.79.1585007214986;
        Mon, 23 Mar 2020 16:46:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7848:99b4:482a:e888? ([2001:b07:6468:f312:7848:99b4:482a:e888])
        by smtp.gmail.com with ESMTPSA id k9sm26815366wrd.74.2020.03.23.16.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 16:46:54 -0700 (PDT)
Subject: Re: [PATCH v3 02/37] KVM: nVMX: Validate the EPTP when emulating
 INVEPT(EXTENT_CONTEXT)
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Junaid Shahid <junaids@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        John Haxby <john.haxby@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20200320212833.3507-1-sean.j.christopherson@intel.com>
 <20200320212833.3507-3-sean.j.christopherson@intel.com>
 <871rpj9lay.fsf@vitty.brq.redhat.com>
 <20200323154555.GH28711@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b6fdc5db-2d50-5e4d-cfe8-4d4624c046e0@redhat.com>
Date:   Tue, 24 Mar 2020 00:46:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200323154555.GH28711@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/20 16:45, Sean Christopherson wrote:
>> My question, however, transforms into "would it
>> make sense to introduce nested_vmx_fail() implementing the logic from
>> SDM:
>>
>> VMfail(ErrorNumber):
>> 	IF VMCS pointer is valid
>> 		THEN VMfailValid(ErrorNumber);
>> 	ELSE VMfailInvalid;
>> 	FI;
>>
> Hmm, I wouldn't be opposed to such a wrapper.  It would pair with
> nested_vmx_succeed().
> 

Neither would I.

Paolo

