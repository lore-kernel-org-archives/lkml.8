Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA188C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964B624676
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996509;
	bh=VspWGomgS76X8lVDq+qOmUYynAz+7FxKT9rWHeesm6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RhuFNDL2Zc7g5HWHmo6iZZRn4+4N8lA2W8oUdC/8uLrw/xMDkSX667bTib5gzbXDM
	 s/Nt1Guf6f1T3yUWiz2t1/mFTV/74Yh6fcxqVWocPVfF67ZBYV2lr2Y7AtfBMiglxz
	 +bhwSxYq28vySC0mJIjD17VwgrPpqinFeavBdvu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbgANKI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:08:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:39818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729094AbgANKI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:08:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CF5020678;
        Tue, 14 Jan 2020 10:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996505;
        bh=VspWGomgS76X8lVDq+qOmUYynAz+7FxKT9rWHeesm6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qUdDob/WxkY6lIZtopiJORpG+f5KnjZYFBFsF6wjcadzU39fhQOKTdpTdNAAeJWTJ
         jpBMBJMwxyBwonZGK+dcXygFrJEcWcFjJ5tjc9k33gUo9sNSFN93LllW65ZR4H+SuR
         pS3BKG0rI08OOmjVD6Cs4P4DdaSlpyToKbrpC5Bo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 06/46] ALSA: hda/realtek - Set EAPD control to default for ALC222
Date:   Tue, 14 Jan 2020 11:01:23 +0100
Message-Id: <20200114094341.708820909@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094339.608068818@linuxfoundation.org>
References: <20200114094339.608068818@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kailang Yang <kailang@realtek.com>

commit 9194a1ebbc56d7006835e2b4cacad301201fb832 upstream.

Set EAPD control to verb control.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -424,6 +424,7 @@ static void alc_fill_eapd_coef(struct hd
 	case 0x10ec0672:
 		alc_update_coef_idx(codec, 0xd, 0, 1<<14); /* EAPD Ctrl */
 		break;
+	case 0x10ec0222:
 	case 0x10ec0623:
 		alc_update_coef_idx(codec, 0x19, 1<<13, 0);
 		break;


