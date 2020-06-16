Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30155C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 053AC20776
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592322457;
	bh=ruNSsfJCTPonu4mLKTusIRA8aOSqZO700jsa+VZrv2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nov8QD/ZGaiFzFBq7ayrnJyeyBBS5imMvXFzmTUsW2PzaXQbkI4iooJQ3jFNPTK9e
	 XmEEDhZPH5zYlCkU4RmgaJAT+z0tNaElKZkgK+Oy+jhv2nrAEiUtE304nd8lprsWvP
	 IknfD5mc/bJWhzSSijrhmjJR6zYXNYHBYNHeqKuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732350AbgFPPrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:47:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732341AbgFPPr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:47:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B771D2071A;
        Tue, 16 Jun 2020 15:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322448;
        bh=ruNSsfJCTPonu4mLKTusIRA8aOSqZO700jsa+VZrv2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O0Ku2j8y9/s5grrH6/67FqqYwHOKeHg3tCN/ViGDOkyOcRzVS6u+vPm07/DD8iZ34
         AZWpPggTliKs/m7zXmT/qyWcFNA3yrYe60MFC/R/RHjtl5WVeq1RjR6c33ekfFxpuc
         53gUW5AmalYK/zjnSb3ni6xr+ASV8Bn4J6l0ddRk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <jsmart2021@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.7 136/163] scsi: lpfc: Fix negation of else clause in lpfc_prep_node_fc4type
Date:   Tue, 16 Jun 2020 17:35:10 +0200
Message-Id: <20200616153113.323720714@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.849127260@linuxfoundation.org>
References: <20200616153106.849127260@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dick Kennedy <dick.kennedy@broadcom.com>

commit f809da6db68a8be49e317f0ccfbced1af9258839 upstream.

Implementation of a previous patch added a condition to an if check that
always end up with the if test being true. Execution of the else clause was
inadvertently negated.  The additional condition check was incorrect and
unnecessary after the other modifications had been done in that patch.

Remove the check from the if series.

Link: https://lore.kernel.org/r/20200501214310.91713-5-jsmart2021@gmail.com
Fixes: b95b21193c85 ("scsi: lpfc: Fix loss of remote port after devloss due to lack of RPIs")
Cc: <stable@vger.kernel.org> # v5.4+
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/lpfc/lpfc_ct.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -462,7 +462,6 @@ lpfc_prep_node_fc4type(struct lpfc_vport
 	struct lpfc_nodelist *ndlp;
 
 	if ((vport->port_type != LPFC_NPIV_PORT) ||
-	    (fc4_type == FC_TYPE_FCP) ||
 	    !(vport->ct_flags & FC_CT_RFF_ID) || !vport->cfg_restrict_login) {
 
 		ndlp = lpfc_setup_disc_node(vport, Did);


