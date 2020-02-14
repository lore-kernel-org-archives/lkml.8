Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56272C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB5824705
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581697645;
	bh=JW5BuyxBR1gPwzyXu4QSQ6uPzSUXrWd0R4epErzA09s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1aF9MCLiov/7pgBlWEOeNBvXh8vvWI+/ftU7GdZ5tRbufy/KVOEfaAjK4dYa8NAVJ
	 P590wPqRoshKmZ9tpl2Z7g+CJ6l4G2rs5jY5oeo6eGtAb3qpmiBwH9hDEYYduRmmCU
	 Bgg9CoqJaK1U/uRCnmdOSJHe9Hi1W6Hj1BZx1TgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406632AbgBNQ1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:27:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:35090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406103AbgBNQZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:25:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6468A24789;
        Fri, 14 Feb 2020 16:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697526;
        bh=JW5BuyxBR1gPwzyXu4QSQ6uPzSUXrWd0R4epErzA09s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SPHgeiDLR8COgViRPoWi576O2OoHWbO6PotQm3bd3+qpHQx85AvPdtxIztGjAO7Vg
         p+ia0uanWlpVrwHiefQbFCXmxk9zZ+UW+SNzRqWYmDBGHOEfWCCi7NAsw9qZTGpKIA
         3ZOdtk9m6MhpEZty5WxXNdrp1455pvTG+e8TgX1E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Elia Geretto <elia.f.geretto@gmail.com>,
        Bob Moore <robert.moore@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org
Subject: [PATCH AUTOSEL 4.4 049/100] ACPICA: Disassembler: create buffer fields in ACPI_PARSE_LOAD_PASS1
Date:   Fri, 14 Feb 2020 11:23:33 -0500
Message-Id: <20200214162425.21071-49-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214162425.21071-1-sashal@kernel.org>
References: <20200214162425.21071-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Erik Kaneda <erik.kaneda@intel.com>

[ Upstream commit 5ddbd77181dfca61b16d2e2222382ea65637f1b9 ]

ACPICA commit 29cc8dbc5463a93625bed87d7550a8bed8913bf4

create_buffer_field is a deferred op that is typically processed in
load pass 2. However, disassembly of control method contents walk the
parse tree with ACPI_PARSE_LOAD_PASS1 and AML_CREATE operators are
processed in a later walk. This is a problem when there is a control
method that has the same name as the AML_CREATE object. In this case,
any use of the name segment will be detected as a method call rather
than a reference to a buffer field. If this is detected as a method
call, it can result in a mal-formed parse tree if the control methods
have parameters.

This change in processing AML_CREATE ops earlier solves this issue by
inserting the named object in the ACPI namespace so that references
to this name would be detected as a name string rather than a method
call.

Link: https://github.com/acpica/acpica/commit/29cc8dbc
Reported-by: Elia Geretto <elia.f.geretto@gmail.com>
Tested-by: Elia Geretto <elia.f.geretto@gmail.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpica/dsfield.c |  2 +-
 drivers/acpi/acpica/dswload.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index 20de148594fdc..d56cbcda37c13 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -272,7 +272,7 @@ acpi_ds_create_buffer_field(union acpi_parse_object *op,
  * FUNCTION:    acpi_ds_get_field_names
  *
  * PARAMETERS:  info            - create_field info structure
- *  `           walk_state      - Current method state
+ *              walk_state      - Current method state
  *              arg             - First parser arg for the field name list
  *
  * RETURN:      Status
diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index 097188a6b1c1b..35f1d7657927a 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -440,6 +440,27 @@ acpi_status acpi_ds_load1_end_op(struct acpi_walk_state *walk_state)
 	ACPI_DEBUG_PRINT((ACPI_DB_DISPATCH, "Op=%p State=%p\n", op,
 			  walk_state));
 
+	/*
+	 * Disassembler: handle create field operators here.
+	 *
+	 * create_buffer_field is a deferred op that is typically processed in load
+	 * pass 2. However, disassembly of control method contents walk the parse
+	 * tree with ACPI_PARSE_LOAD_PASS1 and AML_CREATE operators are processed
+	 * in a later walk. This is a problem when there is a control method that
+	 * has the same name as the AML_CREATE object. In this case, any use of the
+	 * name segment will be detected as a method call rather than a reference
+	 * to a buffer field.
+	 *
+	 * This earlier creation during disassembly solves this issue by inserting
+	 * the named object in the ACPI namespace so that references to this name
+	 * would be a name string rather than a method call.
+	 */
+	if ((walk_state->parse_flags & ACPI_PARSE_DISASSEMBLE) &&
+	    (walk_state->op_info->flags & AML_CREATE)) {
+		status = acpi_ds_create_buffer_field(op, walk_state);
+		return_ACPI_STATUS(status);
+	}
+
 	/* We are only interested in opcodes that have an associated name */
 
 	if (!(walk_state->op_info->flags & (AML_NAMED | AML_FIELD))) {
-- 
2.20.1

