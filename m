Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302C4C47409
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 032CA217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581720213;
	bh=1dUFe/60+iBjueX3vXqk/UGfbi1n4EmSdN70HmJn4Mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cDRmHL+70Tar9Zmlv8QoE+KttMK2681b9rZswmXT28d5uEzePD3tauBsMGcPyi91E
	 m80PEM3ughNNPVsANjAmwCRURKbfQQJH8ofcLXOAY+dHjku04KMMTA8NUmCLXi47Yr
	 rtUWw8pq+PC81D0+YCngngg/RQ3dLzkPcbLwKTPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgBNWnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:43:32 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39717 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbgBNWn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:43:28 -0500
Received: by mail-ot1-f65.google.com with SMTP id 77so10685956oty.6;
        Fri, 14 Feb 2020 14:43:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iJLT9fE31WzVusqA3+ydaNjT/O63JNBeN6ZDzqnRwwg=;
        b=E+wHK0nEB+/YR8RdqqZXD/02AwmJut0mAdBizFI71J00NS2LrLTHjR+R4bRsUOo+8z
         xaDOJy6nmN5xtbgnTMrBfzMFewoYjU3Orx9L0n4rxl6TCrN0KGWm6jTEN81qasIOkUmj
         mxO9qAvsm8jGkehPesF6mnY4tKr7KBWZ1hHy/IkFOpoRwAkTWSIhHoLJCM4UEDrwWUDI
         QeasLNkrf+b9Tqo0KIHxJejrtxIMRXKbz2uW3dFOiGSsq4mLBrlpn/ucBJpcolyyUEpL
         QSw+67YztzBf309I0ZnzFNA0hy7wojbIdsb64OjNzXT8leHPKp5DwUDsNyU06jNMLbPd
         qiNg==
X-Gm-Message-State: APjAAAWZCIRyPfb/tC0hrXIfcKpwbtWugmI9UszYVU565oofuR1hExIb
        mLjswQK5ydv3edrHqnF0yvQ7zvA=
X-Google-Smtp-Source: APXvYqx0xFv4NMz1FqL6vpJxFMFKpg/WkEi3ohp0ZGVbhLQlrLVUpFTQ58w87DSciAPwtsQOj7dTEg==
X-Received: by 2002:a9d:4e93:: with SMTP id v19mr2073700otk.200.1581720207829;
        Fri, 14 Feb 2020 14:43:27 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id m69sm2453167otc.78.2020.02.14.14.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 14:43:27 -0800 (PST)
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
Subject: [PATCH 3/7] powerpc: Drop using struct of_pci_range.pci_space field
Date:   Fri, 14 Feb 2020 16:43:18 -0600
Message-Id: <20200214224322.20030-4-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214224322.20030-1-robh@kernel.org>
References: <20200214224322.20030-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's use the struct of_pci_range.flags field instead so we can remove
the pci_space field.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/powerpc/kernel/pci-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index c6c03416a151..d0074ad73aa3 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -728,7 +728,7 @@ void pci_process_bridge_OF_ranges(struct pci_controller *hose,
 			       " MEM 0x%016llx..0x%016llx -> 0x%016llx %s\n",
 			       range.cpu_addr, range.cpu_addr + range.size - 1,
 			       range.pci_addr,
-			       (range.pci_space & 0x40000000) ?
+			       (range.flags & IORESOURCE_PREFETCH) ?
 			       "Prefetch" : "");
 
 			/* We support only 3 memory ranges */
-- 
2.20.1

