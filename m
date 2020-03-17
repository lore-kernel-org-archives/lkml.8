Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E07C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0C220724
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ia2aMF4T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgCQRi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:38:29 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:43771 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726189AbgCQRi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584466707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KqXznweBlwjgjbqOmCj0t1wRnXCMMt9Q5oGndDgHqKw=;
        b=Ia2aMF4Tm8eocrFe4OQXmSbA9FRlHffG1AnEBAP0WMtAVZv0ip7fsTiYGJBwKQIXK+PKO+
        XhPGSnuwR5XdYrxW52X5aHtGO6PbVABM5ZnI+cjCgjQj9suquxKwB8v1FPerrjfmawJGT1
        17zTro9Vem3GSE+zb7Fwbq05KQVDAy0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-YRTtiqN_MXOTgvLOissZSQ-1; Tue, 17 Mar 2020 13:38:23 -0400
X-MC-Unique: YRTtiqN_MXOTgvLOissZSQ-1
Received: by mail-wm1-f70.google.com with SMTP id z16so59476wmi.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 10:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KqXznweBlwjgjbqOmCj0t1wRnXCMMt9Q5oGndDgHqKw=;
        b=bc6MKOTFFsfZHY8J0WaJOH3SqyWaT7gAuD6zRdDJ8dkjfYOXdJqR5pC2O6yXwDgrii
         xJ8AzCSb8VB8b5Fw2KTsuw5NLnvzotBdDLrnCEbfhGgCZwy0j39HYGWqi++8a1b63K0g
         bI0xOxhL/Ou+kqKJ2u+7rp1Tu5We1lr2+DSQJ06UYtvaLOmcyz5DjJHIHgmsibrNPDrA
         GFndWB9rxTkNokb0LHY8+TQ/6yxMB2ghwTJd69Jbtx/j/UmHyhOWIacmWtWEvhX5BF+i
         poO3/bCFiOjAghsVRC01b6jJmF2f2LashFqjLsyp/+TwrqKefXh2Wrr6SsuEeypnqHR6
         oLFg==
X-Gm-Message-State: ANhLgQ1tWMa2RKMmWIY0zyNrM0TeovHrDbVNGw/bEu1uEsAgpr7OEGOg
        cVF1hSOo2XWexuj/hRyOoGhN1gC1JTQDEemSo2/z/Kq69XrXDMjB5U5kA+7RM1jWNnb8iOCr/IW
        k0kPkBXDfoY/t4pe5kgf2MS8e
X-Received: by 2002:a5d:698c:: with SMTP id g12mr109548wru.382.1584466702583;
        Tue, 17 Mar 2020 10:38:22 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv2+A6tWc5nG/r5JkQ3oWBizSODgSFk5DmsHpehp4pOI8egGtrWh/hnLDHQmJahsWLHxSYI6A==
X-Received: by 2002:a5d:698c:: with SMTP id g12mr109524wru.382.1584466702334;
        Tue, 17 Mar 2020 10:38:22 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.227])
        by smtp.gmail.com with ESMTPSA id k9sm5609036wrd.74.2020.03.17.10.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 10:38:21 -0700 (PDT)
Subject: Re: [PATCH 01/10] KVM: nVMX: Move reflection check into
 nested_vmx_reflect_vmexit()
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
References: <20200312184521.24579-1-sean.j.christopherson@intel.com>
 <20200312184521.24579-2-sean.j.christopherson@intel.com>
 <87k13opi6m.fsf@vitty.brq.redhat.com>
 <20200317053327.GR24267@linux.intel.com>
 <20200317161631.GD12526@linux.intel.com>
 <874kum533c.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bd3fec03-c7c3-6c80-2dce-688340a1ae72@redhat.com>
Date:   Tue, 17 Mar 2020 18:38:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <874kum533c.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/20 18:00, Vitaly Kuznetsov wrote:
> 
> On the other hand, I'm a great fan of splitting checkers ('pure'
> functions) from actors (functions with 'side-effects') and
> nested_vmx_exit_reflected() while looking like a checker does a lot of
> 'acting': nested_mark_vmcs12_pages_dirty(), trace printk.

Good idea (trace_printk is not a big deal, but
nested_mark_vmcs12_pages_dirty should be done outside).  I'll send a
patch, just to show that I can still write KVM code. :)

Paolo

