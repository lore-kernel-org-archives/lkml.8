Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DC7C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24012070A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OKLqpWJf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgCXLdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 07:33:24 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:39485 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727194AbgCXLdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 07:33:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585049603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OmEKUVPUUIW58t8wUbOpcRcdCmPdmzEFAmhnF2iSsrM=;
        b=OKLqpWJfbCz2ThRq0G4O1Hfzwk2gspTohadxyylSjmXUvgbYBo066qGewryp+VGHyBZZG8
        Q6VKPB4unXhjE3hcptcN2CDkUvUjdktfFf35a/bANNjFzhix3YHQKbYYviB7chcpTB/nl3
        hf+feCpF8YDumaozGGPRNEwleNiTXcU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-g2swAAa3PViCr1eb6LVjnw-1; Tue, 24 Mar 2020 07:33:20 -0400
X-MC-Unique: g2swAAa3PViCr1eb6LVjnw-1
Received: by mail-wr1-f72.google.com with SMTP id j12so5226107wrr.18
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 04:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OmEKUVPUUIW58t8wUbOpcRcdCmPdmzEFAmhnF2iSsrM=;
        b=DXSkmGlRUKeDD36XWJvHGsxbcpGPxvqdbZ+A9lsNjFf+4HsdRooaarmczIYheGxKIX
         J5d8Nt0Dq/JBdlRp4bPbQLFvUzSJAER4BQJp+ViZyJUVJJWJeZtbnrt6kw/7VhOLnQ1R
         hyyw1jT2LJF20YamfieyoXLfnvtd4vmJluRUMuWLyyh3pzmtQFAOY9oCjLstANrJAVDw
         Wmc5ji6Jn+OESsV6n23RPEdzuzxlSZJ5/DOY9Ttxa6SP66BuxsWMF/PsxvQXu2h+H37e
         dcmMY+QXn9h62OzfG1sewsH10gEYPu48XUJVaO8NmKpkNUhDE1tqdh6uqU8NPFG01z12
         O7PA==
X-Gm-Message-State: ANhLgQ2RTrvKnZzjUPgvwhz5IuY5dWVHON4XUyE0nVRfOmdHa4mvSRv/
        xJPUMnSaXXUv0oSbxedAcape4srmIyHI0G+RX4R+PhPudMd/byq7sfic7g3SDrJMBuapSYWMam6
        AJb/3ASz2tYwqmaTaUFmXoE8U
X-Received: by 2002:adf:a3db:: with SMTP id m27mr37127626wrb.350.1585049599166;
        Tue, 24 Mar 2020 04:33:19 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvgZHkdhEh+B+n9ipNvW4FVlwMdOadw+K1ajul8byxpJD6tN65QChX591BtD1p6mNq2BLWstQ==
X-Received: by 2002:adf:a3db:: with SMTP id m27mr37127590wrb.350.1585049598914;
        Tue, 24 Mar 2020 04:33:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7848:99b4:482a:e888? ([2001:b07:6468:f312:7848:99b4:482a:e888])
        by smtp.gmail.com with ESMTPSA id s22sm3727898wmc.16.2020.03.24.04.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 04:33:18 -0700 (PDT)
Subject: Re: [PATCH 0/4] KVM: SVM: Move and split up svm.c
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ashish Kalra <Ashish.Kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200324094154.32352-1-joro@8bytes.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <33af4430-e19d-c414-3e78-bcbc69d5bfb7@redhat.com>
Date:   Tue, 24 Mar 2020 12:33:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200324094154.32352-1-joro@8bytes.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/20 10:41, Joerg Roedel wrote:
> Hi,
> 
> here is a patch-set agains kvm/queue which moves svm.c into its own
> subdirectory arch/x86/kvm/svm/ and splits moves parts of it into
> separate source files:
> 
> 	- The parts related to nested SVM to nested.c
> 
> 	- AVIC implementation to avic.c
> 
> 	- The SEV parts to sev.c
> 
> I have tested the changes in a guest with and without SEV.
> 
> Please review.
> 
> Thanks,
> 
> 	Joerg
> 
> Joerg Roedel (4):
>   kVM SVM: Move SVM related files to own sub-directory
>   KVM: SVM: Move Nested SVM Implementation to nested.c
>   KVM: SVM: Move AVIC code to separate file
>   KVM: SVM: Move SEV code to separate file
> 
>  arch/x86/kvm/Makefile                 |    2 +-
>  arch/x86/kvm/svm/avic.c               | 1025 ++++
>  arch/x86/kvm/svm/nested.c             |  823 ++++
>  arch/x86/kvm/{pmu_amd.c => svm/pmu.c} |    0
>  arch/x86/kvm/svm/sev.c                | 1178 +++++
>  arch/x86/kvm/{ => svm}/svm.c          | 6546 ++++++-------------------
>  arch/x86/kvm/svm/svm.h                |  491 ++
>  7 files changed, 5106 insertions(+), 4959 deletions(-)
>  create mode 100644 arch/x86/kvm/svm/avic.c
>  create mode 100644 arch/x86/kvm/svm/nested.c
>  rename arch/x86/kvm/{pmu_amd.c => svm/pmu.c} (100%)
>  create mode 100644 arch/x86/kvm/svm/sev.c
>  rename arch/x86/kvm/{ => svm}/svm.c (56%)
>  create mode 100644 arch/x86/kvm/svm/svm.h
> 

Queued, thanks (only cursorily reviewed for now).

Paolo

