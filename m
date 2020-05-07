Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3F2C54E49
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A32E207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bn4P6TcA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgEGPRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 11:17:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25329 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726519AbgEGPRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 11:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588864631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cRIPMJwMfVphGwxMC976WpIk6/4Dq31PdpH7lHRMERw=;
        b=Bn4P6TcAcdttpCtIN5jXlG/zod36YV1g/uWV68jjjSUw4fKtDYaLGGPvk2TRHF/wrEo5/w
        MDTTwH3xYsPxm7p3ReqNzIt2KbmAV/2n27zH0+blRCSFV9tP4Nv8Goy5wVWWL0gbiJrjCy
        XKQIGLmvOU3g5/YPMR80+YKOShCsCvc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-RSg9Btr2NEeLVryddAxxXg-1; Thu, 07 May 2020 11:17:08 -0400
X-MC-Unique: RSg9Btr2NEeLVryddAxxXg-1
Received: by mail-wr1-f71.google.com with SMTP id g10so3618290wrr.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 08:17:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cRIPMJwMfVphGwxMC976WpIk6/4Dq31PdpH7lHRMERw=;
        b=I66RpjxHNRMuYG7lWdQT6jP+DQnrCoOR1njjZFNg/7IY0Xj3K8TRmwRyU/RaCPQGUG
         KIHkYd7QbibUgtXbIOgAHQKzfLgDVjGfQFOix9fd+eXtVDiwX24cyvLuHq/Oml1t+mDd
         DYM9xxsrEuT+gke2ADTB5NJtypuPB7PhYWltVMwte6JtaR8XM/zF5xf4E//4PdeKDnYg
         /taWOu/Jt9xWXwR0SQ2/drFI9/ktRAEZOBehBIuF3eLbRViJ8NBn3Eiwgxn+9fF+w6kl
         0o69HIY3x2D27gbrIrjh3mWw5ixDlGOoXCk9gNMx4/rJD1lHMvGym7dUK0Zu74ZSAU3j
         Qj0g==
X-Gm-Message-State: AGi0PuaDXcUCxA2KA2wRRRQ+f/Vzq9sN0ZH5vtgakn/vaZd0zN2uT1t9
        s4HJG8kg4Q6wiqI8Ve45Grmonr6bUVjhvQHhBatSR5qMAvDX/F/+XVS7Zvm1NLPaQAGYn8YH3xy
        m9tFNRnz/+xGlrIYv0Yj2pgi7
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr11733468wmh.31.1588864626701;
        Thu, 07 May 2020 08:17:06 -0700 (PDT)
X-Google-Smtp-Source: APiQypIxOythRrjywGd5bcMR7Aky7KZnSEbCO09E3kJJhynh/cbmPoCLvTlRrUUobsVcZbrWuNTNHw==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr11733421wmh.31.1588864626355;
        Thu, 07 May 2020 08:17:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:8d3e:39e5:cd88:13cc? ([2001:b07:6468:f312:8d3e:39e5:cd88:13cc])
        by smtp.gmail.com with ESMTPSA id v2sm8933907wrn.21.2020.05.07.08.17.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 08:17:02 -0700 (PDT)
Subject: Re: [PATCH 1/2] arch/x86: Rename config
 X86_INTEL_MEMORY_PROTECTION_KEYS to generic x86
To:     Dave Hansen <dave.hansen@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Babu Moger <babu.moger@amd.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        sean.j.christopherson@intel.com, x86@kernel.org,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, mchehab+samsung@kernel.org,
        changbin.du@intel.com, namit@vmware.com,
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
 <158880253347.11615.8499618616856685179.stgit@naples-babu.amd.com>
 <4d86b207-77af-dc5d-88a4-f092be0043f6@intel.com>
 <20200507072934.d5l6cpqyy54lrrla@linutronix.de>
 <034cfb90-7f75-8e36-5b1e-ceaef0dfa50d@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1aca7824-f917-c027-ef02-d3a9e7780c3b@redhat.com>
Date:   Thu, 7 May 2020 17:16:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <034cfb90-7f75-8e36-5b1e-ceaef0dfa50d@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/20 16:44, Dave Hansen wrote:
>> You could add a new option (X86_MEMORY_PROTECTION_KEYS) which is
>> def_bool X86_INTEL_MEMORY_PROTECTION_KEYS and avoiding the prompt line.
>> Soo it is selected based on the old option and the user isn't bother. A
>> few cycles later you could remove intel option and add prompt to other.
>> But still little work for…
> That does sound viable, if we decide it's all worth it.
> 
> So, for now my preference would be to change the prompt, but leave the
> CONFIG_ naming in place.

I agree.

What's in a name?  An Intel rose by any other name would smell as sweet.
 Oh wait... :)

Paolo

> If we decide that transitioning the config is
> the right thing (I don't feel super strongly either way), let's use
> Sebastian's trick to avoid the Kconfig prompts.
> 

