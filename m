Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9484FC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 04:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D8662065D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 04:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="IqQlDriT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgFNELx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 00:11:53 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:57790 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgFNELw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 00:11:52 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 49l1Hq4mKNz9vLGn
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 04:11:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 57voik6cttqY for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 23:11:51 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 49l1Hq352nz9vKm1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 23:11:51 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 49l1Hq352nz9vKm1
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 49l1Hq352nz9vKm1
Received: by mail-io1-f70.google.com with SMTP id t23so9014351iog.21
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 21:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KC6zFgxNsc5i6RYHX88wWeIzq9Ejx9oIVhgo1IScugw=;
        b=IqQlDriTeCK4A5zHXVVSnvggbs/sTiwYUzOMpnAbR67ctwGU+H7IEcpgGMJkGQAo7S
         yXaR8M0lY+w/P0bGqQcL9/btZhNGRpsAfgklUHzQzDnm14Tn8GEhbjSa2YREXHBH7v5I
         LV1mZRP8v7O9Fm3jImg+WpnZuK7KAUFjtkXkHBSJ2ZzXu25WuHy92XDtqpSuKUozVO3t
         ryAHD9+6RjI9beD79g4Q6A22JZHUB6MeqyQ6xlV1vYpqZXWjyoe6+yZ6syFuv3uJdA2n
         HEoTRiYMyX+E5xAacYxCjFH5BN2OKM5NgdXJhu5/zEuYOtAbFXzwxlv66uoMEFD8+Ui/
         oxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KC6zFgxNsc5i6RYHX88wWeIzq9Ejx9oIVhgo1IScugw=;
        b=GH3+weC2GOtSy+xa8JmOBown1G34kNBzmgzt/gCz/fHhbW1SHTDGNAmEyZdnEpvELH
         gFYxB8gDf280Qz0nvoUD+xdzFnRGOp9o4otYl+4QRvFUwNOBGZAboEB+EDY8vCVzfKiZ
         IFCbYPRtr3SmKud7G3x1U59QuPiKKs14H1BDRSDsf5RexZ4dA6cxKZlkB4UHhkusGTPV
         j8GuapFUatPd4YCYaStIp8k6Lkis4cVuBtUkBeYXyqPBp18dMPHWXSzDLs6XXwxkGjuI
         O/ivsJAQxD2fRFKA+m/E+POsu7/Mc2EkxEqBTMY21ihwArt90pkTD7aqzVdcJESelSOJ
         ovvw==
X-Gm-Message-State: AOAM533GDkQBQ5/ivk61Xe557T/ArZhXqak/5oSsno2jPiSYO/S0pF7i
        IpG+qekn59W9vr9VomWVXhLfFnXllBA7wgtRS8B0wWk4EifEdpDMcs6LMLf30Ls9Yn0NH51/VFY
        vgCSeMttA96dU2Jh0XkXxyzFLM8qM
X-Received: by 2002:a02:7707:: with SMTP id g7mr15392319jac.141.1592107910964;
        Sat, 13 Jun 2020 21:11:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtCRdKzwjxRQ0dPkIx/477rD6VMwHukV6xzi3GW4hTAEOEmvtzJgyDAPGOuSoS2l0ICeb2EA==
X-Received: by 2002:a02:7707:: with SMTP id g7mr15392311jac.141.1592107910725;
        Sat, 13 Jun 2020 21:11:50 -0700 (PDT)
Received: from syssec1.cs.umn.edu ([2607:ea00:101:3c74:49fa:9c47:e40b:9c40])
        by smtp.gmail.com with ESMTPSA id h14sm5708734ilo.10.2020.06.13.21.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 21:11:50 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, wu000273@umn.edu,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] RDMA/rvt: Fix potential memory leak caused by rvt_alloc_rq
Date:   Sat, 13 Jun 2020 23:11:48 -0500
Message-Id: <20200614041148.131983-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of failure of alloc_ud_wq_attr(), the memory allocated by
rvt_alloc_rq() is not freed. Fix it by calling rvt_free_rq() using
the existing clean-up code.

Fixes: d310c4bf8aea ("IB/{rdmavt, hfi1, qib}: Remove AH refcount for UD QPs")
Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
v1: Fix incorrect order of  rvt_free_rq and free_ud_wq_attr.
Suggested by Dennis Dalessandro.
---
 drivers/infiniband/sw/rdmavt/qp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index 511b72809e14..7db35dd6ad74 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -1204,7 +1204,7 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
 		err = alloc_ud_wq_attr(qp, rdi->dparms.node);
 		if (err) {
 			ret = (ERR_PTR(err));
-			goto bail_driver_priv;
+			goto bail_rq_rvt;
 		}
 
 		if (init_attr->create_flags & IB_QP_CREATE_NETDEV_USE)
@@ -1314,9 +1314,11 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
 	rvt_free_qpn(&rdi->qp_dev->qpn_table, qp->ibqp.qp_num);
 
 bail_rq_wq:
-	rvt_free_rq(&qp->r_rq);
 	free_ud_wq_attr(qp);
 
+bail_rq_rvt:
+	rvt_free_rq(&qp->r_rq);
+
 bail_driver_priv:
 	rdi->driver_f.qp_priv_free(rdi, qp);
 
-- 
2.25.1

