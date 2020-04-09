Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28927C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F240A221E9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWHb6jj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgDIJnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 05:43:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23092 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726620AbgDIJne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 05:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586425414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nIzy0tnj6FqxJz87TqjmoYX4nTo+jUF+UzNkvXq35po=;
        b=CWHb6jj9XUCtKDWBKVYt/8XTkI6wPC6Kpjgm00CsZMbodTfSegehsICtZ1W/kZZcn8CT/z
        9h6L0HpZAr0KzC8lKH9NvbtEnVwMU+nHMaZyXPKdwEwsBwpTmQZKd9lR5thaCaBcsWauNx
        49ET/3C36a9qZXoqHqSmuCDf8AHJBcs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-grGV2qmtN7SOmTm6asXyDw-1; Thu, 09 Apr 2020 05:43:33 -0400
X-MC-Unique: grGV2qmtN7SOmTm6asXyDw-1
Received: by mail-wr1-f69.google.com with SMTP id r17so431304wrg.19
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 02:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nIzy0tnj6FqxJz87TqjmoYX4nTo+jUF+UzNkvXq35po=;
        b=Nq8yOA0Gy3povALRks0pALZXUvgmPobohvYBOnliSKGwXCnS2UPhO9zzLRrxBvrNKm
         j6pBbvwkdzHR3iZVWQp0aMOhLeCdtrI46q+3Ovdr9T4pIc4ynuueg8WtHdLFbqemo/+p
         ccj3Ytm5ttFZCETDzmtxMm9wOP42JYUKTMjbCGAf7WAFD+OApJoWyOZIJFdrOYnh9pFn
         HXLYUBE5ybW68JlvtHrvREb4TF2e70s68IwONs+2r1Xyn+ctPEws1s7y7/Yj0Yp3J1Dm
         5RsVP/BK47NR6sCSO/cvSdCROilGwJUON6+h8VYEm6He7cdWxPPWDpvJGb4NxadxnCR9
         2wiA==
X-Gm-Message-State: AGi0PuZkmfbOAFrehrEdjCu9GLpUDEYIqfuAB2msVvIlHSuKP2vP5+Ro
        O8YaFbb9CfBWZokYibTD6cLpbuI7kZABLztILfN9aEmYuRAUfS+3N8BjUi2w3pLEMAF9dS02BPk
        eb2GaQy0PR46ibAcHPPpcpv3e
X-Received: by 2002:a1c:a7d7:: with SMTP id q206mr5695585wme.45.1586425411855;
        Thu, 09 Apr 2020 02:43:31 -0700 (PDT)
X-Google-Smtp-Source: APiQypJgQiZCrWZvCGiHqYLqjts+lmOUoOTw70VVOHDzOH/wMxfRJcVDU494OZ3lliAXWnRamte4kQ==
X-Received: by 2002:a1c:a7d7:: with SMTP id q206mr5695574wme.45.1586425411623;
        Thu, 09 Apr 2020 02:43:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:bddb:697c:bea8:abc? ([2001:b07:6468:f312:bddb:697c:bea8:abc])
        by smtp.gmail.com with ESMTPSA id g3sm25430861wrw.47.2020.04.09.02.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 02:43:31 -0700 (PDT)
Subject: Re: [PATCH v2] x86/kvm: Disable KVM_ASYNC_PF_SEND_ALWAYS
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>, stable <stable@vger.kernel.org>
References: <20200407172140.GB64635@redhat.com>
 <772A564B-3268-49F4-9AEA-CDA648F6131F@amacapital.net>
 <87eeszjbe6.fsf@nanos.tec.linutronix.de>
 <ce81c95f-8674-4012-f307-8f32d0e386c2@redhat.com>
 <874ktukhku.fsf@nanos.tec.linutronix.de>
 <274f3d14-08ac-e5cc-0b23-e6e0274796c8@redhat.com>
 <20200408153413.GA11322@linux.intel.com>
 <ce28e893-2ed0-ea6f-6c36-b08bb0d814f2@redhat.com>
 <87d08hc0vz.fsf@nanos.tec.linutronix.de>
 <CALCETrWG2Y4SPmVkugqgjZcMfpQiq=YgsYBmWBm1hj_qx3JNVQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <47a7593e-e035-1b48-c6d7-cd6f78a2f6e2@redhat.com>
Date:   Thu, 9 Apr 2020 11:43:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CALCETrWG2Y4SPmVkugqgjZcMfpQiq=YgsYBmWBm1hj_qx3JNVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/20 06:50, Andy Lutomirski wrote:
> The big problem is that #VE doesn't exist on AMD, and I really think
> that any fancy protocol we design should work on AMD.  I have no
> problem with #VE being a nifty optimization to the protocol on Intel,
> but it should *work* without #VE.

Yes and unfortunately AMD does not like to inject a non-existing
exception.  Intel only requires the vector to be <=31, but AMD wants the
vector to correspond to an exception.

However, software injection is always possible and AMD even suggests
that you use software injection for ICEBP and, on older processors, the
INT instruction.

Paolo

