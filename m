Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD62C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF4620709
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fAxcZUtJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbgAXKxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:53:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51873 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728939AbgAXKxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 05:53:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579863191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zBUiwDLMAsAs0p5MkLoJuTXWu+NA6JrXwgJ9lDHAW1s=;
        b=fAxcZUtJVUfPOkVP0vMKknzyy3xTNJ1Dql3Rhis5tRXIjNHUefYxBlAk1uBlDpiaCz5R3A
        aoMymZ2+rBvWa7itSKN7R409Ttkp02b/dwMoJHJa2bp114hJc/5jQBLwkF0P9QH8NbQKgH
        C0rzA7ZJwNvt5WQq61lZXaE8fLkPRFY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-uBMlCtefMViPx5xcB2q59A-1; Fri, 24 Jan 2020 05:53:07 -0500
X-MC-Unique: uBMlCtefMViPx5xcB2q59A-1
Received: by mail-wm1-f70.google.com with SMTP id g26so494289wmk.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 02:53:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=zBUiwDLMAsAs0p5MkLoJuTXWu+NA6JrXwgJ9lDHAW1s=;
        b=EVCRWxqKvkyXM53hl1jb/27O3qBeYqABwgf0KKd/yb2LdSiuVjkDkfPh5WfEzEcxKe
         DBhq6DtXkpSqY/wu4WVjyMErk+L8mqiW2A0TD0F/K6YywjnGfFqeW0nvTo0JNvsT2tBT
         6K2410REk5B5T19vg+5WkivRjfL6Z2BCaWmFeI0DiNjrHqrWNAc3cHgkt+sf3flSfik9
         XnHAWawHC8qT+x76wXWRHZ2NgZMA7hjAKj+f9S2EIO0dHTKIpU/ho4DRKI4ttOps5wo/
         OtoiIt3Vd6nyQLf2FTQ76Z7AM2C377bEBDZkfYPzM5O90t3JvXvQxuTh0jyQC5emLxSQ
         27tQ==
X-Gm-Message-State: APjAAAVZFzwHfdoYSd27DvDERCBfU0HtMBiAlR392JIKQKgCUjNvi4lM
        dGYGidw/EHa0j138ZFGGtUXLe30SugdgIH1nsldpmc5btME+J9e4EEM505/0I/l/J9LFWCMAXQU
        J6wyFaSahH6/8Dawj9aat4xo9
X-Received: by 2002:adf:f091:: with SMTP id n17mr3446833wro.387.1579863185039;
        Fri, 24 Jan 2020 02:53:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqwpzn8bEH5LtY2AtuNqkmU4qUynW/m9Njaa0c3e2ayneSU1C6wfjhDCBQ9qgslOMk2C1Ommww==
X-Received: by 2002:adf:f091:: with SMTP id n17mr3446809wro.387.1579863184764;
        Fri, 24 Jan 2020 02:53:04 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b68sm6415813wme.6.2020.01.24.02.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 02:53:04 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>
Cc:     linmiaohe <linmiaohe@huawei.com>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] KVM: nVMX: set rflags to specify success in handle_invvpid() default case
In-Reply-To: <20200123230125.GA24211@linux.intel.com>
References: <1579749241-712-1-git-send-email-linmiaohe@huawei.com> <8736c6sga7.fsf@vitty.brq.redhat.com> <1a083ac8-3b01-fd2d-d867-2b3956cdef6d@redhat.com> <87wo9iqzfa.fsf@vitty.brq.redhat.com> <ee7d815f-750f-3d0e-2def-1631be66a483@redhat.com> <CALMp9eRRUY6a_QzbG-rHoZi5zc1YWHLk243=V2VBSQa=HL-Dpw@mail.gmail.com> <20200123230125.GA24211@linux.intel.com>
Date:   Fri, 24 Jan 2020 11:53:02 +0100
Message-ID: <87muadnn1t.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Thu, Jan 23, 2020 at 10:22:24AM -0800, Jim Mattson wrote:
>> On Thu, Jan 23, 2020 at 1:54 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>> >
>> > On 23/01/20 10:45, Vitaly Kuznetsov wrote:
>> > >>> SDM says that "If an
>> > >>> unsupported INVVPID type is specified, the instruction fails." and this
>> > >>> is similar to INVEPT and I decided to check what handle_invept()
>> > >>> does. Well, it does BUG_ON().
>> > >>>
>> > >>> Are we doing the right thing in any of these cases?
>> > >>
>> > >> Yes, both INVEPT and INVVPID catch this earlier.
>> > >>
>> > >> So I'm leaning towards not applying Miaohe's patch.
>> > >
>> > > Well, we may at least want to converge on BUG_ON() for both
>> > > handle_invvpid()/handle_invept(), there's no need for them to differ.
>> >
>> > WARN_ON_ONCE + nested_vmx_failValid would probably be better, if we
>> > really want to change this.
>> >
>> > Paolo
>> 
>> In both cases, something is seriously wrong. The only plausible
>> explanations are compiler error or hardware failure. It would be nice
>> to handle *all* such failures with a KVM_INTERNAL_ERROR exit to
>> userspace. (I'm also thinking of situations like getting a VM-exit for
>> INIT.)
>
> Ya.  Vitaly and I had a similar discussion[*].  The idea we tossed around
> was to also mark the VM as having encountered a KVM/hardware bug so that
> the VM is effectively dead.  That would also allow gracefully handling bugs
> that are detected deep in the stack, i.e. can't simply return 0 to get out
> to userspace.

