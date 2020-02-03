Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D40C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97652086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747342;
	bh=TRgddOces3KCcjZiCU9InaohUeoG1Yx/UpbqoCBwJ7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dsFHp4OOFCONsAjZUfvZe4AGA4dnm/AIPyMnRkllfPK4BUBhR2EOHTpO8zj3EKs+A
	 +cy0XZRCb06rbvGs4FGrc3akUKjc8JCjRQaAmBb+7qHbcEEhhonO9QoVqbtsP55Lzr
	 iGMbMn9763/lk5U+3zem1IQLoMH/0akWelXTYvfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbgBCQ3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:29:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:40742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729662AbgBCQ25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:28:57 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5DD520838;
        Mon,  3 Feb 2020 16:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747337;
        bh=TRgddOces3KCcjZiCU9InaohUeoG1Yx/UpbqoCBwJ7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GZRNIof7dl7l2+FEag/cBIyUcAVh+C4jJUdTMsXZ3pBplPH6lftN21fNXTSHu0OgY
         y32mh+aJxCLwCqrdEDuIj2RtWDF8g9KWllZncxs4UrY+URrCoqfuH3scJtVSo5PuS9
         7rU8lFRFU2KXeNvqWXZx6f5ZuHAs/CvR3WlArabg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dirk Behme <dirk.behme@de.bosch.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 4.14 41/89] arm64: kbuild: remove compressed images on make ARCH=arm64 (dist)clean
Date:   Mon,  3 Feb 2020 16:19:26 +0000
Message-Id: <20200203161922.483714935@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161916.847439465@linuxfoundation.org>
References: <20200203161916.847439465@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dirk Behme <dirk.behme@de.bosch.com>

commit d7bbd6c1b01cb5dd13c245d4586a83145c1d5f52 upstream.

Since v4.3-rc1 commit 0723c05fb75e44 ("arm64: enable more compressed
Image formats"), it is possible to build Image.{bz2,lz4,lzma,lzo}
AArch64 images. However, the commit missed adding support for removing
those images on 'make ARCH=arm64 (dist)clean'.

Fix this by adding them to the target list.
Make sure to match the order of the recipes in the makefile.

Cc: stable@vger.kernel.org # v4.3+
Fixes: 0723c05fb75e44 ("arm64: enable more compressed Image formats")
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/Makefile
+++ b/arch/arm64/boot/Makefile
@@ -16,7 +16,7 @@
 
 OBJCOPYFLAGS_Image :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
 
-targets := Image Image.gz
+targets := Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo
 
 $(obj)/Image: vmlinux FORCE
 	$(call if_changed,objcopy)


