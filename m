Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCF6C35669
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 20:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13FB2072C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 20:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=es-iitr-ac-in.20150623.gappssmtp.com header.i=@es-iitr-ac-in.20150623.gappssmtp.com header.b="jwlue2HY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgBUU3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 15:29:15 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42589 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgBUU3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 15:29:15 -0500
Received: by mail-pf1-f194.google.com with SMTP id 4so1833254pfz.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 12:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=AhyF1vb5J/RNFh5gS2ZeVN61pIuMZEud+IXqME7A2aY=;
        b=jwlue2HYdUOtUGPGUVjbVXq5HJ2rdtSNWs+ZDK/Y+cW4vXSOIAez8Jx7Jf8LGCxEP2
         a7XGIyTM213EGwZu8d6sT1rcSj7wf4A0k9d/XRrKxeahVrfOrUqNfbZW0/1pVBN29TSh
         S/B1bn8I0UTpU3ah1q9HpW2nIOdDxx0YqsOeSZVwd00I00OYkcww7FSalaZbreyiQ+/k
         hGH5W5KbngHWQCNBZK+K4DU1GxkP6hz1IbTLUYiF6OD17EgSuQN7kx49w9eDBRK8EH1c
         jf+922Y7SD5MBYpGZ+TaNciPqTu2a0vlykggsd5n3KL4MLIrhqUVRstrQD0VKbwU5DYL
         k53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=AhyF1vb5J/RNFh5gS2ZeVN61pIuMZEud+IXqME7A2aY=;
        b=LqB73v8RzeTjtPoDg6oxUMT5BDJyNKjz4p+BMh/jCn0y9E6A5gnt0+hFCnDyGFxN0X
         /g2zvaZ0TGlIA/9b13hLP0a2434Qqc7wypZqesubHS2I3mpNr8WuT6iIF+FjFwalwkxL
         1x5jTQfYBUU6MTTXmg5BturZZGi39jWk892kudbkFRQOiNJalGnuh0E/tjQ13D1NEBGz
         GrIyVxeJrXvd/dlgsWt0Z+acGiQ6U5CGv0Aau841FeukXjLAFCr/4KVVm1ARQL2zL0kP
         YXBDU2scFrvcN/osJMGN3F2zDL7FgwC3UODw5reXFEsE66pK0O7pDTHxDI4Vxbra//bF
         U8og==
X-Gm-Message-State: APjAAAX0uCrKRYeMZ+GvYltJVErSOrjdcyV3Lb8G+d2yFRYjlCd7xBYc
        EWhcKLVA57rpHgtcgqT9R7Z3Sg==
X-Google-Smtp-Source: APXvYqxFWZN+hGzdjri4i8S+3BEyF1Y//evwgvtuMy4DH27kRD8V2nP2Qdg5E3PjrydgrvgYKNtFHw==
X-Received: by 2002:aa7:8597:: with SMTP id w23mr8980021pfn.38.1582316954634;
        Fri, 21 Feb 2020 12:29:14 -0800 (PST)
Received: from kaaira-HP-Pavilion-Notebook ([103.37.201.178])
        by smtp.gmail.com with ESMTPSA id az9sm3393890pjb.3.2020.02.21.12.29.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 12:29:14 -0800 (PST)
Date:   Sat, 22 Feb 2020 01:59:04 +0530
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
To:     Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: qlge: add braces on all arms of if-else
Message-ID: <20200221202904.GA19627@kaaira-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix all checkpatch.pl warnings of 'braces {} should be used on all arms
of this statement' in the file qlge_ethtool.c by adding the braces.

Signed-off-by: Kaaira Gupta <kgupta@es.iitr.ac.in>
---
 drivers/staging/qlge/qlge_ethtool.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/qlge/qlge_ethtool.c b/drivers/staging/qlge/qlge_ethtool.c
index 790997aff995..592ca7edfc44 100644
--- a/drivers/staging/qlge/qlge_ethtool.c
+++ b/drivers/staging/qlge/qlge_ethtool.c
@@ -259,8 +259,9 @@ static void ql_update_stats(struct ql_adapter *qdev)
 				  "Error reading status register 0x%.04x.\n",
 				  i);
 			goto end;
-		} else
+		} else {
 			*iter = data;
+		}
 		iter++;
 	}
 
@@ -273,8 +274,9 @@ static void ql_update_stats(struct ql_adapter *qdev)
 				  "Error reading status register 0x%.04x.\n",
 				  i);
 			goto end;
-		} else
+		} else {
 			*iter = data;
+		}
 		iter++;
 	}
 
@@ -290,8 +292,9 @@ static void ql_update_stats(struct ql_adapter *qdev)
 				  "Error reading status register 0x%.04x.\n",
 				  i);
 			goto end;
-		} else
+		} else {
 			*iter = data;
+		}
 		iter++;
 	}
 
@@ -304,8 +307,9 @@ static void ql_update_stats(struct ql_adapter *qdev)
 				  "Error reading status register 0x%.04x.\n",
 				  i);
 			goto end;
-		} else
+		} else {
 			*iter = data;
+		}
 		iter++;
 	}
 
@@ -316,8 +320,9 @@ static void ql_update_stats(struct ql_adapter *qdev)
 		netif_err(qdev, drv, qdev->ndev,
 			  "Error reading status register 0x%.04x.\n", i);
 		goto end;
-	} else
+	} else {
 		*iter = data;
+	}
 end:
 	ql_sem_unlock(qdev, qdev->xg_sem_mask);
 quit:
@@ -488,8 +493,9 @@ static int ql_start_loopback(struct ql_adapter *qdev)
 	if (netif_carrier_ok(qdev->ndev)) {
 		set_bit(QL_LB_LINK_UP, &qdev->flags);
 		netif_carrier_off(qdev->ndev);
-	} else
+	} else {
 		clear_bit(QL_LB_LINK_UP, &qdev->flags);
+	}
 	qdev->link_config |= CFG_LOOPBACK_PCS;
 	return ql_mb_set_port_cfg(qdev);
 }
-- 
2.17.1

