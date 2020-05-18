Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD54C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0509720657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589823699;
	bh=UIQl4ZAy4jFJTOLmHnIAuqkH2BFyqX2EZtLhTK5Fetk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WzQf8nTwCP8Ha5CJYQzAx8R/xmYfa8my6V+K8I/hbzndhRXpxuYW3t6ObJ9+FDQ0f
	 nR6KVH8AGmoYrPtRDywRUMQPL67j7fHrNg2vGtXDRxUg7Hl8VY2yad62eq2Lt+FobV
	 hDIfFWCwuiv0i3bcUbqCfUBPODUKu46fu0I+9qYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgERRlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:41:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729258AbgERRlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:41:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 170142083E;
        Mon, 18 May 2020 17:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823692;
        bh=UIQl4ZAy4jFJTOLmHnIAuqkH2BFyqX2EZtLhTK5Fetk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vJ0gkOs012t/BQuaBuBv60xAA7B1uIcpGh7eetNmnKmGwWLrLtzvvH/XEXN+nmTM9
         GtMKoioIDKaKJCVB2XTpuZ0jGmEYdqHGkvivcFkG4st2vblyKnkOdVwCv16QhbbySv
         0MZfAYRy7+a/zojEMZz44//kI7Zw2xUW2ObJMH+4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 83/86] Revert "ALSA: hda/realtek: Fix pop noise on ALC225"
Date:   Mon, 18 May 2020 19:36:54 +0200
Message-Id: <20200518173507.372872681@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.254571947@linuxfoundation.org>
References: <20200518173450.254571947@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit f41224efcf8aafe80ea47ac870c5e32f3209ffc8 upstream.

This reverts commit 3b36b13d5e69d6f51ff1c55d1b404a74646c9757.

Enable power save node breaks some systems with ACL225. Revert the patch
and use a platform specific quirk for the original issue isntead.

Fixes: 3b36b13d5e69 ("ALSA: hda/realtek: Fix pop noise on ALC225")
BugLink: https://bugs.launchpad.net/bugs/1875916
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Link: https://lore.kernel.org/r/20200503152449.22761-1-kai.heng.feng@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    2 --
 1 file changed, 2 deletions(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6341,8 +6341,6 @@ static int patch_alc269(struct hda_codec
 		alc_update_coef_idx(codec, 0x36, 1 << 13, 1 << 5); /* Switch pcbeep path to Line in path*/
 		break;
 	case 0x10ec0225:
-		codec->power_save_node = 1;
-		/* fall through */
 	case 0x10ec0295:
 	case 0x10ec0299:
 		spec->codec_variant = ALC269_TYPE_ALC225;


