Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A2AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C12D24683
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579685907;
	bh=0uAs/JgDdMToNLZ1f9xVmDOb3m1ZaiXy12qiW+AgroA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZNOLODSh4ADv116Ha7NSN+ehX1QK8MFN3EYYDiHONolq+1y4iIjPDwLuVlYk50I4f
	 wY1ZUuX1RTT50ZpAhCUTZ2uVkba+wxEnZeVwihh/ns07RlR5p3p5KXybm99jtMz3kM
	 +gE1CNlJgiubZ2KfHqaY2AvdzZWnrhvUSOd9yGxU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732975AbgAVJi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:38:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:55120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732959AbgAVJiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:38:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DD852467E;
        Wed, 22 Jan 2020 09:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685902;
        bh=0uAs/JgDdMToNLZ1f9xVmDOb3m1ZaiXy12qiW+AgroA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2ZIOg/1qzGjp6domUUrVp5bcZZVng7yYEv61/BjGQ4uHM/lkAVZZWVnMOWdik2J4J
         xLkdWvKOWc8yMmf1xTLhiCfwMyI6ZJGyTWoEDGB47YV88uB7QmUBZrquxetou0zPjS
         qDSX3jFGO+no0OTxlmzJWt+TcKV8t7fM2I+BZgUc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jari Ruusu <jari.ruusu@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>, stable@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 05/65] Fix built-in early-load Intel microcode alignment
Date:   Wed, 22 Jan 2020 10:28:50 +0100
Message-Id: <20200122092752.187381188@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092750.976732974@linuxfoundation.org>
References: <20200122092750.976732974@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jari Ruusu <jari.ruusu@gmail.com>

commit f5ae2ea6347a308cfe91f53b53682ce635497d0d upstream.

Intel Software Developer's Manual, volume 3, chapter 9.11.6 says:

 "Note that the microcode update must be aligned on a 16-byte boundary
  and the size of the microcode update must be 1-KByte granular"

When early-load Intel microcode is loaded from initramfs, userspace tool
'iucode_tool' has already 16-byte aligned those microcode bits in that
initramfs image.  Image that was created something like this:

 iucode_tool --write-earlyfw=FOO.cpio microcode-files...

However, when early-load Intel microcode is loaded from built-in
firmware BLOB using CONFIG_EXTRA_FIRMWARE= kernel config option, that
16-byte alignment is not guaranteed.

Fix this by forcing all built-in firmware BLOBs to 16-byte alignment.

[ If we end up having other firmware with much bigger alignment
  requirements, we might need to introduce some method for the firmware
  to specify it, this is the minimal "just increase the alignment a bit
  to account for this one special case" patch    - Linus ]

Signed-off-by: Jari Ruusu <jari.ruusu@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: stable@kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 firmware/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/firmware/Makefile
+++ b/firmware/Makefile
@@ -19,7 +19,7 @@ quiet_cmd_fwbin = MK_FW   $@
 		  PROGBITS=$(if $(CONFIG_ARM),%,@)progbits;		     \
 		  echo "/* Generated by firmware/Makefile */"		> $@;\
 		  echo "    .section .rodata"				>>$@;\
-		  echo "    .p2align $${ASM_ALIGN}"			>>$@;\
+		  echo "    .p2align 4"					>>$@;\
 		  echo "_fw_$${FWSTR}_bin:"				>>$@;\
 		  echo "    .incbin \"$(2)\""				>>$@;\
 		  echo "_fw_end:"					>>$@;\


