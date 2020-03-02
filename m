Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EC6C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F5812072A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bk+90EXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgCBSks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:40:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55699 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727560AbgCBSkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:40:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583174446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s/Od6bd1uZAYcj3IIa+YSzSqz+jcZdgE1dUcSgs94wk=;
        b=bk+90EXyZUM6vcND+zMzcCT99e8S+i6tvWkDLVL+OGpCQQrRwZavKSByIklTz2A7mnQDBD
        LBMZNQtthJeTR/dsOw45hoDvK6/o+4yJIrTYv4Dh1BnN1qpJGS5NTf3aaxqBBUn8UdLl3J
        J0M5jEnDMrq8xUmDq5D3zurvFK4tH6s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310--T78ZwQTM7iBE8Rw45yxlw-1; Mon, 02 Mar 2020 13:40:44 -0500
X-MC-Unique: -T78ZwQTM7iBE8Rw45yxlw-1
Received: by mail-wr1-f70.google.com with SMTP id m18so71245wro.22
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 10:40:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=s/Od6bd1uZAYcj3IIa+YSzSqz+jcZdgE1dUcSgs94wk=;
        b=dApzCUrj0O1VYGsia09F6E+mIVa3WtIXAkonqG+NwBHDpQLcnT1/dQrOMWzpkPLoI+
         OolEzbNUHzXqBt8hNA48xjoaKh3ITSaHFn2/DRNH90cFc2RynppdO6Wb1T/a8LZ77iFj
         IZagvglEdZwSP9EcxfEi3lZmJs/Upf24287WFqCfeAe5fJKhNGWyoMxUw/AU+3dBSeeo
         i/I1w8/G4CaI/VF8oRfQHBzO+Df6SgVjiGOIu6cHWtOsXp4cQMbxC3xn/P/QeJFoErTW
         VWWai2ADelhQumXy1QBVR2t62oqe0iKEMZzN8NNC9ocytJWk59E3tduKG4djCupwQ78V
         vgPA==
X-Gm-Message-State: ANhLgQ2yF/Ag+NagKYE9Hs7gMayMD5TJXNjLHadJRLD0z4Yeg3EikkwD
        1H8PvbAIiMFsE06AFfMFy4LF4SQCDhh2lYy0Hz8eruK74UUv+gY0FWV/W8xnWbeg9RIOMB9MVxC
        N4GLVqLpUVkd/tZjMdA11A6OG
X-Received: by 2002:adf:f052:: with SMTP id t18mr843739wro.192.1583174437796;
        Mon, 02 Mar 2020 10:40:37 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtSCmyJMl6nNhdF+/IiPnFSvzDLY5HhUSAjLCgUbNnWjPpkV9WfUZ8BhJ7H0sUd3owvA5Gz4Q==
X-Received: by 2002:adf:f052:: with SMTP id t18mr843730wro.192.1583174437573;
        Mon, 02 Mar 2020 10:40:37 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id f195sm397757wmf.17.2020.03.02.10.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 10:40:36 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Oliver Upton <oupton@google.com>
Subject: Re: [GIT PULL] KVM changes for Linux 5.6-rc4
In-Reply-To: <1582570669-45822-1-git-send-email-pbonzini@redhat.com>
References: <1582570669-45822-1-git-send-email-pbonzini@redhat.com>
Date:   Mon, 02 Mar 2020 19:40:35 +0100
Message-ID: <87zhcyfvmk.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

>       KVM: nVMX: Don't emulate instructions in guest mode

I just discovered that this patch breaks Hyper-V on KVM completely;
Oliver's 86f7e90ce8 ("KVM: VMX: check descriptor table exits on
instruction emulation") doesn't fix it either. The breakage manifests
itself as

 qemu-system-x86-23579 [005] 22018.775584: kvm_exit:             reason EPT_VIOLATION rip 0xfffff802987d6169 info 181 0
 qemu-system-x86-23579 [005] 22018.775584: kvm_nested_vmexit:    rip fffff802987d6169 reason EPT_VIOLATION info1 181 info2 0 int_info 0 int_info_err 0
 qemu-system-x86-23579 [005] 22018.775585: kvm_page_fault:       address febd0000 error_code 181
 qemu-system-x86-23579 [005] 22018.775592: kvm_emulate_insn:     0:fffff802987d6169: f3 a5
 qemu-system-x86-23579 [005] 22018.775593: kvm_emulate_insn:     0:fffff802987d6169: f3 a5 FAIL
 qemu-system-x86-23579 [005] 22018.775596: kvm_inj_exception:    #UD (0x0)

We probably need to re-enable instruction emulation for something...

-- 
Vitaly

