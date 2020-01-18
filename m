Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D344C32771
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 21:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21BD246A8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 21:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPPJiP5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgARVmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 16:42:37 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25561 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726910AbgARVmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 16:42:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579383754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xHxqhDP0TufZsymD5aBLz6SOYSXcOXPtS6AtVTuad0M=;
        b=QPPJiP5yW8Hf6chLG+PMeq7Gvdy6x7hAjJrxAFhoed629sXgQmYr+hZ+OamuUCmQ/r+Z5u
        D2M9Eu5GGU0bZRxS17h9jZ/bmoJpE+eWSocdScrk04GzPPjwk46ojHmG6AfrJ/6/DBns/h
        GyMu1h3JWi49EO4nIEZAxXY7aGSrXJE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-frikLQyJP-ygvyt8nfmGag-1; Sat, 18 Jan 2020 16:42:33 -0500
X-MC-Unique: frikLQyJP-ygvyt8nfmGag-1
Received: by mail-wr1-f72.google.com with SMTP id v17so12079428wrm.17
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 13:42:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xHxqhDP0TufZsymD5aBLz6SOYSXcOXPtS6AtVTuad0M=;
        b=lMam4dLGTooFIdf6U9FvfNVcznjualKBIHm9anI2vmrx4kTz7Vpp9ShWE216PMfv3/
         FRcdGHNJXnAIxJUeZzuvqf6j8u7guHrFviS0FypPO58tLPUXfuL9s82NMm7RAHVnj4ty
         fdeMMQyB2ofCV6T2ykAjIg2CSED4mqYjIOlgccgZfJEthIv5izrHi86BPyuZSMglzfxm
         kPaTQvBr394RmMQIiqq7Ztg3ClcM3qsydVqaY2UXsdRPtJeJVrlj4Vz1wEGpTEk6XS6e
         6qa415qHdsCmXynPKjV+WxwqRhUPLau2+J+W3fEozYKrtdpkTri3AxV5ZWjvdpefQ8YV
         Hejg==
X-Gm-Message-State: APjAAAXoJQCk3kSoTUOIHp7Wc7GgIQGBWTaU9w5DZNZ3CIMgw63ym6cR
        0zMXKXPsvzzoRPWnP8Taed/0zi4VME3lLWHrIptCXufIEzJXLVr/7/xxCjmCzaw1/TWoLcBFGXD
        5bZmYfO2xHcK0QP4hrDiAKmnA
X-Received: by 2002:adf:ff8a:: with SMTP id j10mr10039955wrr.312.1579383752263;
        Sat, 18 Jan 2020 13:42:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqyGeL3j5AKbJYgQGL57uc9lh0LouWQB0ofIhLiYd3qtAYLWTK27fNDU66fBia4y4941qRHntg==
X-Received: by 2002:adf:ff8a:: with SMTP id j10mr10039941wrr.312.1579383752058;
        Sat, 18 Jan 2020 13:42:32 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e0d6:d2cd:810b:30a9? ([2001:b07:6468:f312:e0d6:d2cd:810b:30a9])
        by smtp.gmail.com with ESMTPSA id u84sm5122120wmg.10.2020.01.18.13.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2020 13:42:31 -0800 (PST)
Subject: Re: [PATCH RFC 2/3] x86/kvm/hyper-v: move VMX controls sanitization
 out of nested_enable_evmcs()
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Liran Alon <liran.alon@oracle.com>, kvm@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Roman Kagan <rkagan@virtuozzo.com>
References: <20200115171014.56405-1-vkuznets@redhat.com>
 <20200115171014.56405-3-vkuznets@redhat.com>
 <20200115232738.GB18268@linux.intel.com>
 <C6C4003E-0ADD-42A5-A580-09E06806E160@oracle.com>
 <877e1riy1o.fsf@vitty.brq.redhat.com>
 <20200116161928.GC20561@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0c3d32c1-7544-2370-f645-030bed55db83@redhat.com>
Date:   Sat, 18 Jan 2020 22:42:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200116161928.GC20561@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/20 17:19, Sean Christopherson wrote:
> Why not just do this in Qemu?  IMO that's not a major ask, e.g. Qemu is
> doing a decent amount of manual adjustment anyways.  And Qemu isn't even
> using the result of KVM_GET_MSRS so I don't think it's fair to say this is
> solely KVM's fault.

IMHO the features should stay available in case the guest chooses not to
use eVMCS.  A guest that uses eVMCS should know which features it cannot
use and not enable them.

Paolo

