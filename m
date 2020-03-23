Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2600CC54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5612073C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zduysw3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgCWTrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:47:12 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:54881 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725914AbgCWTrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584992831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S9IrSlxfJapkU8CWMBvfg1IPzMz8/r3SznAfCQ6EPKg=;
        b=Zduysw3BXOpqU1DMVZPPDCyEYUHg8H3684wmD+xBXRMqvkjZt0326YR2RD/1QFbf7IQthE
        14HhnuwjIhTgBaSIcyJ5GHyUFK209hQT9CKQUZ4XeUaLFdzWZF3ZBhxSz703KgTodXgz51
        113oncJdBT/xiJPNU+V6Chq0qPzdwvw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-jneoJl0nOMyrJkOjDAg8KA-1; Mon, 23 Mar 2020 15:47:09 -0400
X-MC-Unique: jneoJl0nOMyrJkOjDAg8KA-1
Received: by mail-wr1-f70.google.com with SMTP id h14so1725157wrr.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 12:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S9IrSlxfJapkU8CWMBvfg1IPzMz8/r3SznAfCQ6EPKg=;
        b=pu92VwXaE2ddFSiQD0pKBM4CYcnxlXswPFzibsxKgXrWG/nS0pABi+V8OBxr0Fyslx
         rhBIJqYGmZvkv8VD5aIVdSLv1kribmw3BYAdXgm8TlyfzIQbLqQVUEXVSLo10RiqwRbS
         EL9tHvwMpVbjKvwPaYZi9+W+a8K8D4dcrstwy5V2aBTyjSiOxYiBPjcoyU8dPATaeDOW
         UrS5PolZbnMv+V0rsPVpKMYu0mUdrVD2TwcpTcjTt4NPmVbDyJ6jVhcAESJfNNFNMOlZ
         3fPt4cnvs7tzm4rAAFeTWnQbQHEOJZ6gDMtJc+Drlx64W+dqF6wuarKFSCX3nQbISgK9
         fSFQ==
X-Gm-Message-State: ANhLgQ249GStnsObhIhUj9E1XoL4vdzOLZ9S6RA8sD24EUY4JJTGibdK
        QguwGw6fdKYj9Sz2tAcamNPIBRHVj0ZwhrI23OwWLzakVV0VwuyGY/+365eb3PWOfQGBBF5X0As
        ZfEJBKABeQ+6TWf9nL3oS5ygA
X-Received: by 2002:a5d:674f:: with SMTP id l15mr13381443wrw.196.1584992828064;
        Mon, 23 Mar 2020 12:47:08 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtUWmDK4thpwexQ8hdryAgmCprB22NosAirhPOI+x5C3asXpfwyOua+gaEuAwr0M9NrGpUzvQ==
X-Received: by 2002:a5d:674f:: with SMTP id l15mr13381412wrw.196.1584992827855;
        Mon, 23 Mar 2020 12:47:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:24d8:ed40:c82a:8a01? ([2001:b07:6468:f312:24d8:ed40:c82a:8a01])
        by smtp.gmail.com with ESMTPSA id a186sm756486wmh.33.2020.03.23.12.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 12:47:07 -0700 (PDT)
Subject: Re: [PATCH v3 2/9] KVM: x86: Move init-only kvm_x86_ops to separate
 struct
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
References: <20200321202603.19355-1-sean.j.christopherson@intel.com>
 <20200321202603.19355-3-sean.j.christopherson@intel.com>
 <87lfnr9sqn.fsf@vitty.brq.redhat.com>
 <20200323152909.GE28711@linux.intel.com>
 <87o8sn82ef.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <30b847cf-98db-145f-8aa0-a847146d5649@redhat.com>
Date:   Mon, 23 Mar 2020 20:47:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87o8sn82ef.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/20 17:24, Vitaly Kuznetsov wrote:
> Sounds cool! (not sure that with only two implementations people won't
> call it 'over-engineered' but cool). 

Yes, something like

#define KVM_X86_OP(name) .name = vmx_##name

(svm_##name for svm.c) and then

	KVM_X86_OP(check_nested_events)

etc.

> My personal wish would just be that
> function names in function implementations are not auto-generated so
> e.g. a simple 'git grep vmx_hardware_setup' works

Yes, absolutely; the function names would still be written by hand.

Paolo

> but the way how we
> fill vmx_x86_ops in can be macroed I guess.

