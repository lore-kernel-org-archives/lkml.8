Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6805C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D22821556
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658067;
	bh=KNfO35iPHZp9nM2fIPPOABKvCwIRqbqzPl/v/G3GlKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X2C01Sv/L1ChovCwv9I0hoK8EzqtfQiiH7PdOPHEwzUoViigvub87MAUCZOaGO46u
	 o/VrqUQI72eddLsrkRH9QdNEAEP/gL1/MkrY8LCwrNwliOYFN6IPgAWefHqmu0PrDl
	 dr7Zx0+m69CUimo40yNbGY3W5d2enOnjgU5ETtfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgFHXOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:14:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729001AbgFHXLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:11:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16726214D8;
        Mon,  8 Jun 2020 23:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657911;
        bh=KNfO35iPHZp9nM2fIPPOABKvCwIRqbqzPl/v/G3GlKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W7Lc85CFlDt83ZX8sohUfW87QzT4DAN95yyidRvFTr4ePYYoZOEaZY+yud0haQIZ7
         BTPdWMYp2l3Q2tNeMqDws1NNdFWT70x0/7eG6H8xtoeJlK0BXeZSHoJtNfTi1xKqXM
         9DcxdsezO8JiW3V89cNxwxuJaRN1uDIRhGEmCxhw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chris Chiu <chiu@endlessm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 263/274] platform/x86: asus_wmi: Reserve more space for struct bias_args
Date:   Mon,  8 Jun 2020 19:05:56 -0400
Message-Id: <20200608230607.3361041-263-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Chiu <chiu@endlessm.com>

[ Upstream commit 7b91f1565fbfbe5a162d91f8a1f6c5580c2fc1d0 ]

On the ASUS laptop UX325JA/UX425JA, most of the media keys are not
working due to the ASUS WMI driver fails to be loaded. The ACPI error
as follows leads to the failure of asus_wmi_evaluate_method.
  ACPI BIOS Error (bug): AE_AML_BUFFER_LIMIT, Field [IIA3] at bit offset/length 96/32 exceeds size of target Buffer (96 bits) (20200326/dsopcode-203)
  No Local Variables are initialized for Method [WMNB]
  ACPI Error: Aborting method \_SB.ATKD.WMNB due to previous error (AE_AML_BUFFER_LIMIT) (20200326/psparse-531)

The DSDT for the WMNB part shows that 5 DWORD required for local
variables and the 3rd variable IIA3 hit the buffer limit.

Method (WMNB, 3, Serialized)
{ ..
    CreateDWordField (Arg2, Zero, IIA0)
    CreateDWordField (Arg2, 0x04, IIA1)
    CreateDWordField (Arg2, 0x08, IIA2)
    CreateDWordField (Arg2, 0x0C, IIA3)
    CreateDWordField (Arg2, 0x10, IIA4)
    Local0 = (Arg1 & 0xFFFFFFFF)
    If ((Local0 == 0x54494E49))
  ..
}

The limitation is determined by the input acpi_buffer size passed
to the wmi_evaluate_method. Since the struct bios_args is the data
structure used as input buffer by default for all ASUS WMI calls,
the size needs to be expanded to fix the problem.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-wmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index bb7c529d7d16..cd212ee210e2 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -116,6 +116,8 @@ struct bios_args {
 	u32 arg0;
 	u32 arg1;
 	u32 arg2; /* At least TUF Gaming series uses 3 dword input buffer. */
+	u32 arg4;
+	u32 arg5;
 } __packed;
 
 /*
-- 
2.25.1

