Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB22C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E4C220715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8wGJIOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbgGFK6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 06:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgGFK6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 06:58:48 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348C7C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 03:58:48 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a6so26833356wmm.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 03:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=88uY/K8kMD7acXPJ9B5/vndoO67lAnXVMcUWbnzMjAc=;
        b=f8wGJIOaYzDtcyKU2uxanmD4ynraMOEJCb8nEQ8ZxjsNoVF9HwJkq+vNvAuFhbz0x3
         TkF8dHUSzxjluBZ9MVoiE/YSVMeu0RztCQa0rr5YxkxamY+LvXiY6pNz8DluoOtktTAJ
         R4b7+0+b6eATAZ5AzMArbZTzWC3iVuvsPzi7U+d+d+aUDc4HQJdDVnDxotzsRJujekgh
         gwoA3zjI1bUr1WlCAm/dF8pqe3wY/+14K4k7zmHtyzEUsrC/ytPLYzKswWd2fV/1oPEo
         DG05kNZ0apmxs0HlflIepKsH00zWfTxM0xipQ3UytLoLP75Z52pXXL3ACNEqrGCJuY0f
         RWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=88uY/K8kMD7acXPJ9B5/vndoO67lAnXVMcUWbnzMjAc=;
        b=nUk8hTlcSZcimIb+PeY6yNo1eRuixRCrFuKJQYneuEaSWoBv1d3kcpbJkUINd3Ki7+
         AIjPNEY0Fd6PKlbCTXazyTSjyDGu0kQ3z5YNbFVgNzFjGh2oFUQu6qTFtzs1qw5jvSAx
         WfODDmYAgKBJE12OAgCDjqAnPa0RPyQXToejMgcYBKmL9hRhVrfL0GePh6BYWUKZBztg
         KyulCwsyz0xjXbFgIIDH1jn+IKwefmo57gfBrwKlQIT8lvymid+qAKUao8ENm10jhY6P
         m81VSwohvyhY6x3AtKg8G2FMP7VKcmSOayvVm5yTYi6Q+nzgTRgQl6Cnvh1LEQqdiH0n
         OETA==
X-Gm-Message-State: AOAM532e0b/v6MStjHI1XMSFurv1PNaIxJDO91wC0IhG94BE1bRkYh+p
        FkfB160/8NmYHAbrhh98q/uz7doG440=
X-Google-Smtp-Source: ABdhPJzaXLT0YPvO9lo03X/uzqlPCQ6qLARW3vBhpz+CorNi/WoOkyLCQpFzQ69D8FrQN80S/4A9vA==
X-Received: by 2002:a1c:bb89:: with SMTP id l131mr43676408wmf.125.1594033126663;
        Mon, 06 Jul 2020 03:58:46 -0700 (PDT)
Received: from maphy.uni-hannover.de ([130.75.75.70])
        by smtp.gmail.com with ESMTPSA id u186sm23646522wmu.10.2020.07.06.03.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 03:58:46 -0700 (PDT)
Date:   Mon, 6 Jul 2020 12:58:45 +0200
From:   Tammo Block <tammo.block@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v3 4/6] vt/vt: Add SRG mouse reporting protocol
Message-ID: <f2da517c43f206624ee2da817238968f792c251f.1594032517.git.tammo.block@gmail.com>
References: <cover.1594032517.git.tammo.block@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1594032517.git.tammo.block@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SRG protocol indicates a button release by appending a "m" to the
report. In this case the button number is not 3 (RELEASEEVENT) but
the number of the button that was released. As release events are only
reported for the first three buttons (LOWBUTTON_MASK), we need to store
the number on click events because it is not sent to us from userspace.

We also need to check for the case where no button state change occurred
at all (bit 6 set), in this case a value of 3 is OK even in SRG.

Signed-off-by: Tammo Block <tammo.block@gmail.com>
---
 drivers/tty/vt/vt.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 3699e488ef19..766983a848bb 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1838,13 +1838,32 @@ static inline void respond_ID(struct tty_struct *tty)
 	respond_string(vt102_id, strlen(vt102_id), tty->port);
 }
 
+#define ANYBUTTON_MASK	0xc3
+#define LOWBUTTON_MASK	0x03
+#define RELEASEEVENT	0x03
+
 void mouse_report(struct tty_struct *tty, int butt, int mrx, int mry)
 {
-	char buf[8];
+	static char last_btn = RELEASEEVENT;
+	char buf[20];
+	bool rel;
 	int len;
 
-	len = sprintf(buf, "\033[M%c%c%c", (char)(' ' + butt),
-			(char)('!' + mrx), (char)('!' + mry));
+	switch (vc_cons[fg_console].d->vc_protocol_mouse) {
+	case VC_PMOUSE_SRG:
+		rel = (butt & ANYBUTTON_MASK) == RELEASEEVENT;
+		if ((butt & ANYBUTTON_MASK) < RELEASEEVENT)
+			last_btn = butt & LOWBUTTON_MASK;
+		if ((butt & TIOCL_SELBUTTONMASK) == RELEASEEVENT)
+			butt = (butt & ~LOWBUTTON_MASK) | last_btn;
+		len = sprintf(buf, "\033[<%d;%d;%d%c", butt,
+				mrx + 1, mry + 1, rel ? 'm' : 'M');
+		break;
+	default:
+		len = sprintf(buf, "\033[M%c%c%c", (char)(' ' + butt),
+				(char)('!' + mrx), (char)('!' + mry));
+		break;
+	}
 	respond_string(buf, len, tty->port);
 }
 
-- 
2.27.0

