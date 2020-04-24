Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412A9C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19A512063A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+hOnUfo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgDXQa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 12:30:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41501 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726908AbgDXQaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 12:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587745824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lEnOw8ZF0dGRt/O1mfiDTUYS411MyNzBKC0AjVmnO9I=;
        b=G+hOnUfovzQugdMDvru5Qg7r+uHk9bbdTcdydl0YHwe0aiwHwPAk77lRt7xOOMcG1ef1OO
        OVBGLETAubzoPTmNNIbJ3GFkDXMxaYgrFTtcfayBK1eCgSXW7ptsnZxKrpLPZK5GQsUdGA
        jSkjuAvejN98SlV67AzVbl4CbNpS0z8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-VnFJit_1PBWwAEjVk5G7Rw-1; Fri, 24 Apr 2020 12:30:22 -0400
X-MC-Unique: VnFJit_1PBWwAEjVk5G7Rw-1
Received: by mail-wr1-f72.google.com with SMTP id f2so5054767wrm.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 09:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lEnOw8ZF0dGRt/O1mfiDTUYS411MyNzBKC0AjVmnO9I=;
        b=G/VeLH4Jeg/PJogMOg3HiiIWnRRJIVh39DVx2x+NzphnWgKuRXQV9z2ZyHwyJwOL7B
         VqD1iV1GU7XoxOlTrY8fW8TtihrXbk98zYj7UKDaU3LGeEhYKwFnJf7X4CdTUoEr+dxu
         JVog4k2aaAV782CCDYb0Om0R2F5zgAGqQTiiiHotKsa9FvBv4FjqvQDeleuhITFurITq
         160D4lVIQ+qV3yhepcunSN659QfXakfoEwglBveLGNmcLc9DSEvCKjbL4bOFxCGIdXKy
         H8+eikx+CGVHaGp0XJ4hleS4o6e0ViZg0A7pNdffSTzdmcirU0PQXw/MSv2wQ9SS2vnM
         RZiA==
X-Gm-Message-State: AGi0PuZVC94ca6wa4KbRI0m7v1q+j+Y9LsWg7ozaLlCtJLSlsqNNn7uQ
        pUqs7LNH8GWaIghZpO3tdtqtYhm+0e56sdFSLL3b3oVQUaoe+W9MMzcAtosFH43a3BxtAbhxR+1
        13TzZVzmlOY4HK70xfmqsNbYr
X-Received: by 2002:a1c:384:: with SMTP id 126mr11132862wmd.58.1587745821309;
        Fri, 24 Apr 2020 09:30:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypI5NdM9wUQZ0z948a+KAa0g9t1ym4JE3AZg1fAUjiERTIDRj8cTkPnrs2IYfdntnT5DXIT3Mg==
X-Received: by 2002:a1c:384:: with SMTP id 126mr11132840wmd.58.1587745821093;
        Fri, 24 Apr 2020 09:30:21 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id k14sm9205034wrp.53.2020.04.24.09.30.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 09:30:20 -0700 (PDT)
Subject: Re: [PATCH] [RFC] kvm: x86: emulate APERF/MPERF registers
To:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Li RongQing <lirongqing@baidu.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <1587704935-30960-1-git-send-email-lirongqing@baidu.com>
 <20200424100143.GZ20730@hirez.programming.kicks-ass.net>
 <20200424144625.GB30013@linux.intel.com>
 <CALMp9eQtSrZMRQtxa_Z5WmjayWzJYhSrpNkQbqK5b7Ufxg-cMA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ce51d5f9-aa7b-233b-883d-802d9b00e090@redhat.com>
Date:   Fri, 24 Apr 2020 18:30:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eQtSrZMRQtxa_Z5WmjayWzJYhSrpNkQbqK5b7Ufxg-cMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/20 18:25, Jim Mattson wrote:
>> Assuming we're going forward with this, at an absolute minimum the RDMSRs
>> need to be wrapped with checks on host _and_ guest support for the emulated
>> behavior.  Given the significant overhead, this might even be something
>> that should require an extra opt-in from userspace to enable.
> 
> I would like to see performance data before enabling this unconditionally.

I wouldn't want this to be enabled unconditionally anyway, because you
need to take into account live migration to and from processors that do
not have APERF/MPERF support.

Paolo

