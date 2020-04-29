Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3C4C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84D832072A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTH+5zGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgD2Mkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 08:40:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52232 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726516AbgD2Mks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588164047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BjMHTfluX9v8MZZhvCrUdyjgxKC2vAgjaDfuCMkh7PQ=;
        b=hTH+5zGYaNNalM+uysvBSzCFbZXFTV1FKbIirSkWqGQkHa7M1SbM5zRArj1R7h+Xca/dYD
        wPVi9QB7WROSH9cxMkiny9PS64AKlxy9M/cHrlvlSNf+PjdQg+HINBq+ur63t+KRGb6JYW
        RVzlWN2yUSExXTjMnVvHaTZy0KKtgS0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-p3OWfdZkOjKgzKEEFiRnew-1; Wed, 29 Apr 2020 08:40:45 -0400
X-MC-Unique: p3OWfdZkOjKgzKEEFiRnew-1
Received: by mail-wr1-f72.google.com with SMTP id f15so1672487wrj.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 05:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=BjMHTfluX9v8MZZhvCrUdyjgxKC2vAgjaDfuCMkh7PQ=;
        b=ooWI/IVFoOcdtbLPL0qe/hw39utiTH7hn3udY+IkHcgOg4QDwtptftQbD2qPz5rwHa
         5oO5SxAvX6nZQ5aVAI0QUZ314OKuRdD2c91CYSAbrFu5Aj7tEZ7eAYDCuzuGvnHw7qkB
         rZkQCvGFukZffm5Wn44l5yHP8AIgO0dqwVjtImA/uPL6M/Ywo9WM0oVI1ZEph75qWcYU
         UsAK6xHVvUN3ks//Z+5CO7bu1aAKzehnX3j1VZKmD5qLrkzRvGzi6caSglIP9KCuLPOz
         P2Tt6WtGDx4QI5u9XCdzcaICnPMjAubgR0jetH7aZXvzfECbvoTZJCRAOzFQnDQRR1Jj
         Kj3Q==
X-Gm-Message-State: AGi0PuarhDFcoDKE3qcE6nlHLOLbNF1eoZ2gTB1gnEklaiav9rnWd27J
        wWYdrWbxO0S2EfzLdxCt+TbFZ+fjQ3AOeUc2XGgHD2Fab3oplDTC1hQueVqCyfcSRXkRksyyS3y
        IV9+pRNyBRN87dywMrwOSq5Xw
X-Received: by 2002:adf:f5ce:: with SMTP id k14mr42200026wrp.39.1588164044258;
        Wed, 29 Apr 2020 05:40:44 -0700 (PDT)
X-Google-Smtp-Source: APiQypLZp4jcS3C85kE+Rk2hnA1Olxxl/7H/RjDxxqruRxr0nOa6AbCjvPxxdM01bMtyZ/8kZwX59g==
X-Received: by 2002:adf:f5ce:: with SMTP id k14mr42199996wrp.39.1588164044066;
        Wed, 29 Apr 2020 05:40:44 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id w11sm7350204wmi.32.2020.04.29.05.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 05:40:42 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, x86@kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH RFC 3/6] KVM: x86: interrupt based APF page-ready event delivery
In-Reply-To: <546bb75a-ec00-f748-1f44-2b5299a3d3d7@redhat.com>
References: <20200429093634.1514902-1-vkuznets@redhat.com> <20200429093634.1514902-4-vkuznets@redhat.com> <546bb75a-ec00-f748-1f44-2b5299a3d3d7@redhat.com>
Date:   Wed, 29 Apr 2020 14:40:41 +0200
Message-ID: <87ees6h3cm.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 29/04/20 11:36, Vitaly Kuznetsov wrote:
>> +
>> +	Type 1 page (page missing) events are currently always delivered as
>> +	synthetic #PF exception. Type 2 (page ready) are either delivered
>> +	by #PF exception (when bit 3 of MSR_KVM_ASYNC_PF_EN is clear) or
>> +	via an APIC interrupt (when bit 3 set). APIC interrupt delivery is
>> +	controlled by MSR_KVM_ASYNC_PF2.
>
> I think we should (in the non-RFC version) block async page faults
> completely and only keep APF_HALT unless the guest is using page ready
> interrupt delivery.

Sure, we can do that. This is, however, a significant behavioral change:
APF_HALT frees the host, not the guest, so even if the combined
performance of all guests on the same pCPU remain the same guests with
e.g. a lot of simultaneously running processes may suffer more.

In theory, we can keep two mechanisms side by side for as long as we
want but if the end goal is to have '#PF abuse eliminated' than we'll
have to get rid of the legacy one some day. The day when the new
mechanism lands is also a good choice :-)

-- 
Vitaly

