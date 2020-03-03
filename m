Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE8EC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D062083E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZuDNQiS8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgCCK6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:58:33 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23864 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727927AbgCCK6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:58:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583233111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/zXPTBF4JWqoYp8eI1kQcfpbOmowjFDH+kFOoB5ZRAY=;
        b=ZuDNQiS8P0+bDBilQUX4lwpEwieTLIL98HW6mS8tNlfOO8JdGXzxtNMu2yBz/Z+GJkpXkY
        7vKtSW8AMa2PhgR7Pzt8b2D28ieaq3M9Xp6WPUzZP9gM6J+AZTuJK07rszwVKlojXzofiG
        4MAbjIHTx4UljWJWWw8gYSJlnPH+ZlA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-qtI-Mwh2N2iiofhnOuZEvQ-1; Tue, 03 Mar 2020 05:58:29 -0500
X-MC-Unique: qtI-Mwh2N2iiofhnOuZEvQ-1
Received: by mail-wm1-f72.google.com with SMTP id r19so927646wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 02:58:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/zXPTBF4JWqoYp8eI1kQcfpbOmowjFDH+kFOoB5ZRAY=;
        b=F3aKQGKqedmmGUAd7CCQWpHiepIuWI27C5+Pi3Kky6Cmb37+Ce1BbCe3zG+vkDg8Wh
         gRTXkSOz4y8zL1B22SzUjUjIufLnlVrC9GuTyj3oNz3CS+iJkbEVvwHIaQqWlmNrI0rx
         N5oMupmxT9pZty8V5cENJuWg/M5tnDpI2h4ogWKCQvoqRPGSAoG5IhkmzTF0/7RhOebi
         kjBm0ep5gNkPtlubJ8h/OVzyUB4yP/Xoora9xO/witzkNitIG/i+MnGUk4m5iwHUTJIx
         6Fc8DtQJ7PE9f5tkoO1WeIRH0L+4A9jcW5Dfawff5h+avhw3AMIcHFlnTEm2AGvwAjRz
         JkgQ==
X-Gm-Message-State: ANhLgQ0WP/aPnCPXoFDdYdM4+Tnh7VzHU6/92fzIQGHnsf5gQv6IK2uT
        +J/8JMHwMdtE3tP/Ic8ryqP22wddXgijzsWpKe5cXQeuBUCH3HiDIwXKjZxolMTg7mfgIc2gXyP
        RYbrfXUurLD+Eo2JrcbAsuQx+
X-Received: by 2002:a05:600c:104d:: with SMTP id 13mr3750724wmx.50.1583233107989;
        Tue, 03 Mar 2020 02:58:27 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsd4BS7rp91JqsVP0DXSUT94e+JAinRKnGWMQ7Cvy39iLCGgQ+L61XcKLOC/AXfzKHmLi4C1w==
X-Received: by 2002:a05:600c:104d:: with SMTP id 13mr3750709wmx.50.1583233107679;
        Tue, 03 Mar 2020 02:58:27 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993? ([2001:b07:6468:f312:9def:34a0:b68d:9993])
        by smtp.gmail.com with ESMTPSA id e7sm13496617wrt.70.2020.03.03.02.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 02:58:27 -0800 (PST)
Subject: Re: [GIT PULL] KVM changes for Linux 5.6-rc4
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Oliver Upton <oupton@google.com>
References: <1582570669-45822-1-git-send-email-pbonzini@redhat.com>
 <87zhcyfvmk.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8fbeb3c2-9627-bf41-d798-bafba22073e3@redhat.com>
Date:   Tue, 3 Mar 2020 11:58:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87zhcyfvmk.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/20 19:40, Vitaly Kuznetsov wrote:
> 
>  qemu-system-x86-23579 [005] 22018.775584: kvm_exit:             reason EPT_VIOLATION rip 0xfffff802987d6169 info 181 0
>  qemu-system-x86-23579 [005] 22018.775584: kvm_nested_vmexit:    rip fffff802987d6169 reason EPT_VIOLATION info1 181 info2 0 int_info 0 int_info_err 0
>  qemu-system-x86-23579 [005] 22018.775585: kvm_page_fault:       address febd0000 error_code 181
>  qemu-system-x86-23579 [005] 22018.775592: kvm_emulate_insn:     0:fffff802987d6169: f3 a5
>  qemu-system-x86-23579 [005] 22018.775593: kvm_emulate_insn:     0:fffff802987d6169: f3 a5 FAIL
>  qemu-system-x86-23579 [005] 22018.775596: kvm_inj_exception:    #UD (0x0)
> 
> We probably need to re-enable instruction emulation for something...

This is a rep movsw instruction, it shouldn't be intercepted.  I think
we have a stale ctxt->intercept because the

        /* Fields above regs are cleared together. */

comment is not true anymore since

    commit c44b4c6ab80eef3a9c52c7b3f0c632942e6489aa
    Author: Bandan Das <bsd@redhat.com>
    Date:   Wed Apr 16 12:46:12 2014 -0400

    KVM: emulate: clean up initializations in init_decode_cache

    A lot of initializations are unnecessary as they get set to
    appropriate values before actually being used. Optimize
    placement of fields in x86_emulate_ctxt

    Signed-off-by: Bandan Das <bsd@redhat.com>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

