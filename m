Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AB5C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 19:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C04F6206D4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 19:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgDYTlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 15:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgDYTlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 15:41:36 -0400
X-Greylist: delayed 542 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 25 Apr 2020 12:41:36 PDT
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CCFC09B04D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 12:41:36 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 7C038E50B;
        Sat, 25 Apr 2020 21:32:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8b-C_GMZyM0G; Sat, 25 Apr 2020 21:32:27 +0200 (CEST)
Received: from function (lfbn-bor-1-797-11.w86-234.abo.wanadoo.fr [86.234.239.11])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 4601DE50A;
        Sat, 25 Apr 2020 21:32:27 +0200 (CEST)
Received: from samy by function with local (Exim 4.93)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1jSQXK-00GkbU-31; Sat, 25 Apr 2020 21:32:26 +0200
Date:   Sat, 25 Apr 2020 21:32:26 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     gregkh@linuxfoundation.org
Cc:     speakup@braille.uwo.ca, linux-kernel@vger.kernel.org
Subject: [PATCH] staging/speakup: Add inflection synth parameter
Message-ID: <20200425193226.nv3zfd4k3xavi353@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        gregkh@linuxfoundation.org, speakup@braille.uwo.ca,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The inflection parameter, i.e. the pitch range, allows to change the
expressiveness of the synthesized voice.  This is supported by the DEC
talk synths, and software synthesizers such as espeak/espeak-ng.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 drivers/staging/speakup/speakup_decext.c     |    4 ++++
 drivers/staging/speakup/speakup_decpc.c      |    4 ++++
 drivers/staging/speakup/speakup_dectlk.c     |    5 ++++-
 drivers/staging/speakup/speakup_dummy.c      |    4 ++++
 drivers/staging/speakup/speakup_soft.c       |    4 ++++
 drivers/staging/speakup/spk_types.h          |    3 ++-
 drivers/staging/speakup/spkguide.txt         |    7 ++++---
 drivers/staging/speakup/sysfs-driver-speakup |    6 ++++++
 drivers/staging/speakup/varhandlers.c        |    1 +
 9 files changed, 33 insertions(+), 5 deletions(-)

