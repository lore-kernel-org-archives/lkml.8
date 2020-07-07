Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06812C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA7ED20738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KtfiWAoC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgGGOBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbgGGOBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:01:11 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81140C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:01:11 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o11so45292430wrv.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vhaBeVx21COzmeKvnb9gJbc8Z89FUyhuQpmdHktQvNU=;
        b=KtfiWAoCLK/CcBzFXZH0DW+6gnwMZ2c+Afoe7FlgDiLH/DcOmeTzvT3CLZ28OGCcLk
         BUMwFTWdx9lJz0VKuH/Y0B3Y1mi4EzQtjsGBgL1VwD4zIDyaSJKOp9N3OGwr0p1XvkwK
         wY8TeV3ixEerfVcYgVoT74cyeUVJ4DQ/n5prdBAU6gTD8jcov5a8/KoS47ByMuhEYize
         jEiVEC4KeZVxshjRGg8fBBFvEia+tj0ZDrICFHZMvaLfpJQ0U04UDOZhgcz6SpHuFn+r
         Y8fTa1GJHRTF3KbL6oTL43DcMXqaq3QH2Yu+hI2peNaMNNI2etqkDKkLOGVnDoA1ma8H
         4Tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vhaBeVx21COzmeKvnb9gJbc8Z89FUyhuQpmdHktQvNU=;
        b=R6vIia9ZN2TMKlwuIuP/yH/wzVc2ibqq+he9ExRYQMBqX/sHcVb4U40F93ym4bwVn4
         XTVC7b2Qnkg6oUnhuQ8rgHxcYKXEfg1JsS7JY2921YQdwPZIesS0YLPTzzmyptVfFlHZ
         Nt2oNp9K1b0aSladBf4FIfRfc2k3b4OUNxUmDsPesoVq51buFTCLKYA+il1phc38Z8nG
         EhcRrnhebXnMGmCVU3HE9lSudYXSI3bNuSPthk63w1hx7Y4ZWo8TD8w4KDZF/YlTIdYL
         KKCZnRgVM8mxzAo6fY+EBcpqcaS3K2MqcdY6c74652wvY7mkGCPK+lfDdgzZobXilgTL
         Fbmg==
X-Gm-Message-State: AOAM530flpDsC/9h0mBuM3eC/GNcP3B7xc6qgkzESExMHQQgexd5L6vq
        zV5We6zchAm36Jwo40tIbb3m9o+VV5w=
X-Google-Smtp-Source: ABdhPJwu+ESA+SEzUKUARUNrHJI/19OQ9CJ+6yAjcqNN7zpyPDfFUIUE0XxR14tt9XDWcrNGAZqbeg==
X-Received: by 2002:adf:cf0c:: with SMTP id o12mr53592490wrj.265.1594130470272;
        Tue, 07 Jul 2020 07:01:10 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id z25sm1102823wmk.28.2020.07.07.07.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:01:09 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 09/10] scsi: libfc: fc_disc: Fix-up some incorrectly referenced function parameters
Date:   Tue,  7 Jul 2020 15:00:54 +0100
Message-Id: <20200707140055.2956235-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707140055.2956235-1-lee.jones@linaro.org>
References: <20200707140055.2956235-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/libfc/fc_disc.c:343: warning: Function parameter or member 'disc' not described in 'fc_disc_gpn_ft_req'
 drivers/scsi/libfc/fc_disc.c:343: warning: Excess function parameter 'lport' description in 'fc_disc_gpn_ft_req'
 drivers/scsi/libfc/fc_disc.c:380: warning: Function parameter or member 'disc' not described in 'fc_disc_gpn_ft_parse'
 drivers/scsi/libfc/fc_disc.c:380: warning: Excess function parameter 'lport' description in 'fc_disc_gpn_ft_parse'
 drivers/scsi/libfc/fc_disc.c:498: warning: Function parameter or member 'disc_arg' not described in 'fc_disc_gpn_ft_resp'
 drivers/scsi/libfc/fc_disc.c:498: warning: Excess function parameter 'lp_arg' description in 'fc_disc_gpn_ft_resp'

Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/libfc/fc_disc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/libfc/fc_disc.c b/drivers/scsi/libfc/fc_disc.c
index 2b865c6423e29..428f40cfd1c36 100644
--- a/drivers/scsi/libfc/fc_disc.c
+++ b/drivers/scsi/libfc/fc_disc.c
@@ -337,7 +337,7 @@ static void fc_disc_error(struct fc_disc *disc, struct fc_frame *fp)
 
 /**
  * fc_disc_gpn_ft_req() - Send Get Port Names by FC-4 type (GPN_FT) request
- * @lport: The discovery context
+ * @disc: The discovery context
  */
 static void fc_disc_gpn_ft_req(struct fc_disc *disc)
 {
@@ -370,7 +370,7 @@ static void fc_disc_gpn_ft_req(struct fc_disc *disc)
 
 /**
  * fc_disc_gpn_ft_parse() - Parse the body of the dNS GPN_FT response.
- * @lport: The local port the GPN_FT was received on
+ * @disc:  The descovery context
  * @buf:   The GPN_FT response buffer
  * @len:   The size of response buffer
  *
@@ -488,7 +488,7 @@ static void fc_disc_timeout(struct work_struct *work)
  * fc_disc_gpn_ft_resp() - Handle a response frame from Get Port Names (GPN_FT)
  * @sp:	    The sequence that the GPN_FT response was received on
  * @fp:	    The GPN_FT response frame
- * @lp_arg: The discovery context
+ * @disc_arg: The discovery context
  *
  * Locking Note: This function is called without disc mutex held, and
  *		 should do all its processing with the mutex held
-- 
2.25.1

