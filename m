Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8739DC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C34B2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QrppHo0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgCCNDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 08:03:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58220 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729153AbgCCNDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 08:03:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583240578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fxyaJBCKdEug50sQ1sIk2q1FJ4yKhmLVJVdWUZZRTgs=;
        b=QrppHo0ATY5vjVyun6UV2UEqgyLDU+QZ2u2AzubDepqbNYA9+w82OY/vhM3yJUg+gWJQXe
        uVVMcKnB78+b0kmD2gnQsgIybPQWFVnsU6hzQVoBc0Cp4idAIQ1ytGiSHVoTX2TmiQB+4s
        SFx3b8zPVEHYg2wMrJoFkN2zr4gF7iU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-9NbOYUycNtCOeJbhf3yb9g-1; Tue, 03 Mar 2020 08:02:57 -0500
X-MC-Unique: 9NbOYUycNtCOeJbhf3yb9g-1
Received: by mail-wr1-f70.google.com with SMTP id m18so1170238wro.22
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 05:02:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=fxyaJBCKdEug50sQ1sIk2q1FJ4yKhmLVJVdWUZZRTgs=;
        b=T4VdG/+GwmL8e9Yd+Jr5mxHG45jAWswvMrfiY7mG9C8mPZ3heLuJP1Z/LjSpgCsxj+
         dH1v41MgFNCqpy+6yezQ5asGAzFIQ5V81+VVH5MBsLOwyNyLVU/Yah9zvMBU5HKG48fT
         Md/9uFNn25/eoEQs5yMgZ+BCcJyrsW8GiyGqGk27sEjiW8RRyV29JE+VVJTNlLsdF13o
         r/EJE/wmOkGF1kB4BDCSDqln6tJLQZbTxQsYUPXyJhA4yuco4ly1C3QPNvWLMb2u4rqQ
         Cy73R6vL23jMqa9y0DcJBX8rKp9PEYoCDIIDtULBIqx4TbaOgxfsb02jiqcQUywq82KI
         ssnQ==
X-Gm-Message-State: ANhLgQ309ScNTuXQqPbIca1+8VpIH8PzipGCJ6fUkUwoZn1lzvUllz0n
        WsLT498uV2wRxkq0g1BRb9WGvfGkK+JIkH8B1oOaMgFgvuom8c9ZwHG4y6oGv9rQCZs6mo3bS7U
        q4w+5B6IVYcRup0QQQMwckzxH
X-Received: by 2002:adf:f84a:: with SMTP id d10mr5547887wrq.208.1583240576044;
        Tue, 03 Mar 2020 05:02:56 -0800 (PST)
X-Google-Smtp-Source: ADFU+vu05HQ3OHj9N3aJ8iNGgT/jLI2sDvyFRtk26XLwFnJjSUTHXBpAo4czkkiEuXW6nhpwE+4fTg==
X-Received: by 2002:adf:f84a:: with SMTP id d10mr5547859wrq.208.1583240575803;
        Tue, 03 Mar 2020 05:02:55 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a7sm34797870wrm.29.2020.03.03.05.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 05:02:55 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Oliver Upton <oupton@google.com>
Subject: Re: [GIT PULL] KVM changes for Linux 5.6-rc4
In-Reply-To: <8fbeb3c2-9627-bf41-d798-bafba22073e3@redhat.com>
References: <1582570669-45822-1-git-send-email-pbonzini@redhat.com> <87zhcyfvmk.fsf@vitty.brq.redhat.com> <8fbeb3c2-9627-bf41-d798-bafba22073e3@redhat.com>
Date:   Tue, 03 Mar 2020 14:02:54 +0100
Message-ID: <87tv35fv5t.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 02/03/20 19:40, Vitaly Kuznetsov wrote:
>> 
>>  qemu-system-x86-23579 [005] 22018.775584: kvm_exit:             reason EPT_VIOLATION rip 0xfffff802987d6169 info 181 0
>>  qemu-system-x86-23579 [005] 22018.775584: kvm_nested_vmexit:    rip fffff802987d6169 reason EPT_VIOLATION info1 181 info2 0 int_info 0 int_info_err 0
>>  qemu-system-x86-23579 [005] 22018.775585: kvm_page_fault:       address febd0000 error_code 181
>>  qemu-system-x86-23579 [005] 22018.775592: kvm_emulate_insn:     0:fffff802987d6169: f3 a5
>>  qemu-system-x86-23579 [005] 22018.775593: kvm_emulate_insn:     0:fffff802987d6169: f3 a5 FAIL
>>  qemu-system-x86-23579 [005] 22018.775596: kvm_inj_exception:    #UD (0x0)
>> 
>> We probably need to re-enable instruction emulation for something...
>
> This is a rep movsw instruction, it shouldn't be intercepted.  I think
> we have a stale ctxt->intercept because the
>
>         /* Fields above regs are cleared together. */
>
> comment is not true anymore since
>
>     commit c44b4c6ab80eef3a9c52c7b3f0c632942e6489aa
>     Author: Bandan Das <bsd@redhat.com>
>     Date:   Wed Apr 16 12:46:12 2014 -0400
>
>     KVM: emulate: clean up initializations in init_decode_cache
>

Right you are,

a big hammer like

diff --git a/arch/x86/include/asm/kvm_emulate.h b/arch/x86/include/asm/kvm_emulate.h
index 2a8f2bd..52c9bce 100644
--- a/arch/x86/include/asm/kvm_emulate.h
+++ b/arch/x86/include/asm/kvm_emulate.h
@@ -324,14 +324,6 @@ struct x86_emulate_ctxt {
         */
 
        /* current opcode length in bytes */
-       u8 opcode_len;
-       u8 b;
-       u8 intercept;
-       u8 op_bytes;
-       u8 ad_bytes;
-       struct operand src;
-       struct operand src2;
-       struct operand dst;
        union {
                int (*execute)(struct x86_emulate_ctxt *ctxt);
                fastop_t fop;
@@ -343,6 +335,14 @@ struct x86_emulate_ctxt {
         * or elsewhere
         */
        bool rip_relative;
+       u8 opcode_len;
+       u8 b;
+       u8 intercept;
+       u8 op_bytes;
+       u8 ad_bytes;
+       struct operand src;
+       struct operand src2;
+       struct operand dst;
        u8 rex_prefix;
        u8 lock_prefix;
        u8 rep_prefix;

seems to make the issue go away. (For those wondering why fielf
shuffling makes a difference: init_decode_cache() clears
[rip_relative, modrm) range) How did this even work before...
(I'm still looking at the code, stay tuned...)

-- 
Vitaly

