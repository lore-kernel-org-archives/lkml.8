Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C03DC3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38EDF2467B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607607;
	bh=x/XNKUFPLS3neS+LDoNIiq/pjbpPs7OtyRIHTd6zdl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M8hYUhBzORlbOZbKcLIlD29FQmCCRvk9JlJURbeaXHffQK3JQPzBOPr+j3KxPT1yC
	 Mdw186ei4BTsGzEB4N7LfzqJQmOoLyS7lMMYL8hRBxgIUrKyPEEaHtp2StesyiYt/J
	 eEJ889j1m9QR1BSAbSTX5F0UbMBvpyKh6KiQdKNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387633AbgBMP0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:26:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:39674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728417AbgBMPZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:25:01 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67836246A4;
        Thu, 13 Feb 2020 15:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607500;
        bh=x/XNKUFPLS3neS+LDoNIiq/pjbpPs7OtyRIHTd6zdl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dSnA5phARhJZmPBQRvBFBr2aJKS5U8ZiYruK6TMhLc9XtTyMlqqa1EiplrwhO27vA
         k1I2nmlapQ39mKA3yCPK6UKVYN7gtqyqrb1/lh7FwuBiwqe1hPg1+g8xLxfDLhA6dD
         Pn0Shoy/VcXktazsdPSXodHlNBt8wy3UUsCIM7Ug=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.14 037/173] ACPI: video: Do not export a non working backlight interface on MSI MS-7721 boards
Date:   Thu, 13 Feb 2020 07:19:00 -0800
Message-Id: <20200213151943.327388407@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151931.677980430@linuxfoundation.org>
References: <20200213151931.677980430@linuxfoundation.org>
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
@@ -328,6 +328,11 @@ static const struct dmi_system_id video_
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
@@ -336,6 +341,14 @@ static const struct dmi_system_id video_
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
 


