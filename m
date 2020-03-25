Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80ACCC2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 18:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59CBC2074D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 18:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLQ5jdqM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgCYS01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 14:26:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40519 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbgCYS00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 14:26:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id l184so1453372pfl.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 11:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=rdOwQ11n3cpKxP1BnmbKbCp9D6XytaUHGx7F/xFAJIw=;
        b=YLQ5jdqMUqkf5nUdhOeIqGBUKQMvKSU5dOE/f/on/yy1ZjkRYbO+QC0yH3loc1RBrI
         8vq2BARKAuVLS4B4rkewceFxkPUnbVuNcwx2TvXQGBJ/uyM5cua7oqCYDdFD4x3Qcf0P
         MVGIUCA8QeCEVWeuBNNruftZGmJfbxGwCw+w6rJpBshpXXluQcFANXQ3c0FkhgzZYold
         xF/N7snIgVzB7mPP3fxPlFSbTWs4Ln5Y9VO1dBgN8ri9Gy0O8IL1IC2rNKJS/Tcc0JBW
         Dr8qmOckxGoJMz/fdhJbasckqIEXNxe2IeItDFu9BvwmDJi8TL9a7Dqris43Fi0Ru1AX
         TkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rdOwQ11n3cpKxP1BnmbKbCp9D6XytaUHGx7F/xFAJIw=;
        b=oVb91LojawCMIXlEIxhm5RQ/DwQbREWJ1lyBULCCDd4siKHtgKeWPwdM3KVDeDpphR
         9AecPUnS+vwt1HB+7V+lv2aP+zx0gVtYgiE/Fp4fCbjdxgklxz+uIgl0Ra+EIOxqxM2P
         OFdmU1NbDk+hocnINjCoH6cincZdd4ivmjwSuMVSkLll1L3/oWLkqzOaps1r4O0JpFel
         AE/2u0xfJwgmMVO/gP6AS5tm2URo/nDjmlTi25B9qvaQBPpLapvpD1Asvgvgw61oHu78
         Ipg1elZGMejUGsZE+7QPdZt87Omy9M8R3Iwuh1Ard3VBs4g+2OOQoiQGDvFO+QlxPAmz
         8oMg==
X-Gm-Message-State: ANhLgQ0NmthtUbnF3VEteBaiGe/7OQcPShPbnBH+pIkDKNcMyKxl0GCp
        Om+RLMQm+UEJCc3S6Ukmd8w=
X-Google-Smtp-Source: ADFU+vsM45qbZaWKmVwyap6q+4eaKiz8s3B6hIo9eHBtONe002wIdWM4MSOoHZzu9/ZTnRrNQxFHIA==
X-Received: by 2002:a63:df15:: with SMTP id u21mr4022987pgg.95.1585160785420;
        Wed, 25 Mar 2020 11:26:25 -0700 (PDT)
Received: from simran-Inspiron-5558 ([2409:4052:78f:bb47:8124:5e4b:ea06:7595])
        by smtp.gmail.com with ESMTPSA id k6sm4160953pfa.214.2020.03.25.11.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 11:26:24 -0700 (PDT)
Date:   Wed, 25 Mar 2020 23:56:17 +0530
From:   Simran Singhal <singhalsimran0@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH] staging: rtl8723bs: Remove blank line before '}' brace
Message-ID: <20200325182617.GA9411@simran-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded blank line before a close brace '}'.
Issue found by checkpatch.pl:
CHECK: Blank lines aren't necessary before a close brace '}'

Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_security.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
index 9c4607114cea..5ebf691bd743 100644
--- a/drivers/staging/rtl8723bs/core/rtw_security.c
+++ b/drivers/staging/rtl8723bs/core/rtw_security.c
@@ -434,7 +434,6 @@ void rtw_seccalctkipmic(u8 *key, u8 *header, u8 *data, u32 data_len, u8 *mic_cod
 			rtw_secmicappend(&micdata, &header[16], 6);
 		else
 			rtw_secmicappend(&micdata, &header[10], 6);
-
 	}
 	rtw_secmicappend(&micdata, &priority[0], 4);
 
@@ -723,7 +722,6 @@ u32 rtw_tkip_encrypt(struct adapter *padapter, u8 *pxmitframe)
 
 			TKIP_SW_ENC_CNT_INC(psecuritypriv, pattrib->ra);
 		}
-
 	}
 	return res;
 }
@@ -829,11 +827,9 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
 			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo == NULL!!!\n", __func__));
 			res = _FAIL;
 		}
-
 	}
 exit:
 	return res;
-
 }
 
 
@@ -1219,7 +1215,6 @@ static void construct_mic_header2(
 		if (!qc_exists && a4_exists) {
 			for (i = 0; i < 6; i++)
 				mic_header2[8+i] = mpdu[24+i];   /* A4 */
-
 		}
 
 		if (qc_exists && !a4_exists) {
@@ -1234,7 +1229,6 @@ static void construct_mic_header2(
 			mic_header2[14] = mpdu[30] & 0x0f;
 			mic_header2[15] = mpdu[31] & 0x00;
 		}
-
 }
 
 /************************************************/
@@ -1413,7 +1407,6 @@ static sint aes_cipher(u8 *key, uint	hdrlen,
 		}
 		bitwise_xor(aes_out, padded_buffer, chain_buffer);
 		aes128k128d(key, chain_buffer, aes_out);
-
 	}
 
 	for (j = 0 ; j < 8; j++)
@@ -1719,7 +1712,6 @@ static sint aes_decipher(u8 *key, uint	hdrlen,
 		}
 		bitwise_xor(aes_out, padded_buffer, chain_buffer);
 		aes128k128d(key, chain_buffer, aes_out);
-
 	}
 
 	for (j = 0; j < 8; j++)
-- 
2.17.1

