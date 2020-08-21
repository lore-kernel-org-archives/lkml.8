Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782B7C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5823820732
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kE2/rzVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgHUQpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbgHUQUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:20:41 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C09C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 09:20:41 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id f19so1587148qtp.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 09:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SnctsuDqqlA5ER6TRf1wGNDf5ctTnVHX934E0v8jiKs=;
        b=kE2/rzVKhLFjVHa4TBoS4RNn4LkOQyfSEpegQ1o5S1smE6U1gjIbdzoACeuOT1w/hS
         CFwjGcSYrK3z8ltyVrRDPX1tIaueQtkdUz9d4seWs56SfVhltnNi55DrKsvW/1WK/ygp
         ewgl0UFESexwf4yIx/m3K60SiHFxgiSXaBsXgyuPY6sr7cFXcUUzM0C9F5iYcFutWwfX
         gj8tvxTERGCRPf0OuJThfFvRoTUvt+grGqDSGSU+B6sYoVOBBaa5kXcVeP6taU0fXz09
         I1k+QPCDHAbdGuNnTID+AENF2qdS+HvW0+sK2irNllXdsy1tgrRT9o+0DOSMH+TD/IFV
         kjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SnctsuDqqlA5ER6TRf1wGNDf5ctTnVHX934E0v8jiKs=;
        b=qTpp36no7g77g+j/BsPO3Ww/9s40Sm50ErTz7JXtM2UuvVbLE3dur87WgEcRv8tz4u
         GAGKhJdPGkPWN6rGl22/nXsNrSGYGmVJhmYrBHnnCLuOrRVeEtOjI3esS8978rNrq3TN
         H87KvJo8eF4VPELOwtbbuN9qE9ITbUIqlKGvQgfGOEn5BAomOwfZlzOQq4Wl+avy10z5
         uqf+MTj5psdNrCIYzckSti0ktcVvmUugVXMysrXjwH+cHMXAVA3TDOKjMU8l6Dz5wXql
         Q5BwkNIwhcJO7q2V9rTFC0kfwav5UDQ/917x6rI2/WW75ONFKcGV97YvPgT/KF2u/hFZ
         HwgA==
X-Gm-Message-State: AOAM530gDCQequfr1lx83nnQjU1arjcjxW03JWbHlm3Exm3F5OMfxupL
        4BdDke566VQI+PtJ8sS0TZo=
X-Google-Smtp-Source: ABdhPJwk5mPqN/pK3UEoSEsH0DnR8mrYFh5ZdA08dUAcPlo0SwInasFrQxXSuurg/NOrbDsr+lTOXg==
X-Received: by 2002:ac8:12cc:: with SMTP id b12mr3312871qtj.349.1598026835922;
        Fri, 21 Aug 2020 09:20:35 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c100:b9d:613a:3cfc:fb4b:2e6])
        by smtp.googlemail.com with ESMTPSA id l66sm2465030qte.48.2020.08.21.09.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 09:20:35 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     jikos@kernel.org, dsterba@suse.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ztong0001@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] tty: ipwireless: fix error handling
Date:   Fri, 21 Aug 2020 12:19:40 -0400
Message-Id: <20200821161942.36589-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821092844.GB2026@suse.cz>
References: <20200821092844.GB2026@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ipwireless_send_packet() can only return 0 on success and -ENOMEM on
error, the caller should check non zero for error condition

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---

v2: - According to Jiri's comment, I made the checking consistent with
the rest of the kernel. I also rebased the code using f684668a24ec.
Thank you Jiri!
v3: fix commit log according to David's comment, and rebased using
Greg's tty-testing tree. Thank you David!

 drivers/tty/ipwireless/network.c | 4 ++--
 drivers/tty/ipwireless/tty.c     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/ipwireless/network.c b/drivers/tty/ipwireless/network.c
index cf20616340a1..fe569f6294a2 100644
--- a/drivers/tty/ipwireless/network.c
+++ b/drivers/tty/ipwireless/network.c
@@ -117,7 +117,7 @@ static int ipwireless_ppp_start_xmit(struct ppp_channel *ppp_channel,
 					       skb->len,
 					       notify_packet_sent,
 					       network);
-			if (ret == -1) {
+			if (ret < 0) {
 				skb_pull(skb, 2);
 				return 0;
 			}
@@ -134,7 +134,7 @@ static int ipwireless_ppp_start_xmit(struct ppp_channel *ppp_channel,
 					       notify_packet_sent,
 					       network);
 			kfree(buf);
-			if (ret == -1)
+			if (ret < 0)
 				return 0;
 		}
 		kfree_skb(skb);
diff --git a/drivers/tty/ipwireless/tty.c b/drivers/tty/ipwireless/tty.c
index fad3401e604d..23584769fc29 100644
--- a/drivers/tty/ipwireless/tty.c
+++ b/drivers/tty/ipwireless/tty.c
@@ -218,7 +218,7 @@ static int ipw_write(struct tty_struct *linux_tty,
 	ret = ipwireless_send_packet(tty->hardware, IPW_CHANNEL_RAS,
 			       buf, count,
 			       ipw_write_packet_sent_callback, tty);
-	if (ret == -1) {
+	if (ret < 0) {
 		mutex_unlock(&tty->ipw_tty_mutex);
 		return 0;
 	}
-- 
2.25.1

