Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176B1C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D974A21734
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338139;
	bh=x/XNKUFPLS3neS+LDoNIiq/pjbpPs7OtyRIHTd6zdl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E2qKnShPoO10OkQriBodEpf2CWrXSdtBe+QroKbyrc64KND4A7ywm2EK+3jd7zq/J
	 0P8o9At/kaeDWtstm2srnWZlTF7ysFk9xkVNUVF+js2CHG4uatpJdo1oOf0S5/oW1N
	 KEYMnIl7aS6vUD0zM59CX431MBtMvD3vKFZZ3r/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgBJMfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:35:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:51476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727363AbgBJMfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:35:23 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78B1D24650;
        Mon, 10 Feb 2020 12:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338122;
        bh=x/XNKUFPLS3neS+LDoNIiq/pjbpPs7OtyRIHTd6zdl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nRN/uB8btRh2Qx9XXFoJplwgT12tb0T1YRXR26wL30Vx0D6jjSpdVNGAo5eRzlAAl
         mYftd4Q2CGAAHaQOhDjDRWCGksu4NsJagulsGX/FtNmZwxHU406qAyFp4ydkBb0+nC
         sRCaXzFawyeX5697DFz6qFFNnr+RzCbsidoyivVc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.19 059/195] ACPI: video: Do not export a non working backlight interface on MSI MS-7721 boards
Date:   Mon, 10 Feb 2020 04:31:57 -0800
Message-Id: <20200210122311.716296774@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
References: <20200210122305.731206734@linuxfoundation.org>
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
 


