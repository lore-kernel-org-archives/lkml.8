Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32147C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160AA214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387977AbgCDKxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 05:53:12 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:64290 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387707AbgCDKw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:52:56 -0500
Received: from 79.184.237.41.ipv4.supernova.orange.pl (79.184.237.41) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 2b9b5be4e094f220; Wed, 4 Mar 2020 11:52:54 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Drake <drake@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH v2 3/6] ACPI: EC: Drop AE_NOT_FOUND special case from ec_install_handlers()
Date:   Wed, 04 Mar 2020 11:46:31 +0100
Message-ID: <1745425.pKipCqq21V@kreacher>
In-Reply-To: <2411774.6kdisLRoUK@kreacher>
References: <2094703.CetWLLyMuz@kreacher> <2411774.6kdisLRoUK@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

If the status value returned by acpi_install_address_space_handler()
in ec_install_handlers() is AE_NOT_FOUND, it is treated in a special
way, apparently because it might mean a _REG method evaluation
failure (at least that is the case according to the comment in
there), but acpi_install_address_space_handler() does not take
_REG evaluation errors into account at all, so the AE_NOT_FOUND
special handling is confusing at best.

For this reason, change ec_install_handlers() to stop the EC and
return -ENODEV on all acpi_install_address_space_handler() errors.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2: No changes.

---
 drivers/acpi/ec.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 3153e7684053..6f501d552e6e 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1489,19 +1489,8 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device)
 							    &acpi_ec_space_handler,
 							    NULL, ec);
 		if (ACPI_FAILURE(status)) {
-			if (status == AE_NOT_FOUND) {
-				/*
-				 * Maybe OS fails in evaluating the _REG
-				 * object. The AE_NOT_FOUND error will be
-				 * ignored and OS * continue to initialize
-				 * EC.
-				 */
-				pr_err("Fail in evaluating the _REG object"
-					" of EC device. Broken bios is suspected.\n");
-			} else {
-				acpi_ec_stop(ec, false);
-				return -ENODEV;
-			}
+			acpi_ec_stop(ec, false);
+			return -ENODEV;
 		}
 		set_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
 	}
-- 
2.16.4





