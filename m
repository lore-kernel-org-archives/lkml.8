Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8A5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0224F24680
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686160;
	bh=0uAs/JgDdMToNLZ1f9xVmDOb3m1ZaiXy12qiW+AgroA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cpPF62TIq9YhUAKd64bFvtWihfHLcDEiKQ3YY9uPcIJ8urKa/zINhyw7cGRtjAmXo
	 Dz79mJPC+T8OGxSysZaL5rMEyGqPIfLfnheRlqQ8quggAsweUjiRTpUbvm5xa5uDvo
	 9CoLmQGLsEE3DgKR3LJ8rXHaJ0ncWYRctqY6NFU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387595AbgAVJmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:42:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:34340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387720AbgAVJm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:42:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A34A824680;
        Wed, 22 Jan 2020 09:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579686148;
        bh=0uAs/JgDdMToNLZ1f9xVmDOb3m1ZaiXy12qiW+AgroA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YtdxkANc9HMwbWzMhYyCou0Bnv0WyWpe2GVlVgBXs6lA0h81zfTvIxL3Ag3VxFDnZ
         XfgrDMmBT8IxVmA7Skvkb6Y6yEAefPXR3ftNdgZCwIlSGe13KJHdf5PAhS1uNj6q6G
         J+YFQBqYaX6r8q00DPEAiay//yjxz1T1XmTatZ1Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jari Ruusu <jari.ruusu@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>, stable@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 027/103] Fix built-in early-load Intel microcode alignment
Date:   Wed, 22 Jan 2020 10:28:43 +0100
Message-Id: <20200122092807.905046027@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092803.587683021@linuxfoundation.org>
References: <20200122092803.587683021@linuxfoundation.org>
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


