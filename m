Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5C6C2D0CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 02:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174832087E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 02:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAVCTe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 21:19:34 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2993 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726396AbgAVCTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 21:19:33 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 43ABC4499A2157656E84;
        Wed, 22 Jan 2020 10:19:31 +0800 (CST)
Received: from dggeme766-chm.china.huawei.com (10.3.19.112) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 22 Jan 2020 10:19:30 +0800
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 dggeme766-chm.china.huawei.com (10.3.19.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 22 Jan 2020 10:19:30 +0800
Received: from dggeme763-chm.china.huawei.com ([10.6.66.36]) by
 dggeme763-chm.china.huawei.com ([10.6.66.36]) with mapi id 15.01.1713.004;
 Wed, 22 Jan 2020 10:19:30 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     Andy Lutomirski <luto@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH] KVM: async_pf: drop kvm_arch_async_page_present wrappers
Thread-Topic: [PATCH] KVM: async_pf: drop kvm_arch_async_page_present wrappers
Thread-Index: AdXQyK5K2xdAGSmDSPGt2iVdgeHYwg==
Date:   Wed, 22 Jan 2020 02:19:30 +0000
Message-ID: <5cbb5d89f6254dda8d9d156fa07dfd97@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.221.158]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
Paolo Bonzini <pbonzini@redhat.com> wrote:
>The wrappers make it less clear that the position of the call to kvm_arch_async_page_present depends on the architecture, and that only one of the two call sites will actually be active.
>Remove them.
>
>Cc: Andy Lutomirski <luto@kernel.org>
>Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>---
> virt/kvm/async_pf.c | 21 ++++-----------------
> 1 file changed, 4 insertions(+), 17 deletions(-)
>
>-static inline void kvm_async_page_present_sync(struct kvm_vcpu *vcpu,
>-					       struct kvm_async_pf *work)
>-{
>-#ifdef CONFIG_KVM_ASYNC_PF_SYNC
>-	kvm_arch_async_page_present(vcpu, work);
>-#endif
>-}
>-static inline void kvm_async_page_present_async(struct kvm_vcpu *vcpu,
>-						struct kvm_async_pf *work)
>-{
>-#ifndef CONFIG_KVM_ASYNC_PF_SYNC
>-	kvm_arch_async_page_present(vcpu, work);
>-#endif
>-}
>-

Actually, these two functions took me some minutes to note the difference between them.
I thought they do the same thing and really confused me ... :)

> static struct kmem_cache *async_pf_cache;
> 
> int kvm_async_pf_init(void)
>@@ -80,7 +65,8 @@ static void async_pf_execute(struct work_struct *work)
> 	if (locked)
> 		up_read(&mm->mmap_sem);
> 
>-	kvm_async_page_present_sync(vcpu, apf);
>+	if (IS_ENABLED(CONFIG_KVM_ASYNC_PF_SYNC))
>+		kvm_arch_async_page_present(vcpu, apf);
> 
> 	spin_lock(&vcpu->async_pf.lock);
> 	list_add_tail(&apf->link, &vcpu->async_pf.done); @@ -157,7 +143,8 @@ void kvm_check_async_pf_completion(struct kvm_vcpu *vcpu)
> 		spin_unlock(&vcpu->async_pf.lock);
> 
> 		kvm_arch_async_page_ready(vcpu, work);
>-		kvm_async_page_present_async(vcpu, work);
>+		if (!IS_ENABLED(CONFIG_KVM_ASYNC_PF_SYNC))
>+			kvm_arch_async_page_present(vcpu, work);
> 
> 		list_del(&work->queue);
> 		vcpu->async_pf.queued--;
>--
>1.8.3.1

This patch really helps. Thanks!

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

