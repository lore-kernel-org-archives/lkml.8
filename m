Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA22C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C3EF2083E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589823522;
	bh=I7x4hEt+td/apd6fnTsATVe5BaQSVa0UKEXNXolXzYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nV3sBGWERww89dpgiNhwtWsE/FSCb37YIiSqQMpCmo6xQd4mfWOT+LeTueQ4l0Jjb
	 rkNGaMPhxSiijIJ5MWi37MZTa+wBD76dCaYp7fl7bw2ZD/93HkikgglMhrZcV1VNzx
	 uck7sMpFapciMPo+3ZEiZn2Jt89mKFHWUFbePoQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgERRil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:38:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:32842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728566AbgERRij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:38:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98078207C4;
        Mon, 18 May 2020 17:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823519;
        bh=I7x4hEt+td/apd6fnTsATVe5BaQSVa0UKEXNXolXzYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V7O3v5jvPjVYpyJlwLNF6m7UTrbeTdKyRVxTqcYi/NqkOEb6ChjdOOZrANg445fqk
         +dRYDWnHbuDx9uVS8mxVx92DFT8+maXbaPrO8/hasYoBW4M4Qe15E+oLmX1C9VxD3p
         9/yww1eQeYFjfCtkzod9sBvIcK2rB8x4tl59MVf0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.4 07/86] Revert "ACPI / video: Add force_native quirk for HP Pavilion dv6"
Date:   Mon, 18 May 2020 19:35:38 +0200
Message-Id: <20200518173451.797165848@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.254571947@linuxfoundation.org>
References: <20200518173450.254571947@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit fd25ea29093e275195d0ae8b2573021a1c98959f upstream.

Revert commit 6276e53fa8c0 (ACPI / video: Add force_native quirk for
HP Pavilion dv6).

In the commit message for the quirk this revert removes I wrote:

"Note that there are quite a few HP Pavilion dv6 variants, some
woth ATI and some with NVIDIA hybrid gfx, both seem to need this
quirk to have working backlight control. There are also some versions
with only Intel integrated gfx, these may not need this quirk, but it
should not hurt there."

Unfortunately that seems wrong, I've already received 2 reports of
this commit causing regressions on some dv6 variants (at least one
of which actually has a nvidia GPU). So it seems that HP has made a
mess here by using the same model-name both in marketing and in the
DMI data for many different variants. Some of which need
acpi_backlight=native for functional backlight control (as the
quirk this commit reverts was doing), where as others are broken by
it. So lets get back to the old sitation so as to avoid regressing
on models which used to work without any kernel cmdline arguments
before.

Fixes: 6276e53fa8c0 (ACPI / video: Add force_native quirk for HP Pavilion dv6)
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/video_detect.c |   11 -----------
 1 file changed, 11 deletions(-)

--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -289,17 +289,6 @@ static const struct dmi_system_id video_
 		DMI_MATCH(DMI_PRODUCT_NAME, "Dell System XPS L702X"),
 		},
 	},
-	{
-	/* https://bugzilla.redhat.com/show_bug.cgi?id=1204476 */
-	/* https://bugs.launchpad.net/ubuntu/+source/linux-lts-trusty/+bug/1416940 */
-	.callback = video_detect_force_native,
-	.ident = "HP Pavilion dv6",
-	.matches = {
-		DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-		DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dv6 Notebook PC"),
-		},
-	},
-
 	{ },
 };
 


