Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03D0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 896832075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597882422;
	bh=P4hYlXuCrt4vYT4MbhM81oT38igvQ0iujDFHaqGZrHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eiR9TwksoA7VJDZR9Iow+25sbICTj+seqjSXoqS2EDdbEQ+ec20Lk5UBa60FhcnTU
	 brhmqGK6esmoPQ+7v/Rq4jKg3jqJLW33UL54crYlJPSoxR1kZ+z6A0VH3oHgFGERB+
	 /jzg7+im4PamfPN7Nk23LKVE8I6u0aYBc+BLgwPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgHTANj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 20:13:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbgHTABc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 20:01:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3B27214F1;
        Thu, 20 Aug 2020 00:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597881690;
        bh=P4hYlXuCrt4vYT4MbhM81oT38igvQ0iujDFHaqGZrHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MKdA8v/kKzhE6IDrQH0+pQ5G8sc2JpNobgDHhGowmqP02QKgw5X05cW4/r98mw7w6
         sRZEjG09FtH2yQ59Olqd8V80mfbfW1mYrk6+ISR9L7F1JC+PjdRYrzHRwzOTY8cyQX
         oAU7XWgEdwtkH9itlMLuN0eGNZ/jeJumXfPPGhqg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jinyang He <hejinyang@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>, linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 10/27] MIPS: Fix unable to reserve memory for Crash kernel
Date:   Wed, 19 Aug 2020 20:00:59 -0400
Message-Id: <20200820000116.214821-10-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820000116.214821-1-sashal@kernel.org>
References: <20200820000116.214821-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jinyang He <hejinyang@loongson.cn>

[ Upstream commit b1ce9716f3b5ed3b49badf1f003b9e34b7ead0f9 ]

Use 0 as the align parameter in memblock_find_in_range() is
incorrect when we reserve memory for Crash kernel.

The environment as follows:
[    0.000000] MIPS: machine is loongson,loongson64c-4core-rs780e
...
[    1.951016]     crashkernel=64M@128M

The warning as follows:
[    0.000000] Invalid memory region reserved for crash kernel

And the iomem as follows:
00200000-0effffff : System RAM
  04000000-0484009f : Kernel code
  048400a0-04ad7fff : Kernel data
  04b40000-05c4c6bf : Kernel bss
1a000000-1bffffff : pci@1a000000
...

The align parameter may be finally used by round_down() or round_up().
Like the following call tree:

mips-next: mm/memblock.c

memblock_find_in_range
└── memblock_find_in_range_node
    ├── __memblock_find_range_bottom_up
    │   └── round_up
    └── __memblock_find_range_top_down
        └── round_down
\#define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
\#define round_down(x, y) ((x) & ~__round_mask(x, y))
\#define __round_mask(x, y) ((__typeof__(x))((y)-1))

The round_down(or round_up)'s second parameter must be a power of 2.
If the second parameter is 0, it both will return 0.

Use 1 as the parameter to fix the bug and the iomem as follows:
00200000-0effffff : System RAM
  04000000-0484009f : Kernel code
  048400a0-04ad7fff : Kernel data
  04b40000-05c4c6bf : Kernel bss
  08000000-0bffffff : Crash kernel
1a000000-1bffffff : pci@1a000000
...

Signed-off-by: Jinyang He <hejinyang@loongson.cn>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 7b537fa2035df..588b21245e00b 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -497,7 +497,7 @@ static void __init mips_parse_crashkernel(void)
 	if (ret != 0 || crash_size <= 0)
 		return;
 
-	if (!memblock_find_in_range(crash_base, crash_base + crash_size, crash_size, 0)) {
+	if (!memblock_find_in_range(crash_base, crash_base + crash_size, crash_size, 1)) {
 		pr_warn("Invalid memory region reserved for crash kernel\n");
 		return;
 	}
-- 
2.25.1

