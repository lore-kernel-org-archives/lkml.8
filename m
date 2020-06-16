Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87C4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90C0320882
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592324309;
	bh=+1D9kExDD3bEf33XbVDEMg9hH0GZgEy1vDz5bhWcY/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vBcKGZHwfT1AnDwktG+dSqfDnYJ3ta8aaRizckvJr+CqbOBwmdkMe36gqGPCJiI1+
	 irifAcAsPd1lnGHbUPrAq9MfjCpNTNs2n3DSQu5gb+5TEpMr74BY5zlUwzdGl4oJc/
	 /dcfB4vk0Mrv49P+HkhgLaXg/ZW2w093CO6Obu6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731832AbgFPQSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:18:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730593AbgFPPiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:38:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56B30214DB;
        Tue, 16 Jun 2020 15:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592321893;
        bh=+1D9kExDD3bEf33XbVDEMg9hH0GZgEy1vDz5bhWcY/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HmoQFxWu4H6kiq8DEZ2O2bXXXfiakAavN5JtdEiTRvmgDuRWDCgfGaYT0YXa+XKE5
         cqKAwnBM3fNqWqeOAnOphZs9KNwpLkuSsRWKGVe/mlGPxrVP9+kX7OkTzIYQglpzvD
         QArCVKb1g1HRq+375DWTV8LQH9asL1rVSJW0nrzs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hui Wang <hui.wang@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 057/134] ALSA: hda/realtek - add a pintbl quirk for several Lenovo machines
Date:   Tue, 16 Jun 2020 17:34:01 +0200
Message-Id: <20200616153103.506479809@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153100.633279950@linuxfoundation.org>
References: <20200616153100.633279950@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Wang <hui.wang@canonical.com>

commit 573fcbfd319ccef26caa3700320242accea7fd5c upstream.

A couple of Lenovo ThinkCentre machines all have 2 front mics and they
use the same codec alc623 and have the same pin config, so add a
pintbl entry for those machines to apply the fixup
ALC283_FIXUP_HEADSET_MIC.

Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
Link: https://lore.kernel.org/r/20200608115541.9531-1-hui.wang@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8156,6 +8156,12 @@ static const struct snd_hda_pin_quirk al
 		ALC225_STANDARD_PINS,
 		{0x12, 0xb7a60130},
 		{0x17, 0x90170110}),
+	SND_HDA_PIN_QUIRK(0x10ec0623, 0x17aa, "Lenovo", ALC283_FIXUP_HEADSET_MIC,
+		{0x14, 0x01014010},
+		{0x17, 0x90170120},
+		{0x18, 0x02a11030},
+		{0x19, 0x02a1103f},
+		{0x21, 0x0221101f}),
 	{}
 };
 


