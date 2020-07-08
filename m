Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FA6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9FB420739
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pxXV0EYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgGHMCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729059AbgGHMCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:02:42 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918B2C08E81A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 05:02:41 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so2734410wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 05:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PUEEoaUyF+s08hE4dARneQxf1Covum7aHqB9FrCQqkg=;
        b=pxXV0EYbO/Efhe2l4FrwNUHf3aw91pdWOupfVC6/0ixxbUMs5OuGizocqMJNMZzYDb
         p99Kk593i/aTNpYlRIHL4qJnB+nMqMw5jpLA3QI34FM1tvDcip5cse0QZ0ymPnhQvGMR
         M8yLIIYKhbXqe242v/hCKN4SQHrpvSyAO/8cRKhfaUYiksC872hREKWmbbgcoaE2vNws
         LwiK4DKh2h8n34GK46+eoruCag26JNpB5IbScXXbhULDPH9Ukye4/J++DodbIP+z4iG7
         AbnL2aAKpoqL44rwUWi29SoDwp/az05LGAWp7NPAznlDkT14oMqei6dkKRqkf/CvCQ2K
         lUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PUEEoaUyF+s08hE4dARneQxf1Covum7aHqB9FrCQqkg=;
        b=lFNJOo0LwK4R+6+a/9UWeF3P/W/aBHuz3Po/RXXyl3DN7MCMmrxwZSpyce442vOYsp
         qwMTFt4zlexfhFal1kjMScmOT1cq8s9gkfCeNutlF0rFjjjTTcAu5tsQ/+FQy73hfapr
         T1g+yfEI2b1UEhBujkZIKasMUnsOvnlSVqtVVhWtOW2/LQ+A5HWyEuLPcS1t+FWrUzjo
         rS7ufG2SoyejuGw/t747tyuFj6mPzRm8UQvgPJtxQEvTVFH/7sk7GKgG6xp40OS5qQX0
         DSfml7RjallW/QLH5EP9ok82HJl37WB0ErPE0Ul7Gk11gBIADywCQJV0f2TxWNzeglhb
         Alog==
X-Gm-Message-State: AOAM531Oaasqx1/btHXK1sgh9Y2DEhTosmUPl6ydRDS7QhTbyB8fr5Gn
        XH6Xz3i3JB5zpCmyETSu49lnvdEBvXE=
X-Google-Smtp-Source: ABdhPJzxdA+vdJ9AscwTb1wWQzpErI8U1G4NExOlK6INLjHkDA9iMum4ZAxybvC6e7lyHjZyUYKJlg==
X-Received: by 2002:a1c:6354:: with SMTP id x81mr8672065wmb.98.1594209760335;
        Wed, 08 Jul 2020 05:02:40 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id m62sm3964997wmm.42.2020.07.08.05.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 05:02:39 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 11/30] scsi: libfc: fc_rport: Fix a couple of misdocumented function parameters
Date:   Wed,  8 Jul 2020 13:02:02 +0100
Message-Id: <20200708120221.3386672-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708120221.3386672-1-lee.jones@linaro.org>
References: <20200708120221.3386672-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/libfc/fc_rport.c:129: warning: Function parameter or member 'port_id' not described in 'fc_rport_create'
 drivers/scsi/libfc/fc_rport.c:129: warning: Excess function parameter 'ids' description in 'fc_rport_create'
 drivers/scsi/libfc/fc_rport.c:1452: warning: Function parameter or member 'rdata_arg' not described in 'fc_rport_logo_resp'
 drivers/scsi/libfc/fc_rport.c:1452: warning: Excess function parameter 'lport_arg' description in 'fc_rport_logo_resp'

Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/libfc/fc_rport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/libfc/fc_rport.c b/drivers/scsi/libfc/fc_rport.c
index 278d15ff1c5ae..ea99e69d4d89c 100644
--- a/drivers/scsi/libfc/fc_rport.c
+++ b/drivers/scsi/libfc/fc_rport.c
@@ -121,7 +121,7 @@ EXPORT_SYMBOL(fc_rport_lookup);
 /**
  * fc_rport_create() - Create a new remote port
  * @lport: The local port this remote port will be associated with
- * @ids:   The identifiers for the new remote port
+ * @port_id:   The identifiers for the new remote port
  *
  * The remote port will start in the INIT state.
  */
@@ -1445,7 +1445,7 @@ static void fc_rport_recv_rtv_req(struct fc_rport_priv *rdata,
  * fc_rport_logo_resp() - Handler for logout (LOGO) responses
  * @sp:	       The sequence the LOGO was on
  * @fp:	       The LOGO response frame
- * @lport_arg: The local port
+ * @rport_arg: The local port
  */
 static void fc_rport_logo_resp(struct fc_seq *sp, struct fc_frame *fp,
 			       void *rdata_arg)
-- 
2.25.1

