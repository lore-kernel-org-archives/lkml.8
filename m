Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235A9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E5582086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbgHDQHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:07:48 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:50732 "EHLO
        hera.aquilenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgHDQGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:06:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 4FCF5E2D2;
        Tue,  4 Aug 2020 18:06:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6b5WCCxbPFoh; Tue,  4 Aug 2020 18:06:39 +0200 (CEST)
Received: from function (lfbn-bor-1-797-11.w86-234.abo.wanadoo.fr [86.234.239.11])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 6ED1A83E4;
        Tue,  4 Aug 2020 18:06:39 +0200 (CEST)
Received: from samy by function with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1k2zSX-0027mG-FU; Tue, 04 Aug 2020 18:06:37 +0200
Date:   Tue, 4 Aug 2020 18:06:37 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: [PATCHv2 1/2] speakup: Fix wait_for_xmitr for ttyio case
Message-ID: <20200804160637.x3iycau5izywbgzl@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        speakup@linux-speakup.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was missed while introducing the tty-based serial access.

The only remaining use of wait_for_xmitr with tty-based access is in
spk_synth_is_alive_restart to check whether the synth can be restarted.
With tty-based this is up to the tty layer to cope with the buffering
etc. so we can just say yes.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Index: linux-2.6/drivers/accessibility/speakup/serialio.c
===================================================================
--- linux-2.6.orig/drivers/accessibility/speakup/serialio.c
+++ linux-2.6/drivers/accessibility/speakup/serialio.c
@@ -32,6 +32,7 @@ static void spk_serial_tiocmset(unsigned
 static unsigned char spk_serial_in(void);
 static unsigned char spk_serial_in_nowait(void);
 static void spk_serial_flush_buffer(void);
+static int spk_serial_wait_for_xmitr(struct spk_synth *in_synth);
 
 struct spk_io_ops spk_serial_io_ops = {
 	.synth_out = spk_serial_out,
@@ -40,6 +41,7 @@ struct spk_io_ops spk_serial_io_ops = {
 	.synth_in = spk_serial_in,
 	.synth_in_nowait = spk_serial_in_nowait,
 	.flush_buffer = spk_serial_flush_buffer,
+	.wait_for_xmitr = spk_serial_wait_for_xmitr,
 };
 EXPORT_SYMBOL_GPL(spk_serial_io_ops);
 
@@ -211,7 +213,7 @@ void spk_stop_serial_interrupt(void)
 }
 EXPORT_SYMBOL_GPL(spk_stop_serial_interrupt);
 
-int spk_wait_for_xmitr(struct spk_synth *in_synth)
+static int spk_serial_wait_for_xmitr(struct spk_synth *in_synth)
 {
 	int tmout = SPK_XMITR_TIMEOUT;
 
@@ -280,7 +282,7 @@ static void spk_serial_flush_buffer(void
 
 static int spk_serial_out(struct spk_synth *in_synth, const char ch)
 {
-	if (in_synth->alive && spk_wait_for_xmitr(in_synth)) {
+	if (in_synth->alive && spk_serial_wait_for_xmitr(in_synth)) {
 		outb_p(ch, speakup_info.port_tts);
 		return 1;
 	}
@@ -295,7 +297,7 @@ const char *spk_serial_synth_immediate(s
 	while ((ch = *buff)) {
 		if (ch == '\n')
 			ch = synth->procspeech;
-		if (spk_wait_for_xmitr(synth))
+		if (spk_serial_wait_for_xmitr(synth))
 			outb(ch, speakup_info.port_tts);
 		else
 			return buff;
Index: linux-2.6/drivers/accessibility/speakup/spk_priv.h
===================================================================
--- linux-2.6.orig/drivers/accessibility/speakup/spk_priv.h
+++ linux-2.6/drivers/accessibility/speakup/spk_priv.h
@@ -34,7 +34,6 @@
 
 const struct old_serial_port *spk_serial_init(int index);
 void spk_stop_serial_interrupt(void);
-int spk_wait_for_xmitr(struct spk_synth *in_synth);
 void spk_serial_release(void);
 void spk_ttyio_release(void);
 void spk_ttyio_register_ldisc(void);
Index: linux-2.6/drivers/accessibility/speakup/spk_ttyio.c
===================================================================
--- linux-2.6.orig/drivers/accessibility/speakup/spk_ttyio.c
+++ linux-2.6/drivers/accessibility/speakup/spk_ttyio.c
@@ -116,6 +116,7 @@ static void spk_ttyio_tiocmset(unsigned
 static unsigned char spk_ttyio_in(void);
 static unsigned char spk_ttyio_in_nowait(void);
 static void spk_ttyio_flush_buffer(void);
+static int spk_ttyio_wait_for_xmitr(struct spk_synth *in_synth);
 
 struct spk_io_ops spk_ttyio_ops = {
 	.synth_out = spk_ttyio_out,
@@ -125,6 +126,7 @@ struct spk_io_ops spk_ttyio_ops = {
 	.synth_in = spk_ttyio_in,
 	.synth_in_nowait = spk_ttyio_in_nowait,
 	.flush_buffer = spk_ttyio_flush_buffer,
+	.wait_for_xmitr = spk_ttyio_wait_for_xmitr,
 };
 EXPORT_SYMBOL_GPL(spk_ttyio_ops);
 
@@ -286,6 +288,11 @@ static void spk_ttyio_tiocmset(unsigned
 	mutex_unlock(&speakup_tty_mutex);
 }
 
+static int spk_ttyio_wait_for_xmitr(struct spk_synth *in_synth)
+{
+	return 1;
+}
+
 static unsigned char ttyio_in(int timeout)
 {
 	struct spk_ldisc_data *ldisc_data = speakup_tty->disc_data;
Index: linux-2.6/drivers/accessibility/speakup/spk_types.h
===================================================================
--- linux-2.6.orig/drivers/accessibility/speakup/spk_types.h
+++ linux-2.6/drivers/accessibility/speakup/spk_types.h
@@ -158,6 +158,7 @@ struct spk_io_ops {
 	unsigned char (*synth_in)(void);
 	unsigned char (*synth_in_nowait)(void);
 	void (*flush_buffer)(void);
+	int (*wait_for_xmitr)(struct spk_synth *synth);
 };
 
 struct spk_synth {
Index: linux-2.6/drivers/accessibility/speakup/synth.c
===================================================================
--- linux-2.6.orig/drivers/accessibility/speakup/synth.c
+++ linux-2.6/drivers/accessibility/speakup/synth.c
@@ -159,7 +159,7 @@ int spk_synth_is_alive_restart(struct sp
 {
 	if (synth->alive)
 		return 1;
-	if (spk_wait_for_xmitr(synth) > 0) {
+	if (synth->io_ops->wait_for_xmitr(synth) > 0) {
 		/* restart */
 		synth->alive = 1;
 		synth_printf("%s", synth->init);
