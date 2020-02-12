Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8648CC3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 16:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F49521734
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 16:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MmT6dKzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgBLQko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 11:40:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47206 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727548AbgBLQko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 11:40:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581525642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NrzhUur53Q4Y2ZEl1kiuBFTu/KwLXcTXVoqRdvHJiBI=;
        b=MmT6dKzIFED2xhfqhOBjly+jhYXiP1wFlnVwK+4da6z35cIqLUZEyrDvnfQqFh8nH2rw9O
        8hHQPz48rA3YiLWxNpia0pGSfrRJ1K/z+eps2lM4jCNEDHIQiyWJxwo0/xeJ7rxkM5w1CF
        YNFbI1rPmbILrpTIJfmyhLz5ENm1eGQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-Mdftop4CNUWSWA7jm5_pNw-1; Wed, 12 Feb 2020 11:40:40 -0500
X-MC-Unique: Mdftop4CNUWSWA7jm5_pNw-1
Received: by mail-wr1-f69.google.com with SMTP id c6so1026144wrm.18
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 08:40:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NrzhUur53Q4Y2ZEl1kiuBFTu/KwLXcTXVoqRdvHJiBI=;
        b=uSlkbqLo0g8QU7Nmd54+o2OHGzYeHdmE+ZWgEHXFaRrzqJYiGrrEWKitGKc89lyn6M
         iiF3taOKjJrx6QdqE72T6FRLuUciILHnKoMZs9zM4wX3dYAiruS1WRYX/1FzTCWCQYs5
         2CtlN3dDTgz4tU1wsS8SDP/1tUT/5TDEgdcj61taUotFAJKm270zWLiQVq7/dITsjFcr
         6CWwowPyxe/LNg+5VXUsXw5JxhbiuiVwvZdxAsA3B3ESEwWwY4joGTbJcdcRyRfey3wh
         Zh/cm+8ITapfTUP6h3eSjkaYBUvgLbfIpGAZMOiAOyg0oN2N2JIVC4zac/OF51VsglYT
         Fyvw==
X-Gm-Message-State: APjAAAUA5m+zLM42EM1VEqjynqbLk/gnm+gw1e5pI2f5i1LuWD840v1n
        l+XZ5WPy3UBr8WLQC9qbsfoEsJIdwAvNFOmmTD5gPsuWG/v8g7sJUpYSvIND+/hHviWZgdsjVw/
        exn7YMUDGYZy4+Aw1KXhKCJi6
X-Received: by 2002:adf:f288:: with SMTP id k8mr17060151wro.301.1581525639840;
        Wed, 12 Feb 2020 08:40:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqzXp2B+0mO+xq5e6mZFerIe0v8m3gwrAdj/HKSYiJvdfgdAfcAjS2vwUxPN1hDCGYWFBWWsgQ==
X-Received: by 2002:adf:f288:: with SMTP id k8mr17060137wro.301.1581525639611;
        Wed, 12 Feb 2020 08:40:39 -0800 (PST)
Received: from [192.168.178.40] ([151.30.86.140])
        by smtp.gmail.com with ESMTPSA id n8sm1179999wrx.42.2020.02.12.08.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 08:40:39 -0800 (PST)
Subject: Re: [PATCH RFC 0/4] KVM: MIPS: Provide arch-specific
 kvm_flush_remote_tlbs()
To:     Paul Burton <paulburton@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-mips@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20200207223520.735523-1-peterx@redhat.com>
 <44ba59d6-39a5-4221-1ae6-41e5a305d316@redhat.com>
 <20200212163004.cpd33ux4zslfc3es@lantea.localdomain>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <66e0a38c-a7f5-dcd1-d06b-b317588fad7a@redhat.com>
Date:   Wed, 12 Feb 2020 17:40:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200212163004.cpd33ux4zslfc3es@lantea.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/20 17:30, Paul Burton wrote:
> Hi Paolo,
> 
> On Wed, Feb 12, 2020 at 01:25:30PM +0100, Paolo Bonzini wrote:
>> MIPS folks, I see that arch/mips/kvm/mmu.c uses pud_index, so it's not
>> clear to me if it's meant to only work if CONFIG_PGTABLE_LEVELS=4 or
>> it's just bit rot.  Should I add a "depends on PGTABLE_LEVEL=4" to
>> arch/mips/Kconfig?
> 
> I'm no expert on this bit of code, but I'm pretty sure the systems
> KVM/VZ has been used on the most internally had PGTABLE_LEVEL=3.
> 
> I suspect this is actually a regression from commit 31168f033e37 ("mips:
> drop __pXd_offset() macros that duplicate pXd_index() ones"). Whilst
> that commit is correct that pud_index() & __pud_offset() are the same
> when pud_index() is actually provided, it doesn't take into account the
> __PAGETABLE_PUD_FOLDED case. There __pud_offset() was available but
> would always evaluate to zero, whereas pud_index() isn't defined...

Ok, I'll try to whip out a patch that handles __PAGETABLE_PUD_FOLDED.
On the other hand this makes me worry about how much KVM is being tested
by people that care about MIPS (even just compile-tested).

Paolo

