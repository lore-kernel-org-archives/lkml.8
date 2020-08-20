Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40B8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A28B020724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597932695;
	bh=6Ph9bjp28ZJvGhNXbLdFvK04Ec5xSbH1QX9g4Ch7iaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U4SK+nJIiS8gA3RQiqO+i+YcE17WsxHHXQJv9JEYwvPEVBXT7FDbce5KFv9NMrc12
	 R36Xbla+ABCqixNh+NU2WAF3/pdplLurCnnI+YXTft/+Pj0GcW7DuFh2AV7k7SaOtT
	 A9OiN3MIB2tN5l43wAKSomlKR9fLEUeda8jI0ewg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbgHTNyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:54:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727929AbgHTJ0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:26:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DD5822D04;
        Thu, 20 Aug 2020 09:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915607;
        bh=6Ph9bjp28ZJvGhNXbLdFvK04Ec5xSbH1QX9g4Ch7iaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YAOlR8l2asklr49WHkOpiIiDsLgUtAtDIcKSW34tRdZnjPT0DuuAb8ZJdQzcqse3e
         KV1uK8ukdsVm6XoIBr+3J32ndHl/kNIX26ertlUpfVn/SgkVJZIbWamlH1lS1J7Qkt
         J9CNgS1Njl+0jmF+DSba/1t4Kj2mPGZnUTZY3Nd8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [PATCH 5.8 073/232] MIPS: CPU#0 is not hotpluggable
Date:   Thu, 20 Aug 2020 11:18:44 +0200
Message-Id: <20200820091616.342176412@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huacai Chen <chenhc@lemote.com>

commit 9cce844abf07b683cff5f0273977d5f8d0af94c7 upstream.

Now CPU#0 is not hotpluggable on MIPS, so prevent to create /sys/devices
/system/cpu/cpu0/online which confuses some user-space tools.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/topology.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/kernel/topology.c
+++ b/arch/mips/kernel/topology.c
@@ -20,7 +20,7 @@ static int __init topology_init(void)
 	for_each_present_cpu(i) {
 		struct cpu *c = &per_cpu(cpu_devices, i);
 
-		c->hotpluggable = 1;
+		c->hotpluggable = !!i;
 		ret = register_cpu(c, i);
 		if (ret)
 			printk(KERN_WARNING "topology_init: register_cpu %d "


