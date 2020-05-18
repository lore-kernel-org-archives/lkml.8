Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BCBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C464920787
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hoyvxbOl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgERMcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 08:32:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26688 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726709AbgERMcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 08:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589805118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JSwYOVViRmho7SQfsfACP8dXKwqAgv5XuIjfF821PSU=;
        b=hoyvxbOlXky1wnDbrX6jMt2qm58vX5BLcULP2RfWStKOeG0/dfL7qENbYU8mo4hz1dVbk/
        LC/Ki9w2zmitNlD9CfevHCXMxuzB7h6qbxDCmRMfJvReVZUkz7n1FmTQ0wjbo0IuFI51se
        lK+5Ncs17vcJPS96t5RCTLin2q432jI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-ka7Mp5RJMsappvmJuyJKPw-1; Mon, 18 May 2020 08:31:57 -0400
X-MC-Unique: ka7Mp5RJMsappvmJuyJKPw-1
Received: by mail-wr1-f69.google.com with SMTP id z10so5623606wrs.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 05:31:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JSwYOVViRmho7SQfsfACP8dXKwqAgv5XuIjfF821PSU=;
        b=SGwu+x4qq0CRKV4r/ZOxbPWj47IR0zXtWOIw8DX9zCy7yy87rckSGSWvgqSMj17nl9
         CqJFIuN/IrTlHx9oypVvRhzoGCbiI9bgvUm9IWzOpRjQPW3Qpt0zvfBBA/b5X9TdfFVD
         ZSAAj4wfxIUaXXsIO8ynyOKyyty1WOSBuBHXfQPdEgn7xbp00nqz7IgW2qQiQaMALRlR
         BzpwrHj1ngt5nZqOW8DQcX5ztGBMZy1lDbHrEw1eaGY4YHzxsTpoSL5m/jClBDPoRZSf
         +0e4/EYvtoScyBuvW8lnGDEn0l/xh/f3hreR02J8cyL84rDP280USoTOpS28cUn+8Urg
         PvgQ==
X-Gm-Message-State: AOAM533Ch+Y85G3GZ+E60bTMgV9jByC+FqdK8Rk4lyHYORubWvCjZaGd
        MoGQh2Q7v4KCkAiyaZ5+0p3Uj2CAh55WxdHdQNeb1EfTfKJVwZN2+hLvNFeNZGiyBbURg2tYWOS
        GKdBdrHqcYmYVTbrFdSGpIQtK
X-Received: by 2002:a1c:c2c6:: with SMTP id s189mr20300113wmf.25.1589805115985;
        Mon, 18 May 2020 05:31:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeeGxVDfzc+aC9AYtRchJxAqaRHN553hwC8AKlTRhhdZrmctqO5FrFE9595gxCNWK9MUNt4w==
X-Received: by 2002:a1c:c2c6:: with SMTP id s189mr20300085wmf.25.1589805115732;
        Mon, 18 May 2020 05:31:55 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.90.67])
        by smtp.gmail.com with ESMTPSA id b12sm16992464wmj.0.2020.05.18.05.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 05:31:55 -0700 (PDT)
Subject: Re: [PATCH] kvm: x86: Use KVM CPU capabilities to determine CR4
 reserved bits
To:     Xiaoyao Li <xiaoyao.li@intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     jmattson@google.com,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20200506094436.3202-1-pbonzini@redhat.com>
 <6a4daca4-6034-901a-261f-215df7d606a6@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <09cb27f8-fa02-4b37-94de-1a4d86b9bdbd@redhat.com>
Date:   Mon, 18 May 2020 14:31:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <6a4daca4-6034-901a-261f-215df7d606a6@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/20 06:52, Xiaoyao Li wrote:
> On 5/6/2020 5:44 PM, Paolo Bonzini wrote:
>> Using CPUID data can be useful for the processor compatibility
>> check, but that's it.  Using it to compute guest-reserved bits
>> can have both false positives (such as LA57 and UMIP which we
>> are already handling) and false negatives: 
> 
>> in particular, with
>> this patch we don't allow anymore a KVM guest to set CR4.PKE
>> when CR4.PKE is clear on the host.
> 
> A common question about whether a feature can be exposed to guest:
> 
> Given a feature, there is a CPUID bit to enumerate it, and a CR4 bit to
> turn it on/off. Whether the feature can be exposed to guest only depends
> on host CR4 setting? I.e., if CPUID bit is not cleared in cpu_data in
> host but host kernel doesn't set the corresponding CR4 bit to turn it
> on, we cannot expose the feature to guest. right?

It depends.  The most obvious case is that the host kernel doesn't use
CR4.PSE but we even use 4MB pages to emulate paging disabled mode when
the processor doesn't support unrestricted guests.

Basically, the question is whether we are able to save/restore any
processor state attached to the CR4 bit on vmexit/vmentry.  In this case
there is no PKRU field in the VMCS and the RDPKRU/WRPKRU instructions
require CR4.PKE=1; therefore, we cannot let the guest enable CR4.PKE
unless it's also enabled on the host.

Paolo

