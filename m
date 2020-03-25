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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFC2C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF23208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBvMOXic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbgCYOWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:22:34 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41262 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbgCYOWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 10:22:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id b1so1205655pgm.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 07:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pcFRyCnL2SJ7lsWb00Ktgfpiha1T6QVZTxHpgve0HfA=;
        b=IBvMOXic3QYDgQSRZGPtISAPOTYAbBG+IPlPXOuv8W5fiiD/2joX9ypEKZDeqzeXtR
         9hv8+1RDYXz/f0teGPl8n/iRkNmc7DMFBw6PpIJ29ObnRdulDiQB9oz0xG2tz6jqMUXp
         cfNHYHvZPQVuVfWaa93mk4GzBZ/ynzZbbl4OwI2Pt+lARObkyRoCkY0JcZy0y8cq5u8F
         RkTgMPqCwAyUj/JuNLaeHL57azs0LRCeL12fOcQb8KK4dMmRY2sVY80+L1JsUZeYigx3
         qbNYX7PL1yYalalmDh8yUsrxxnR4f6kTkc/jcu3VtRtbXItJy3KqVugRDo6VH7/R1OKo
         talw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pcFRyCnL2SJ7lsWb00Ktgfpiha1T6QVZTxHpgve0HfA=;
        b=QNzvjSHbYqY+5ztP/x1FEUvr0lvtkWciY7gXcANJmlHM/lU8U1M/ZCBTSSNlEwI0Fk
         U6HH1yY630EVLDhPwwJubQnzVbMJFMH/KcUn4NUfnrNf2zY5Mfp2AcEuSZnUJm9HR2nc
         jeKeEP7KZpDftMn7nVFh45ZnvFEs+KiqYid2eYHtAr5WeD+uubG8FcOhctLbzZkcY26n
         O8TWs/aiQTXnIvTdMRLl/0Nax/zAT4fAQD6r1ucDgzl/HQmQyqz+aQTsAngtAnuaNfZF
         kHhi7asKz2G5f13YxJPdi36fEPj6EHAhPWafZqKQUJVHtLJOWxsJESJdXk2uzTpFW7/9
         eGow==
X-Gm-Message-State: ANhLgQ09HipX3sV/41ERCv3+nMtc18xJCt4uvyez+a/5+8RYNdYRfTPV
        1OpvJHmL9pGqPSIkK2rlxr4=
X-Google-Smtp-Source: ADFU+vsRMsStWrusCqvyO22VEA+D9RFGOgQSEUQ7ZI4dwMat4P6s70DROLp/Vz5sQI0aOgfCkLinXw==
X-Received: by 2002:a63:7359:: with SMTP id d25mr3285349pgn.2.1585146152947;
        Wed, 25 Mar 2020 07:22:32 -0700 (PDT)
Received: from simran-Inspiron-5558 ([2409:4052:78f:bb47:8124:5e4b:ea06:7595])
        by smtp.gmail.com with ESMTPSA id x4sm16570514pgi.76.2020.03.25.07.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 07:22:32 -0700 (PDT)
Date:   Wed, 25 Mar 2020 19:52:26 +0530
From:   Simran Singhal <singhalsimran0@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel <outreachy-kernel@googlegroups.com>
Subject: [PATCH] staging: rtl8723bs: Remove multiple assignments
Message-ID: <20200325142226.GA14711@simran-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove multiple assignments by factorizing them.
Problem found using checkpatch.pl:-
CHECK: multiple assignments should be avoided

Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 61a9bf61b976..744b40dd4cf0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -194,7 +194,9 @@ int rtw_init_cmd_priv(struct	cmd_priv *pcmdpriv)
 
 	pcmdpriv->rsp_buf = pcmdpriv->rsp_allocated_buf  +  4 - ((SIZE_PTR)(pcmdpriv->rsp_allocated_buf) & 3);
 
-	pcmdpriv->cmd_issued_cnt = pcmdpriv->cmd_done_cnt = pcmdpriv->rsp_cnt = 0;
+	pcmdpriv->cmd_issued_cnt = 0;
+	pcmdpriv->cmd_done_cnt = 0;
+	pcmdpriv->rsp_cnt = 0;
 
 	mutex_init(&pcmdpriv->sctx_mutex);
 exit:
@@ -2138,7 +2140,8 @@ void rtw_setassocsta_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *
 		goto exit;
 	}
 
-	psta->aid = psta->mac_id = passocsta_rsp->cam_id;
+	psta->aid = passocsta_rsp->cam_id;
+	psta->mac_id = passocsta_rsp->cam_id;
 
 	spin_lock_bh(&pmlmepriv->lock);
 
-- 
2.17.1

