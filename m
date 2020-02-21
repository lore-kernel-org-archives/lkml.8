Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979F9C35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF61206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C4zH7Bof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgBUPjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:39:47 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60453 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728235AbgBUPjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:39:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582299584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KRcebtTHRi/kIYrBfNEoKmga6fbLI0TK02ClKxB6zpM=;
        b=C4zH7BofXbDfwZ2zgWGu5WAgQTWBZ7dYZQ85o0ixebQ+xcz5VaoQY/AKOyRi7ns74MQqg4
        +b3dTtoSvdBBR870GuNZzsDFWZC510xaDTRrqzbgT0RS15qhrCB7JHj2fQKMfgZvOovwG6
        eNEp+/ANR+kjcyrZ95L0pz+l1z9rT/k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-r1d-IdsxPaOl0d37jt8psQ-1; Fri, 21 Feb 2020 10:39:38 -0500
X-MC-Unique: r1d-IdsxPaOl0d37jt8psQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCFCD1005512;
        Fri, 21 Feb 2020 15:39:36 +0000 (UTC)
Received: from x1.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3EF7B27183;
        Fri, 21 Feb 2020 15:39:36 +0000 (UTC)
Date:   Fri, 21 Feb 2020 08:39:34 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, joro@8bytes.org, jon.grimm@amd.com
Subject: Re: [PATCH] kvm: x86: svm: Fix NULL pointer dereference when AVIC
 not enabled
Message-ID: <20200221083934.3ed38014@x1.home>
In-Reply-To: <1582296737-13086-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1582296737-13086-1-git-send-email-suravee.suthikulpanit@amd.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2020 08:52:17 -0600
Suravee Suthikulpanit <suravee.suthikulpanit@amd.com> wrote:

> Launching VM w/ AVIC disabled together with pass-through device
> results in NULL pointer dereference bug with the following call trace.
> 
>     RIP: 0010:svm_refresh_apicv_exec_ctrl+0x17e/0x1a0 [kvm_amd]
> 
>     Call Trace:
>      kvm_vcpu_update_apicv+0x44/0x60 [kvm]
>      kvm_arch_vcpu_ioctl_run+0x3f4/0x1c80 [kvm]
>      kvm_vcpu_ioctl+0x3d8/0x650 [kvm]
>      do_vfs_ioctl+0xaa/0x660
>      ? tomoyo_file_ioctl+0x19/0x20
>      ksys_ioctl+0x67/0x90
>      __x64_sys_ioctl+0x1a/0x20
>      do_syscall_64+0x57/0x190
>      entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Investigation shows that this is due to the uninitialized usage of
> struct vapu_svm.ir_list in the svm_set_pi_irte_mode(), which is
> called from svm_refresh_apicv_exec_ctrl().
> 
> The ir_list is initialized only if AVIC is enabled. So, fixes by
> adding a check if AVIC is enabled in the svm_refresh_apicv_exec_ctrl().
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=206579
> Fixes: 8937d762396d ("kvm: x86: svm: Add support to (de)activate posted interrupts.")
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> ---
>  arch/x86/kvm/svm.c | 3 +++
>  1 file changed, 3 insertions(+)

Works for me, thanks Suravee!

Tested-by: Alex Williamson <alex.williamson@redhat.com>

> 
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 19035fb..1858455 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -5222,6 +5222,9 @@ static void svm_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
>  	struct vmcb *vmcb = svm->vmcb;
>  	bool activated = kvm_vcpu_apicv_active(vcpu);
>  
> +	if (!avic)
> +		return;
> +
>  	if (activated) {
>  		/**
>  		 * During AVIC temporary deactivation, guest could update

