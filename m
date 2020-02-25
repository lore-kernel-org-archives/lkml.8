Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886C6C35DE1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 13:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD6B21744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 13:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PPLqaze3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbgBYNxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 08:53:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52899 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726019AbgBYNxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 08:53:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582638819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g+dtmvyyQhltLoB4R7/151zB27mnUy9MkrZ7W6Tc+tY=;
        b=PPLqaze35ntMXpJ6OI3NY/pixpI6uIYvei07POkvhEn+5krlT70AUuoPa+XRrOsVEYnhXv
        8yRqgX9NPGy6CRyeKqbitEIsL9XkF3TbD81xawy3Xbf0uYHNC6uHn3KhxqyZpgV8fKAeR9
        F6R7qRfI2oILgLEFR+yoY5k28Eozwxc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-OKd0OCVLOCCvX3Pap8TLzw-1; Tue, 25 Feb 2020 08:53:37 -0500
X-MC-Unique: OKd0OCVLOCCvX3Pap8TLzw-1
Received: by mail-wr1-f70.google.com with SMTP id o6so7315664wrp.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 05:53:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=g+dtmvyyQhltLoB4R7/151zB27mnUy9MkrZ7W6Tc+tY=;
        b=GaGZw7lYeLKc1FWRu0apoD3rMtkaMrJr6VOadHR1iJ3ACFIw+TOErvTb3u1qI2Gg6b
         Lq1NTTkd51CXberUJThOAUzumpEakqPv+7bPwO0i5gtoTea9PMjK5iihW0hqP44WzBL1
         9VpVA7CgpleFHVtmtylKrgxiFLvy1M8EYBXVXCTTFBUt2pTrM821jgORvMiF60MwZUDG
         9q5KHAoL/5LW61Nncg5KdDD3GHlgfMZHLXnccm9k4jXOrvozor3BhSIvReBFsQ8psXkM
         hyKPr6Nz+90atgAGv0lbllnjopkUmWas/t5e16J6QOl0F8usJ/OsJ+dKsBOq9v/K1fRW
         7eEQ==
X-Gm-Message-State: APjAAAVGsq0oW2TALjVPIyKOzseuv/NHaBi5U0yigxJ8dxyTTtEinVze
        nAc+6GHcX8ModRtAfUprgdmt8aKGAcsNZnUxUmRYYAp82N94TwomkCsx0rHvKPk09k5wlsLjrR4
        /B436Wdku/dbn4XhsqLSQlyOd
X-Received: by 2002:a1c:238e:: with SMTP id j136mr5509867wmj.33.1582638816067;
        Tue, 25 Feb 2020 05:53:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqzRNrbfqdLfP2T/8HWo4yZpAbcqoVoybvQCuR0Yz6CzqeiveSd65IOm+ITqUFo0QoJK9tyE0w==
X-Received: by 2002:a1c:238e:: with SMTP id j136mr5509791wmj.33.1582638814949;
        Tue, 25 Feb 2020 05:53:34 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o2sm4218045wmh.46.2020.02.25.05.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 05:53:34 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 48/61] KVM: x86: Do host CPUID at load time to mask KVM cpu caps
In-Reply-To: <20200224233119.GS29865@linux.intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-49-sean.j.christopherson@intel.com> <87o8tnmwni.fsf@vitty.brq.redhat.com> <20200224233119.GS29865@linux.intel.com>
Date:   Tue, 25 Feb 2020 14:53:33 +0100
Message-ID: <871rqin57m.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Mon, Feb 24, 2020 at 11:46:09PM +0100, Vitaly Kuznetsov wrote:
>> 
>> If we don't really believe that masking will actually mask anything,
>> maybe we should move it under '#ifdef CONFIG_KVM_CPUID_AUDIT'? And/or 
>> add a WARN_ON()?
>
> I'm not opposed to trying that, but I'd definitely want to do it as a
> separate patch, or maybe even let it stew separately in kvm/queue for a
> few cycles.
>

Sounds like a good idea)

-- 
Vitaly

