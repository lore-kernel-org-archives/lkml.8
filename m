Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7959C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 20:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5152074A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 20:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OsR77xO6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbgCMUrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 16:47:25 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40507 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgCMUrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 16:47:23 -0400
Received: by mail-pj1-f66.google.com with SMTP id bo3so3536630pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 13:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WmR0Zy/INv8T8Q5kpQokwP6/VvkYAWeVeStzwjBb3QQ=;
        b=OsR77xO6S3/Q0dciqM0G3rlzGynb1g8GBeeGYt0oyJ2X9+/Yt1IVFN2292US9JwJ3I
         m4gWfpLKPMMVfqbtGJzfzOdmZgnRQqxn05Eoc61EAhZQLc44M2ZHEjGuxdb7lXvQIfot
         YNSbpQjw4kgzI//8hMEzKSiXnvuIlCFUfSj5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WmR0Zy/INv8T8Q5kpQokwP6/VvkYAWeVeStzwjBb3QQ=;
        b=CUMrYCbZMYY7a/Yz08xj2R3W+nLV1MfgVmX5hITBz7fqHfGHfj8OwLhJLmDjAcQhqT
         6sGFWjKoaiG9GOZmEG5tttNnjs+G35M9SPHUC2KnU9R/VinaDm9AanEAaWFCKYTz2xpN
         2OhFkz/wx2Dq/nHmPI/7xQxDfubU32YNcS0rs5QZHkimobNhsdcfb7C438wfJHzgfcmP
         ZZElee1zm+fcu9m5eVbT1e6q5q8vRmCNUM0f1xx01ZBy+Qml7ktRHWqTJUls4/YZQSVz
         GH5q3e17Di1g1DLVz2sckM+p3pCwezOpLOttPP3sJ+teidcIBZijlA+zv0qeKc6Pu60P
         uJzQ==
X-Gm-Message-State: ANhLgQ22uixiVBlmqHzRRJoS7z98poCXfdcnVrT0CVFo0jJUNerwRqBT
        tX+IKsZE5jrTXN/ZViqHixGzOQ==
X-Google-Smtp-Source: ADFU+vueocNRDiEDaoc5lL0rcsBqaOHG/wMpUZqEnr6mvREDuEKQvFR/4jeFV7cx64SuqEFaTFBMlA==
X-Received: by 2002:a17:90a:da01:: with SMTP id e1mr12067723pjv.100.1584132442065;
        Fri, 13 Mar 2020 13:47:22 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id a13sm26532278pfc.24.2020.03.13.13.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 13:47:21 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     gregkh@linuxfoundation.org
Cc:     mka@chromium.org, swboyd@chromium.org, ryandcase@chromium.org,
        bjorn.andersson@linaro.org, akashast@codeaurora.org,
        skakit@codeaurora.org, rojay@codeaurora.org,
        mgautam@codeaurora.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Doug Anderson <dianders@google.com>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Jiri Slaby <jslaby@suse.com>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 2/2] tty: serial: qcom_geni_serial: Don't try to manually disable the console
Date:   Fri, 13 Mar 2020 13:46:52 -0700
Message-Id: <20200313134635.2.I3648fac6c98b887742934146ac2729ecb7232eb1@changeid>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200313134635.1.Icf54c533065306b02b880c46dfd401d8db34e213@changeid>
References: <20200313134635.1.Icf54c533065306b02b880c46dfd401d8db34e213@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The geni serial driver's shutdown code had a special case to call
console_stop().  Grepping through the code, it was the only serial
driver doing something like this (the only other caller of
console_stop() was in serial_core.c).

As far as I can tell there's no reason to call console_stop() in the
geni code.  ...and a good reason _not_ to call it.  Specifically if
you have an agetty running on the same serial port as the console then
killing the agetty kills your console and if you start the agetty
again the console doesn't come back.

Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver support for GENI based QUP")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/tty/serial/qcom_geni_serial.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 09d8612517aa..69a0072e0c53 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -827,10 +827,6 @@ static void get_tx_fifo_size(struct qcom_geni_serial_port *port)
 
 static void qcom_geni_serial_shutdown(struct uart_port *uport)
 {
-	/* Stop the console before stopping the current tx */
-	if (uart_console(uport))
-		console_stop(uport->cons);
-
 	disable_irq(uport->irq);
 }
 
-- 
2.25.1.481.gfbce0eb801-goog

