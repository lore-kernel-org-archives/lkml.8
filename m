Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE02C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6CE32063A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qHKlQ5E6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgHQJCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgHQJCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:02:44 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD1AC061342;
        Mon, 17 Aug 2020 02:02:44 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j21so7797700pgi.9;
        Mon, 17 Aug 2020 02:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nd35gBts6NgtKlgN2lcrX3AbyIcMYWPkE6/ISk0jZVU=;
        b=qHKlQ5E6ehfBA/hV/XlchuGk9r9+52SaKrqq5Ok0Yd97+uobN4Zyvw7O82ta5goNeL
         xBfom1nx+gYLXtn94ddvCCxxNFbRp5+n7BpIbqScWc5Sw0JoTpemM2JOk0zZIl1vphfd
         vYSLMUNFAFB3b/MT+bML4I3ZeMpmF1WsGeUJTD1Qd+02T1Nw/mtUIm+qp3t4ePJJ4B6u
         BJAPaA5NLPV9itEiWAesNfBSHQtLtJW1M2iXdCwhwUujS7+WjX1iUWUQhsph56doS1MV
         lLrQ4xwvaLW6IgaxGpHG6qJpY+tYETB2W+EgCO3Y0Xub6NR4XrYDos5cc6O5jw3X9fuN
         WqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nd35gBts6NgtKlgN2lcrX3AbyIcMYWPkE6/ISk0jZVU=;
        b=p2/GszVrjNrWNuEwN6kD+Fh767gwE9HWIrkDYTxp9RBCQYYKVrwzeLSN9wz6B4///W
         Mj9KdFLhKGplUjeWE3WCk3XrGtW9BuAgNL+uyrFFiRBL9TqsuLsSto8fvJ5jvyQ+oUC4
         57HeMK/fVozCAiKIgijOk1TcDAziqz+sGsvjO2bvYg8wyUKqiINET/KS51bxYt/D3yRy
         d07SdGjd1FvQqvLy65uWr9huL1hnJQXxsL42jGVhZDPdbpVQJ8MsUxba/Aj3YINORX4b
         PrAzObjsPoaQX9C026yHvdnIixUEnx9wwRHNH7zILkYBwC+Yx02KUG4QuO8YxewsohwG
         9A9Q==
X-Gm-Message-State: AOAM531FetSPXlO4fwrEjX5WIn2IeqpK+fi3rKWkc821oHZ9TDC0ahwe
        237so6KbfLxYdo8rz/Ru8S4=
X-Google-Smtp-Source: ABdhPJzf4Yw256WODaILrOgLYx1TniHaJ4JHn/KjTEA/sb3iaSQaoGjAR+GXmFwEKiXhf2N63ukVKQ==
X-Received: by 2002:a63:6b01:: with SMTP id g1mr8932278pgc.192.1597654964140;
        Mon, 17 Aug 2020 02:02:44 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id f3sm19488238pfj.206.2020.08.17.02.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 02:02:43 -0700 (PDT)
From:   Allen Pais <allen.cryptic@gmail.com>
To:     duncan.sands@free.fr, gregkh@linuxfoundation.org,
        jacmet@sunsite.dk, balbi@kernel.org, leoyang.li@nxp.com,
        johan@kernel.org
Cc:     keescook@chromium.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 4/7] usb/gadget: f_midi: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 14:32:06 +0530
Message-Id: <20200817090209.26351-5-allen.cryptic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817090209.26351-1-allen.cryptic@gmail.com>
References: <20200817090209.26351-1-allen.cryptic@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Allen Pais <allen.lkml@gmail.com>

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/usb/gadget/function/f_midi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/f_midi.c b/drivers/usb/gadget/function/f_midi.c
index 46af0aa07e2e..85cb15734aa8 100644
--- a/drivers/usb/gadget/function/f_midi.c
+++ b/drivers/usb/gadget/function/f_midi.c
@@ -698,9 +698,9 @@ static void f_midi_transmit(struct f_midi *midi)
 	f_midi_drop_out_substreams(midi);
 }
 
-static void f_midi_in_tasklet(unsigned long data)
+static void f_midi_in_tasklet(struct tasklet_struct *t)
 {
-	struct f_midi *midi = (struct f_midi *) data;
+	struct f_midi *midi = from_tasklet(midi, t, tasklet);
 	f_midi_transmit(midi);
 }
 
@@ -875,7 +875,7 @@ static int f_midi_bind(struct usb_configuration *c, struct usb_function *f)
 	int status, n, jack = 1, i = 0, endpoint_descriptor_index = 0;
 
 	midi->gadget = cdev->gadget;
-	tasklet_init(&midi->tasklet, f_midi_in_tasklet, (unsigned long) midi);
+	tasklet_setup(&midi->tasklet, f_midi_in_tasklet);
 	status = f_midi_register_card(midi);
 	if (status < 0)
 		goto fail_register;
-- 
2.17.1

