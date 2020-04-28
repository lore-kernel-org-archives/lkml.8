Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49E2C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F190206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588100133;
	bh=+YyOS4rZ6yyGaR/yktSF9m7AWnmg8UoouChpex/Yoy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ch5Q/VTUF02TtduRgid9HiFuYAz89wIZkIZsszK4TqJFIjlCd6rmceLi1fKdiADQi
	 Mqd5bXpNGD4bxDuDl6F9FQ/eM6jcqmlh660YfZrbTSUmNxKymEE8D44t9xz+OCMt/t
	 KAeVNzik0Td1J0geBOksYH/5EXmtrEKnxvpwkjew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbgD1Sc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:32:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729801AbgD1ScV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:32:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8C31217D8;
        Tue, 28 Apr 2020 18:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098741;
        bh=+YyOS4rZ6yyGaR/yktSF9m7AWnmg8UoouChpex/Yoy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A+a/yDW45OghjHe3M7ZNp7o9BiwvOiWwto8VPvUsbSf6tgwIqCSiuH5vndT11GDKK
         /X1+3mfdHvK0V3z5oRHHtpOlMjopZPfaLY9qVPyhIlkbIlLSic6mVaE2drVhaWdhvf
         2hyC6GOnHaQdfRzUptuzLsYIe3PS0xNoSNwW7yaI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, KarimAllah Ahmed <karahmed@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 048/131] KVM: Properly check if "page" is valid in kvm_vcpu_unmap
Date:   Tue, 28 Apr 2020 20:24:20 +0200
Message-Id: <20200428182231.061902118@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182224.822179290@linuxfoundation.org>
References: <20200428182224.822179290@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KarimAllah Ahmed <karahmed@amazon.de>

commit b614c6027896ff9ad6757122e84760d938cab15e upstream.

The field "page" is initialized to KVM_UNMAPPED_PAGE when it is not used
(i.e. when the memory lives outside kernel control). So this check will
always end up using kunmap even for memremap regions.

Fixes: e45adf665a53 ("KVM: Introduce a new guest mapping API")
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 virt/kvm/kvm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 5b949aa273de5..33b288469c70c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1754,7 +1754,7 @@ void kvm_vcpu_unmap(struct kvm_vcpu *vcpu, struct kvm_host_map *map,
 	if (!map->hva)
 		return;
 
-	if (map->page)
+	if (map->page != KVM_UNMAPPED_PAGE)
 		kunmap(map->page);
 #ifdef CONFIG_HAS_IOMEM
 	else
-- 
2.20.1



