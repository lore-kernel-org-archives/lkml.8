Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51FFC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B85342081E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581720216;
	bh=jYfsD5czgDYDXiyFTMoYHav0ovIOiDlyXvuL1R02Arc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KcyERFAVafn+XjMm4SeK3xl/n2gmNktiTl1VkmnbcmnsxkVPjJJUXliVbby+Hu4EF
	 CDQgLc3Kw0NQvD+z06XABhtWPc/pnzDLi2WYb5n7ADj9yJ5z0I/uCUoET9/j9DBIJl
	 GGmuKvmS815hhccSGCKjQ4oGJBdHBp1TBbH8tRE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgBNWng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:43:36 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46675 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgBNWna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:43:30 -0500
Received: by mail-ot1-f65.google.com with SMTP id g64so10656712otb.13;
        Fri, 14 Feb 2020 14:43:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AyyJC538Y/y34o2rpyNkr6k8LEp+yP8uKUpD7OCEln0=;
        b=l/BybSQ2gZfpWFA4sI87+S9+phBcyTL7g3NvICVKVYKMR4ZFOl4B93nKgC3hoq1A9L
         cNcjt34ovaOwnuCKZRl4BkYTFpVziJkNR9+rURc1OC6nlgm0eToWCazMFFGrp2lOrlDl
         /o8fxXA+q9gESPJ33N4A5G4k9RCVzttRlCohgF4Iavo8MvmI3hlUtB7UlndyfZmJ84dM
         sgG4CVwoQIfBTi6blZtbhbbN3HqN8wL/L+u0JjkhXrdN+CBznTCR0dva8wJo1or9TFTD
         QzJRy9prf/rQgJrTWo1zS7mwwbqiVEbb0FSLhW/Xn57Xbmi48j4SmKJsZsTwQ2YY8oU0
         aLYA==
X-Gm-Message-State: APjAAAXDtAEJeT5LvR80jUI6Kqa/4LfXFD09nMB4fNLucrYdQxDzjxrf
        NgfodtNWMqwj1CX1hcBy5pscAak=
X-Google-Smtp-Source: APXvYqx8MMsvAf68sW+GAmZMr1gg/xcRTWMRudRem8bnJp5yjH/sXdGdXEh5dgpekBos7HCRRi6xyw==
X-Received: by 2002:a9d:6452:: with SMTP id m18mr3956084otl.366.1581720208923;
        Fri, 14 Feb 2020 14:43:28 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id m69sm2453167otc.78.2020.02.14.14.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 14:43:28 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH 4/7] of: Drop struct of_pci_range.pci_space field
Date:   Fri, 14 Feb 2020 16:43:19 -0600
Message-Id: <20200214224322.20030-5-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214224322.20030-1-robh@kernel.org>
References: <20200214224322.20030-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no more users of struct of_pci_range.pci_space field, so remove it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/address.c       | 1 -
 include/linux/of_address.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 846045a48395..5d608d7c10d6 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -736,7 +736,6 @@ struct of_pci_range *of_pci_range_parser_one(struct of_pci_range_parser *parser,
 	if (!parser->range || parser->range + parser->np > parser->end)
 		return NULL;
 
-	range->pci_space = be32_to_cpup(parser->range);
 	range->flags = of_bus_pci_get_flags(parser->range);
 	range->pci_addr = of_read_number(parser->range + 1, ns);
 	if (parser->dma)
diff --git a/include/linux/of_address.h b/include/linux/of_address.h
index eac7ab109df4..8d12bf18e80b 100644
--- a/include/linux/of_address.h
+++ b/include/linux/of_address.h
@@ -16,7 +16,6 @@ struct of_pci_range_parser {
 };
 
 struct of_pci_range {
-	u32 pci_space;
 	u64 pci_addr;
 	u64 cpu_addr;
 	u64 size;
-- 
2.20.1

