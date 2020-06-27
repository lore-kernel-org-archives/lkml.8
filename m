Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA574C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 12:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6D592184D
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 12:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cMqLOo14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgF0MzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 08:55:09 -0400
Received: from mout.gmx.net ([212.227.17.22]:52029 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbgF0MzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 08:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593262492;
        bh=OZFz73ODcG4HFVet5IxLP7LoD5Tul3KsEAIISgKqlEA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=cMqLOo14qDy43kwqRC5RunQ9/8+1rZmrsf0EuKYO6Mm+jhcMb74jiRjlsSJu0NbWJ
         j9xto0rcAQ/usNU4tZMeNS5pJUoGyssE19JrqoLbJuYX4UwasjtPv+05JXMffVlMJX
         XEFSGlXuHddcgz7xuYOC5hL1aLL4vGG5x+zoci4E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.73.70]) by mail.gmx.com
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1N3siG-1ipfml3n96-00zoC5; Sat, 27 Jun 2020 14:54:52 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Kees Cook <keescook@chromium.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     kernel-hardening@lists.openwall.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oscar Carter <oscar.carter@gmx.com>
Subject: [PATCH] drivers/s390/char/tty3270: Remove function callback casts
Date:   Sat, 27 Jun 2020 14:54:17 +0200
Message-Id: <20200627125417.18887-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WuLVlRTrugTdMXef4+/XXVnc8C9knOmuEp8gUSwkWy9Toq23Y5B
 MyN5hAU4IiecdUDVIvl+O1g8No+219xwL53VlaOGWjTVLPgWWpIzZ7kaoJvi/BdIrDmhNq2
 zjh0RnLOgL1kUHJy1cXOEJtsSGnIwBtBIgnoQ0jmyeeyWRTav0zTNhYDOLih8KfHTDf858h
 bn0dcKhtppCqNkjsUwTZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HUfvtbJHxCU=:wVnHHWAAYZzyqtb6vmVCxL
 woNLDkTI0KAiNyG/mbSv1JTsnjv09BojAkwDuw/ytyOYrjDteKWh6gmRnOQWTv+SqCFveXZTG
 vZcsBYf6lR5pvngUEiamQYCHj+f6t2HgyUKFV8RlGIuRkh2EVhLflig21KSC8GYX+HBTORehW
 Twxwm8ppmQ7Shjv7tAniEhhy9ZC2dzA4tiEFaRwfZ8PgqFWzHMcxDDSG7KB5Mbco8NB8/1/ei
 0laH8IvM2AtcFCLMtlU0ZCc+zmbq9gDdybmjwfIroi4lhi0RV5LLi0b1dG6SF6U9NxtryRw5O
 hYE+luzPT58uie5fdVd0RBfDV0wqQDmGxmycCRD1BQJMrqjrXfhGikWD7FGrxMsR90WolEoXL
 PkzuFNxh9xFVrGKJPWvqs5U0PGT1UlChCmlZ3qWnhYJQubNe9T1hIk57hvk9cdDxxSsW7NCxQ
 fSXr2O/GR0TLX1uSSoPmZkiTl5O6KzgQh1ib4i6omTOrXI3u2f8qBZ/UQ85usA1qat2abnmez
 vYkCZYobxnRJNgPeDFq5mLn7TEtAU5h4fX3ttu+N8EDDblCg/7fFEKgKcAs3EzFNnlAdMg3tm
 g0Tg7RQpxP8k/JTGv7h/2ijofU7NEBRNr4QaQAuKKl7yjKcE7InawrIjghaRRhMB0KR7Svyt/
 /+HJcs6gnbkPEsykDU+7FnDcjXu5J1zs3Uij6QOcZ1Ms07rLHX7ZXI1dhN9iWer/jhoNfiTKG
 yp5QqTdCt8EgzbBn59h66Hxr0EWYepfURo/pv3yIT3G28yF5tghjsFsJgMdfxD6+XPnsSflwH
 jpb26ZOx6bPcQsIFk7fYin8dlRJtf11J72vDFa/NjES2p6FFwptPRf1oNTjJNHZPAww9f1XST
 8ssOWMRWLGdq5whMhYt7XJqTqmAeQFV4DyCiN4J/uHXrtZ0nlVK3y+0p2Ayz6kBZ4HYClSMrP
 UpvkMzdFb4KmkSDuySzuKD9F3uAec/fBYk1j6Bdbxf5zRFEji4mmolm0QDDFYMuGEmTrLexmc
 9pWJZWkYbdnI+c9McaavZYduNGXOpLVi8RTgxlP4oON8fMkkD17cwYLpup56Yg/2REgXPC1TH
 5NvZF6vkVIsx/Jpwrhf0VL2PO1+6fbJpTIa/B1+0YqHxlnRO/IQdL/rX/NcBQojl3MNHnnsBK
 zGopnAW8+Br3XkJ+90uUI1jDU+j9oLlDYp1AlcI1/vb0bzI7B1PUCazzogYgEXJWqBSU19xff
 EwfePvX23zwtVPKOO
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an effort to enable -Wcast-function-type in the top-level Makefile to
support Control Flow Integrity builds, remove all the function callback
casts.

To do this modify the function prototypes accordingly.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/s390/char/tty3270.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index 98d7fc152e32..aec996de44d9 100644
=2D-- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
@@ -556,8 +556,9 @@ tty3270_scroll_backward(struct kbd_data *kbd)
  * Pass input line to tty.
  */
 static void
-tty3270_read_tasklet(struct raw3270_request *rrq)
+tty3270_read_tasklet(unsigned long data)
 {
+	struct raw3270_request *rrq =3D (struct raw3270_request *)data;
 	static char kreset_data =3D TW_KR;
 	struct tty3270 *tp =3D container_of(rrq->view, struct tty3270, view);
 	char *input;
@@ -652,8 +653,9 @@ tty3270_issue_read(struct tty3270 *tp, int lock)
  * Hang up the tty
  */
 static void
-tty3270_hangup_tasklet(struct tty3270 *tp)
+tty3270_hangup_tasklet(unsigned long data)
 {
+	struct tty3270 *tp =3D (struct tty3270 *)data;
 	tty_port_tty_hangup(&tp->port, true);
 	raw3270_put_view(&tp->view);
 }
@@ -752,11 +754,9 @@ tty3270_alloc_view(void)

 	tty_port_init(&tp->port);
 	timer_setup(&tp->timer, tty3270_update, 0);
-	tasklet_init(&tp->readlet,
-		     (void (*)(unsigned long)) tty3270_read_tasklet,
+	tasklet_init(&tp->readlet, tty3270_read_tasklet,
 		     (unsigned long) tp->read);
-	tasklet_init(&tp->hanglet,
-		     (void (*)(unsigned long)) tty3270_hangup_tasklet,
+	tasklet_init(&tp->hanglet, tty3270_hangup_tasklet,
 		     (unsigned long) tp);
 	INIT_WORK(&tp->resize_work, tty3270_resize_work);

=2D-
2.20.1

