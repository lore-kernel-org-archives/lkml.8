Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC4DC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BEEE2072B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587386449;
	bh=jYo6b44XSM0muOLTX9c5vHpa/7SrsPs18J65+dSq6kM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jNOFoj2mqdyPwsiMoknNM3smo411IqQBilCi+eKi+rG5mcbOlkrZ7JB/7klDWYkRw
	 bEfLhoEkUpcK89GhHxmVN6Sjg188I9bmsxxCC0CA0alhOkoidzC46/XTLgfndPBeBd
	 12u0m6bjgDSPe6GbczQzeNZ24jtT9qBJUc8SpNq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgDTMks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:40:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727833AbgDTMkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:40:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B61320724;
        Mon, 20 Apr 2020 12:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386444;
        bh=jYo6b44XSM0muOLTX9c5vHpa/7SrsPs18J65+dSq6kM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V6Tmts7rd1+eE/vKXuYex+d8IjduKYdE+cZQlhKMXwFV3+Gw5qNWBrH5G+RBpGArU
         6ZXsfOaQnLqeJ+vbjVmvrfD2opNhi7v3V/VpSTaLPd0IPhw45j9m6rTJMnrO4FwPk6
         FWZm6GpYmCxS4ldBpmjd80t/St3FtqpwkhsUP+1A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 5.5 25/65] acpi/nfit: improve bounds checking for func
Date:   Mon, 20 Apr 2020 14:38:29 +0200
Message-Id: <20200420121511.780217602@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121505.909671922@linuxfoundation.org>
References: <20200420121505.909671922@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 01091c496f920e634ea84b689f480c39016752a8 upstream.

The 'func' variable can come from the user in the __nd_ioctl().  If it's
too high then the (1 << func) shift in acpi_nfit_clear_to_send() is
undefined.  In acpi_nfit_ctl() we pass 'func' to test_bit(func, &dsm_mask)
which could result in an out of bounds access.

To fix these issues, I introduced the NVDIMM_CMD_MAX (31) define and
updated nfit_dsm_revid() to use that define as well instead of magic
numbers.

Fixes: 11189c1089da ("acpi/nfit: Fix command-supported detection")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Link: https://lore.kernel.org/r/20200225161927.hvftuq7kjn547fyj@kili.mountain
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/nfit/core.c |   10 ++++++----
 drivers/acpi/nfit/nfit.h |    1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -360,7 +360,7 @@ static union acpi_object *acpi_label_inf
 
 static u8 nfit_dsm_revid(unsigned family, unsigned func)
 {
-	static const u8 revid_table[NVDIMM_FAMILY_MAX+1][32] = {
+	static const u8 revid_table[NVDIMM_FAMILY_MAX+1][NVDIMM_CMD_MAX+1] = {
 		[NVDIMM_FAMILY_INTEL] = {
 			[NVDIMM_INTEL_GET_MODES] = 2,
 			[NVDIMM_INTEL_GET_FWINFO] = 2,
@@ -386,7 +386,7 @@ static u8 nfit_dsm_revid(unsigned family
 
 	if (family > NVDIMM_FAMILY_MAX)
 		return 0;
-	if (func > 31)
+	if (func > NVDIMM_CMD_MAX)
 		return 0;
 	id = revid_table[family][func];
 	if (id == 0)
@@ -492,7 +492,8 @@ int acpi_nfit_ctl(struct nvdimm_bus_desc
 	 * Check for a valid command.  For ND_CMD_CALL, we also have to
 	 * make sure that the DSM function is supported.
 	 */
-	if (cmd == ND_CMD_CALL && !test_bit(func, &dsm_mask))
+	if (cmd == ND_CMD_CALL &&
+	    (func > NVDIMM_CMD_MAX || !test_bit(func, &dsm_mask)))
 		return -ENOTTY;
 	else if (!test_bit(cmd, &cmd_mask))
 		return -ENOTTY;
@@ -3492,7 +3493,8 @@ static int acpi_nfit_clear_to_send(struc
 	if (nvdimm && cmd == ND_CMD_CALL &&
 			call_pkg->nd_family == NVDIMM_FAMILY_INTEL) {
 		func = call_pkg->nd_command;
-		if ((1 << func) & NVDIMM_INTEL_SECURITY_CMDMASK)
+		if (func > NVDIMM_CMD_MAX ||
+		    (1 << func) & NVDIMM_INTEL_SECURITY_CMDMASK)
 			return -EOPNOTSUPP;
 	}
 
--- a/drivers/acpi/nfit/nfit.h
+++ b/drivers/acpi/nfit/nfit.h
@@ -34,6 +34,7 @@
 		| ACPI_NFIT_MEM_NOT_ARMED | ACPI_NFIT_MEM_MAP_FAILED)
 
 #define NVDIMM_FAMILY_MAX NVDIMM_FAMILY_HYPERV
+#define NVDIMM_CMD_MAX 31
 
 #define NVDIMM_STANDARD_CMDMASK \
 (1 << ND_CMD_SMART | 1 << ND_CMD_SMART_THRESHOLD | 1 << ND_CMD_DIMM_FLAGS \