--- a/drivers/staging/speakup/speakup_decext.c
+++ b/drivers/staging/speakup/speakup_decext.c
@@ -43,6 +43,7 @@ static struct var_t vars[] = {
 	{ CAPS_STOP, .u.s = {"[:dv ap 100]" } },
 	{ RATE, .u.n = {"[:ra %d]", 7, 0, 9, 150, 25, NULL } },
 	{ PITCH, .u.n = {"[:dv ap %d]", 100, 0, 100, 0, 0, NULL } },
+	{ INFLECTION, .u.n = {"[:dv pr %d] ", 100, 0, 10000, 0, 0, NULL } },
 	{ VOL, .u.n = {"[:dv gv %d]", 13, 0, 16, 0, 5, NULL } },
 	{ PUNCT, .u.n = {"[:pu %c]", 0, 0, 2, 0, 0, "nsa" } },
 	{ VOICE, .u.n = {"[:n%c]", 0, 0, 9, 0, 0, "phfdburwkv" } },
@@ -59,6 +60,8 @@ static struct kobj_attribute caps_stop_a
 	__ATTR(caps_stop, 0644, spk_var_show, spk_var_store);
 static struct kobj_attribute pitch_attribute =
 	__ATTR(pitch, 0644, spk_var_show, spk_var_store);
+static struct kobj_attribute inflection_attribute =
+	__ATTR(inflection, 0644, spk_var_show, spk_var_store);
 static struct kobj_attribute punct_attribute =
 	__ATTR(punct, 0644, spk_var_show, spk_var_store);
 static struct kobj_attribute rate_attribute =
@@ -87,6 +90,7 @@ static struct attribute *synth_attrs[] =
 	&caps_start_attribute.attr,
 	&caps_stop_attribute.attr,
 	&pitch_attribute.attr,
+	&inflection_attribute.attr,
 	&punct_attribute.attr,
 	&rate_attribute.attr,
 	&voice_attribute.attr,
--- a/drivers/staging/speakup/speakup_decpc.c
+++ b/drivers/staging/speakup/speakup_decpc.c
@@ -139,6 +139,7 @@ static struct var_t vars[] = {
 	{ CAPS_STOP, .u.s = {"[:dv ap 100]" } },
 	{ RATE, .u.n = {"[:ra %d]", 9, 0, 18, 150, 25, NULL } },
 	{ PITCH, .u.n = {"[:dv ap %d]", 80, 0, 100, 20, 0, NULL } },
+	{ INFLECTION, .u.n = {"[:dv pr %d] ", 100, 0, 10000, 0, 0, NULL } },
 	{ VOL, .u.n = {"[:vo se %d]", 5, 0, 9, 5, 10, NULL } },
 	{ PUNCT, .u.n = {"[:pu %c]", 0, 0, 2, 0, 0, "nsa" } },
 	{ VOICE, .u.n = {"[:n%c]", 0, 0, 9, 0, 0, "phfdburwkv" } },
@@ -155,6 +156,8 @@ static struct kobj_attribute caps_stop_a
 	__ATTR(caps_stop, 0644, spk_var_show, spk_var_store);
 static struct kobj_attribute pitch_attribute =
 	__ATTR(pitch, 0644, spk_var_show, spk_var_store);
+static struct kobj_attribute inflection_attribute =
+	__ATTR(inflection, 0644, spk_var_show, spk_var_store);
 static struct kobj_attribute punct_attribute =
 	__ATTR(punct, 0644, spk_var_show, spk_var_store);
 static struct kobj_attribute rate_attribute =
@@ -183,6 +186,7 @@ static struct attribute *synth_attrs[] =
 	&caps_start_attribute.attr,
 	&caps_stop_attribute.attr,
 	&pitch_attribute.attr,
+	&inflection_attribute.attr,
 	&punct_attribute.attr,
 	&rate_attribute.attr,
 	&voice_attribute.attr,
--- a/drivers/staging/speakup/speakup_dectlk.c
+++ b/drivers/staging/speakup/speakup_dectlk.c
@@ -44,7 +44,7 @@ static struct var_t vars[] = {
 	{ CAPS_START, .u.s = {"[:dv ap 160] " } },
 	{ CAPS_STOP, .u.s = {"[:dv ap 100 ] " } },
 	{ RATE, .u.n = {"[:ra %d] ", 180, 75, 650, 0, 0, NULL } },
-	{ PITCH, .u.n = {"[:dv ap %d] ", 122, 50, 350, 0, 0, NULL } },
+	{ INFLECTION, .u.n = {"[:dv pr %d] ", 100, 0, 10000, 0, 0, NULL } },
 	{ VOL, .u.n = {"[:dv g5 %d] ", 86, 60, 86, 0, 0, NULL } },
 	{ PUNCT, .u.n = {"[:pu %c] ", 0, 0, 2, 0, 0, "nsa" } },
 	{ VOICE, .u.n = {"[:n%c] ", 0, 0, 9, 0, 0, "phfdburwkv" } },
@@ -61,6 +61,8 @@ static struct kobj_attribute caps_stop_a
 	__ATTR(caps_stop, 0644, spk_var_show, spk_var_store);
 static struct kobj_attribute pitch_attribute =
 	__ATTR(pitch, 0644, spk_var_show, spk_var_store);
+static struct kobj_attribute inflection_attribute =
+	__ATTR(inflection, 0644, spk_var_show, spk_var_store);
 static struct kobj_attribute punct_attribute =
 	__ATTR(punct, 0644, spk_var_show, spk_var_store);
 static struct kobj_attribute rate_attribute =
@@ -89,6 +91,7 @@ static struct attribute *synth_attrs[] =
 	&caps_start_attribute.attr,
 	&caps_stop_attribute.attr,
 	&pitch_attribute.attr,
+	&inflection_attribute.attr,
 	&punct_attribute.attr,
 	&rate_attribute.attr,
 	&voice_attribute.attr,
--- a/drivers/staging/speakup/speakup_dummy.c
+++ b/drivers/staging/speakup/speakup_dummy.c
@@ -24,6 +24,7 @@ static struct var_t vars[] = {
 	{ PAUSE, .u.s = {"PAUSE\n"} },
 	{ RATE, .u.n = {"RATE %d\n", 8, 1, 16, 0, 0, NULL } },
 	{ PITCH, .u.n = {"PITCH %d\n", 8, 0, 16, 0, 0, NULL } },
+	{ INFLECTION, .u.n = {"INFLECTION %d\n", 8, 0, 16, 0, 0, NULL } },
 	{ VOL, .u.n = {"VOL %d\n", 8, 0, 16, 0, 0, NULL } },
 	{ TONE, .u.n = {"TONE %d\n", 8, 0, 16, 0, 0, NULL } },
 	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
@@ -39,6 +40,8 @@ static struct kobj_attribute caps_stop_a
 	__ATTR(caps_stop, 0644, spk_var_show, spk_var_store);
 static struct kobj_attribute pitch_attribute =
 	__ATTR(pitch, 0644, spk_var_show, spk_var_store);
+static struct kobj_attribute inflection_attribute =
+	__ATTR(inflection, 0644, spk_var_show, spk_var_store);
 static struct kobj_attribute rate_attribute =
 	__ATTR(rate, 0644, spk_var_show, spk_var_store);
 static struct kobj_attribute tone_attribute =
@@ -65,6 +68,7 @@ static struct attribute *synth_attrs[] =
 	&caps_start_attribute.attr,
 	&caps_stop_attribute.attr,
 	&pitch_attribute.attr,
+	&inflection_attribute.attr,
 	&rate_attribute.attr,
 	&tone_attribute.attr,
 	&vol_attribute.attr,
--- a/drivers/staging/speakup/speakup_soft.c
+++ b/drivers/staging/speakup/speakup_soft.c
@@ -38,6 +38,7 @@ static struct var_t vars[] = {
 	{ PAUSE, .u.n = {"\x01P" } },
 	{ RATE, .u.n = {"\x01%ds", 2, 0, 9, 0, 0, NULL } },
 	{ PITCH, .u.n = {"\x01%dp", 5, 0, 9, 0, 0, NULL } },
+	{ INFLECTION, .u.n = {"\x01%dr", 5, 0, 9, 0, 0, NULL } },
 	{ VOL, .u.n = {"\x01%dv", 5, 0, 9, 0, 0, NULL } },
 	{ TONE, .u.n = {"\x01%dx", 1, 0, 2, 0, 0, NULL } },
 	{ PUNCT, .u.n = {"\x01%db", 0, 0, 2, 0, 0, NULL } },
@@ -57,6 +58,8 @@ static struct kobj_attribute freq_attrib
 	__ATTR(freq, 0644, spk_var_show, spk_var_store);
 static struct kobj_attribute pitch_attribute =
 	__ATTR(pitch, 0644, spk_var_show, spk_var_store);
+static struct kobj_attribute inflection_attribute =
+	__ATTR(inflection, 0644, spk_var_show, spk_var_store);
 static struct kobj_attribute punct_attribute =
 	__ATTR(punct, 0644, spk_var_show, spk_var_store);
 static struct kobj_attribute rate_attribute =
@@ -96,6 +99,7 @@ static struct attribute *synth_attrs[] =
 	&freq_attribute.attr,
 /*	&lang_attribute.attr, */
 	&pitch_attribute.attr,
+	&inflection_attribute.attr,
 	&punct_attribute.attr,
 	&rate_attribute.attr,
 	&tone_attribute.attr,
--- a/drivers/staging/speakup/spk_types.h
+++ b/drivers/staging/speakup/spk_types.h
@@ -42,7 +42,8 @@ enum var_id_t {
 	SAY_CONTROL, SAY_WORD_CTL, NO_INTERRUPT, KEY_ECHO,
 	SPELL_DELAY, PUNC_LEVEL, READING_PUNC,
 	ATTRIB_BLEEP, BLEEPS,
-	RATE, PITCH, VOL, TONE, PUNCT, VOICE, FREQUENCY, LANG, DIRECT, PAUSE,
+	RATE, PITCH, INFLECTION, VOL, TONE, PUNCT, VOICE, FREQUENCY, LANG,
+	DIRECT, PAUSE,
 	CAPS_START, CAPS_STOP, CHARTAB,
 	MAXVARS
 };
--- a/drivers/staging/speakup/spkguide.txt
+++ b/drivers/staging/speakup/spkguide.txt
@@ -406,6 +406,7 @@ freq
 full_time
 jiffy_delta
 pitch
+inflection
 punct
 rate
 tone
@@ -518,9 +519,9 @@ All the entries in the Speakup sys syste
 writable by root only, and some are writable by everyone.  Unless you
 know what you are doing, you should probably leave the ones that are
 writable by root only alone.  Most of the names are self explanatory.
-Vol for controlling volume, pitch for pitch, rate for controlling speaking
-rate, etc.  If you find one you aren't sure about, you can post a query
-on the Speakup list.
+Vol for controlling volume, pitch for pitch, inflection for pitch range, rate
+for controlling speaking rate, etc.  If you find one you aren't sure about, you
+can post a query on the Speakup list.
 
 6.  Changing Synthesizers
 
--- a/drivers/staging/speakup/varhandlers.c
+++ b/drivers/staging/speakup/varhandlers.c
@@ -37,6 +37,7 @@ static struct st_var_header var_headers[
 	{ "bell_pos", BELL_POS, VAR_NUM, &spk_bell_pos, NULL },
 	{ "rate", RATE, VAR_NUM, NULL, NULL },
 	{ "pitch", PITCH, VAR_NUM, NULL, NULL },
+	{ "inflection", INFLECTION, VAR_NUM, NULL, NULL },
 	{ "vol", VOL, VAR_NUM, NULL, NULL },
 	{ "tone", TONE, VAR_NUM, NULL, NULL },
 	{ "punct", PUNCT, VAR_NUM, NULL, NULL   },
--- a/drivers/staging/speakup/sysfs-driver-speakup
+++ b/drivers/staging/speakup/sysfs-driver-speakup
@@ -325,6 +325,12 @@ KernelVersion:	2.6
 Contact:	speakup@linux-speakup.org
 Description:	Gets or sets the pitch of the synthesizer. The range is 0-9.
 
+What:		/sys/accessibility/speakup/soft/inflection
+KernelVersion:	5.8
+Contact:	speakup@linux-speakup.org
+Description:	Gets or sets the inflection of the synthesizer, i.e. the pitch
+		range. The range is 0-9.
+
 What:		/sys/accessibility/speakup/soft/punct
 KernelVersion:	2.6
 Contact:	speakup@linux-speakup.org
