Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D10C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 05:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C5A82067C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 05:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6R00qTG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgA3FoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 00:44:15 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60238 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725865AbgA3FoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 00:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580363054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b8PEF8AVAWODPDupJea+4sWEJHHfwQkjaA/7qcZmag4=;
        b=Y6R00qTGMkNZUDTi9Bjzix9BllX0aNbcel38FTI/KrI0Gy8ohOqOO1Bo+f8ANxQ1udmsI+
        9gc93iPBE/sR02iBoU12Jc/3Qc6eX62uUl1dMn9j+vUyG+JNRIzIuJRkCkDUz+nQ7AQlt3
        2i8of8hMPtwPYKMTBmpP5X7h+dsdlcs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-MVr2CZvGNim4MDn3B-twLQ-1; Thu, 30 Jan 2020 00:44:12 -0500
X-MC-Unique: MVr2CZvGNim4MDn3B-twLQ-1
Received: by mail-wm1-f69.google.com with SMTP id b133so672539wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 21:44:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b8PEF8AVAWODPDupJea+4sWEJHHfwQkjaA/7qcZmag4=;
        b=RphK7ZNdT/3nSD2EONMtPhaOaWXk/3S0icWi4WAjVzRIv1sUMoUWs51JnxZkjfFItq
         8VStGrhC2joR+IT8hkIsvA2TYQBf1V4F2MrvkoU/Wv5A6ebMy7l8uWazcL31xmcYkiiu
         twZKJrQf5txYi89T8AJImmiH4ZVOlS0GM/4h/cMN9bkXX2S/uPLGumle/H1fAOLtcEqa
         nRqEPRrSGzKCeJoM+gc7GqThWVMaTzLUqICO07E1Gsu2cy09nqdiVsCk+vBXmvKsMSdj
         a6jbnVUDOLTBG9iL03mqlou92yriorzivRgTKOKChl6BOc87oFpn8AaAEohtZczXkOu5
         TsAw==
X-Gm-Message-State: APjAAAWtbtVVr+N8Qttzhl0jQGANBLbr+TgY9oCVG86VPkIRh1MBRuAE
        xv1AoV/b14PtNamfukBOsIVUcjWe7wtf/7K23RdOVGnOYurMB040c6dnnnNuAxJ/VZRiyaD4dsi
        Cr96mT21BAaV9txtnv4w7k8HN
X-Received: by 2002:a7b:cbcf:: with SMTP id n15mr3175386wmi.21.1580363051336;
        Wed, 29 Jan 2020 21:44:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqxvrtUyXEqgq8iYKVpAB/LAj4fC31bOc+VOTWRDvsFWxjJ6sWsl8qJGadVTcya+7iE6vbimVA==
X-Received: by 2002:a7b:cbcf:: with SMTP id n15mr3175335wmi.21.1580363050959;
        Wed, 29 Jan 2020 21:44:10 -0800 (PST)
Received: from [10.1.251.141] ([80.188.125.198])
        by smtp.gmail.com with ESMTPSA id 4sm4795049wmg.22.2020.01.29.21.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 21:44:10 -0800 (PST)
Subject: Re: [PATCH 5/5] KVM: x86: Set kvm_x86_ops only after
 ->hardware_setup() completes
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
References: <20200130001023.24339-1-sean.j.christopherson@intel.com>
 <20200130001023.24339-6-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <44e0c550-7dcc-bfed-07c4-907e61d476a1@redhat.com>
Date:   Thu, 30 Jan 2020 06:44:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200130001023.24339-6-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/20 01:10, Sean Christopherson wrote:
> Set kvm_x86_ops with the vendor's ops only after ->hardware_setup()
> completes to "prevent" using kvm_x86_ops before they are ready, i.e. to
> generate a null pointer fault instead of silently consuming unconfigured
> state.

What about even copying kvm_x86_ops by value, so that they can be
accessed with "kvm_x86_ops.callback()" and save one memory access?

Paolo

