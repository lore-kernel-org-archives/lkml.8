Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C238C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 10:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BA2217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 10:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=interia.pl header.i=@interia.pl header.b="Kuxf4Ium"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbgBMKor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 05:44:47 -0500
Received: from smtpo.poczta.interia.pl ([217.74.65.152]:57326 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbgBMKoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 05:44:46 -0500
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Feb 2020 05:44:45 EST
X-Interia-R: Interia
X-Interia-R-IP: 185.15.80.246
X-Interia-R-Helo: <photon.emea.nsn-net.net>
Received: from photon.emea.nsn-net.net (185-15-80-246.ksi-system.net [185.15.80.246])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
        Thu, 13 Feb 2020 11:37:20 +0100 (CET)
From:   Radoslaw Smigielski <radoslaw.smigielski@interia.pl>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        alsa-devel@alsa-project.org, corbet@lwn.net, tiwai@suse.com,
        perex@perex.cz, radoslaw.smigielski@interia.pl
Subject: [alsa-devel] [PATCH] ALSA: doc: fix snd_hda_intel driver name
Date:   Thu, 13 Feb 2020 11:36:37 +0100
Message-Id: <20200213103636.733463-1-radoslaw.smigielski@interia.pl>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Interia-Antivirus: OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1581590241;
        bh=gVqMAKSIPkY8OiAd077JlbnTBYo5wVcLt3iZ6loGT8Y=;
        h=X-Interia-R:X-Interia-R-IP:X-Interia-R-Helo:From:To:Subject:Date:
         Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
         X-Interia-Antivirus;
        b=Kuxf4Ium3/75vWo/SUnB0MPiRIZaAhRwFeR3fVI2USNtD0mDfNojDrYcVc7jj4236
         ja6CwFGQc5CIwIKyNFO2xuKqU4nu06YQ2FuYAffUqfmwzXsA6sJXQg7nf1P37FJcc6
         XlS8uu5sIaKwuV0GVLrPR6YLjYqX2fFsdBEbuRUs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update driver name snd-hda-intel to proper, existing driver
name snd_hda_intel in Documentation/sound/hd-audio/notes.rst.

Signed-off-by: Radoslaw Smigielski <radoslaw.smigielski@interia.pl>
---
 Documentation/sound/hd-audio/notes.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/sound/hd-audio/notes.rst b/Documentation/sound/hd-audio/notes.rst
index 0f3109d9abc8..56ccc15f4d26 100644
--- a/Documentation/sound/hd-audio/notes.rst
+++ b/Documentation/sound/hd-audio/notes.rst
@@ -17,12 +17,12 @@ methods for the	HD-audio hardware.
 
 The HD-audio component consists of two parts: the controller chip and 
 the codec chips on the HD-audio bus.  Linux provides a single driver
-for all controllers, snd-hda-intel.  Although the driver name contains
+for all controllers, snd_hda_intel.  Although the driver name contains
 a word of a well-known hardware vendor, it's not specific to it but for
 all controller chips by other companies.  Since the HD-audio
 controllers are supposed to be compatible, the single snd-hda-driver
 should work in most cases.  But, not surprisingly, there are known
-bugs and issues specific to each controller type.  The snd-hda-intel
+bugs and issues specific to each controller type.  The snd_hda_intel
 driver has a bunch of workarounds for these as described below.
 
 A controller may have multiple codecs.  Usually you have one audio
@@ -31,7 +31,7 @@ multiple audio codecs, e.g. for analog and digital outputs, and the
 driver might not work properly because of conflict of mixer elements.
 This should be fixed in future if such hardware really exists.
 
-The snd-hda-intel driver has several different codec parsers depending
+The snd_hda_intel driver has several different codec parsers depending
 on the codec.  It has a generic parser as a fallback, but this
 functionality is fairly limited until now.  Instead of the generic
 parser, usually the codec-specific parser (coded in patch_*.c) is used
@@ -226,7 +226,7 @@ the external amplifier bits.  Thus a headphone output has a slightly
 better chance.
 
 Before making a bug report, double-check whether the mixer is set up
-correctly.  The recent version of snd-hda-intel driver provides mostly
+correctly.  The recent version of snd_hda_intel driver provides mostly
 "Master" volume control as well as "Front" volume (where Front
 indicates the front-channels).  In addition, there can be individual
 "Headphone" and "Speaker" controls.
@@ -596,7 +596,7 @@ For example, if you have two cards, one for an on-board analog and one
 for an HDMI video board, you may pass patch option like below:
 ::
 
-    options snd-hda-intel patch=on-board-patch,hdmi-patch
+    options snd_hda_intel patch=on-board-patch,hdmi-patch
 
 
 Power-Saving
-- 
2.24.1

