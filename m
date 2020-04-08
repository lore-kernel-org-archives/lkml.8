Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB07C2BA1B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E27020801
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/OX2awc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgDHJFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 05:05:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47863 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726934AbgDHJFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 05:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586336705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+RzyGS9EoGujFpaXJAEBJ9AsmfM4q8CD3D3UVVpE8Bc=;
        b=Q/OX2awcM8mnsBgzKu/5ONyaBjrWetBmocAeYVjETW9jPTq6ULPYvVszdMuQVDhjTsHqqW
        5On2/Ymk/DLBF4Jpa8bv2tiEJWcZDg7VwR7kCvd6JiNc+OwViaGaKgZjlNJ5i9WDBCSJeL
        YAkUhXDTvegWPDlsUwD9cgaYO3PtDEo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-o1mveXh8NjKI6qojWcqQQw-1; Wed, 08 Apr 2020 05:05:03 -0400
X-MC-Unique: o1mveXh8NjKI6qojWcqQQw-1
Received: by mail-wr1-f71.google.com with SMTP id d4so3655590wrq.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 02:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+RzyGS9EoGujFpaXJAEBJ9AsmfM4q8CD3D3UVVpE8Bc=;
        b=nRWahl7J1WA6xcxTxzVuvKD+l9lsWJeBfbFOiaewJI4gm7kZkwOUNMwRjik2edhA59
         Bysv0oS+adYNpgx5IQpKMOgsG2hjwpF/p2UgvMjSpPdquNonRAPB+njlTiGslRjpdDcP
         d6z0qY4TWOUuDJZCsVH2/TaLxz4XkHBQcjWBn89Mmt/C4tbx2xjRSKMg9Sm54w4uzDdE
         Q2pYrm1owzaqPSbLCzTaeeDLpywwZ1AfR1DFPVbARJIIsyERUleHydp98tZVhVq9SY7+
         soRfCuJrxmOj8WBm7+Df6j70zdR6PzBjONFGr7/CYI4lUYTX8anBr5fb5yT7tjePEvkT
         FROA==
X-Gm-Message-State: AGi0PuYJAVgJNNtJWPgkitztWZqi+ec/4CKp0QEkG7xIApJE0cKYW9no
        KokJkLQjNFOdMC0Ib1JWK1ZXuEvr/6eC6KVdLdbgPeBs7LZbTSfPqYWrswQAbstMsJav8u1nzH9
        8hz+tT5sT2Yn4uSBrgo1nkJgk
X-Received: by 2002:a7b:c012:: with SMTP id c18mr3607455wmb.22.1586336702420;
        Wed, 08 Apr 2020 02:05:02 -0700 (PDT)
X-Google-Smtp-Source: APiQypJXM2yXZr3t9mtg2MkEeN2e23EKKvaE0vPqyGRupTqHU0t6tmIQZNb8KYn7TeoQmMbPttzMbA==
X-Received: by 2002:a7b:c012:: with SMTP id c18mr3607427wmb.22.1586336702150;
        Wed, 08 Apr 2020 02:05:02 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id b11sm34653675wrq.26.2020.04.08.02.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 02:05:01 -0700 (PDT)
Subject: Re: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hch@infradead.org, sean.j.christopherson@intel.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        kenny@panix.com, jeyu@kernel.org, rasmus.villemoes@prevas.dk,
        fenghua.yu@intel.com, xiaoyao.li@intel.com, nadav.amit@gmail.com,
        thellstrom@vmware.com, tony.luck@intel.com,
        gregkh@linuxfoundation.org, jannh@google.com,
        keescook@chromium.org, David.Laight@aculab.com,
        dcovelli@vmware.com, mhiramat@kernel.org,
        Wolfgang Mauerer <wolfgang.mauerer@oth-regensburg.de>
References: <20200407110236.930134290@infradead.org>
 <20200407111007.429362016@infradead.org>
 <20200407174824.5e97a597@gandalf.local.home>
 <137fe245-69f3-080e-5f2b-207cd218f199@siemens.com>
 <0ed2739b-6961-c476-be2d-020e855796dc@redhat.com>
 <2aed2b96-c726-1357-44bb-649ec0a809ad@siemens.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2fe38887-adba-5b4c-8514-5f0925470623@redhat.com>
Date:   Wed, 8 Apr 2020 11:04:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <2aed2b96-c726-1357-44bb-649ec0a809ad@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/20 10:58, Jan Kiszka wrote:
>> Why not contribute the Jailhouse loader into Linux?
> 
> Definitely planned. But right now it would add the burden of managing
> the interface between loader and hypervisor carefully. Currently it is
> internal to Jailhouse and maintained in lock-step, without any backward
> compatibility.

How often does that change?

Paolo

