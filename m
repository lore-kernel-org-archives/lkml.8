Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67710C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 21:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E3E320885
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 21:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="cT3EKhb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgHMVEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 17:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgHMVE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 17:04:29 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD67FC061384
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 14:04:28 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id v22so5491071qtq.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 14:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fP9lP5J3iDMYf8rHzghnKH6TXtdMcDE1b3S5bi4nUEU=;
        b=cT3EKhb5eeN0mTmMlyXvcbBoen4kpRz9MkJyXeAirYXUWdz02tUwkvQXECmNg+TkaD
         jzU6fsqB4ZGIum35WEjTvUUcDvDvHZIzBBiA99mcqr3/lGUWb2X0BA2O0/fnivLH8p2V
         NzV95903xJU32+dWivod7qGlYAgyNtu3GJhgERYcqyCXiXKYZQsrbP0PPc8qL1MXoJ+u
         HmPvz2cLV+Jol1enJaQVaj/DEeEDovYu6GxmNm14KpsdFmjGuYlWtj9gct9fAIvvLBOs
         yY/WxWHzhr/G+ajuBOVOkYtBmLjs56+vL2Y0V/ycCP5A3KUIjBdJt5NhbmLkAZaIc7H2
         C5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fP9lP5J3iDMYf8rHzghnKH6TXtdMcDE1b3S5bi4nUEU=;
        b=JhW8hlyDGZAr6P0UVkxC0SElfO2IfVDLu1i8LPBuv1zeuN0YnQZOc447TH0AecSJ5Y
         1XnYTajyIHZ2lcFPNEPnoilxauinrahGFqYJ2hQe3P2J3NafAjZJSAOEuRA5qCeQQDzR
         lcL1D1Yxv+Qy+6RzFC+ZoHkJrB5ywShcIuwWtuInd6mftKKt/dcH8WPnPYAxmS6c1c8T
         nv/XCDnavdn0RCs0o5NNsT8vpMxxgBrRRSFvV766vsmhCjS78B6hUPvba9/BJWhEFfKp
         dXbR/VacyltJYUdB9bdu1GIRMzEKF64GiLIoRlx7Ly7vq39mM0EsRa6nTho4uiFHwX9a
         FNUg==
X-Gm-Message-State: AOAM530NACEL+ohayxcLMLjbWiK424ESi2lnrUsU4jWSK7xMAkxvdxYf
        Je1HKfIw2A+TS8EoKN03ndwHZw==
X-Google-Smtp-Source: ABdhPJzswgyzPU1h7n0HxzeOaC1WtFB0NHM2erdCX+zd7HARBrYyuExecLpPjtSgwW9qEwus5zGumw==
X-Received: by 2002:ac8:748b:: with SMTP id v11mr7121989qtq.293.1597352667526;
        Thu, 13 Aug 2020 14:04:27 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s30sm8077804qtc.87.2020.08.13.14.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 14:04:26 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     hch@lst.de, viro@ZenIV.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        kernel-team@fb.com
Subject: [PATCH 6/6] sunrpc: rework proc handlers to take advantage of the new buffer
Date:   Thu, 13 Aug 2020 17:04:11 -0400
Message-Id: <20200813210411.905010-7-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200813210411.905010-1-josef@toxicpanda.com>
References: <20200813210411.905010-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we're allocating an extra slot for the NULL terminated string,
use scnprintf() and write directly into the buffer.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/sunrpc/sysctl.c            | 10 ++--------
 net/sunrpc/xprtrdma/svc_rdma.c | 16 ++--------------
 2 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/net/sunrpc/sysctl.c b/net/sunrpc/sysctl.c
index 999eee1ed61c..31ed530d9846 100644
--- a/net/sunrpc/sysctl.c
+++ b/net/sunrpc/sysctl.c
@@ -117,14 +117,8 @@ proc_dodebug(struct ctl_table *table, int write, void *buffer, size_t *lenp,
 		if (strcmp(table->procname, "rpc_debug") == 0)
 			rpc_show_tasks(&init_net);
 	} else {
-		len = sprintf(tmpbuf, "0x%04x", *(unsigned int *) table->data);
-		if (len > left)
-			len = left;
-		memcpy(buffer, tmpbuf, len);
-		if ((left -= len) > 0) {
-			*((char *)buffer + len) = '\n';
-			left--;
-		}
+		len = scnprintf(buffer, *lenp, "0x%04x\n", *(unsigned int *) table->data);
+		left -= len;
 	}
 
 done:
diff --git a/net/sunrpc/xprtrdma/svc_rdma.c b/net/sunrpc/xprtrdma/svc_rdma.c
index 526da5d4710b..9b3a113598af 100644
--- a/net/sunrpc/xprtrdma/svc_rdma.c
+++ b/net/sunrpc/xprtrdma/svc_rdma.c
@@ -90,20 +90,8 @@ static int read_reset_stat(struct ctl_table *table, int write,
 	if (write)
 		atomic_set(stat, 0);
 	else {
-		char str_buf[32];
-		int len = snprintf(str_buf, 32, "%d\n", atomic_read(stat));
-		if (len >= 32)
-			return -EFAULT;
-		len = strlen(str_buf);
-		if (*ppos > len) {
-			*lenp = 0;
-			return 0;
-		}
-		len -= *ppos;
-		if (len > *lenp)
-			len = *lenp;
-		if (len)
-			memcpy(buffer, str_buf, len);
+		size_t len = scnprintf(buffer, *lenp, "%d\n",
+				       atomic_read(stat));
 		*lenp = len;
 		*ppos += len;
 	}
-- 
2.24.1

