Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13515C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E45552073A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595262290;
	bh=kIm8M2uXcQTxSOK4OoPtGwErITq0mltCNsirn6XB47w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1h9zcjM9YKVS1QU4sQAkZWSlNjOuc+scCLhSLHky3maoEf/T8ZFnI7vfAKyZWAuMO
	 bx+jgG7urmC5Ru6nVwY3vzNhgGgsSjtfCq9Oblp7zD3mGT16ukL3HYgPoBxgZC5PFG
	 48e0Af6lAQ6Kuk/D9PI0XBZuglWp7ZHfsfbBLP0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387604AbgGTQYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:24:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732671AbgGTQC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:02:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD06B2176B;
        Mon, 20 Jul 2020 16:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260949;
        bh=kIm8M2uXcQTxSOK4OoPtGwErITq0mltCNsirn6XB47w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qCShURl+S/BL6CohlbfnJRaitfguxrK0MCgxWoz6CcPqf/tO08qqFrrKALuWFN9E0
         qo3f4ghmjIOHUyHopi7ynTHjm4ibcvoeurhdKCX4GzXfj6WNJTeHC40RCzpZVcZh6u
         ed857H2bbSlMXts5WgTKdk0/0FFMHDXefRlaaFX4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 154/215] ALSA: hda/realtek - Enable Speaker for ASUS UX563
Date:   Mon, 20 Jul 2020 17:37:16 +0200
Message-Id: <20200720152827.518452945@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152820.122442056@linuxfoundation.org>
References: <20200720152820.122442056@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kailang Yang <kailang@realtek.com>

commit 158ae2f5e6fead30be1f0c203037f5556871513b upstream.

ASUS UX563 speaker can't output.
Add quirk to link suitable model will enable it.
This model also could enable headset Mic.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/96dee3ab01a04c28a7b44061e88009dd@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7516,6 +7516,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1043, 0x17d1, "ASUS UX431FL", ALC294_FIXUP_ASUS_DUAL_SPK),
 	SND_PCI_QUIRK(0x1043, 0x18b1, "Asus MJ401TA", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x18f1, "Asus FX505DT", ALC256_FIXUP_ASUS_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1043, 0x194e, "ASUS UX563FD", ALC294_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x19ce, "ASUS B9450FA", ALC294_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x19e1, "ASUS UX581LV", ALC295_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),


