Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C0AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 770DF20721
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590521326;
	bh=egsL6AH/ANsTTekNKP3t3n4xT4+RurSQuBnpdQfJb/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AiARYeAL1teuk9dnzmhTi6m6/bWVbDKUiDfNlq5mGiTVFUmzbHZQwtzyGGSwJRf7r
	 TvmkOVe8Lq8mrRRi+R9rJMCSr5i1pS8M0zfjVMJAL3naCpSifJ5T+HoHMXfqgnRGNp
	 9H8AP9Dg9iNZ3wNfwK44GcFshmYn0VhRp1t3bp0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392561AbgEZT2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:28:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391135AbgEZTCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:02:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4804720849;
        Tue, 26 May 2020 19:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519759;
        bh=egsL6AH/ANsTTekNKP3t3n4xT4+RurSQuBnpdQfJb/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mPovLgUOgIVMFD5jet8oYmakFYiyBxEoOwgcmbugFrilP4DG+qTh7A77C/X6dfJri
         kVIsaU595UD37ofyFXFKbg95rW+Wjchjehh23w5mTv9+BKTF70+FH11Vb85BUtf6XT
         7qIfGUQphpztuGUvkbI0n58LU1CjldJ8tQ/66Xg0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Scott Bahling <sbahling@suse.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 35/59] ALSA: iec1712: Initialize STDSP24 properly when using the model=staudio option
Date:   Tue, 26 May 2020 20:53:20 +0200
Message-Id: <20200526183919.093179911@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183907.123822792@linuxfoundation.org>
References: <20200526183907.123822792@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Scott Bahling <sbahling@suse.com>

commit b0cb099062b0c18246c3a20caaab4c0afc303255 upstream.

The ST Audio ADCIII is an STDSP24 card plus extension box. With commit
e8a91ae18bdc ("ALSA: ice1712: Add support for STAudio ADCIII") we
enabled the ADCIII ports using the model=staudio option but forgot
this part to ensure the STDSP24 card is initialized properly.

Fixes: e8a91ae18bdc ("ALSA: ice1712: Add support for STAudio ADCIII")
Signed-off-by: Scott Bahling <sbahling@suse.com>
Cc: <stable@vger.kernel.org>
BugLink: https://bugzilla.suse.com/show_bug.cgi?id=1048934
Link: https://lore.kernel.org/r/20200518175728.28766-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/ice1712/ice1712.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -2377,7 +2377,8 @@ static int snd_ice1712_chip_init(struct
 	pci_write_config_byte(ice->pci, 0x61, ice->eeprom.data[ICE_EEP1_ACLINK]);
 	pci_write_config_byte(ice->pci, 0x62, ice->eeprom.data[ICE_EEP1_I2SID]);
 	pci_write_config_byte(ice->pci, 0x63, ice->eeprom.data[ICE_EEP1_SPDIF]);
-	if (ice->eeprom.subvendor != ICE1712_SUBDEVICE_STDSP24) {
+	if (ice->eeprom.subvendor != ICE1712_SUBDEVICE_STDSP24 &&
+	    ice->eeprom.subvendor != ICE1712_SUBDEVICE_STAUDIO_ADCIII) {
 		ice->gpio.write_mask = ice->eeprom.gpiomask;
 		ice->gpio.direction = ice->eeprom.gpiodir;
 		snd_ice1712_write(ice, ICE1712_IREG_GPIO_WRITE_MASK,


