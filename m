Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CE0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 11:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0506F207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 11:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VMWqPkzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731480AbgFSL3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 07:29:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29626 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731147AbgFSL3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 07:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592566183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b3G5Sg9UDrE3ygdkaaLbR8lITkBl+GdILcq1UrtCIMM=;
        b=VMWqPkzU4iEvuSBgyoVny3Ifr52RLGvEkYWKEbE1R+Xj0hxNCHCGUlbgFtTyOEV82jXV0g
        RFJm0R2F4dYh0C04q8RzgAgrnmCC/hBOlzGNOeJvaa5q4dPS6BI4TZ82OX+Aw/lm1yK1mD
        ow4fmqLp8rqKamLVj0+zgdJHfepyz+I=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-H-wP2kzFN4C7X9_nm-v1gg-1; Fri, 19 Jun 2020 07:29:41 -0400
X-MC-Unique: H-wP2kzFN4C7X9_nm-v1gg-1
Received: by mail-ej1-f72.google.com with SMTP id f27so3844998ejt.17
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 04:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=b3G5Sg9UDrE3ygdkaaLbR8lITkBl+GdILcq1UrtCIMM=;
        b=MlHczVF1cYSKyWcOgam53RjZSeDR3vfFBWiuTNLilLAxTsvNnIHY3bJEV2byODSQSn
         ORsS25xChBQIFwQg2Q8nU9jJsaDsNsP568AInx0CkZa+bVoFFLgV2rHsGehjSH7d8eMj
         /rIH/dwAhteCa8hja5e2KNWY1j+ZdU09gUspq6/M5N5deeDFN9fAP2tQZPUUJtTqlo85
         5cDuvYXvQZsNhFhkTjFGGss6ZyiXdJSMXG6zd7K69gd6TR20BO4acO5dG78MH12ir+ky
         mFyKFmc3/o84EBB+cHkRLCs3WiR1pEzxr0R3w9Op5vjLPDtFXuTvSj73L5kQrDH5fP5X
         LGBA==
X-Gm-Message-State: AOAM531tdg6GNpDiJdir74wvr+Y7pwzO12sBqsckeMGaZXYUw4JM3WwO
        fZ8yzTE/6N3oqq86zchJMY9YFSj8W1jrPPP8W8DtPWUO7zQjZazxTCcxMuuO71+acDHjjPUbQE/
        dqjhYucSWEgqAnHA3AbabrMGJ
X-Received: by 2002:a17:906:cc85:: with SMTP id oq5mr3120807ejb.142.1592566180117;
        Fri, 19 Jun 2020 04:29:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKOezBmCA21RB4bkpAUbx0Esf7jxxGwzvG3u6+Ourw/aIp/mFzQOIEXQr09AR9vOGl8T5Zqg==
X-Received: by 2002:a17:906:cc85:: with SMTP id oq5mr3120784ejb.142.1592566179899;
        Fri, 19 Jun 2020 04:29:39 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id q5sm4447074edr.21.2020.06.19.04.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 04:29:39 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     like.xu@intel.com, kvm@vger.kernel.org
Cc:     Jim Mattson <jmattson@google.com>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>
Subject: Re: [PATCH RFC] Revert "KVM: VMX: Micro-optimize vmexit time when not exposing PMU"
In-Reply-To: <2c7d6849-7fac-b9f6-7bcb-5509863564f3@intel.com>
References: <20200619094046.654019-1-vkuznets@redhat.com> <2c7d6849-7fac-b9f6-7bcb-5509863564f3@intel.com>
Date:   Fri, 19 Jun 2020 13:29:38 +0200
Message-ID: <87366rguot.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Xu, Like" <like.xu@intel.com> writes:

> On 2020/6/19 17:40, Vitaly Kuznetsov wrote:
>> Guest crashes are observed on a Cascade Lake system when 'perf top' is
>> launched on the host, e.g.
> Interesting, is it specific to Cascade Lake?
>

Actually no, just reproduced this on a Haswell system. If you run the
guest with "-cpu host,-pmu" and do 'perf top' (on the host) the guest
crashes immediately.

> Would you mind sharing the output of
> "cpuid -r -l 1 -1" and "cat /proc/cpuinfo| grep microcode | uniq" with us ?

Sure (this is probably unrelated because the issue also reproduces on
Haswell but still):

# cpuid -r -l 1 -1

CPU:
   0x00000001 0x00: eax=0x00050657 ebx=0x03200800 ecx=0x7ffefbff edx=0xbfebfbff

# cat /proc/cpuinfo| grep microcode | uniq
microcode	: 0x500002c

This is "Intel(R) Xeon(R) Gold 5218 CPU @ 2.30GHz"

-- 
Vitaly

