Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28330C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 16:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE0920714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 16:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGdrdDKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgBLQms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 11:42:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60174 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728673AbgBLQmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 11:42:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581525766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1adZyTOfR/v6s80ffHMqqXSo2pdemYsunr3oiNOk5/8=;
        b=MGdrdDKTh7HkDluVDpa/DI2fmmOV3Ub0U4tkw96Fv1vGT+2dYYcVhh2Wz/lyLOAH3bw2om
        QKo7+N2WVnvvKwy8u5IxNJkvlu7z5wwZL/rCfzoqRzRqTr5bh0WX1FXokhI8L3UoPziCiP
        0MbpGKtP2Nsuw4zsV+k8v/lsWVwe6ec=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-QUpHotblOvCV6CrWzx77ig-1; Wed, 12 Feb 2020 11:42:44 -0500
X-MC-Unique: QUpHotblOvCV6CrWzx77ig-1
Received: by mail-wr1-f70.google.com with SMTP id w6so1034400wrm.16
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 08:42:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1adZyTOfR/v6s80ffHMqqXSo2pdemYsunr3oiNOk5/8=;
        b=ftnUB65apN492LOxck1kkIY39+GWQ8VUMCgXoaFd6BbrtiN3YbXU8ZiQFHhqSlNh6P
         Oy22Foai+d2UB2HtJoFjVKiR8EBIObdgWzYjVlI79aLn73eVIryUrb5mw/5J9Zvr7RSk
         QXQ4CyShIZ2K5JoNe3ReqlDYxZqTm6ops1tSU4y3JnKT28w6uVXv+bcMOpmca4+UgZUK
         zaaQTFDDztRU2itw/7DiO5s0JQLE2hQqiQ8MU8GV/TFVInsmLfO5GbA4VPK5epeHY0ES
         3/Cl9YwnVV5kp31MG2I2TCQpEif+kEpuvqU8AX9+710iZ5YU4qcZxMLwf3LwDRQCJrZp
         gDhQ==
X-Gm-Message-State: APjAAAVCSGo0A+bnCR1fREuAfce7QgNxpPRsab6ZEnBeerCMdNixf2oe
        O0K+W4mgMP2L8M6GfYN36/JjoviCBQSf5gVTePwNHPxS7gBBUAlK7T5AA4EjqDjG4PzPhdIy4kK
        84dZtFwk4UePyhp8awpIkFPI2
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr15775962wrp.167.1581525755303;
        Wed, 12 Feb 2020 08:42:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqxB0bsei9MGFy/+qFOztBrTBKZisUs5CRha1tPks1V/Cpgkk6GhQwqh67eqtc4RvdpsN+FipA==
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr15775940wrp.167.1581525755032;
        Wed, 12 Feb 2020 08:42:35 -0800 (PST)
Received: from [192.168.178.40] ([151.30.86.140])
        by smtp.gmail.com with ESMTPSA id w11sm867177wrt.35.2020.02.12.08.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 08:42:34 -0800 (PST)
Subject: Re: [PATCH v2 6/7] KVM: x86/mmu: Rename kvm_mmu->get_cr3() to
 ->get_guest_cr3_or_eptp()
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200207173747.6243-1-sean.j.christopherson@intel.com>
 <20200207173747.6243-7-sean.j.christopherson@intel.com>
 <1424348b-7f09-513a-960b-6d15ac3a9ae4@redhat.com>
 <20200212162816.GB15617@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <de17199e-aff3-b664-73f5-9c88727d064e@redhat.com>
Date:   Wed, 12 Feb 2020 17:42:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200212162816.GB15617@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/20 17:28, Sean Christopherson wrote:
> On Wed, Feb 12, 2020 at 01:00:59PM +0100, Paolo Bonzini wrote:
>> On 07/02/20 18:37, Sean Christopherson wrote:
>>> Rename kvm_mmu->get_cr3() to call out that it is retrieving a guest
>>> value, as opposed to kvm_mmu->set_cr3(), which sets a host value, and to
>>> note that it will return L1's EPTP when nested EPT is in use.  Hopefully
>>> the new name will also make it more obvious that L1's nested_cr3 is
>>> returned in SVM's nested NPT case.
>>>
>>> No functional change intended.
>>
>> Should we call it "get_pgd", since that is how Linux calls the top-level
>> directory?  I always get confused by PUD/PMD, but as long as we only
>> keep one /p.d/ moniker it should be fine.
> 
> Heh, I have the exact same sentiment.  get_pgd() works for me.

Ok, I'll post a patch that uses get_guest_pgd() as soon as I open
kvm/next for 5.7 material.

Paolo

