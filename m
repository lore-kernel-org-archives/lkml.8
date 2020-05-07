Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79D4C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9453E20753
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 08:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXol8bvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgEGIHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 04:07:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29065 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725802AbgEGIHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 04:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588838870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wv0mOSCnxKTicrthUx8qD4Gdmzuzm3B45a3lzpvmvbE=;
        b=aXol8bvWpmpytcMLlsDXuWSvajCFWwazpLDhTQqI/7AjYyTFIoYJnfYBpf7HiVpzFmUlNP
        iRkbNGuhp5v50vgam+aMqs2qwTNB4R2enXx+sStTbKd7NB7QP+M9IsEmCEgs1E5fW2/CD0
        llPufCqxGxbR6nGvV1vqP/DHI0nZmgY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-WOwVkiH6PQ2k4tuKBTztOA-1; Thu, 07 May 2020 04:07:49 -0400
X-MC-Unique: WOwVkiH6PQ2k4tuKBTztOA-1
Received: by mail-wr1-f69.google.com with SMTP id q13so2946566wrn.14
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 01:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wv0mOSCnxKTicrthUx8qD4Gdmzuzm3B45a3lzpvmvbE=;
        b=QJSVoU7D6l8kde2c7Yu5f8x8HJGA6og2gsBBn5vwVVeXNiZrJ6mwNLZR9scLvQriF0
         zE0TUuGf2jt+TlJkMhwe25SyF4p7Hf3d0TeU2q0NnzG//1xLulEEDuCin5oAYH4N/7Mw
         ZpQa35kdUSoyoFoTRhLcZBxVHj1Yu6Uy0l0FRJze5Ec4qCP6yrHoKOqZx/0gyhRVxS09
         v81S5SgVyMo763LiO7MMhLUP00ABIkjUbapVhCg8dKwRKBG7+om5gJNWuAOD0kYrJ1Pi
         1NcvPFa6yhIIvJT6NomgY2EPjdAfcp8WLzNw0POpsZrvRjJPoD6qfDHho7BxnOpn1905
         O6vw==
X-Gm-Message-State: AGi0PubXWf94Cj6mElfu711IBwWW//pF/znBNXMxTwXauJ52Uqy8qVgT
        rs4OyhLRDYtxfNzPxWyRO7CMCNVDu4NFOwhdMH48uStMP4RBL2k+i9v9p1MEmSmrEFiM4754S2B
        4x5JbVRJmN9CW3pxAm9ndASdj
X-Received: by 2002:a1c:e284:: with SMTP id z126mr9413066wmg.32.1588838867919;
        Thu, 07 May 2020 01:07:47 -0700 (PDT)
X-Google-Smtp-Source: APiQypLTXiiU3UkAdYR4RMFur3wFpU3okv9srf6nRpwXbG0FArZbqcl2F96cXBzPuGbEq+xSCMwkXQ==
X-Received: by 2002:a1c:e284:: with SMTP id z126mr9413005wmg.32.1588838867612;
        Thu, 07 May 2020 01:07:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8d3e:39e5:cd88:13cc? ([2001:b07:6468:f312:8d3e:39e5:cd88:13cc])
        by smtp.gmail.com with ESMTPSA id 19sm6563897wmo.3.2020.05.07.01.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 01:07:47 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: SVM: Add support for MPK feature on AMD
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Babu Moger <babu.moger@amd.com>
Cc:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        mchehab+samsung@kernel.org, changbin.du@intel.com,
        namit@vmware.com, bigeasy@linutronix.de,
        yang.shi@linux.alibaba.com, asteinhauser@google.com,
        anshuman.khandual@arm.com, jan.kiszka@siemens.com,
        akpm@linux-foundation.org, steven.price@arm.com,
        rppt@linux.vnet.ibm.com, peterx@redhat.com,
        dan.j.williams@intel.com, arjunroy@google.com, logang@deltatee.com,
        thellstrom@vmware.com, aarcange@redhat.com, justin.he@arm.com,
        robin.murphy@arm.com, ira.weiny@intel.com, keescook@chromium.org,
        jgross@suse.com, andrew.cooper3@citrix.com,
        pawan.kumar.gupta@linux.intel.com, fenghua.yu@intel.com,
        vineela.tummalapalli@intel.com, yamada.masahiro@socionext.com,
        sam@ravnborg.org, acme@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <158880240546.11615.2219410169137148044.stgit@naples-babu.amd.com>
 <158880254122.11615.156420638099504288.stgit@naples-babu.amd.com>
 <20200506222643.GL3329@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d573551a-29cb-3cb8-b807-200b5e462a01@redhat.com>
Date:   Thu, 7 May 2020 10:07:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200506222643.GL3329@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/20 00:26, Sean Christopherson wrote:
>> +	/* Load the guest pkru state */
>> +	if (static_cpu_has(X86_FEATURE_PKU) &&
>> +	    kvm_read_cr4_bits(vcpu, X86_CR4_PKE) &&
>> +	    vcpu->arch.pkru != svm->host_pkru)
>> +		__write_pkru(vcpu->arch.pkru);
> This and the restoration should be moved to common x86 helpers, at a glance
> they look identical.
> 
> In short, pretty much all of this belongs in common x86.
> 

We could stick this in kvm_load_guest_xsave_state
kvm_load_host_xsave_state.  It's not a perfect match, after all the code
itself proves that PKRU can be loaded without XSAVE; but it's close
enough and it's exactly in the right point of vmx_vcpu_run and svm_vcpu_run.

Paolo

