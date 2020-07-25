Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2189FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 12:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECD15206D7
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 12:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4ETVqf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgGYMVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 08:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgGYMVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 08:21:05 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3F1C0619D3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 05:21:05 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s189so6847159pgc.13
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 05:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yRXLZ1hu0sdoPx6SqZ2r2f9LoGCTilqOZCtacbE99yE=;
        b=c4ETVqf2fjIOzvWD4AEHxxk34aiEUhfytDdkjgA3gxDihXSGeihBUrxYoQpM9Mf4L9
         38xRK/wDozdEvvx/x7WrPwtxnUJlTm4+Vl4Khh+l+1SnpTUACZZuy6v+oJa7ryJ0HBTt
         7js5oKB5xSO+2olbei6IzycDLdiUzSe6+WHqKmDqAsl8Gj9zELuSOl988WwJU3RkwWzl
         0GvV/5j7IFZESrVkUWOMZU1wDuezxE8YTw2pOauVuNsTFLZ0RUor/bLzbBA/O3RAa/lo
         Rdo1k6md8UtQ4swo+sGTmr8hPJi6PQjer9vFLUkgPVHJXrsgkZIP1NWN8VFNMlLpzul0
         eMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yRXLZ1hu0sdoPx6SqZ2r2f9LoGCTilqOZCtacbE99yE=;
        b=cSeZ3O+V5miHB/McWyNPSwKBBj1UCXOfP+L42bDfuBdbAb08QI6bAlhxNqacODhX1I
         InPQLzYI7bcOkPhwV/HPJpXE8Lmzxu4VQHXnJexXqmBmU2f1abHZfnsE0E76D6KSnhA6
         AgUOaiNy+tKSofY3mynROittmvYMIsbwAR/Z5afTHciMZnLS3Xyn6X/yG0YPg73RPLvV
         7mKvWT8T05vLVAGpwcBq585IwG01DS4zqTTEaPT3E1VVfQkK1I0jkH/eT81xCTIakySL
         AqcoR47OOj1rAn/jvQydHd1r3KuhvQGS2Yu/C5bpNcrNivUOrBMQLYuCzF5hiPCNeD5s
         7gRg==
X-Gm-Message-State: AOAM531fBzxQ8+ow7ntINDDMZQ79r3AG3aW5uanBkFzNapuLUmKJZqBF
        gizhl6c4vV5ZXaVroZkoyMQ=
X-Google-Smtp-Source: ABdhPJy1KXFwgIZqdb2bB1Z/+XcKp3QfLpB8HjgEDafci6Ce3yLSlQqAlwsxMFaQQFzFosEYI+W1gw==
X-Received: by 2002:a62:1d52:: with SMTP id d79mr12707193pfd.106.1595679664617;
        Sat, 25 Jul 2020 05:21:04 -0700 (PDT)
Received: from localhost.localdomain ([106.51.23.74])
        by smtp.gmail.com with ESMTPSA id q3sm8561141pjo.16.2020.07.25.05.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 05:21:03 -0700 (PDT)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     anant.thazhemadam@gmail.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anoop S <anoop.skumar1507@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        Joe Perches <joe@perches.com>,
        Merwin Trever Ferrao <merwintf@gmail.com>,
        Rahul Gottipati <rahul.blr97@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] STAGING - REALTEK RTL8188EU DRIVERS: Fix Coding Style Error
Date:   Sat, 25 Jul 2020 17:50:38 +0530
Message-Id: <20200725122041.5663-1-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running the checkpatch.pl script on the file for which patch was created, the 
following error was found to exist.
ERROR: space required after that ',' (ctx:VxV)

Fixed the above error which was found on line #721 by inserting a blank
space at the appropriate position.

Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/core/rtw_security.c
index 21f6652dd69f..57e171d3e48d 100644
--- a/drivers/staging/rtl8188eu/core/rtw_security.c
+++ b/drivers/staging/rtl8188eu/core/rtw_security.c
@@ -718,7 +718,7 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 				res = _FAIL;
 			}
 		} else {
-			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo==NULL!!!\n",__func__));
+			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo==NULL!!!\n", __func__));
 			res = _FAIL;
 		}
 	}
-- 
2.25.1

