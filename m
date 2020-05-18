Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840F4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D3DD207C4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824430;
	bh=zQA/tFV6SfYFifM48UZ7M06d8prsKGA7ypufzYqTwYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HBzSFqRSkY2jFcygTWP3LaNbuNOAsAJMFEtT06YLnbfNmw8Uqc+bj/FE2bWKLgKV7
	 Qy95jbUlAunDOtNewK4CY9W+npJDd9ZoKw9iMYGbYYbNnf0YzlID5z81hc0j9/MNYp
	 glM6E1ogJshwwNsqD3TqYUBPn0ha3/d90DEoe6Jw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbgERRxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:53:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729133AbgERRxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:53:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6F9F20674;
        Mon, 18 May 2020 17:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824425;
        bh=zQA/tFV6SfYFifM48UZ7M06d8prsKGA7ypufzYqTwYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PH9MbVym0oSaZb0vWEjnVrmMAr46aSGUXLK7vho+HHLEt3TgbpXlXrhq0h8VxMr2c
         kXOpRJoLF8Z/IKv/SUW4r1J8DgbgUAoTGLdCt045uyMWTwIAEMJsdcpRgFk6ovxt44
         1OmSzlbKNKUkJgL3ZrBwNe5qucjiFlUYRbwzGvxM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 72/80] Revert "ALSA: hda/realtek: Fix pop noise on ALC225"
Date:   Mon, 18 May 2020 19:37:30 +0200
Message-Id: <20200518173504.957078186@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.097837707@linuxfoundation.org>
References: <20200518173450.097837707@linuxfoundation.org>
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
@@ -7827,8 +7827,6 @@ static int patch_alc269(struct hda_codec
 		spec->gen.mixer_nid = 0;
 		break;
 	case 0x10ec0225:
-		codec->power_save_node = 1;
-		/* fall through */
 	case 0x10ec0295:
 	case 0x10ec0299:
 		spec->codec_variant = ALC269_TYPE_ALC225;


