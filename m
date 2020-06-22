Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5A1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AE6F20706
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LtwMFa0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgFVLAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 07:00:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51302 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727810AbgFVLAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 07:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592823600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h8E9QgTr5DUSmPQUcgFY/pyHg2J7mDIdAy0q0CM6YVs=;
        b=LtwMFa0jhS1Q6rUkiuSDTD7VCgOQUrucnd2zx9QUHli6D6NSgx3jLhDgDStH0y6MaFIwJd
        vquXFJ7ADcT/5UDhw4xgT/9FjUKSIsiA7nWL8Xq/zVNjKGIzSxzGiw9VCJGjQMlJvQPIB8
        US/AWURjEvKv1GDqENkm4m6D9G2+LPI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-WNi59jGoNS2t_2yFWveAMQ-1; Mon, 22 Jun 2020 06:59:56 -0400
X-MC-Unique: WNi59jGoNS2t_2yFWveAMQ-1
Received: by mail-wm1-f69.google.com with SMTP id e15so2904802wme.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 03:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=h8E9QgTr5DUSmPQUcgFY/pyHg2J7mDIdAy0q0CM6YVs=;
        b=TyhasNCI4tcmP3dsPD2uLg/5p6PvN8XcF8RwD3MIuuIo75LB8m8yR6sQGFdqzC9IKh
         lUHI/Bw9xCcVZXhC5/oizrRhbk5v6sCxZMY2+fJfQu5MtxzIRk0dZ/VEOlyzrB7nFWlY
         OOtkCGe8Z1yqBJ1qOogotGBmQqpsDgpm6ydNb4lJFZ+Rq7q3uL0VhMhNWfZXW60z1mu9
         TYEsBH/t8sZgQ09UKjQZSuUjXtp2aP3ZIJmIi7+D0ATucS50WJmdq7gs3Sb9ZA+2wJ1K
         N422R8GOvhx2uhXq/Al+1cyL5HglB6xhe6VVFV9tNELRIzw0zw76SHkyGQCqCR5L6dwK
         RxAA==
X-Gm-Message-State: AOAM530qzvYCheFePCSDCcCq9v5kGfh6yZnRtw9xdGtsrKbSrYY+EKc6
        TIQ3ZDQOV2rV5bAOajYPpVEp7T1iIQUGKHgS0M9cqqX0m0Qj9MBrbNddziCsrAsSAqs6qId8C/l
        JDea9PH4dKeWJDoiESqFneZY9
X-Received: by 2002:a1c:9ec4:: with SMTP id h187mr17658377wme.27.1592823595583;
        Mon, 22 Jun 2020 03:59:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzU0bX7wm+ozkWz+5aBqs2YpW0BK97Ao8m+ZhEht7Htjof/4aAVnlwSlLaDsim2jqnkq0PV2A==
X-Received: by 2002:a1c:9ec4:: with SMTP id h187mr17658362wme.27.1592823595363;
        Mon, 22 Jun 2020 03:59:55 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id u13sm15951613wmm.6.2020.06.22.03.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 03:59:54 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>, xudong.hao@intel.com,
        Joerg Roedel <joro@8bytes.org>,
        Jim Mattson <jmattson@google.com>,
        kvm list <kvm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Subject: Re: selftests: kvm: Test results on x86_64
In-Reply-To: <CA+G9fYvVfSEBsZCaiMCpCKfJNdbFzrKGdXR0KeRYG+nhDiEpuA@mail.gmail.com>
References: <CA+G9fYvVfSEBsZCaiMCpCKfJNdbFzrKGdXR0KeRYG+nhDiEpuA@mail.gmail.com>
Date:   Mon, 22 Jun 2020 12:59:53 +0200
Message-ID: <87r1u7fjrq.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Naresh Kamboju <naresh.kamboju@linaro.org> writes:

> FYI,
> Linaro test farm selftests kvm test cases results.
>   * kvm_mmio_warning_test — SKIP
>   * kvm_svm_vmcall_test — SKIP
>   * kvm_clear_dirty_log_test — PASS
>   * kvm_cr4_cpuid_sync_test — PASS
>   * kvm_debug_regs — PASS
>   * kvm_demand_paging_test — PASS
>   * kvm_dirty_log_test — PASS
>   * kvm_evmcs_test — PASS
>   * kvm_hyperv_cpuid — PASS
>   * kvm_ * kvm_create_max_vcpus — PASS
>   * kvm_platform_info_test — PASS
>   * kvm_set_memory_region_test — PASS
>   * kvm_set_sregs_test — PASS
>   * kvm_smm_test — PASS
>   * kvm_state_test — PASS
>   * kvm_steal_time — PASS
>   * kvm_sync_regs_test — PASS
>   * kvm_vmx_close_while_nested_test — PASS
>   * kvm_vmx_dirty_log_test — PASS
>   * kvm_vmx_preemption_timer_test — PASS
>   * kvm_vmx_set_nested_state_test — PASS
>   * kvm_vmx_tsc_adjust_test — PASS
>   * kvm_xss_msr_test — PASS

[...]

Thanks you! It would be great to see which particular commit was tested
here and how often you run these tests in general, which git/branch you
follow. Also, you can improve your subject line by adding [PASS] or
[FAIL] so we can see if there's a problem to deal with.

-- 
Vitaly

