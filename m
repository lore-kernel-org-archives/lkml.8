Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8A7C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CAD720771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RoTJFRbR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441724AbgDPPDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:03:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35869 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2441725AbgDPNxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587045221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l5Kvo8iqImptqYWsZSVRrcAXyDBLn+NV1FJvmlGAZQs=;
        b=RoTJFRbR4rzaOwNX7LcSs9elegXgI7fBsqdwi96HECy8futjYinQItzUlaftvuAqO0c7Yb
        jwQKfnWxXZxY4S1NGcuwObEHaIOcri0paPu1hRmE5RL6nVFuXREyfZvkeVOh9qL6cofR/c
        t3/UBI4k02MNHwYgJeIEBCfOdW1IRlU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-2YJKJvimMT-5RUX7qxa0pA-1; Thu, 16 Apr 2020 09:53:39 -0400
X-MC-Unique: 2YJKJvimMT-5RUX7qxa0pA-1
Received: by mail-wr1-f70.google.com with SMTP id d17so1723931wrr.17
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 06:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l5Kvo8iqImptqYWsZSVRrcAXyDBLn+NV1FJvmlGAZQs=;
        b=djHXVdtt/LEOwQgqdnBQ5lFz3DoHoPR3IykBa87k3QzUf7dHOmTJ4mLtjIvc/YsozY
         T0FXgHfHPEIOmvhSiTjiXNpnIqBHrG/OW5wEiTGJvEa/wkQkRAiRiJb3g6IJLArmSGEj
         JaHeAey0w9pFsSTvakBLfmWnZA7AIBK8tSoVARSJAiKCaAt7QOPUnLnXbwLioe4/FABN
         YJR0jz+DGf5IOuU1qRVZ9hPghsiNYrLkNMbB/hY+oVnvmwSpvkUIsqzArKlslMVpN+xL
         ToTWnbYuNZT/sPpmS72UKHjFULCSs4W38kuWnWc1wOlE6q5+AqbewKF6QHWT2/MN5IWt
         TxQg==
X-Gm-Message-State: AGi0PuYbyU7D+JS2uli26XaYPkFARDSSIeesFV/lA2vfT/flNLphqoft
        OllLm8c7hFfU61TB+YlK04zepRQHvZOoqO+9DZYQsmCR4j5TkqiTSNJANI0RvW4mJ8JZdl2ZPRi
        MqVIO2x0iM3y6Pw5uY7pHG58t
X-Received: by 2002:a1c:41d7:: with SMTP id o206mr5041261wma.89.1587045218354;
        Thu, 16 Apr 2020 06:53:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypJz8z7BCZnr8VscT/Dzs37ZSpW6T2prR2o4U8uyDX4us/2PqqegrZdIYt2ZRQvbdMEU26XesA==
X-Received: by 2002:a1c:41d7:: with SMTP id o206mr5041239wma.89.1587045218126;
        Thu, 16 Apr 2020 06:53:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:399d:3ef7:647c:b12d? ([2001:b07:6468:f312:399d:3ef7:647c:b12d])
        by smtp.gmail.com with ESMTPSA id f23sm3585008wml.4.2020.04.16.06.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 06:53:37 -0700 (PDT)
Subject: Re: [PATCH 1/1] selftests: kvm: Add overlapped memory regions test
To:     Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Wainer dos Santos Moschetta <wainersm@redhat.com>,
        kvm@vger.kernel.org
Cc:     drjones@redhat.com, sean.j.christopherson@intel.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20200415204505.10021-1-wainersm@redhat.com>
 <20200415204505.10021-2-wainersm@redhat.com>
 <455a01b6-506b-3c16-7ad8-327ad63292e9@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1d05b77b-1e8b-2dfd-cbc9-5b09b685b630@redhat.com>
Date:   Thu, 16 Apr 2020 15:53:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <455a01b6-506b-3c16-7ad8-327ad63292e9@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/20 01:57, Krish Sadhukhan wrote:
> 
>> Add the test_overlap_memory_regions() test case in
>> set_memory_region_test. This should check that overlapping
>> memory regions on the guest physical address cannot be added.
> 
> 
> I think the commit header and the body need some improvement. For example,
> 
>         Header: Test that overlapping guest memory regions can not be added
> 
>         Body:  Enhance the existing tests in set_memory_region_test.c so
> that it tests overlapping guest
> 
>                     memory regions. The new test verifies that adding
> overlapping guest memory regions fails.

I like Wainer's header and your body. :)

Paolo

