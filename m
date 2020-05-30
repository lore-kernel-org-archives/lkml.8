Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C55C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 16:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28F63207BB
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 16:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dnPe36dK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgE3QUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 12:20:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46092 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729038AbgE3QUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 12:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590855610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Y07FflDlYJVMUyysoTwcpFsx8MSfGOT4BCyFdsShZo=;
        b=dnPe36dKTq6Is62q3s3jA57vZWNGY2whNJyoMC3vNyH+7TyUZLOr2hN2jbWiJmRZyapsbn
        PvArHB1Qb3Z6VKTeHxkS4+IVd16y777EGKgpizERLBsu60PxGs15IRuEoH1MbTJT8SAUML
        76fg9QQl/MRMt7Cd1to6tMDNGcakN8w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-v_lvovRZMKO2tSBEsNCXJQ-1; Sat, 30 May 2020 12:20:08 -0400
X-MC-Unique: v_lvovRZMKO2tSBEsNCXJQ-1
Received: by mail-wr1-f71.google.com with SMTP id n6so2379453wrv.6
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 09:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1Y07FflDlYJVMUyysoTwcpFsx8MSfGOT4BCyFdsShZo=;
        b=OpAz9q3YWJH4ed7nzE+j18wlkOBcPo+g9K04dTCEbzIz0c9xkOojgR6ap2avZTjM5h
         EMaM+aTNzDOkYNXbDSBC3xqksz1j1eNZZhfTZk/QLN9MyIduV2mvcAXJvSNI39y9BeKr
         3iHCzvBhCWpvE1sZarQeM+xFxQ08h4g0eo6PHO/MNGgLAS9jIAzFNFmO+V1G9lzns/4X
         tIimgcQPVzVA7HcVRvwUBpc74NMK3gPd+1yXXdAM7zMuKC6qrb8g8wSL9f3BT87pnjuK
         l7xel8g38jjLNR1L725emVAA9iPCc064o1AbrtHN2HtADur+r9q38EA94LVZc0Uyr5ym
         hHDg==
X-Gm-Message-State: AOAM530mhSQ9/ZRlJzcvtxGu9Vvyo2khMdGz+eD/nM2hpleIS8lI7t7n
        LfJ39dVGjI2ydAcs/hMy/n5GkMFZIB5fNnSzd7o5+qgDD1KkmBibiWXO+aNrsDIGbxrmpwDM+N+
        EN4eWIbpEnB9hiBR8lIV4RlaG
X-Received: by 2002:adf:e68a:: with SMTP id r10mr13854865wrm.384.1590855607371;
        Sat, 30 May 2020 09:20:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXlElKTzRL6bFu/3rQrgfAs1k3BodxDyJgVmRXgSjiwdnIdN6gv3xiEGh0NHUK0QqpPIYfTw==
X-Received: by 2002:adf:e68a:: with SMTP id r10mr13854851wrm.384.1590855607156;
        Sat, 30 May 2020 09:20:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8? ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
        by smtp.gmail.com with ESMTPSA id b8sm14890619wrs.36.2020.05.30.09.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2020 09:20:06 -0700 (PDT)
Subject: Re: [PATCH 8/9] x86: kvm_hv_set_msr(): use __put_user() instead of
 32bit __clear_user()
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
 <20200529232723.44942-1-viro@ZenIV.linux.org.uk>
 <20200529232723.44942-8-viro@ZenIV.linux.org.uk>
 <CAHk-=wgq2dzOdN4_=eY-XwxmcgyBM_esnPtXCvz1zStZKjiHKA@mail.gmail.com>
 <20200530143147.GN23230@ZenIV.linux.org.uk>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <81563af6-6ea2-3e21-fe53-9955910e303a@redhat.com>
Date:   Sat, 30 May 2020 18:20:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200530143147.GN23230@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, May 29, 2020 at 04:52:59PM -0700, Linus Torvalds wrote:
>> It looks like the argument for the address being validated is that it
>> comes from "gfn_to_hva()", which should only return
>> host-virtual-addresses. That may be true.

Yes, the access_ok is done in __kvm_set_memory_region and gfn_to_hva()
returns a page-aligned address so it's obviously ok for a u32.

But I have no objections to removing the __ because if a read or write
is in the hot path it will use kvm_write_guest_cached and similar.

Paolo

>> But "should" is not "does", and honestly, the cost of gfn_to_hva() is
>> high enough that then using that as an argument for removing
>> "access_ok()" smells.



