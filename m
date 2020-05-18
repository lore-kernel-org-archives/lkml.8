Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24A5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C5F620674
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbgERRuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:50:22 -0400
Received: from smtprelay0091.hostedemail.com ([216.40.44.91]:47570 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730659AbgERRuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:50:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id C5566837F24C;
        Mon, 18 May 2020 17:50:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pies21_1f8ccfdebe71f
X-Filterd-Recvd-Size: 4208
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Mon, 18 May 2020 17:50:16 +0000 (UTC)
Message-ID: <c28e8b2f987d94a95b6405b881f791858793709b.camel@perches.com>
Subject: [PATCH] tty: n_gsm: gsm_print_packet: use scnprintf to avoid pr_cont
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Mon, 18 May 2020 10:50:15 -0700
In-Reply-To: <20200518074803.GA3095136@kroah.com>
References: <20200512115323.1447922-1-gregory.clement@bootlin.com>
         <20200512115323.1447922-2-gregory.clement@bootlin.com>
         <f957eb74-cdbe-848f-b345-7c9fb3d7b1e6@suse.com> <87tv0dg0ii.fsf@FE-laptop>
         <20200518073829.GA3055513@kroah.com> <87o8qlg00b.fsf@FE-laptop>
         <20200518074803.GA3095136@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a temporary buffer to avoid multiple pr_cont uses.

Signed-off-by: Joe Perches <joe@perches.com>
---

> > > Ugh, as I already applied this series, should I just revert them all, or
> > > are you going to send fix-ups on top of what I have applied instead?
> > 
> > I was about to send a new series, but I can just send fix-ups. It's up
> > to you.
> 
> fix-ups are less work for me :)

Perhaps use something like this instead?

It does increase object size a tiny bit.

 drivers/tty/n_gsm.c | 71 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 42 insertions(+), 29 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 69200bd411f7..7d7820aeb57b 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -454,58 +454,71 @@ static u8 gsm_encode_modem(const struct gsm_dlci *dlci)
  */
 
 static void gsm_print_packet(const char *hdr, int addr, int cr,
-					u8 control, const u8 *data, int dlen)
+			     u8 control, const u8 *data, int dlen)
 {
+	char buf[100];
+	char *p;
+	char *type;
+
 	if (!(debug & 1))
 		return;
 
-	pr_info("%s %d) %c: ", hdr, addr, "RC"[cr]);
+	p = buf;
+	p += scnprintf(p, buf - p, "%s %d) %c: ", hdr, addr, "RC"[cr]);
 
 	switch (control & ~PF) {
 	case SABM:
-		pr_cont("SABM");
+		type = "SABM";
 		break;
 	case UA:
-		pr_cont("UA");
+		type = "UA";
 		break;
 	case DISC:
-		pr_cont("DISC");
+		type = "DISC";
 		break;
 	case DM:
-		pr_cont("DM");
+		type = "DM";
 		break;
 	case UI:
-		pr_cont("UI");
+		type = "UI";
 		break;
 	case UIH:
-		pr_cont("UIH");
+		type = "UIH";
 		break;
 	default:
-		if (!(control & 0x01)) {
-			pr_cont("I N(S)%d N(R)%d",
-				(control & 0x0E) >> 1, (control & 0xE0) >> 5);
-		} else switch (control & 0x0F) {
-			case RR:
-				pr_cont("RR(%d)", (control & 0xE0) >> 5);
-				break;
-			case RNR:
-				pr_cont("RNR(%d)", (control & 0xE0) >> 5);
-				break;
-			case REJ:
-				pr_cont("REJ(%d)", (control & 0xE0) >> 5);
-				break;
-			default:
-				pr_cont("[%02X]", control);
+		type = NULL;
+		break;
+	}
+
+	if (type) {
+		p += scnprintf(p, buf - p, "%s", type);
+	} else if (!(control & 0x01)) {
+		p += scnprintf(p, buf - p, "I N(S)%d N(R)%d",
+			       (control & 0x0E) >> 1, (control & 0xE0) >> 5);
+	} else {
+		switch (control & 0x0F) {
+		case RR:
+			p += scnprintf(p, buf - p, "RR(%d)",
+				       (control & 0xE0) >> 5);
+			break;
+		case RNR:
+			p += scnprintf(p, buf - p, "RNR(%d)",
+				       (control & 0xE0) >> 5);
+			break;
+		case REJ:
+			p += scnprintf(p, buf - p, "REJ(%d)",
+				       (control & 0xE0) >> 5);
+			break;
+		default:
+			p += scnprintf(p, buf - p, "[%02X]", control);
+			break;
 		}
 	}
 
-	if (control & PF)
-		pr_cont("(P)");
-	else
-		pr_cont("(F)");
+	p += scnprintf(p, buf - p, "(%c)", control & PF ? 'P' : 'F');
 
-	if (dlen)
-		print_hex_dump_bytes("", DUMP_PREFIX_NONE, data, dlen);
+	pr_info("%s\n", buf);
+	print_hex_dump_bytes("", DUMP_PREFIX_NONE, data, dlen);
 }
 
 


