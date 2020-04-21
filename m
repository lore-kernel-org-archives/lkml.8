Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3945DC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1243B206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4D48JL+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbgDUNbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729028AbgDUNbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:31:00 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2F2C061A10;
        Tue, 21 Apr 2020 06:31:00 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id g4so5864944ljl.2;
        Tue, 21 Apr 2020 06:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JV0defNdBCi7bt39b6lkeE4mZVzhV/J3uLKgKiW1woA=;
        b=N4D48JL+oU5t26IH+SBYg9y6+xH5Aiozqu9i0fA1oPUhcGEBOExSYCDHy6zWJfjmJF
         MdlelVzIpGmoXiYbHhSQw7A+opj3vhPvUEYx9TfFxeybiL2ZtxpSorLBDk1RqFfhf9Nw
         yORvUmgpkeBvXYOAKMBvh8s1MyceQmhPclGEtMnQ9PkhVYBi8qjlzMk9Z8ANdBfN6G4o
         SnAGuOpVemf4ypdE5BBQEjoz66OZIb7uLf7SMy6zHPYPAr6xX+odaOD4iTWfl8yYdcYS
         LMQ4Bvrbs3HT99wA1hfD/hk/LN60KiRC9K2ir4b+Fi4PAa9ryCX5IitW/CKPPhCoBCy5
         wrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JV0defNdBCi7bt39b6lkeE4mZVzhV/J3uLKgKiW1woA=;
        b=jtyrFmmIHRnDBNlMGAHeSSX4prHibC7stE2xmdeTBhN0iHD7pEl+LkcQmFYlIfovyZ
         dWlm+ijwe37B0QDzeOdH9cXGvGsI+E0bQiXAkeatRYF0nreAVJ12PrFXf2YqE3hQq4jf
         9GzncOwesLnjIm6FSvnxc4EMPHsOibakilZEkvaeBJUWj9jC6yYk9OCu1b5HI3Y5Ioom
         G22Rb+Bh8naRunXUyIcXMdbRUhhSHntYJZzOtLfl1XXZdzVSDBXd95Y40VcMo9ARL/Tn
         T7LnQgdcBmbSm17DbxYNWXNBCg3Vl6DWBSCYAS6HaM5UrPRWRMyUkue7OCy7gR/co90M
         7Ejw==
X-Gm-Message-State: AGi0PuZTWfi2ag9qL2WSoeW7d3SnpgGahOpS3DcA0fJrnB6Nga1KJ8q4
        jjHKBsx/XIW8mMeY5w2mBhw=
X-Google-Smtp-Source: APiQypKImdg6Y/c2VCPiFBfQ/4MMUmDaSmVK7HUOFlznPD4TLDXTk0QjcQt4jXdST4wqVF6589YWzA==
X-Received: by 2002:a2e:878b:: with SMTP id n11mr1114245lji.196.1587475858271;
        Tue, 21 Apr 2020 06:30:58 -0700 (PDT)
Received: from oak.local ([188.123.231.141])
        by smtp.gmail.com with ESMTPSA id v17sm2031456lfi.49.2020.04.21.06.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 06:30:57 -0700 (PDT)
From:   matwey.kornilov@gmail.com
To:     stern@rowland.harvard.edu, Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org (open list:MUSB MULTIPOINT HIGH SPEED
        DUAL-ROLE CONTROLLER), linux-kernel@vger.kernel.org (open list)
Cc:     "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        linux-usb@vger.kernel.org (open list:MUSB MULTIPOINT HIGH SPEED
        DUAL-ROLE CONTROLLER), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 4/6] usb: musb: Rename musb_start_urb() to musb_start_next_urb()
Date:   Tue, 21 Apr 2020 16:30:17 +0300
Message-Id: <20200421133019.27167-5-matwey.kornilov@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200421133019.27167-1-matwey.kornilov@gmail.com>
References: <20200421133019.27167-1-matwey.kornilov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matwey V. Kornilov" <matwey@sai.msu.ru>

In the following commit we introduce new musb_start_urb() function
which will be able to start arbitrary urb. In order to have
intuitive function names we rename musb_start_urb() to
musb_start_next_urb().

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 drivers/usb/musb/musb_host.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 28d6576b6d8d..c3c9aa8ba973 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -213,7 +213,7 @@ static struct musb_qh *musb_ep_get_qh(struct musb_hw_ep *ep, int is_in)
  * Context: controller locked, irqs blocked
  */
 static void
-musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
+musb_start_next_urb(struct musb *musb, int is_in, struct musb_qh *qh)
 {
 	u32			len;
 	void __iomem		*mbase =  musb->mregs;
@@ -385,7 +385,7 @@ static void musb_advance_schedule(struct musb *musb, struct urb *urb,
 	if (qh != NULL && qh->is_ready) {
 		musb_dbg(musb, "... next ep%d %cX urb %p",
 		    hw_ep->epnum, is_in ? 'R' : 'T', next_urb(qh));
-		musb_start_urb(musb, is_in, qh);
+		musb_start_next_urb(musb, is_in, qh);
 	}
 }
 
@@ -975,7 +975,7 @@ static void musb_bulk_nak_timeout(struct musb *musb, struct musb_hw_ep *ep,
 		}
 
 		if (next_qh)
-			musb_start_urb(musb, is_in, next_qh);
+			musb_start_next_urb(musb, is_in, next_qh);
 	}
 }
 
@@ -2108,7 +2108,7 @@ static int musb_schedule(
 	qh->hw_ep = hw_ep;
 	qh->hep->hcpriv = qh;
 	if (idle)
-		musb_start_urb(musb, is_in, qh);
+		musb_start_next_urb(musb, is_in, qh);
 	return 0;
 }
 
-- 
2.25.0

