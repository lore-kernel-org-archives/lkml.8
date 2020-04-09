Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FB7C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 11:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EE020757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 11:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZ/KYm7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgDILOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 07:14:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54129 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725972AbgDILOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 07:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586430859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eVe7IfDc6Eg1zSotYzISNC1XY4K3ye5o8p4mKeTvCRU=;
        b=TZ/KYm7SQYqfkNiFFf/CRNt0A6o3AnNNP4jjAYYfHRRHG1qqUkRfYtSWsinw0+Ocsxrx2T
        658iAbACdpEgpeoJ/+Sve9nq2/WpYMhuoAvSFbcX2NkYfzVYEHaxSAonk0bSmKIWw2bfrG
        lQppL9DWZ6fxND3eLCh0ZWxfZyAB1qI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-HhMlN1h7MDCuOk4nH7Eh8w-1; Thu, 09 Apr 2020 07:14:17 -0400
X-MC-Unique: HhMlN1h7MDCuOk4nH7Eh8w-1
Received: by mail-wr1-f72.google.com with SMTP id n7so6191981wru.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 04:14:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=eVe7IfDc6Eg1zSotYzISNC1XY4K3ye5o8p4mKeTvCRU=;
        b=XgMOmumTc0qinsnym1/lVqQ1OS8FkMPQhUKGPctUVmSSABgYVqUOflv1FeMybJVMYn
         DTtnnbGQ2GYdpdQOOOKttgodnzDdtybdcoA+172TnRJ9z3BHpIOcDwmiRkVbSMgdUjlx
         BhgcLbcS/Y41hvdi7xRxT1AcRGEEMkUd+3ai5a7us6HlTHEa8SMfS5ocY0PayxqjX3vg
         jTyU4mSHcvRDDzVEVR7GiUMU+XxN5qQ+hcjYIFij8d27Hb3zEZCDAdq4uRhb0yHlIeqI
         wvTaiYAmefCaOvQOMYLouqeGSk1lcBbi2xu/An+0ILMAW2LmCW4oD3T06KOvWWZBwEim
         ZefA==
X-Gm-Message-State: AGi0PuYFZn2CKVws57okPrEVCjJ1MgZ2CCh6AYdTKcRKsEu3ApZRKy88
        c6L5LFnCm+uk895RqIyHilZzRFQa0m9a22Mbdz4sDUAbGxFPk5kAS6vCQyAfzQk0Tz14/6G3lPG
        waB/es785HDeS/j3goTfPltKh
X-Received: by 2002:adf:aad7:: with SMTP id i23mr13446974wrc.184.1586430856639;
        Thu, 09 Apr 2020 04:14:16 -0700 (PDT)
X-Google-Smtp-Source: APiQypJrJJvOfBtCg0nF+bFCAwjKhMQCswXXApj7bVfJMGmrNUaRyCwySn1n7/vsqTWSUHcBZMCe9Q==
X-Received: by 2002:adf:aad7:: with SMTP id i23mr13446952wrc.184.1586430856377;
        Thu, 09 Apr 2020 04:14:16 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id c20sm3387575wmd.36.2020.04.09.04.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 04:14:15 -0700 (PDT)
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
In-Reply-To: <20200409012002.GT2402@MiWiFi-R3L-srv>
References: <20200321193751.24985-1-sean.j.christopherson@intel.com> <20200407110115.GA14381@MiWiFi-R3L-srv> <87r1wzlcwn.fsf@vitty.brq.redhat.com> <20200408151808.GS2402@MiWiFi-R3L-srv> <87mu7l2256.fsf@vitty.brq.redhat.com> <20200409012002.GT2402@MiWiFi-R3L-srv>
Date:   Thu, 09 Apr 2020 13:14:14 +0200
Message-ID: <87imi829o9.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baoquan He <bhe@redhat.com> writes:

>
> While I would suggest adding kexec@lists.infradead.org when code changes
> are related to kexec/kdump since we usually watch this mailing list.
> LKML contains too many mails, we may miss this kind of change, have to
> debug and test again.
>

Definitely makes sense and I'll try my best to remember doing this
myself next time but the problem is that scripts/checkpatch.pl is not
smart enough, kexec related bits are scattered all over kernel and
drivers so I'm afraid you're missing a lot in kexec@ :-(

-- 
Vitaly

