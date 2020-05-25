Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE875C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CC9820878
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IqD+ho9t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404244AbgEYPm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 11:42:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29792 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404152AbgEYPmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 11:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590421373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3vYHKDvyAIo7f+4+8rStf8JenmWg3cFq5KE9Yy8/9hM=;
        b=IqD+ho9ta7sHOQnLac2ohsmVtZUVTtGp/pW1Alopt4ZOwc8Chnk8MG4MtGGXdFodJESxY/
        2N/x7mXdlOiGnFEmekqjh8aJ34rqqS/OXp0YO4su1UQWR4Pfk+oOh9nOD73f5yv7azLtuQ
        KP2RiC5YLZMrv7sACSU6teHZcJm5QR4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-w6HAmsVvNmOi4mYoSwfORg-1; Mon, 25 May 2020 11:42:52 -0400
X-MC-Unique: w6HAmsVvNmOi4mYoSwfORg-1
Received: by mail-ej1-f69.google.com with SMTP id gl5so6478090ejb.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 08:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=3vYHKDvyAIo7f+4+8rStf8JenmWg3cFq5KE9Yy8/9hM=;
        b=Ett+jJZ7mQli7WyDXQERrVlyMt1SdEDqmzIpB76TEUUhaysD2/1rRS/+zvlleJbBHn
         neaeeJEM3sARmybmMCAf3woapnG0D0WC/v/8CvqPM7ONKM3hJu1UDxS6RPsNmTEu61Gf
         e1OarrBkqK7YdY2HCzksmR4TJkkRz7bpvgigBUdjIQAOER48WKmUc2tgVOlnlQDlx43H
         +vTykvlaMO7OHhK7QXwcwx3FeGx49CuuohXqvKceQhxlbO0GWZoGtzBIblg9yeC5WlUa
         Mmp9zwkihj8DyUVh/+ck5HnVLR8wFiM/3O9vgiQ8O/boaI9QSSWFPykTFDxQRG5+DobJ
         o+8g==
X-Gm-Message-State: AOAM532MliHWu/z0x0fIM7WOApLlppENPAG4Q5xALoby7Dp+E0eph5bZ
        /hlI4ZmhE+bGlndMviOa5ECYyYkla02WNh8nbJhCRdAizknDlhr64Lh26vA6eOpd68YS3HbKdaE
        CrpRFFbMn11rRiNdOoWQpotsY
X-Received: by 2002:a50:8165:: with SMTP id 92mr16085679edc.263.1590421370956;
        Mon, 25 May 2020 08:42:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGSWgO76QR2V0LyE7qteEGb8bQaL/pDvG4rJS4OeAKgPxt9awtw5ua1zb/U6iY5ijx4zHUBg==
X-Received: by 2002:a50:8165:: with SMTP id 92mr16085655edc.263.1590421370763;
        Mon, 25 May 2020 08:42:50 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b27sm15514775ejd.6.2020.05.25.08.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 08:42:50 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        "Edgecombe\, Rick P" <rick.p.edgecombe@intel.com>,
        "Kleen\, Andi" <andi.kleen@intel.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC 13/16] x86/kvmclock: Share hvclock memory with the host
In-Reply-To: <20200525152527.7g57us6imlh62x7i@box>
References: <20200522125214.31348-1-kirill.shutemov@linux.intel.com> <20200522125214.31348-14-kirill.shutemov@linux.intel.com> <875zck82fx.fsf@vitty.brq.redhat.com> <20200525152527.7g57us6imlh62x7i@box>
Date:   Mon, 25 May 2020 17:42:48 +0200
Message-ID: <87v9kk6mx3.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Kirill A. Shutemov" <kirill@shutemov.name> writes:

> On Mon, May 25, 2020 at 05:22:10PM +0200, Vitaly Kuznetsov wrote:
>> "Kirill A. Shutemov" <kirill@shutemov.name> writes:
>> 
>> > hvclock is shared between the guest and the hypervisor. It has to be
>> > accessible by host.
>> >
>> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> > ---
>> >  arch/x86/kernel/kvmclock.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
>> > index 34b18f6eeb2c..ac6c2abe0d0f 100644
>> > --- a/arch/x86/kernel/kvmclock.c
>> > +++ b/arch/x86/kernel/kvmclock.c
>> > @@ -253,7 +253,7 @@ static void __init kvmclock_init_mem(void)
>> >  	 * hvclock is shared between the guest and the hypervisor, must
>> >  	 * be mapped decrypted.
>> >  	 */
>> > -	if (sev_active()) {
>> > +	if (sev_active() || kvm_mem_protected()) {
>> >  		r = set_memory_decrypted((unsigned long) hvclock_mem,
>> >  					 1UL << order);
>> >  		if (r) {
>> 
>> Sorry if I missed something but we have other structures which KVM guest
>> share with the host,
>> 
>> sev_map_percpu_data():
>> ...
>> 	for_each_possible_cpu(cpu) {
>> 		__set_percpu_decrypted(&per_cpu(apf_reason, cpu), sizeof(apf_reason));
>> 		__set_percpu_decrypted(&per_cpu(steal_time, cpu), sizeof(steal_time));
>> 		__set_percpu_decrypted(&per_cpu(kvm_apic_eoi, cpu), sizeof(kvm_apic_eoi));
>> 	}
>> ...
>> 
>> Do you handle them somehow in the patchset? (I'm probably just blind
>> failing to see how 'early_set_memory_decrypted()' is wired up)
>
> I don't handle them yet: I've seen the function, but have not modified it.
> I want to understand first why it doesn't blow up for me without the
> change. Any clues?

(if I got the idea of the patchset right) these features are kernel-only
(e.g. QEMU doesn't need to access these areas). E.g. for APF KVM will do
kvm_write_guest_cached() and this will use FOLL_KVM. Guests should not
rely on that and mark all shared areas as unprotected.

-- 
Vitaly

