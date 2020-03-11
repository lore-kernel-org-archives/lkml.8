Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0342AC18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 01:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A28222C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 01:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSWmNcSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgCKB0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 21:26:52 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43019 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbgCKB0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 21:26:51 -0400
Received: by mail-qk1-f194.google.com with SMTP id q18so553375qki.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 18:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UCtkFFyzWvdtpD3qcxemfQRR6JkYt3csnpIWX56p83w=;
        b=QSWmNcSQr6Dkhtf0ataFvPH3lyriSK8dTS69dj+OPApW2rIc2GcT04dSBSF5V1x1wd
         ujvfnHj3wXmHGCeWq5zbM73TusV6OlJgMKTR17sNw+ve1yjX52vdIMJ0azaORdle1BWc
         1Nk2yxDdV7mdUGXgrhudtxPNLhJpXu1gX/o1qo9UOJ69fIleQcAvt1jZHpgQADZusMcG
         6uLVoY8QgxNNN28Mq2O1VDi9A3nhNSTfBZq1PF1ph/MAR/+U7pwooP33eubml8nSASax
         KOaUtsv+z3iepBlPQT6AHsiNdcOWH1Z++3W2998AImEWZkENL/9QbaJcvOYR3Y+PeQeH
         SV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UCtkFFyzWvdtpD3qcxemfQRR6JkYt3csnpIWX56p83w=;
        b=oxWiXhvwtZZEWQ1VFmsR3Re0fgwt5O6JTZFnUIlGDcGu82OyqlhIbfZ324PE3CuMnY
         dVzcvhpv6QvHrJaXlJ0P/vav9L8bA5iJcPuipO7eNbEBQGBgG7wTSonVc4pJdFeL/p6R
         Wbtmxa1Q6DTlnDxZWwSjfv2ml6VVtJLmHTNgvJ7bPswn6pjW2ABOiIwzg9Q9oH+MaHkh
         FLSWqXh0Sx8MoxPOg7tyOmQ5Old+Mxwypp2i3BMehCmt3eev8Pjgdy/S30638/y9hdg0
         kzASDv13sZW46u4mRXi6U3FHOU9eOiG7JMip1m5Ub0ZgiPZj7Xl6qVi8fTATVOLABCP2
         rRmA==
X-Gm-Message-State: ANhLgQ05WdsWyUkJG0/vFdDhDo9rkkKfO/uGYF4uTP3AMQzSe7uGB3SO
        VBofu6X2DYDSSCmAcCq7kvA=
X-Google-Smtp-Source: ADFU+vs80U7uCDpKBrjfjFYBr8EBQ2qV/rC3KPBixrmZP2xvYFRmkKkdFVIp35YjnPAtklWA7Ils0A==
X-Received: by 2002:a05:620a:1644:: with SMTP id c4mr572113qko.315.1583890009650;
        Tue, 10 Mar 2020 18:26:49 -0700 (PDT)
Received: from 171489447db2.ic.unicamp.br (wifi-177-220-84-20.wifi.ic.unicamp.br. [177.220.84.20])
        by smtp.gmail.com with ESMTPSA id k202sm12193192qke.134.2020.03.10.18.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 18:26:48 -0700 (PDT)
From:   Andre Pinto <andrealmeidap1996@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Subject: [PATCH] staging: rtl8188eu: fix typo s/informations/information
Date:   Wed, 11 Mar 2020 01:26:38 +0000
Message-Id: <20200311012638.18889-1-andrealmeidap1996@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch check: 'informations' may be misspelled - perhaps
'information'? in rtw_mlme_ext.c:1151.

Signed-off-by: Andre Pinto <andrealmeidap1996@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 36841d20c..04897cd48 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -1151,7 +1151,7 @@ static void issue_assocreq(struct adapter *padapter)
 				if (!padapter->registrypriv.wifi_spec) {
 					/* Commented by Kurt 20110629 */
 					/* In some older APs, WPS handshake */
-					/* would be fail if we append vender extensions informations to AP */
+					/* would be fail if we append vender extensions information to AP */
 					if (!memcmp(pIE->data, WPS_OUI, 4))
 						pIE->Length = 14;
 				}
-- 
2.20.1

