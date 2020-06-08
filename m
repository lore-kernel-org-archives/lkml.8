Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B383C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72CCE20774
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591663686;
	bh=/747nDpUrA+HrhPyngwEof3PhSh74KiCISRw9/z8wE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wBU7VLz3QfhGqjdO5beW7eIOLkFydb7Nt4XWmnbFpxlhrFcu/rGe5KnY17CuWO5sv
	 VL37x0e9VrExvIBN2TvntFXlghfo7BN0P6i8uu5fgVnBMMAaFqzuppphffMOni9VvL
	 YYP0JtglzXWPJrN6Rigdd9BubH1ClWSTbyBoVjns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730907AbgFIAsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:48:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728850AbgFHXLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:11:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A53242100A;
        Mon,  8 Jun 2020 23:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657869;
        bh=/747nDpUrA+HrhPyngwEof3PhSh74KiCISRw9/z8wE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qmF7AeJLJF5fHHJNCmoCNi9bwdDc4NcfuhjJxHP6u24Zef4lXnLnkoeGzGvjsaOZ+
         N06r9YHSrqzHn2VRX7A0rist5bCRSUtzRy22iDDe9ZlW1rEFzgRiuHGUegPLck+9+g
         uNn9UR2tGID2/9QwjAInEOIBozm+hptSC1wjfX+0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kaige Li <likaige@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>, linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 230/274] MIPS: tools: Fix resource leak in elf-entry.c
Date:   Mon,  8 Jun 2020 19:05:23 -0400
Message-Id: <20200608230607.3361041-230-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaige Li <likaige@loongson.cn>

[ Upstream commit f33a0b941017b9cb5a4e975af198b855b2f2b455 ]

There is a file descriptor resource leak in elf-entry.c, fix this
by adding fclose() before return and die.

Signed-off-by: Kaige Li <likaige@loongson.cn>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/tools/elf-entry.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/mips/tools/elf-entry.c b/arch/mips/tools/elf-entry.c
index adde79ce7fc0..dbd14ff05b4c 100644
--- a/arch/mips/tools/elf-entry.c
+++ b/arch/mips/tools/elf-entry.c
@@ -51,11 +51,14 @@ int main(int argc, const char *argv[])
 	nread = fread(&hdr, 1, sizeof(hdr), file);
 	if (nread != sizeof(hdr)) {
 		perror("Unable to read input file");
+		fclose(file);
 		return EXIT_FAILURE;
 	}
 
-	if (memcmp(hdr.ehdr32.e_ident, ELFMAG, SELFMAG))
+	if (memcmp(hdr.ehdr32.e_ident, ELFMAG, SELFMAG)) {
+		fclose(file);
 		die("Input is not an ELF\n");
+	}
 
 	switch (hdr.ehdr32.e_ident[EI_CLASS]) {
 	case ELFCLASS32:
@@ -67,6 +70,7 @@ int main(int argc, const char *argv[])
 			entry = be32toh(hdr.ehdr32.e_entry);
 			break;
 		default:
+			fclose(file);
 			die("Invalid ELF encoding\n");
 		}
 
@@ -83,14 +87,17 @@ int main(int argc, const char *argv[])
 			entry = be64toh(hdr.ehdr64.e_entry);
 			break;
 		default:
+			fclose(file);
 			die("Invalid ELF encoding\n");
 		}
 		break;
 
 	default:
+		fclose(file);
 		die("Invalid ELF class\n");
 	}
 
 	printf("0x%016" PRIx64 "\n", entry);
+	fclose(file);
 	return EXIT_SUCCESS;
 }
-- 
2.25.1

