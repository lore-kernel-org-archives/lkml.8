Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C01FC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3ADB206F7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKMGy2Zb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgDGMFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 08:05:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29070 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728209AbgDGMFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 08:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586261103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xs2PYMoagJh94p0hVD/QmfuH7llxM6LPUQDf48wdDxQ=;
        b=ZKMGy2ZbThMThSPn1sMApdcyFTAybgncM4FCVq1avjOwQhKmKj+ZiDBUTCxDIKX9DlINup
        6AnrxXFMCAiL5weQqssBLhwMpAhorSs1e2vITjNo11uWyyCpqEK+hh8lXBfmoZSQgZqvy5
        k6mCjLVJJ1CXLW3otT7kGlR3lv+OWP0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-wETm9zmzMA6ts11MWWEB2A-1; Tue, 07 Apr 2020 08:04:59 -0400
X-MC-Unique: wETm9zmzMA6ts11MWWEB2A-1
Received: by mail-wm1-f69.google.com with SMTP id y1so501068wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 05:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=xs2PYMoagJh94p0hVD/QmfuH7llxM6LPUQDf48wdDxQ=;
        b=CBq8d2VCjUaL5AXHx+afgg9C+1VQ11lkTnjTbLwEdyIsXlP+zhDauh8/raU/f3wREv
         b5Hk7vGKKw3bZyzF0lmjYTI41jv6sULPLvlJkeBe7ciLAmruFybwoPxkrVBii2SrmH0U
         KtMgfCU2gDmFRId4iT7D2W0W/FM/5ERqLc+X9up1Vvc9TqtMOwlrMSNJKnoDKy9BF1FN
         VME7eQhvZxBy/PAfsTa4pS+cdGTcC5UIanW8YaPmJfGFHoUhxMleWsZgevK7A5CBnp8j
         QovBE5F4BLdZLI0c2gGqPXQnXNum5KamdDOBgwQnINSEbukZyCWHygx4NsldrjTj7JIE
         faCg==
X-Gm-Message-State: AGi0PuYWztg2gSKNxB2tCbLa/+nUreVrBN+LtZhsa1pfq+TjijasPJsO
        lJAxUaCUOByp+PNrpI0nIsCYoZgWRn90Cw6LGGYb7IIJbbUTkF1PCUAZSzLt7S7aaOoNYKXq/5a
        5p37BR4IQrQgyUtmtJ2dIaqnA
X-Received: by 2002:a7b:cb59:: with SMTP id v25mr2068572wmj.139.1586261098296;
        Tue, 07 Apr 2020 05:04:58 -0700 (PDT)
X-Google-Smtp-Source: APiQypIxvMFy1wzXFEuNpmyuAGAymcuopHHwSE4i0SJNeaS+clSzuREQQnSpHRy9z4S008CNZ2pTlw==
X-Received: by 2002:a7b:cb59:: with SMTP id v25mr2068545wmj.139.1586261098042;
        Tue, 07 Apr 2020 05:04:58 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id f4sm13282639wrp.80.2020.04.07.05.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 05:04:57 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        dzickus@redhat.com, dyoung@redhat.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v2 0/3] KVM: VMX: Fix for kexec VMCLEAR and VMXON cleanup
In-Reply-To: <20200407110115.GA14381@MiWiFi-R3L-srv>
References: <20200321193751.24985-1-sean.j.christopherson@intel.com> <20200407110115.GA14381@MiWiFi-R3L-srv>
Date:   Tue, 07 Apr 2020 14:04:56 +0200
Message-ID: <87r1wzlcwn.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baoquan He <bhe@redhat.com> writes:

>
> The trace is here. 
>
> [  132.480817] RIP: 0010:crash_vmclear_local_loaded_vmcss+0x57/0xd0 [kvm_intel] 

This is a known bug,

https://lore.kernel.org/kvm/20200401081348.1345307-1-vkuznets@redhat.com/

-- 
Vitaly

