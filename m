Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57503C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 138F621D79
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lRr0iV7j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbgIIJnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgIIJml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:42:41 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3065C0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 02:42:39 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id v196so1802536pfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 02:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cJ2b5yC6U6sZBSPpf2NMndA3c8MuYwyg/EbWONDGDEQ=;
        b=lRr0iV7jW0zq00Y+PI9+C7cOPYDyM1oIQtYgXGw2Jok5nCprEdhOZiwh5Vp+h7I5bK
         sDVm/tVXX/1Feq/Yn7thUALZCMh8wcsS13njzNpVOyy+NKgPOQxkgpwOHjheAOj5H8PN
         jPS12IkBQ5rM8aOk+DU5/JDyzG2RLZTleokG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cJ2b5yC6U6sZBSPpf2NMndA3c8MuYwyg/EbWONDGDEQ=;
        b=jrcf+ZPoTU3IHq+SrjJo8Vb0CdDl5g+zHl4gCJ6QiE2SllcuKj0y1twY8rrhbYyX2X
         vOLPEbSrTZZpRLnciEcZ60YtBrtzWyVWBwuRKdRUkyxhhS0U7WNfGTVcYzRzWQ1359ER
         iXzmYdzBDSMAb+apauXmRTOikp/4KsLMMFG1XopDvFG+xrw6UZmrIVowYrvZwHPkoHTn
         JjVIXpI3TtOIt/G7mKjyNBGZc1/S3cA+JWA4QYRv4+PXNKX7Vjsr0hKymPYOVVAd1Mw5
         Ov4r6+tJrflmkfLEGSEni+/PgzUlMUf8Z0ASgzVj9/UO//b7s9tAXEGIgP5Ax9Y0nLfU
         4+cw==
X-Gm-Message-State: AOAM530zgiSm63eK0qq4zh7VCTJaxp3RyMLt0Gnjs3EVTolVslAQtrpX
        MHXffqECmvFz0k2P44Hf3pKkZg==
X-Google-Smtp-Source: ABdhPJy0kQhiImzPyvMTXIoe3S5XBcVzI1ubsHTbbUHt8tNPKWinvH0asFzNdG96HgDS858kUtEN9w==
X-Received: by 2002:a17:902:9349:b029:d0:cb2d:f26c with SMTP id g9-20020a1709029349b02900d0cb2df26cmr156960plp.5.1599644559530;
        Wed, 09 Sep 2020 02:42:39 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:de4a:3eff:fe7d:ff5f])
        by smtp.gmail.com with ESMTPSA id a23sm1692275pgv.86.2020.09.09.02.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 02:42:39 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: sco: expose WBS packet length in socket option
Date:   Wed,  9 Sep 2020 17:42:02 +0800
Message-Id: <20200909174129.v2.2.I03247d3813c6dcbcdbeab26d068f9fd765edb1f5@changeid>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200909094202.3863687-1-josephsih@chromium.org>
References: <20200909094202.3863687-1-josephsih@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is desirable to expose the wideband speech packet length via
a socket option to the user space so that the user space can set
the value correctly in configuring the sco connection.

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

(no changes since v1)

 net/bluetooth/sco.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index dcf7f96ff417e6..79ffcdef0b7ad5 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1001,6 +1001,12 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
 			err = -EFAULT;
 		break;
 
+	case BT_SNDMTU:
+	case BT_RCVMTU:
+		if (put_user(sco_pi(sk)->conn->mtu, (u32 __user *)optval))
+			err = -EFAULT;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
2.28.0.526.ge36021eeef-goog

