Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB5FC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF392072D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZMWXkI0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgCER27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:28:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49256 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726177AbgCER26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:28:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583429338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ceF3GiUSQK1WEq8w5MgfVzcliLUcA5FO9ZKOb5pgtv0=;
        b=ZMWXkI0zPhxvURTRzBbDivlJnQC9sUmU7AXFc1zubi9V3uAWQBo71w6v6nhvL03yozD38/
        Jc4aGw2bbLBFYRI2xmQIguDokm25daAcoNYvVhWebT+W1IyyDsKitNSFnZiHaJoYFzLU5u
        vDhKswLMHgdc49Ho1WmbEW/vLAsfaVs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-bDcrisE6M3-B81sEcCJAhg-1; Thu, 05 Mar 2020 12:28:56 -0500
X-MC-Unique: bDcrisE6M3-B81sEcCJAhg-1
Received: by mail-wr1-f72.google.com with SMTP id w18so2587316wro.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 09:28:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ceF3GiUSQK1WEq8w5MgfVzcliLUcA5FO9ZKOb5pgtv0=;
        b=J84v8oex9kzGcx42U4oeqqzqoLtaXb68A5tCOlGLhoUsoR9zB8+hD68kszthpue6vx
         4cloJG/eJaakv8pjibWdmXz/PJWdcM41xgijiClcLk6/o2Sxmu3J5LhDqyR9OkV14+RW
         JhaitqCIHf4ycWfzNjJ0yzCWv0qTumeIiq6ospqcJ0Q0B4ToL7YbwBy/Zbb5wMHUqsiZ
         Dv9hTH85zwTNflCgIA0285jVRbn5ab3RXscZEFqFATc/TKFcnOb6TdFfrL2sTzeV6TX1
         6WjP3fO2XgaDz+LEu1A3/oOSTWTzHoZSzIeiCa6lKRQ1hxnWQttmqWXfgZyYPOSoMTLO
         Eg6w==
X-Gm-Message-State: ANhLgQ1z6xJMgJ2sEN2cswoykn7NC4+Pt1y+fT9LCBc/HpSdd2GRdiTr
        MNwauWulzxt+dHsNgxBubc3XpFPJmfQtXq7KXiRPA92+QFm0HJe1jkr15w/oSdYEBb+aiw/3q9i
        IriL13yXETLHmzseKgk6OKyww
X-Received: by 2002:adf:a505:: with SMTP id i5mr3861wrb.33.1583429335374;
        Thu, 05 Mar 2020 09:28:55 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsQoFH7kzyx+gM+glwSlc10vMgCj0V9akWbUaOT9igFNEYotJGKzGObcS79C1ILPoEQ5igBZg==
X-Received: by 2002:adf:a505:: with SMTP id i5mr3844wrb.33.1583429335147;
        Thu, 05 Mar 2020 09:28:55 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993? ([2001:b07:6468:f312:9def:34a0:b68d:9993])
        by smtp.gmail.com with ESMTPSA id o8sm9617441wmh.15.2020.03.05.09.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 09:28:54 -0800 (PST)
Subject: Re: [RFC PATCH 0/1] kvm: selftests: Add TEST_FAIL macro
To:     Wainer dos Santos Moschetta <wainersm@redhat.com>,
        kvm@vger.kernel.org
Cc:     shuah@kernel.org, tglx@linutronix.de, thuth@redhat.com,
        sean.j.christopherson@intel.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200305172532.9360-1-wainersm@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e7bacea1-6964-aeb2-633e-371ad1231881@redhat.com>
Date:   Thu, 5 Mar 2020 18:28:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200305172532.9360-1-wainersm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/20 18:25, Wainer dos Santos Moschetta wrote:
> The following patch's commit message is self-explanatory about this proposal.
> 
> I adjusted to use TEST_FAIL only a few source files, in reality it will
> need to change all the ones listed below. I will proceed with the
> adjustments if this new macro idea is accepted.
> 
> $ find . -type f -name "*.c" -exec grep -l "TEST_ASSERT(false" {} \;
> ./lib/kvm_util.c
> ./lib/io.c
> ./lib/x86_64/processor.c
> ./lib/aarch64/ucall.c
> ./lib/aarch64/processor.c
> ./x86_64/vmx_dirty_log_test.c
> ./x86_64/state_test.c
> ./x86_64/vmx_tsc_adjust_test.c
> ./x86_64/svm_vmcall_test.c
> ./x86_64/evmcs_test.c
> ./x86_64/vmx_close_while_nested_test.c
> 
> Wainer dos Santos Moschetta (1):
>   kvm: selftests: Add TEST_FAIL macro
> 
>  tools/testing/selftests/kvm/dirty_log_test.c             | 7 +++----
>  tools/testing/selftests/kvm/include/test_util.h          | 3 +++
>  tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c | 4 ++--
>  3 files changed, 8 insertions(+), 6 deletions(-)
> 

Yes, why not.

Paolo

