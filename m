Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFE6C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E8F92465A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582055818;
	bh=ObUpMlK267QZmVRlHMUvnqv/x+nKyOlA4C48PMZo4H4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fowqLnouDUqqwZ1mnUi5KUQ+jnspsaqkrQK7LVWw3ZhVdhGPfvrr8I7Fa9Y1C+i2J
	 W2jKb3J5ihI0rfy41kpNsuPTOA6JP5fSDuMyJoAvFKyI8CPX+dAAOrC0LNRUCjOiV2
	 0popZ/7+L15I31LpS2Q+GovEyqQRdaaDvXIQahhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgBRT44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:56:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:34046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727680AbgBRT4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:56:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1545024125;
        Tue, 18 Feb 2020 19:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582055812;
        bh=ObUpMlK267QZmVRlHMUvnqv/x+nKyOlA4C48PMZo4H4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kdh30zdd1QGdm9SGzuJE07gC57vv9WPSSoTT7GeTbU4LVxI2MUyy+uJAbTsnQrnXB
         TG9uRn7C1QF5bQ0NZmMQTxWL2dr6OfjE3SmBw2m1/XPOZIv9YPGCky+9jgq/DriQjv
         nrLhDAAx1e6bJeB6vyhxw93wHsrY90WNC4IuzK80=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 05/38] ALSA: hda/realtek - Fix silent output on MSI-GL73
Date:   Tue, 18 Feb 2020 20:54:51 +0100
Message-Id: <20200218190419.171847259@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200218190418.536430858@linuxfoundation.org>
References: <20200218190418.536430858@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 7dafba3762d6c0083ded00a48f8c1a158bc86717 upstream.

MSI-GL73 laptop with ALC1220 codec requires a similar workaround for
Clevo laptops to enforce the DAC/mixer connection path.  Set up a
quirk entry for that.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204159
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200212081047.27727-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2442,6 +2442,7 @@ static const struct snd_pci_quirk alc882
 	SND_PCI_QUIRK(0x1071, 0x8258, "Evesham Voyaeger", ALC882_FIXUP_EAPD),
 	SND_PCI_QUIRK(0x1458, 0xa002, "Gigabyte EP45-DS3/Z87X-UD3H", ALC889_FIXUP_FRONT_HP_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1458, 0xa0b8, "Gigabyte AZ370-Gaming", ALC1220_FIXUP_GB_DUAL_CODECS),
+	SND_PCI_QUIRK(0x1462, 0x1276, "MSI-GL73", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x7350, "MSI-7350", ALC889_FIXUP_CD),
 	SND_PCI_QUIRK(0x1462, 0xda57, "MSI Z270-Gaming", ALC1220_FIXUP_GB_DUAL_CODECS),
 	SND_PCI_QUIRK_VENDOR(0x1462, "MSI", ALC882_FIXUP_GPIO3),


