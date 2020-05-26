Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9CAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CCB5208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519781;
	bh=zLWuKfdOMv5Vm2wkPGbl40+ScNFyWiRzHsIAtytfIco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iE+PImxJI01vBurrowItOadKgDoc59rMVGQS/lwntvloxryIopwHJoCYuQ3Yw239T
	 i+LpIbL7CUoyxkSXYbMFtTZp1KbRY8HEBwQa+UgGwLePI5BKV1aigoo74lwhK2rFbp
	 ZLFf2BVnZEWcoWnaYdiiBLDAX2IijK5e3gXzTysM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403845AbgEZTDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:03:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:57954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403842AbgEZTCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:02:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD68D208A7;
        Tue, 26 May 2020 19:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519774;
        bh=zLWuKfdOMv5Vm2wkPGbl40+ScNFyWiRzHsIAtytfIco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mlf5DkK9G/uIOPUCiI2kjx0jOOlzwCAtP1HTv3Rb1TbSAnZ368ieycgzZ1rXaDoEr
         oGz+yaAdlUrjvuU2k/nF9GJqAhvubl0/dBE36bvQYslJ5+1GIMCy4nndQJB0yPurIR
         mfo4TFJRC+jnPY1Eh2iK1s90EAxvZLyUl1Q6CUiU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liran Alon <liran.alon@oracle.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.19 04/81] KVM: SVM: Fix potential memory leak in svm_cpu_init()
Date:   Tue, 26 May 2020 20:52:39 +0200
Message-Id: <20200526183924.272896961@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183923.108515292@linuxfoundation.org>
References: <20200526183923.108515292@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

commit d80b64ff297e40c2b6f7d7abc1b3eba70d22a068 upstream.

When kmalloc memory for sd->sev_vmcbs failed, we forget to free the page
held by sd->save_area. Also get rid of the var r as '-ENOMEM' is actually
the only possible outcome here.

Reviewed-by: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/svm.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -998,33 +998,32 @@ static void svm_cpu_uninit(int cpu)
 static int svm_cpu_init(int cpu)
 {
 	struct svm_cpu_data *sd;
-	int r;
 
 	sd = kzalloc(sizeof(struct svm_cpu_data), GFP_KERNEL);
 	if (!sd)
 		return -ENOMEM;
 	sd->cpu = cpu;
-	r = -ENOMEM;
 	sd->save_area = alloc_page(GFP_KERNEL);
 	if (!sd->save_area)
-		goto err_1;
+		goto free_cpu_data;
 
 	if (svm_sev_enabled()) {
-		r = -ENOMEM;
 		sd->sev_vmcbs = kmalloc_array(max_sev_asid + 1,
 					      sizeof(void *),
 					      GFP_KERNEL);
 		if (!sd->sev_vmcbs)
-			goto err_1;
+			goto free_save_area;
 	}
 
 	per_cpu(svm_data, cpu) = sd;
 
 	return 0;
 
-err_1:
+free_save_area:
+	__free_page(sd->save_area);
+free_cpu_data:
 	kfree(sd);
-	return r;
+	return -ENOMEM;
 
 }
 


