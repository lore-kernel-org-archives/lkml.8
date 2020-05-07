Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B39DC47247
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 414EF2073A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588861867;
	bh=0pS+i0Ixr68HNWXXzQPsLMW2+ywCYwWogyt2MvpScbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bX80Gnb8QKOUX1iF8mwpIDvptXyMkYhTr5opGxclbosJAMbyBWS8TUZJhBpoZn0pS
	 wWkUETfPzw8cBRFA3RFRw3WyRS8NEzZe2/zAHk1pRFdHxKlfMu0j54U9Ol6+3SduTY
	 FvlvKT6/Mgi6dEiLXH8/2J8VhwzN30B+JXiopYPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgEGOa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:30:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728828AbgEGOa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:30:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBBE620B1F;
        Thu,  7 May 2020 14:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588861825;
        bh=0pS+i0Ixr68HNWXXzQPsLMW2+ywCYwWogyt2MvpScbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FfHz3ELyb8RrCZ9c1Jy0ssQjoupDOQYrJ0XXccoQnIs0X116IWtPUTBV++hSSQCJ2
         o3+4ljbsKpxjmJoJqYQ8if12D3KAcooKWnlCj9P35PtqqHr2vbid2FdFmudT/kadYI
         kukd6iFVhNwbBsFLyM+XvBnZvOxFveMH/Jfw5BNY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.4 6/9] ALSA: hda: Match both PCI ID and SSID for driver blacklist
Date:   Thu,  7 May 2020 10:30:15 -0400
Message-Id: <20200507143018.27195-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200507143018.27195-1-sashal@kernel.org>
References: <20200507143018.27195-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 977dfef40c8996b69afe23a9094d184049efb7bb ]

The commit 3c6fd1f07ed0 ("ALSA: hda: Add driver blacklist") added a
new blacklist for the devices that are known to have empty codecs, and
one of the entries was ASUS ROG Zenith II (PCI SSID 1043:874f).
However, it turned out that the very same PCI SSID is used for the
previous model that does have the valid HD-audio codecs and the change
broke the sound on it.

Since the empty codec problem appear on the certain AMD platform (PCI
ID 1022:1487), this patch changes the blacklist matching to both PCI
ID and SSID using pci_match_id().  Also, the entry that was removed by
the previous fix for ASUS ROG Zenigh II is re-added.

Link: https://lore.kernel.org/r/20200424061222.19792-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_intel.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index da9f6749b3be2..8dd6cf0b8939b 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1977,9 +1977,10 @@ static const struct hdac_io_ops pci_hda_io_ops = {
  * some HD-audio PCI entries are exposed without any codecs, and such devices
  * should be ignored from the beginning.
  */
-static const struct snd_pci_quirk driver_blacklist[] = {
-	SND_PCI_QUIRK(0x1462, 0xcb59, "MSI TRX40 Creator", 0),
-	SND_PCI_QUIRK(0x1462, 0xcb60, "MSI TRX40", 0),
+static const struct pci_device_id driver_blacklist[] = {
+	{ PCI_DEVICE_SUB(0x1022, 0x1487, 0x1043, 0x874f) }, /* ASUS ROG Zenith II / Strix */
+	{ PCI_DEVICE_SUB(0x1022, 0x1487, 0x1462, 0xcb59) }, /* MSI TRX40 Creator */
+	{ PCI_DEVICE_SUB(0x1022, 0x1487, 0x1462, 0xcb60) }, /* MSI TRX40 */
 	{}
 };
 
@@ -2002,7 +2003,7 @@ static int azx_probe(struct pci_dev *pci,
 	bool schedule_probe;
 	int err;
 
-	if (snd_pci_quirk_lookup(pci, driver_blacklist)) {
+	if (pci_match_id(driver_blacklist, pci)) {
 		dev_info(&pci->dev, "Skipping the blacklisted device\n");
 		return -ENODEV;
 	}
-- 
2.20.1

