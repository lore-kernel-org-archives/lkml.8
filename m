Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9824C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 740CC20772
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 13:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594302261;
	bh=v6Vn1YgNxBgfgcIxWirvzy4yRH6zVpQpKkve958MzHg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=sXDLT+VcwfFl3sjgEpoKbRGT+3P+GFRnlDHOHhBEludwrH6lqyWTNM23mug3yyAjd
	 0XhZGPmoFQ2bE23iRltcSXqv7Tl57u0bfUEMKL/VIGwBVxEXfs1yv/4lEnQ1MAf2dE
	 wA63JTEXoEld3FAVu/OtUL1fPAzCDuh5SefxFeWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgGINoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:44:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbgGINoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 09:44:19 -0400
Received: from hump.s81c.com (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B524D20772;
        Thu,  9 Jul 2020 13:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594302258;
        bh=v6Vn1YgNxBgfgcIxWirvzy4yRH6zVpQpKkve958MzHg=;
        h=From:To:Cc:Subject:Date:From;
        b=lMjqciFNM1a9a8XnYPdfLoueKSxMVUUC04xe4cfAyGXumRmM6Jtyvobso2Qakeuwj
         sIBHMI9VZIZgtHqb9wOAov5RLIq1Uaq8+D3D6esAvdXjKms88zyMXvasGLfDo4XMAb
         U8RBe2jWwmIDfdzAvZCLYWce/w9R6DPhHMJw9q1g=
From:   Mike Rapoport <rppt@kernel.org>
To:     Vineet Gupta <vgupta@synopsys.com>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Mike Rapoport <rppt@kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [RFC/RFT PATCH v2 0/1] arc: add sparsemem support
Date:   Thu,  9 Jul 2020 16:44:11 +0300
Message-Id: <20200709134412.1464453-1-rppt@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

It took me a while to get back to it, but better late than never :)

This patch adds SPARSEMEM support as an alternative to DISCONTIGMEM in
the case when there are two DRAM banks populated.

I've verified that it boots on nsim, but I could not find a way to make
nsim emulate two memory banks.

There is slight improvement in the resulting kernel size for
nsim_700_defconfig with CONFIG_HIGHMEM=y.

If sparse actually works on a system with 2 DRAM banks and does not
introduce performance regression, I suggest to update this patch to
replace DISCONTIGMEM with SPARSEMEM on arc.

$ size discontig/vmlinux  sparse/vmlinux 
   text	   data	    bss	    dec	    hex	filename
3894379	1093092	 244932	5232403	 4fd713	discontig/vmlinux
3879040	1093964	 244956	5217960	 4f9ea8	sparse/vmlinux

$ ./scripts/bloat-o-meter ~/tmp/arc/discontig/vmlinux  ~/tmp/arc/sparse/vmlinux 
add/remove: 35/23 grow/shrink: 35/384 up/down: 8110/-26438 (-18328)
...
Total: Before=4282217, After=4263889, chg -0.43%


Mike Rapoport (1):
  arc: add sparsemem support

 arch/arc/Kconfig                 | 10 ++++++++++
 arch/arc/include/asm/sparsemem.h | 13 +++++++++++++
 arch/arc/mm/init.c               |  7 ++++++-
 3 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100644 arch/arc/include/asm/sparsemem.h

-- 
2.26.2

