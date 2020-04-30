Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824A5C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60FE820774
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCHbH6Vr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgD3Ntn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:49:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54543 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726906AbgD3Ntm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:49:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588254581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IEBaJZZn8G4VkvBwEauwJGfaJC10NnAmuAyBH5fbQnA=;
        b=RCHbH6VrbDqs9IsoJovxZ0sJbi5CO3Hwsfp/n0Jb0Nqim2qMv/pJzLZtF3wZBvY6Yb/2tH
        +zdDBgFFUsS2EJb/wXXfLmuVbd5aafXpR5Gfpi61SJ0lbm6dkYg0VJZtQS3Si9j2IduHpd
        mK8hsjXBo5rmnEZ9K7cAwaz0ggITx78=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-oL5JzGQDNPOwVzUF-7r3Ww-1; Thu, 30 Apr 2020 09:49:39 -0400
X-MC-Unique: oL5JzGQDNPOwVzUF-7r3Ww-1
Received: by mail-wr1-f72.google.com with SMTP id r17so3882099wrg.19
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 06:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=IEBaJZZn8G4VkvBwEauwJGfaJC10NnAmuAyBH5fbQnA=;
        b=dGXYAVsvUftzgJTyZqXaeKc6zMyL5Ii1DzTh9YyTD0r4lW8wM9+oWm1TxeMp8z4fCK
         is+NH9B6G1dsq4ddK9Q6huLLRv9wNm8OJJR+tb5W2WSNEOYTNfjeE4waS7OrHkEiYtxr
         bLYhYnTrVnNFJzfT6/hwJ7MzdHvtudzxfpJvWF3L8EQgQtJ6JjuUHvlmGcttBsXve6Qp
         ev9kNmiCPnk9XSSydk5Vq9K7VNg5yaE4WcNyiDQ0vOL4fncTDJBhFih2EzE0vQRNWXtW
         p3BhqXxM3XykI8P32scF/l66cwCmbxNs3amW2yFKYlYfvtuLmrQ/N9+190zKR6sEJk1d
         k+MA==
X-Gm-Message-State: AGi0PuaaL94EecAaoQUK0mVvIu9yAMdgyI1pCa/MTofY2zUro1UYczb9
        u/69dxAXGMMfaKgeJavPRhCi0AsawauQZJxg31GwSPXINqVjcMxAG6jnc4UVXMHXHVWY9Tw5sF5
        835+5WKhXRiB11eo+WkIvv3R+
X-Received: by 2002:a1c:6a0b:: with SMTP id f11mr3082440wmc.123.1588254575073;
        Thu, 30 Apr 2020 06:49:35 -0700 (PDT)
X-Google-Smtp-Source: APiQypKPdUBEwRbmSXCzUBZ0gX8bjI8gMw9HBoTwk6kFinzxWLo9L+OUtgiEezO+fqbN+i/GXfMCCg==
X-Received: by 2002:a1c:6a0b:: with SMTP id f11mr3082411wmc.123.1588254574896;
        Thu, 30 Apr 2020 06:49:34 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id 91sm4520928wra.37.2020.04.30.06.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 06:49:34 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH RFC 3/6] KVM: x86: interrupt based APF page-ready event delivery
In-Reply-To: <20200430132805.GB40678@xz-x1>
References: <20200429093634.1514902-1-vkuznets@redhat.com> <20200429093634.1514902-4-vkuznets@redhat.com> <20200429212708.GA40678@xz-x1> <87v9lhfk7v.fsf@vitty.brq.redhat.com> <20200430132805.GB40678@xz-x1>
Date:   Thu, 30 Apr 2020 15:49:33 +0200
Message-ID: <877dxxf5hu.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> On Thu, Apr 30, 2020 at 10:31:32AM +0200, Vitaly Kuznetsov wrote:
>> as we need to write to two MSRs to configure the new mechanism ordering
>> becomes important. If the guest writes to ASYNC_PF_EN first to establish
>> the shared memory stucture the interrupt in ASYNC_PF2 is not yet set
>> (and AFAIR '0' is a valid interrupt!) so if an async pf happens
>> immediately after that we'll be forced to inject INT0 in the guest and
>> it'll get confused and linkely miss the event.
>> 
>> We can probably mandate the reverse sequence: guest has to set up
>> interrupt in ASYNC_PF2 first and then write to ASYNC_PF_EN (with both
>> bit 0 and bit 3). In that case the additional 'enable' bit in ASYNC_PF2
>> seems redundant. This protocol doesn't look too complex for guests to
>> follow.
>
> Yep looks good.  We should also update the document too about the fact.
>

Of course. It will also mention the fact that #PF-based mechanism is
now depreceted and unless guest opts into interrupt based delivery
async_pf is not functional (except for APF_HALT).

-- 
Vitaly

