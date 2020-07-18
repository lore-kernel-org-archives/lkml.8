Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0770C43457
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE79E2076D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r72XjXYG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgGRG6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729132AbgGRG6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:58:06 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72ECC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:58:05 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id b6so13213666wrs.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TjgzLnntMqyR4iw5HYm5Wn13YkqCTneXtgN6zeUHap4=;
        b=r72XjXYGJjf/KxWyAu0wVQikYmQ2VwI9NGj6g3nIE9OaYb8RV3SBjMyRky+Cho90Xe
         cOKWmg4gzZJJTc6nLhNNi15qjiXSEUgNrjBwO6H3v3Y3CfozuBEKa2HQoAPBu5KpgcnC
         K5bv1E3iXmB4y7KExMH8IbsfQ0agBH/XSz27WkaloayNrbKA05gbXvz1Ow6NTJ2oldJY
         UjVhVbEo2D7t5k1dpXnisUFa37DslfxyO/6YcMpPvwqgzpbEDowyx1wASHBE/C0sWJG6
         3cZ3gqQWEU/C3VydulDz+Io+EhBqZsDE/xUDF5ztfvcrFGVdUGP/Yrs5G5M0S6xZyUQn
         mlvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TjgzLnntMqyR4iw5HYm5Wn13YkqCTneXtgN6zeUHap4=;
        b=NGZV89gK1LBJB6iUY/r8lszBF8w+sSXKLTlje38P9T1dIkjwlgsavfwmAbv74Zx4mg
         KtR2SeA34Xfm22P1n1lhfO8jYui8A5WdEFC5yIscs8dPTEQ/ihsodlOYgfGUtjcT7z9p
         gBrnedIF3GeOgEIndTJtUfu3Wxvp+T9R8L590KQIjljAcZLwHrI/uK7rEmDPDhbZ2uMf
         lAjgD5sNH5OOUN9Sf49MZ7oaoL/fGaXglPJGuRibRmJATkfnmN/nt2TO2itxU1mO5i7c
         lnxyVwBzUQWIkh68g3cDaGOqNeMQU5uUqG3VAi0yf+QORvbDHC6X02ihSoO1vpNhvxbi
         jNXg==
X-Gm-Message-State: AOAM5323CkrKyERbncuQivneeMe+wzKEZImZzeMtfQnYXaDAXIlXrf3r
        fi0+CyYpWEaEcH9QeHLprH5Lb81+
X-Google-Smtp-Source: ABdhPJxr09Wle5letJhcuWVOT+IwP/rPKtKvkpvcjIDD2+ZMra8NjiVc9MN+EncWhfdTcNPjmeDJdQ==
X-Received: by 2002:a5d:55c9:: with SMTP id i9mr128080wrw.31.1595055484444;
        Fri, 17 Jul 2020 23:58:04 -0700 (PDT)
Received: from localhost.localdomain (dslb-002-204-142-170.002.204.pools.vodafone-ip.de. [2.204.142.170])
        by smtp.gmail.com with ESMTPSA id 32sm409015wrn.86.2020.07.17.23.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 23:58:03 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: clear tabstop style issues
Date:   Sat, 18 Jul 2020 08:55:14 +0200
Message-Id: <20200718065514.16289-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear tabstop style issues reported by checkpatch.
WARNING: Statements should start on a tabstop

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ioctl_set.c    | 2 +-
 drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c | 2 +-
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c b/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
index fa88e8b2852d..26e5193cfd6c 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
@@ -343,7 +343,7 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
 		    *pold_state == Ndis802_11IBSS) {
 			if (check_fwstate(pmlmepriv, _FW_LINKED))
 				rtw_indicate_disconnect(padapter); /* will clr Linked_state; before this function, we must have checked whether  issue dis-assoc_cmd or not */
-	       }
+		}
 
 		*pold_state = networktype;
 
diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
index 740004d71a15..2baef9a285c0 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
@@ -145,7 +145,7 @@ void rtw_hal_set_odm_var(struct adapter *Adapter, enum hal_odm_variable eVariabl
 			} else {
 				DBG_88E("### Clean STA_(%d) info\n", psta->mac_id);
 				ODM_CmnInfoPtrArrayHook(podmpriv, ODM_CMNINFO_STA_STATUS, psta->mac_id, NULL);
-		       }
+			}
 		}
 		break;
 	case HAL_ODM_P2P_STATE:
diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index 5e6f7f0ed009..2e83d24fcb09 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -811,7 +811,7 @@ static int rtw_wx_set_pmkid(struct net_device *dev,
 				psecuritypriv->PMKIDList[j].bUsed = false;
 				break;
 			}
-	       }
+		}
 	} else if (pPMK->cmd == IW_PMKSA_FLUSH) {
 		DBG_88E("[rtw_wx_set_pmkid] IW_PMKSA_FLUSH!\n");
 		memset(&psecuritypriv->PMKIDList[0], 0x00, sizeof(struct rt_pmkid_list) * NUM_PMKID_CACHE);
-- 
2.27.0

