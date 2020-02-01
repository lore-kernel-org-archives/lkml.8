Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69295C33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 17:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36493206D3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 17:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeX2Lgen"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgBARJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 12:09:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35953 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbgBARJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 12:09:51 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so12467426wru.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 09:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=M5KeM9XPEcQOSTgANXYZAkXANlceUDSTwSKd2fmzxsg=;
        b=ZeX2LgenLwzZn2ZefiTmLj9NSXzjTV6+FCUUDVss9vB31lMUHQNVmOtA9fxqFtJ38I
         08wxomhQbtbHmBA5uv6n0XpDJWGJrmbSNuHxVSx44Zj0bwnwp2koV5n2eutjKe7CR3u5
         GIKOf7H6uw9FSNuPNz/Lj0SJlm7SnlxkeouzHgCIVGumBT8jYAuLxj5x0Dh3gWJtPHtX
         5OfUx45n5OWYL7F4g3JSiStWSMqLbpQQfYXPrxvRCUKtnxiEu27ql6lSMHzJdqo18Eqd
         cFKY0zPrI+CVeNBrXOcxv/LF+XUH2aWCwK4FcPhgdJEMGJK+ebVoFR++DvC6o0OAClBW
         R0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M5KeM9XPEcQOSTgANXYZAkXANlceUDSTwSKd2fmzxsg=;
        b=N/b/mva5xSUuhLQUKfcH4WEjMQkMG4bWfdYX7A/X6gjSWeUDvdc6no3UKg46YTQHdo
         pBL24G67tvQdifq8gJZ7GVVkeItxuI/LDQDLRcm2hUsQvZZe+R9e2LzAVoUc9NGpmFnc
         W22leDQx2gVjclbeuA2ddoxpfPOKo74DRIPl6bq3zAtF0lT+AeLsJD6gRYHRwyN4nl0m
         L8b+mL65t8ZsUgq9FRFRxx2hx7hP1kXES9+7/rxFCjgcSRu3AuPaYWDl63yQeif2u3vW
         ZLKvDQTz/0sReW/cRzUnp8Z0FyDJEFlHnn9wZNDydXZ7HoEfbx9f1Pm8MV+iFvzDfTO2
         iUSw==
X-Gm-Message-State: APjAAAUZVuSj0rgJd3g/6tz1UuvN5WyN6BC+W8zzdN0sA4fZh3c0RP74
        qBBNSrBpEXi5mv3E7mxWdOc=
X-Google-Smtp-Source: APXvYqyXQPivQeOLGHjYOjxCCwEvHsE7pCbNy5Bktscfvdep4bNFD1CxryQdNM3Ire8mEOCXQ23L6Q==
X-Received: by 2002:a5d:550f:: with SMTP id b15mr5223481wrv.196.1580576989001;
        Sat, 01 Feb 2020 09:09:49 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d5f:200:619d:5ce8:4d82:51eb])
        by smtp.gmail.com with ESMTPSA id a62sm16311759wmh.33.2020.02.01.09.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2020 09:09:48 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH RFC] MAINTAINERS: clarify maintenance of nvdimm testing tool
Date:   Sat,  1 Feb 2020 18:09:33 +0100
Message-Id: <20200201170933.924-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The git history shows that the files under ./tools/testing/nvdimm are
being developed and maintained by the LIBNVDIMM maintainers.

This was identified with a small script that finds all files only
belonging to "THE REST" according to the current MAINTAINERS file, and I
acted upon its output.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
This is a RFC patch based on what I could see as an outsider to nvdimm.
Dan, please pick this patch if it reflects the real responsibilities.

applies cleanly on current master and next-20200131

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1f77fb8cdde3..929386123257 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9564,6 +9564,7 @@ F:	drivers/acpi/nfit/*
 F:	include/linux/nd.h
 F:	include/linux/libnvdimm.h
 F:	include/uapi/linux/ndctl.h
+F:	tools/testing/nvdimm/
 
 LICENSES and SPDX stuff
 M:	Thomas Gleixner <tglx@linutronix.de>
-- 
2.17.1

