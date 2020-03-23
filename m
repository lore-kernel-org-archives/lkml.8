Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7028DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 23:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1D720409
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 23:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cRgIL2qP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbgCWXvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 19:51:03 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:48065 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727054AbgCWXvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 19:51:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585007461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fkoyXc5mPqBCz/R4buWFD5GyDb56hM12lE3DoIwJ1ag=;
        b=cRgIL2qPRmX9pJkmiumA6DNiKycUTtChW56nN2z7PbkZdNtQas80NpmuprV8Ol6lf+0oWU
        vlUUl/oGDyPo+2vOP2ikDnIewIpV1qDP/KBA1UhhqV4U7gItWBDXKlwneuNneu8dMrMlQM
        UYvzzYg5oVWoBaXEkNoPDPlHPnlAlmw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-6c3N03jpN4mQ4FKuda-xHQ-1; Mon, 23 Mar 2020 19:51:00 -0400
X-MC-Unique: 6c3N03jpN4mQ4FKuda-xHQ-1
Received: by mail-wr1-f72.google.com with SMTP id u18so8242799wrn.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 16:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fkoyXc5mPqBCz/R4buWFD5GyDb56hM12lE3DoIwJ1ag=;
        b=eyw5ppWOFg752VDgH/ddngzQ3VhnZoipP2ITsx+rG4Kg19gGyHwARWs+cU0OcGj13Y
         7AcgPgMfUzwDVn//t3cR0faCEYn1wCeaats/QfLS8JlyXAN7oAA028PN7gl/vEIWfBJM
         7P5hw7Mw2Pg2kt1EDDGyPodS7SaLLKdUxWLSAotM4YVRNl0aqIqemmDhTB6JvOzF5xQN
         URR3CBX4NfILpRRj0dUAT3Q/v41qSf9zMyvmeeG1pFW0l+cpJ2k1xk10MXucBckYKFRA
         uOtWCHchlFFD5fCNH4gsYIxCNEULJWGkd8QdjcrwJPE1Bfr2CE2SDTOc6h9QAvkeMPdT
         Ryhw==
X-Gm-Message-State: ANhLgQ2j7nlHRj94pyo/IrPKOEIHquW1cefO7G9XtUQYKN7SFzM/LGSB
        W0wmf8qyZaYDVyydaqK67LdxcKjjuVTSryykDepzCRG4/n2rRfKPZjHNabaTtoB1uKwiXt733dH
        aWUG8Kbq7WHTriDGxizSEhoZW
X-Received: by 2002:a05:6000:1251:: with SMTP id j17mr16473487wrx.228.1585007457867;
        Mon, 23 Mar 2020 16:50:57 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsOy8DXJXcdx0vvDGI7IevKM2IukdVaVZbmxFnSFjwbFv1Wp5JWRKray+ne4w05EP+Db72IPA==
X-Received: by 2002:a05:6000:1251:: with SMTP id j17mr16473474wrx.228.1585007457630;
        Mon, 23 Mar 2020 16:50:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7848:99b4:482a:e888? ([2001:b07:6468:f312:7848:99b4:482a:e888])
        by smtp.gmail.com with ESMTPSA id o67sm1695824wmo.5.2020.03.23.16.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 16:50:57 -0700 (PDT)
Subject: Re: [PATCH v3 03/37] KVM: nVMX: Invalidate all EPTP contexts when
 emulating INVEPT for L1
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Gardon <bgardon@google.com>,
        Junaid Shahid <junaids@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        John Haxby <john.haxby@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20200320212833.3507-1-sean.j.christopherson@intel.com>
 <20200320212833.3507-4-sean.j.christopherson@intel.com>
 <CALMp9eR5Uu7nRDOS2nQHGzb+Gi6vjDEk1AmuiqkkGWFjKNG+sA@mail.gmail.com>
 <20200323162807.GN28711@linux.intel.com>
 <CALMp9eR42eM7g81EgHieyNky+kP2mycO7UyMN+y2ibLoqrD2Yg@mail.gmail.com>
 <20200323164447.GQ28711@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8d99cdf0-606a-f4df-35e7-3b856bb3ea0e@redhat.com>
Date:   Tue, 24 Mar 2020 00:50:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200323164447.GQ28711@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/20 17:44, Sean Christopherson wrote:
> So I think
> 
>   Fixes: 14c07ad89f4d ("x86/kvm/mmu: introduce guest_mmu")
> 
> would be appropriate?
> 

Yes.  I changed it and also added the comment

+		/*
+		 * Nested EPT roots are always held through guest_mmu,
+		 * not root_mmu.
+		 */

which isn't unlike what you suggested elsewhere in the thread.

Paolo

