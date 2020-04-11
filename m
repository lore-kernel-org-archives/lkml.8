Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58B3C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1FE21556
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607252;
	bh=wGXvAvLnfJ6NWQrIy69NGR+MFT+eCM2KgZp7EqI1qx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J516CVl5PflgmDfp87YbKrVb4kwl5fwwmhiiSK1h92Bq91yrHTDiT7vbr7upp5a2N
	 gSXZWKashqrveVb0+8c7oxOf2eDtYH4wFvBXy1y2mMuHhiZcr1TCZgTiHcE0Ih9JB6
	 BJf57A0t0FCuv8RUNaADGh/W3EuG+OS/+X5FzzTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgDKMOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:14:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbgDKMOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:14:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBE1F216FD;
        Sat, 11 Apr 2020 12:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607245;
        bh=wGXvAvLnfJ6NWQrIy69NGR+MFT+eCM2KgZp7EqI1qx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=so9GzSVB9oZ2tZxTR15tgG8WTwznQfDkd5Yt3+fZzWT2uiV/x9BW3nibVIKNRDohO
         lOvZLF4KA3/WN7ZU1DpzRFGak9v7KKlQbQoMkEn9WjDcfJheU2ZFbg15xJNubtebWd
         FRfXM7/xYCGtiErH/Z8svEfPmIxqsIYXgO7YooN0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>,
        Grzegorz Burzynski <grzegorz.burzynski@intel.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.14 32/38] acpi/nfit: Fix bus command validation
Date:   Sat, 11 Apr 2020 14:09:16 +0200
Message-Id: <20200411115440.974333990@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115437.795556138@linuxfoundation.org>
References: <20200411115437.795556138@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

commit ebe9f6f19d80d8978d16078dff3d5bd93ad8d102 upstream.

Commit 11189c1089da "acpi/nfit: Fix command-supported detection" broke
ND_CMD_CALL for bus-level commands. The "func = cmd" assumption is only
valid for:

    ND_CMD_ARS_CAP
    ND_CMD_ARS_START
    ND_CMD_ARS_STATUS
    ND_CMD_CLEAR_ERROR

The function number otherwise needs to be pulled from the command
payload for:

    NFIT_CMD_TRANSLATE_SPA
    NFIT_CMD_ARS_INJECT_SET
    NFIT_CMD_ARS_INJECT_CLEAR
    NFIT_CMD_ARS_INJECT_GET

Update cmd_to_func() for the bus case and call it in the common path.

Fixes: 11189c1089da ("acpi/nfit: Fix command-supported detection")
Cc: <stable@vger.kernel.org>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
Reported-by: Grzegorz Burzynski <grzegorz.burzynski@intel.com>
Tested-by: Jeff Moyer <jmoyer@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/acpi/nfit/core.c |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -214,7 +214,7 @@ static int cmd_to_func(struct nfit_mem *
 	if (call_pkg) {
 		int i;
 
-		if (nfit_mem->family != call_pkg->nd_family)
+		if (nfit_mem && nfit_mem->family != call_pkg->nd_family)
 			return -ENOTTY;
 
 		for (i = 0; i < ARRAY_SIZE(call_pkg->nd_reserved2); i++)
@@ -223,6 +223,10 @@ static int cmd_to_func(struct nfit_mem *
 		return call_pkg->nd_command;
 	}
 
+	/* In the !call_pkg case, bus commands == bus functions */
+	if (!nfit_mem)
+		return cmd;
+
 	/* Linux ND commands == NVDIMM_FAMILY_INTEL function numbers */
 	if (nfit_mem->family == NVDIMM_FAMILY_INTEL)
 		return cmd;
@@ -238,6 +242,7 @@ int acpi_nfit_ctl(struct nvdimm_bus_desc
 		unsigned int cmd, void *buf, unsigned int buf_len, int *cmd_rc)
 {
 	struct acpi_nfit_desc *acpi_desc = to_acpi_nfit_desc(nd_desc);
+	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
 	union acpi_object in_obj, in_buf, *out_obj;
 	const struct nd_cmd_desc *desc = NULL;
 	struct device *dev = acpi_desc->dev;
@@ -252,18 +257,18 @@ int acpi_nfit_ctl(struct nvdimm_bus_desc
 	if (cmd_rc)
 		*cmd_rc = -EINVAL;
 
+	if (cmd == ND_CMD_CALL)
+		call_pkg = buf;
+	func = cmd_to_func(nfit_mem, cmd, call_pkg);
+	if (func < 0)
+		return func;
+
 	if (nvdimm) {
-		struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
 		struct acpi_device *adev = nfit_mem->adev;
 
 		if (!adev)
 			return -ENOTTY;
 
-		if (cmd == ND_CMD_CALL)
-			call_pkg = buf;
-		func = cmd_to_func(nfit_mem, cmd, call_pkg);
-		if (func < 0)
-			return func;
 		dimm_name = nvdimm_name(nvdimm);
 		cmd_name = nvdimm_cmd_name(cmd);
 		cmd_mask = nvdimm_cmd_mask(nvdimm);
@@ -274,12 +279,9 @@ int acpi_nfit_ctl(struct nvdimm_bus_desc
 	} else {
 		struct acpi_device *adev = to_acpi_dev(acpi_desc);
 
-		func = cmd;
 		cmd_name = nvdimm_bus_cmd_name(cmd);
 		cmd_mask = nd_desc->cmd_mask;
-		dsm_mask = cmd_mask;
-		if (cmd == ND_CMD_CALL)
-			dsm_mask = nd_desc->bus_dsm_mask;
+		dsm_mask = nd_desc->bus_dsm_mask;
 		desc = nd_cmd_bus_desc(cmd);
 		guid = to_nfit_uuid(NFIT_DEV_BUS);
 		handle = adev->handle;


