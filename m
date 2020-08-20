Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA44FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A77472054F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597923694;
	bh=BbVjOawr2HPM457F4RYi76yZJrjyaGdSN/XIGqZ/k9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hIvM5aJGAJjnd/PAL/a55H17ll4xxRuUr2vJvToXuS7ZzfxolOrQCrxCeGi6M/IqS
	 bhTtSWNf2MSUIGBLo3rnWZj6cPXtPAdKKdb4uuGCkSGqt/3I6ijalyq0wbOVOFgnid
	 F5KGaDselIciYG5X4x4c/jvW+lw2LgzK8pueU5+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbgHTLlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:41:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730442AbgHTKEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:04:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D255E2067C;
        Thu, 20 Aug 2020 10:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917884;
        bh=BbVjOawr2HPM457F4RYi76yZJrjyaGdSN/XIGqZ/k9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ftxsyRhsE8kLqaXpglMDwPfmzWtaztkhf5wpG71Vof7BederQ+XvpHqNpLS7GcBlg
         pw5rG6RxT/OlhwNEceNH727zYNOnGX0gNkzuJApwPT1AQkx9G35wLuqjAcRYiBB3Xc
         kmobdBAjmwFdP4+LPm93urtbDNbaLQPA3xXINn1I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anton Blanchard <anton@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 191/212] pseries: Fix 64 bit logical memory block panic
Date:   Thu, 20 Aug 2020 11:22:44 +0200
Message-Id: <20200820091612.029523410@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anton Blanchard <anton@ozlabs.org>

commit 89c140bbaeee7a55ed0360a88f294ead2b95201b upstream.

Booting with a 4GB LMB size causes us to panic:

  qemu-system-ppc64: OS terminated: OS panic:
      Memory block size not suitable: 0x0

Fix pseries_memory_block_size() to handle 64 bit LMBs.

Cc: stable@vger.kernel.org
Signed-off-by: Anton Blanchard <anton@ozlabs.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200715000820.1255764-1-anton@ozlabs.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/pseries/hotplug-memory.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -29,7 +29,7 @@ static bool rtas_hp_event;
 unsigned long pseries_memory_block_size(void)
 {
 	struct device_node *np;
-	unsigned int memblock_size = MIN_MEMORY_BLOCK_SIZE;
+	u64 memblock_size = MIN_MEMORY_BLOCK_SIZE;
 	struct resource r;
 
 	np = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");


