Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB6EC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E4CD2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587550714;
	bh=M6ptCejwI31FoxbckhDkOLx2nSehW9/IaJ0HcvrgiMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1ouGwdF9Rbe9/w2Tel9JZBuVG7a5jhPptcropA7/u7QbPrbYVDTdAttc2utmmuxq+
	 PHjVxGyJtUSTup2wPFtOs3p9z6pyKb72I5N5IU3DYIJN2uK4k/JotoEa1almmhR31q
	 9DudbS+G/sLQBXNMujjl0WZa5JZ+KINXs+QXrLEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbgDVKSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:18:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729862AbgDVKRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:17:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8941220776;
        Wed, 22 Apr 2020 10:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550658;
        bh=M6ptCejwI31FoxbckhDkOLx2nSehW9/IaJ0HcvrgiMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=URu+o84rE5OeWDfFzthA9TdJGBK8JxP71OvSn13SApg1vOi3YVOUvjikP0A8kfLI4
         oHQmLG4KZbnM1jRSmb51OWru/nbpRvSAobi3DK8PgjDMAjzk9l9aOt16sUpyM0KNUI
         auDvjN5tr784YVP9lyo73Mk6A02oniuf0CMMMlSU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 008/118] ALSA: hda: Honor PM disablement in PM freeze and thaw_noirq ops
Date:   Wed, 22 Apr 2020 11:56:09 +0200
Message-Id: <20200422095032.889229251@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095031.522502705@linuxfoundation.org>
References: <20200422095031.522502705@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 10db5bccc390e8e4bd9fcd1fbd4f1b23f271a405 upstream.

freeze_noirq and thaw_noirq need to check the PM availability like
other PM ops.  There are cases where the device got disabled due to
the error, and the PM operation should be ignored for that.

Fixes: 3e6db33aaf1d ("ALSA: hda - Set SKL+ hda controller power at freeze() and thaw()")
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=207043
Link: https://lore.kernel.org/r/20200413082034.25166-3-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_intel.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1068,6 +1068,8 @@ static int azx_freeze_noirq(struct devic
 	struct azx *chip = card->private_data;
 	struct pci_dev *pci = to_pci_dev(dev);
 
+	if (!azx_is_pm_ready(card))
+		return 0;
 	if (chip->driver_type == AZX_DRIVER_SKL)
 		pci_set_power_state(pci, PCI_D3hot);
 
@@ -1080,6 +1082,8 @@ static int azx_thaw_noirq(struct device
 	struct azx *chip = card->private_data;
 	struct pci_dev *pci = to_pci_dev(dev);
 
+	if (!azx_is_pm_ready(card))
+		return 0;
 	if (chip->driver_type == AZX_DRIVER_SKL)
 		pci_set_power_state(pci, PCI_D0);
 


