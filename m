Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128C7C33CB7
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 15:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE2A2469D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 15:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ssBOBaPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgARPgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 10:36:33 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34288 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgARPgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 10:36:32 -0500
Received: by mail-ed1-f66.google.com with SMTP id l8so25235903edw.1;
        Sat, 18 Jan 2020 07:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7B2mjVQ1dHIRCu4RANo+v8JmGtXc7z+57XvhPDJ4C8o=;
        b=ssBOBaPmTeDGD4ZIImlaJsywyi7HoBboXfJnH6PZmrJ8Z78Qk3FcqIakY1iEL5Igi2
         6zUSo4eKq7Al9yNNY3VfU44iJQzbeVBrFBjSKnSxKiZ1hBcLxFHFS27wbTNoapnN7IoJ
         COCdcjhVRVAPXmDFC2JRYTduMzXw6RXU/Y8JYqS97640WGon7CWDXPfEpjlMTdvSSOmi
         1ZR6TP4O8fHl/IYgf+Yu5r8dsqH90O9cHpI3vHV1KoPx6PB1r6Mk4xt9+4kzsp4PZ3hL
         epHJee0KHpdEk56ilBzacSlbz7KahTIIub/QrBHoTkwI9PoC8SFjcChxbEPuArLG0zyr
         nZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7B2mjVQ1dHIRCu4RANo+v8JmGtXc7z+57XvhPDJ4C8o=;
        b=paV9X58sOtoTyhT6eCmL4gDfzvRn7r2K0yX0UqLM1So8uwNr4f4nZGvbxrQjK7t5/X
         +r+lFr9nHvsR7v6kATCID0qcwjSmP/DaBSx+kiQB8ZicE23tV/VPSAF3iTMPwNWpwS4z
         uJstJ6b9NTjCCoYlpoQZPXW0h5KkoQSadhZJxF2bM/rHOB1TZr4t5J/X1GydivSU2K/a
         CgQAw2WkOkxy8tu24n5bnQ4slUYYc6B2zdN0u0pSUgijqSZ3Io8A/9hfnkfcnMjpYX4b
         /7ffi4gyMGYJgob5yLKTPxGDxtGhFrOgTVhGi+iee6Tisl+cLYz7VPMMPWTfXXP7CZrc
         HSaw==
X-Gm-Message-State: APjAAAWzjXPtX+smxc5KeQjxWZdO+1WEn4pn1x3KG1y73nRHbEfaWj6k
        pw49uZT2HnjXD+VwSJXZGVqau+4Ojak=
X-Google-Smtp-Source: APXvYqze67soLzbb1oH4PfOADDQs/2Cm4yhLXbeLL4XJS9qKqw7OvnfTl/HDwnOvhpx7iC/uiILpjg==
X-Received: by 2002:a05:6402:30b7:: with SMTP id df23mr9418518edb.325.1579361790897;
        Sat, 18 Jan 2020 07:36:30 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2db9:c700:ed1f:3ff2:64cf:36f2])
        by smtp.gmail.com with ESMTPSA id d8sm1099623edn.52.2020.01.18.07.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 07:36:30 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] docs: nvdimm: use ReST notation for subsection
Date:   Sat, 18 Jan 2020 16:36:20 +0100
Message-Id: <20200118153620.8276-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ACPI Device Specific Methods (_DSM) paragraph is intended to be a
subsection of the Submit Checklist Addendum section. Dan Williams however
used Markdown notation for this subsection, which does not parse as
intended in a ReST documentation.

Change the markup to ReST notation, as described in the Specific
guidelines for the kernel documentation section in
Documentation/doc-guide/sphinx.rst.

Fixes: 47843401e3a0 ("libnvdimm, MAINTAINERS: Maintainer Entry Profile")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Jonathan, please pick this small doc fixup.

applies cleanly on v5.5-rc6, the current master (25e73aadf297)
and next-20200117. I ran make htmldocs and checked the html output.

The subsection was added in v3, but unfortunately, nobody noticed this
issue during the last review.
Thanks for the first maintainer entry profile, I look forward to read
more of them.

 Documentation/nvdimm/maintainer-entry-profile.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/nvdimm/maintainer-entry-profile.rst b/Documentation/nvdimm/maintainer-entry-profile.rst
index 77081fd9be95..efe37adadcea 100644
--- a/Documentation/nvdimm/maintainer-entry-profile.rst
+++ b/Documentation/nvdimm/maintainer-entry-profile.rst
@@ -33,7 +33,8 @@ Those tests need to be passed before the patches go upstream, but not
 necessarily before initial posting. Contact the list if you need help
 getting the test environment set up.
 
-### ACPI Device Specific Methods (_DSM)
+ACPI Device Specific Methods (_DSM)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Before patches enabling for a new _DSM family will be considered it must
 be assigned a format-interface-code from the NVDIMM Sub-team of the ACPI
 Specification Working Group. In general, the stance of the subsystem is
-- 
2.17.1

