Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9547DC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623F424650
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338357;
	bh=/UYY92hIuxlKCb4IasHxTkK8sZop0UB/Sp72zc2SlF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zGmC/0lYaFUvlXT8XTtTHTqOZF55i+PUTc50gEOym6BzHngGFsNGQlS6LtmiT8Wj+
	 8/7kMMYJNt2RriGlKqhjSc4lHPTEIxfTcI1I4eGcz3dGgW9poibVu5vP1oOBSMxvIz
	 r2YLkr4c88vCtfvDE3aG7vjCm9dmSjDaVhFcooPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgBJMjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:39:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:58972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728747AbgBJMh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:37:26 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 827DD2467A;
        Mon, 10 Feb 2020 12:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338245;
        bh=/UYY92hIuxlKCb4IasHxTkK8sZop0UB/Sp72zc2SlF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MnW+Dfez5vEKOHq7XVtzCVWnO6TyJoi/rXG7CONlLFZ4si/mIdLQF5QMhTFlGTDkc
         1vOBQKKcLcmurxmFsk7VbTLQ60DCfNtXgIw5QZPK7GIANqBnzfiBVqyN2iRIA3x3nY
         97MmZ3xLypLumIGgiKYH8RjCIYYaalzrdBckWAg8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.4 086/309] ACPI: video: Do not export a non working backlight interface on MSI MS-7721 boards
Date:   Mon, 10 Feb 2020 04:30:42 -0800
Message-Id: <20200210122414.152151088@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit d21a91629f4b8e794fc4c0e0c17c85cedf1d806c upstream.

Despite our heuristics to not wrongly export a non working ACPI backlight
interface on desktop machines, we still end up exporting one on desktops
using a motherboard from the MSI MS-7721 series.

I've looked at improving the heuristics, but in this case a quirk seems
to be the only way to solve this.

While at it also add a comment to separate the video_detect_force_none
entries in the video_detect_dmi_table from other type of entries, as we
already do for the other entry types.

Cc: All applicable <stable@vger.kernel.org>
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1783786
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/video_detect.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -336,6 +336,11 @@ static const struct dmi_system_id video_
 		DMI_MATCH(DMI_PRODUCT_NAME, "Precision 7510"),
 		},
 	},
+
+	/*
+	 * Desktops which falsely report a backlight and which our heuristics
+	 * for this do not catch.
+	 */
 	{
 	 .callback = video_detect_force_none,
 	 .ident = "Dell OptiPlex 9020M",
@@ -344,6 +349,14 @@ static const struct dmi_system_id video_
 		DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 9020M"),
 		},
 	},
+	{
+	 .callback = video_detect_force_none,
+	 .ident = "MSI MS-7721",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "MSI"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "MS-7721"),
+		},
+	},
 	{ },
 };
 


