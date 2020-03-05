Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41488C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1875820637
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jq2QSF9W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgCEQnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 11:43:53 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30271 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726142AbgCEQnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 11:43:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583426631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BhhISddobKRvxCyVQfFxQKYUaxrCs/nqVOLHMdfl6w4=;
        b=Jq2QSF9WA2AIGKCtnSVdplpqmydjUI0+o+1Xs45mcQLj/lNA0GvWf9Ny8h5pza5JqG6BUc
        cuq6Yd7gTmLojVgwJtyRr15dQQ803QIjOIvYQ2jNXjPZDw+uZA1ZeHm/sx03Zo2Mjusv2+
        IC2fImhDGdbn/NYLHgU+yi84Je4Fl6M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-Mj5oMJtgMd-toYPLNCkdnA-1; Thu, 05 Mar 2020 11:43:48 -0500
X-MC-Unique: Mj5oMJtgMd-toYPLNCkdnA-1
Received: by mail-wr1-f72.google.com with SMTP id q18so2526406wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 08:43:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BhhISddobKRvxCyVQfFxQKYUaxrCs/nqVOLHMdfl6w4=;
        b=c0K7mOBTY48pz/jdvh2JYhkYUzbFP9RpW+412Wvo3igRuv/0uUiTp2vPiPRgAVvS2l
         PTF0FewaP7FbX23WVCsE32Z5I+YkMgypusNXJu48PwVDu8N8cMASwBryUrh8IUCRzjCy
         tWDuD0Q+yE8uo7tcbebod3vI8Cn+w4vCzSJ0UnUwcN8aroLeB3HVVshiiodkBr3ZRbxD
         pRlSVzvFoEjXrZXJRBcTIkNWLuyKQ5bSnN9k6F69VeFK+4ZUN1KKCM79MD3YdF0/X6K1
         UiRbHQpVbWspgn/n4hsZjUxiIDcZa6aJIAddWzfIfJp5X1KLSpCkQhC1lsg5dUTpW5QB
         OlUg==
X-Gm-Message-State: ANhLgQ025wBrl8YAqym+DCDb+7qR5or1h0zZftNEHi+KCTDRWjFJkklL
        VdgHiYgQ0q8lO6rK5Ik9YxlYeli1oU66m+RMNyJ9nvHfShDfYvhLj2JHPoD80SAL4UFag+mTvqI
        Xa+i2rrh4oSIgjo+sZFkxy/Kl
X-Received: by 2002:adf:d4c7:: with SMTP id w7mr1907320wrk.20.1583426627093;
        Thu, 05 Mar 2020 08:43:47 -0800 (PST)
X-Google-Smtp-Source: ADFU+vudytWymUEkci84I/WZSseDXaNi0Bm39I2yP2Zha9wZsreA/1rCNGnBV4PyCOqqQHgKHjKo+Q==
X-Received: by 2002:adf:d4c7:: with SMTP id w7mr1907297wrk.20.1583426626866;
        Thu, 05 Mar 2020 08:43:46 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993? ([2001:b07:6468:f312:9def:34a0:b68d:9993])
        by smtp.gmail.com with ESMTPSA id g129sm11491735wmg.12.2020.03.05.08.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 08:43:46 -0800 (PST)
Subject: Re: [PATCH 2/2] KVM: x86: VMX: untangle VMXON revision_id setting
 when using eVMCS
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200305100123.1013667-1-vkuznets@redhat.com>
 <20200305100123.1013667-3-vkuznets@redhat.com>
 <20200305154130.GB11500@linux.intel.com>
 <8736amg3q5.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4e4218fe-2409-558f-8d0f-aae18e8d4651@redhat.com>
Date:   Thu, 5 Mar 2020 17:43:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <8736amg3q5.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/20 17:34, Vitaly Kuznetsov wrote:
>> I'd strongly prefer to keep the alloc_vmcs_cpu() name and call the new enum
>> "vmcs_type".  The discrepancy could be resolved by a comment above the
>> VMXON_REGION usage, e.g.
>>
>> 		/* The VMXON region is really just a special type of VMCS. */
>> 		vmcs = alloc_vmcs_cpu(VMXON_REGION, cpu, GFP_KERNEL);
> I have no strong opinion (but honestly I don't really know what VMXON
> region is being used for), Paolo already said 'queued' but I think I'll
> send v2 with the suggested changes (including patch prefixes :-)

Yes, please do.

Paolo

