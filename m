Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171E4C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 18:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBA9320731
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 18:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZipqMQh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387727AbgDMS1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 14:27:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30226 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387695AbgDMS1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 14:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586802431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LE4Q5pv4+ttMd6fa4HJ5hzCrYdDEL+fHTEMdK/F84bA=;
        b=FZipqMQhBvlY7tEs7XpZB5H6x8Z2aVqun4sxNnxGDkbJ0nIzeug6hLM9jlZq0Mbe8UeKwK
        aEmNMZJVepPFRuzyQtfesy9jBLMjkqsMJleSnjU5XhXEfYO2E92zWMmKtpien9d2DJaYO5
        fEtUXz2CYzSVQLL+6OKWuERBLdzqEvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-fywtPCKvPym3A9psr-clxg-1; Mon, 13 Apr 2020 14:27:09 -0400
X-MC-Unique: fywtPCKvPym3A9psr-clxg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE9EF18FE861;
        Mon, 13 Apr 2020 18:27:07 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-15.gru2.redhat.com [10.97.116.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD0CA5D9CD;
        Mon, 13 Apr 2020 18:26:57 +0000 (UTC)
Subject: Re: [PATCH 01/10] KVM: selftests: Take vcpu pointer instead of id in
 vm_vcpu_rm()
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>
References: <20200410231707.7128-1-sean.j.christopherson@intel.com>
 <20200410231707.7128-2-sean.j.christopherson@intel.com>
From:   Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <b696c5b9-2507-8849-e196-37c83806cfdf@redhat.com>
Date:   Mon, 13 Apr 2020 15:26:55 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200410231707.7128-2-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/10/20 8:16 PM, Sean Christopherson wrote:
> The sole caller of vm_vcpu_rm() already has the vcpu pointer, take it
> directly instead of doing an extra lookup.


Most of (if not all) vcpu related functions in kvm_util.c receives an 
id, so this change creates an inconsistency.

Disregarding the above comment, the changes look good to me. So:

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>


>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>   tools/testing/selftests/kvm/lib/kvm_util.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 8a3523d4434f..9a783c20dd26 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -393,7 +393,7 @@ struct vcpu *vcpu_find(struct kvm_vm *vm, uint32_t vcpuid)
>    *
>    * Input Args:
>    *   vm - Virtual Machine
> - *   vcpuid - VCPU ID
> + *   vcpu - VCPU to remove
>    *
>    * Output Args: None
>    *
> @@ -401,9 +401,8 @@ struct vcpu *vcpu_find(struct kvm_vm *vm, uint32_t vcpuid)
>    *
>    * Within the VM specified by vm, removes the VCPU given by vcpuid.
>    */
> -static void vm_vcpu_rm(struct kvm_vm *vm, uint32_t vcpuid)
> +static void vm_vcpu_rm(struct kvm_vm *vm, struct vcpu *vcpu)
>   {
> -	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
>   	int ret;
>   
>   	ret = munmap(vcpu->state, sizeof(*vcpu->state));
> @@ -427,7 +426,7 @@ void kvm_vm_release(struct kvm_vm *vmp)
>   	int ret;
>   
>   	while (vmp->vcpu_head)
> -		vm_vcpu_rm(vmp, vmp->vcpu_head->id);
> +		vm_vcpu_rm(vmp, vmp->vcpu_head);
>   
>   	ret = close(vmp->fd);
>   	TEST_ASSERT(ret == 0, "Close of vm fd failed,\n"

