Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11DCC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8EAF24680
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996535;
	bh=k7kjU9j0TYsN5f6EiBfMNCH3voyuC2Mmp1NyQsEfLoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i/YOqhmmJ0IwIr00MPTdGqW0ZL3hbJt1aJudWY2tgNPr5UPwsTX+erW2YGvoQWJpU
	 aPNgA0nGfqVn7p8PGQxu+rrbidGbkDY6tDVJ30mypiSnzFt/ZDIixyXpmOEsDMfksb
	 tTx0KwURaqxcAS/kRC5b3idXqCdFqtcjPSwMfUhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731157AbgANKIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:08:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:40886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731117AbgANKIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:08:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0202924677;
        Tue, 14 Jan 2020 10:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996533;
        bh=k7kjU9j0TYsN5f6EiBfMNCH3voyuC2Mmp1NyQsEfLoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MlkzcAXTKyZoC+PMUnvNF6SKM/3C58C393e4mkTYJL6UaL+jW1G3v+mxUWHjnRsRl
         F1RRI32K7bVrSWAg8rnFdps9WAPXr233m198QbtoBH1PmwAoS2yKOhWfZzs3D7yBJf
         KZ3DCL04yoKa4K2d/glGVbBcAVBI1cKWQlJeeGeA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.19 37/46] scsi: bfa: release allocated memory in case of error
Date:   Tue, 14 Jan 2020 11:01:54 +0100
Message-Id: <20200114094347.569969550@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094339.608068818@linuxfoundation.org>
References: <20200114094339.608068818@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

commit 0e62395da2bd5166d7c9e14cbc7503b256a34cb0 upstream.

In bfad_im_get_stats if bfa_port_get_stats fails, allocated memory needs to
be released.

Link: https://lore.kernel.org/r/20190910234417.22151-1-navid.emamdoost@gmail.com
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/bfa/bfad_attr.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/scsi/bfa/bfad_attr.c
+++ b/drivers/scsi/bfa/bfad_attr.c
@@ -283,8 +283,10 @@ bfad_im_get_stats(struct Scsi_Host *shos
 	rc = bfa_port_get_stats(BFA_FCPORT(&bfad->bfa),
 				fcstats, bfad_hcb_comp, &fcomp);
 	spin_unlock_irqrestore(&bfad->bfad_lock, flags);
-	if (rc != BFA_STATUS_OK)
+	if (rc != BFA_STATUS_OK) {
+		kfree(fcstats);
 		return NULL;
+	}
 
 	wait_for_completion(&fcomp.comp);
 


