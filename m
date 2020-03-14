Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88776C4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 03:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1EC20578
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 03:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cuhKXD2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgCODkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 23:40:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24398 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726668AbgCODkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 23:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584243610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7mUmgqOIFOdKgmbkoQ0zespckuiZdF8ycwVxiswURFM=;
        b=cuhKXD2JoWMcCLwfw5DqmA6ZZvk1QBAp0wZrhs4q2gkrPjV/ObUMLEjeWEiY+LaHsQ0v84
        RlgxXKYrIS8Rp0nkg+BcsCO+2YLdRhwJJEQJvyQ69gclcHE1Rgftfk4jnvNIr2xB4se6kN
        jXSfQBliixw0AcywWJmRCYXAkUqqCaY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-Pw3YuW3APQWkuirTtbakpw-1; Sat, 14 Mar 2020 07:37:44 -0400
X-MC-Unique: Pw3YuW3APQWkuirTtbakpw-1
Received: by mail-wr1-f69.google.com with SMTP id u12so3382473wrw.10
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 04:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7mUmgqOIFOdKgmbkoQ0zespckuiZdF8ycwVxiswURFM=;
        b=UNWq+U1vxabWfBv98hiapV9uQIIBj6lNk/PkTpWmnZhRxBpAhCgWcALKaiapKy+i6f
         Ycimovx++pP1XuNdqfdWLVaPGe1shCiJeym+C/o5vnUPbiUisUs26bjVn7xUqoJ6r8cM
         LXg4rqkJBVKPRfX4opqNC3Re3bnwJBwwqmuBVgeFQLkTPoIPcpz29cppJKQWHLSWv3rr
         qB+zY6elsL3SqQzy8ndxhzQkr/w8ZVpagUp0YCfmNTW/0QxvO4n/OGpUpnF0y5hSqNNL
         SNpjBXDUAwYa4erFrrgfgMBUuC+E7lGiLZXAou1APIRERZYD3vH40Rrvyhm8BEupZYv5
         T03A==
X-Gm-Message-State: ANhLgQ2dr1e7fjkU6G3Ww8EEFaQ+bZZcfCUuCfqs9gGsKyvTqn1qLuZ9
        O+ZbADSYgKCzo/SsPJb1UM/NHhRmjVOtaAXXIafPfcC105vjNxsSYWVXRodpSL21/eI9t8HqGQQ
        jZOsiAk6PA2i9dR79Ifu/z32M
X-Received: by 2002:a5d:6a0e:: with SMTP id m14mr24146631wru.202.1584185863205;
        Sat, 14 Mar 2020 04:37:43 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtNGoRby/wRfjauVrobYr5jBC5s8q6oSM+F2dujPpEvIkjrwFi5vDmCl73ddSAQ4SsdWa43Zw==
X-Received: by 2002:a5d:6a0e:: with SMTP id m14mr24146612wru.202.1584185862992;
        Sat, 14 Mar 2020 04:37:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7de8:5d90:2370:d1ac? ([2001:b07:6468:f312:7de8:5d90:2370:d1ac])
        by smtp.gmail.com with ESMTPSA id f17sm76798128wrj.28.2020.03.14.04.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2020 04:37:42 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] kvm: selftests: Introduce TEST_FAIL and convert
To:     Wainer dos Santos Moschetta <wainersm@redhat.com>,
        kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        sean.j.christopherson@intel.com, shuah@kernel.org,
        tglx@linutronix.de, thuth@redhat.com
References: <20200310025059.9301-1-wainersm@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <61b30d46-316c-5ef6-179f-fc394d352766@redhat.com>
Date:   Sat, 14 Mar 2020 12:37:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310025059.9301-1-wainersm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/20 03:50, Wainer dos Santos Moschetta wrote:
> Introduce the TEST_FAIL macro and change the tests/utilities
> to use it.
> 
> v1 -> v2:
> - Completed the conversion to TEST_FAIL.
> 
> v1:
> - [RFC PATCH 0/1] kvm: selftests: Add TEST_FAIL macro
>   https://lore.kernel.org/kvm/20200305172532.9360-1-wainersm@redhat.com/
> 
> Wainer dos Santos Moschetta (2):
>   selftests: kvm: Introduce the TEST_FAIL macro
>   selftests: kvm: Uses TEST_FAIL in tests/utilities
> 
>  tools/testing/selftests/kvm/dirty_log_test.c  |  7 +++----
>  .../testing/selftests/kvm/include/test_util.h |  3 +++
>  .../selftests/kvm/lib/aarch64/processor.c     | 17 +++++++--------
>  .../testing/selftests/kvm/lib/aarch64/ucall.c |  2 +-
>  tools/testing/selftests/kvm/lib/io.c          | 12 +++++------
>  tools/testing/selftests/kvm/lib/kvm_util.c    | 21 ++++++++-----------
>  .../selftests/kvm/lib/x86_64/processor.c      |  5 ++---
>  .../kvm/x86_64/cr4_cpuid_sync_test.c          |  4 ++--
>  .../testing/selftests/kvm/x86_64/evmcs_test.c |  6 +++---
>  .../testing/selftests/kvm/x86_64/state_test.c |  6 +++---
>  .../selftests/kvm/x86_64/svm_vmcall_test.c    |  6 ++----
>  .../kvm/x86_64/vmx_close_while_nested_test.c  |  4 ++--
>  .../selftests/kvm/x86_64/vmx_dirty_log_test.c |  6 +++---
>  .../kvm/x86_64/vmx_tsc_adjust_test.c          |  4 ++--
>  14 files changed, 49 insertions(+), 54 deletions(-)
> 

Queued, thanks.

Paolo

