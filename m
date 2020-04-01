Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1DBC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7909420772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758980;
	bh=LFojRfP+Ryk/Ggz7Q1TEtogALZDvsONa+izl2jHtNXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a90OgITUkbLNo3Uce4SHS6fS+glOJXGi3JAl/ILNgEMQmLdNu9dWFuW8gt/k3pBzK
	 xRlVB07OY+VL2L+knZgdd6DKkgUtHC1WjedtpLPm7T26w1BQMz9maLRj1NPUpKflh5
	 9+bk507wklK1wotQ5wXz6FwZ28a2VxbBXFaxA9O0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388835AbgDAQgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:36:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387983AbgDAQgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:36:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CE0D20857;
        Wed,  1 Apr 2020 16:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758967;
        bh=LFojRfP+Ryk/Ggz7Q1TEtogALZDvsONa+izl2jHtNXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wrg0y1zgHSef1K8ImiOuQ9PsFA2oxhs6mYQlYT0ZSqfFef1ugm7e6DQMhvTirlkmL
         H9jC9SOIxcU62/THysMeY+/W2JEinW193SvKCkxzYhg9hm9povmy15otcNKdVMnVhm
         Jztx3OeK+Jv/uI2FcWi5RlsCJLdLnQ/QfSotzFjE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 033/102] ALSA: hda/realtek: Fix pop noise on ALC225
Date:   Wed,  1 Apr 2020 18:17:36 +0200
Message-Id: <20200401161539.129583761@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161530.451355388@linuxfoundation.org>
References: <20200401161530.451355388@linuxfoundation.org>
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
@@ -4212,6 +4212,8 @@ static void alc_determine_headset_type(s
 		is_ctia = (val & 0x1c02) == 0x1c02;
 		break;
 	case 0x10ec0225:
+		codec->power_save_node = 1;
+		/* fall through */
 	case 0x10ec0295:
 	case 0x10ec0299:
 		alc_process_coef_fw(codec, coef0225);