Yea, I was thinking about introducing a big hammer which would stop the
whole VM as soon as possible to make it easier to debug such
situations. Something like (not really tested):

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index cf917139de6b..5476f88c9ada 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8001,6 +8001,15 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	bool req_immediate_exit = false;
 
 	if (kvm_request_pending(vcpu)) {
+		/* INTERROR check should always come first */
+		if (kvm_check_request(KVM_REQ_INTERROR, vcpu)) {
+			if (vcpu->run->exit_reason != KVM_EXIT_INTERNAL_ERROR) {
+				vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+				vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_OTHERCPU;
+			}
+			r = 0;
+			goto out;
+		}
 		if (kvm_check_request(KVM_REQ_GET_VMCS12_PAGES, vcpu)) {
 			if (unlikely(!kvm_x86_ops->get_vmcs12_pages(vcpu))) {
 				r = 0;
@@ -8510,6 +8519,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	kvm_sigset_activate(vcpu);
 	kvm_load_guest_fpu(vcpu);
 
+	if (unlikely(vcpu->kvm->vm_bugged)) {
+		vcpu->run->exit_reason = KVM_REQ_INTERROR;
+		/* Maybe a suberror for 'attempted to run a vCPU of a bugged VM? */
+		r = 0;
+		goto out;
+	}
+
 	if (unlikely(vcpu->arch.mp_state == KVM_MP_STATE_UNINITIALIZED)) {
 		if (kvm_run->immediate_exit) {
 			r = -EINTR;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 538c25e778c0..d003be5fcf42 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -146,6 +146,7 @@ static inline bool is_error_page(struct page *page)
 #define KVM_REQ_MMU_RELOAD        (1 | KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 #define KVM_REQ_PENDING_TIMER     2
 #define KVM_REQ_UNHALT            3
+#define KVM_REQ_INTERROR          (4 | KVM_REQUEST_WAIT)
 #define KVM_REQUEST_ARCH_BASE     8
 
 #define KVM_ARCH_REQ_FLAGS(nr, flags) ({ \
@@ -501,6 +502,9 @@ struct kvm {
 	struct srcu_struct srcu;
 	struct srcu_struct irq_srcu;
 	pid_t userspace_pid;
+
+	/* VM caused internal KVM error */
+	bool vm_bugged;
 };
 
 #define kvm_err(fmt, ...) \
@@ -613,6 +617,7 @@ static inline void kvm_irqfd_exit(void)
 int kvm_init(void *opaque, unsigned vcpu_size, unsigned vcpu_align,
 		  struct module *module);
 void kvm_exit(void);
+void kvm_vm_bug(struct kvm_vcpu *vcpu, u32 error);
 
 void kvm_get_kvm(struct kvm *kvm);
 void kvm_put_kvm(struct kvm *kvm);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index f0a16b4adbbd..62505161ae98 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -246,6 +246,8 @@ struct kvm_hyperv_exit {
 #define KVM_INTERNAL_ERROR_DELIVERY_EV	3
 /* Encounter unexpected vm-exit reason */
 #define KVM_INTERNAL_ERROR_UNEXPECTED_EXIT_REASON	4
+/* Some other vCPU caused internal KVM error */
+#define KVM_INTERNAL_ERROR_OTHERCPU	5
 
 /* for KVM_RUN, returned by mmap(vcpu_fd, offset=0) */
 struct kvm_run {
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 00268290dcbd..4cc268d57714 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4446,6 +4446,18 @@ void kvm_exit(void)
 }
 EXPORT_SYMBOL_GPL(kvm_exit);
 
+void kvm_vm_bug(struct kvm_vcpu *vcpu, u32 error)
+{
+	vcpu->kvm->vm_bugged = true;
+
+	vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+	vcpu->run->internal.suberror = error;
+	/* We can also pass ndata/data ... */
+
+	kvm_make_all_cpus_request(vcpu->kvm, KVM_REQ_INTERROR);
+}
+EXPORT_SYMBOL_GPL(kvm_vm_bug);
+
 struct kvm_vm_worker_thread_context {
 	struct kvm *kvm;
 	struct task_struct *parent;

If you guys like the idea in general I can prepare patches.

-- 
Vitaly

