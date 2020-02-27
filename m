Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE8DC3F34B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0070624691
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811754;
	bh=QQNSVRbe7PnoIGUfrKBf5d6NawvI+UWMX4n3ovQOjMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dh1SZKgs+6FsoF1Dx5LLSGTENcTshE0I7i10zFBuJ+GzHYVVak8qAUS+1iuDC61K0
	 I9O7B9pCNId15DX//oz0hiUOfMLsbdT7H0G6Cs8N6cAAsN1/o9Y5hH+6euWbIBQplV
	 pSRXLpsl3TTYbE7lH+2sByrJ6ibLZIK3dlzF0Mbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732039AbgB0Nzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:55:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:56184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732029AbgB0Nzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:55:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88985246B6;
        Thu, 27 Feb 2020 13:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811749;
        bh=QQNSVRbe7PnoIGUfrKBf5d6NawvI+UWMX4n3ovQOjMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=06Mdlu9HivLitHmC/xKlkN0Y49FvDNXewQMccqXxlEw+NTe1+c5/LcqIdA0v3DYcH
         9GQ5X82mQUUO+LnPLKl6ROuOQge/y9pTIzEKk77mjMyDu8NpcjvvgRJMbUy0+wUvJI
         tMWnfYWja3jdd5FzWNhDqXYVbO3zUWbZH+qUy/D4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Elia Geretto <elia.f.geretto@gmail.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 087/237] ACPICA: Disassembler: create buffer fields in ACPI_PARSE_LOAD_PASS1
Date:   Thu, 27 Feb 2020 14:35:01 +0100
Message-Id: <20200227132303.453824430@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 7bcf5f5ea0297..8df4a49a99a6b 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -273,7 +273,7 @@ cleanup:
  * FUNCTION:    acpi_ds_get_field_names
  *
  * PARAMETERS:  info            - create_field info structure
- *  `           walk_state      - Current method state
+ *              walk_state      - Current method state
  *              arg             - First parser arg for the field name list
  *
  * RETURN:      Status
diff --git a/drivers/acpi/acpica/dswload.c b/drivers/acpi/acpica/dswload.c
index eaa859a89702a..1d82e1419397e 100644
--- a/drivers/acpi/acpica/dswload.c
+++ b/drivers/acpi/acpica/dswload.c
@@ -444,6 +444,27 @@ acpi_status acpi_ds_load1_end_op(struct acpi_walk_state *walk_state)
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



