Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBA1C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECF320870
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585056400;
	bh=jBlR8myRFQ2UDNN474Qc1xJlIKXcLOzYLEnNwH4qlHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EvYQqp2HaZSIukC1UAWPvKv2wPEzmOfQAamVPBNiKHJbkDruiGUt4gjFzh0OV1LK3
	 jdT/0yufiayoKTC6XwAxo20tDobyrJ/yvDw0ockk1e3dwIFkqzwNQmyNnSW0skStaw
	 OnX/eh/ISEhafKNBRpaNCxe58oGBGg3/A/jspbxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbgCXN0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:26:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729112AbgCXN0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:26:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49D7A208CA;
        Tue, 24 Mar 2020 13:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585056396;
        bh=jBlR8myRFQ2UDNN474Qc1xJlIKXcLOzYLEnNwH4qlHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sD1NWfPuvCoGJ7nv6LhV0dfe6kpPU89Nb+AfHruGU6Y4AUHzk8ayZAQHtXlvIMpKY
         REsksocnzuJrdi2gA2nPdMVOfXAtLxXXI+//2/7+EfsEg3gmkAYIiz+AyGX2ugxKxY
         XfthPkonboJIWZ7M3mVcR8VYidTi9ytoqKtiuwlQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.5 105/119] ALSA: hda/realtek: Fix pop noise on ALC225
Date:   Tue, 24 Mar 2020 14:11:30 +0100
Message-Id: <20200324130818.433688051@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130808.041360967@linuxfoundation.org>
References: <20200324130808.041360967@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit 3b36b13d5e69d6f51ff1c55d1b404a74646c9757 upstream.

Commit 317d9313925c ("ALSA: hda/realtek - Set default power save node to
0") makes the ALC225 have pop noise on S3 resume and cold boot.

So partially revert this commit for ALC225 to fix the regression.

Fixes: 317d9313925c ("ALSA: hda/realtek - Set default power save node to 0")
BugLink: https://bugs.launchpad.net/bugs/1866357
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Link: https://lore.kernel.org/r/20200311061328.17614-1-kai.heng.feng@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8051,6 +8051,8 @@ static int patch_alc269(struct hda_codec
 		spec->gen.mixer_nid = 0;
 		break;
 	case 0x10ec0225:
+		codec->power_save_node = 1;
+		/* fall through */
 	case 0x10ec0295:
 	case 0x10ec0299:
 		spec->codec_variant = ALC269_TYPE_ALC225;


