Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1515C35254
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 18:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77C222464
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 18:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgBHScN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 13:32:13 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34648 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727947AbgBHS3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 13:29:49 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1j0UrO-0003j9-7F; Sat, 08 Feb 2020 18:29:42 +0000
Received: from ben by deadeye with local (Exim 4.93)
        (envelope-from <ben@decadent.org.uk>)
        id 1j0UrL-000CVQ-7C; Sat, 08 Feb 2020 18:29:39 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Date:   Sat, 08 Feb 2020 18:21:01 +0000
Message-ID: <lsq.1581185941.608409442@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 122/148] platform/x86: hp-wmi: Fix ACPI errors caused
 by passing 0 as input size
In-Reply-To: <lsq.1581185939.857586636@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.82-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit f3e4f3fc8ee9729c4b1b27a478c68b713df53c0c upstream.

The AML code implementing the WMI methods creates a variable length
field to hold the input data we pass like this:

        CreateDWordField (Arg1, 0x0C, DSZI)
        Local5 = DSZI /* \HWMC.DSZI */
        CreateField (Arg1, 0x80, (Local5 * 0x08), DAIN)

If we pass 0 as bios_args.datasize argument then (Local5 * 0x08)
is 0 which results in these errors:

[   71.973305] ACPI BIOS Error (bug): Attempt to CreateField of length zero (20190816/dsopcode-133)
[   71.973332] ACPI Error: Aborting method \HWMC due to previous error (AE_AML_OPERAND_VALUE) (20190816/psparse-529)
[   71.973413] ACPI Error: Aborting method \_SB.WMID.WMAA due to previous error (AE_AML_OPERAND_VALUE) (20190816/psparse-529)

And in our HPWMI_WIRELESS2_QUERY calls always failing. for read commands
like HPWMI_WIRELESS2_QUERY the DSZI value is not used / checked, except for
read commands where extra input is needed to specify exactly what to read.

So for HPWMI_WIRELESS2_QUERY we can safely pass the size of the expected
output as insize to hp_wmi_perform_query(), as we are already doing for all
other HPWMI_READ commands we send. Doing so fixes these errors.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=197007
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=201981
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1520703
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/platform/x86/hp-wmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -400,7 +400,7 @@ static int hp_wmi_rfkill2_refresh(void)
 	struct bios_rfkill2_state state;
 
 	err = hp_wmi_perform_query(HPWMI_WIRELESS2_QUERY, 0, &state,
-				   0, sizeof(state));
+				   sizeof(state), sizeof(state));
 	if (err)
 		return err;
 
@@ -825,7 +825,7 @@ static int __init hp_wmi_rfkill2_setup(s
 	int err, i;
 	struct bios_rfkill2_state state;
 	err = hp_wmi_perform_query(HPWMI_WIRELESS2_QUERY, 0, &state,
-				   0, sizeof(state));
+				   sizeof(state), sizeof(state));
 	if (err)
 		return err;
 

