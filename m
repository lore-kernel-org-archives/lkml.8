Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA70C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C49C21D7D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkfwTjno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgBFUYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 15:24:23 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:55424 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbgBFUYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:24:23 -0500
Received: by mail-wm1-f53.google.com with SMTP id q9so214031wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 12:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tlf2cEuWqzi15jSc47YFX5cP+L61Uac1o8CP7Bpwcew=;
        b=kkfwTjno4EgKmmyYFzOP6XL5hOkg6l0rGjmLQOH5LOdE8GAdQzM+AsTWXky834JXuO
         dDTsjyoQA5bpKM+41c++AOIAQE08Q5a421JkCvk20ja6NlQef5l201DB/m8RVwe/2kGc
         Nsey+xGi5pdp/vNIqi0QuDzGJQAFoMI6bGFM45BAq7Ypb0mXjG5t7YnUkp1MIwZ5BoZR
         QRE/wiCU9jq4OYLMSmfoUWCtH2ZllAqhBTyqzkKCrxeVSu3FF6jDDM9Rhkq0ZJJJvzHj
         EhqxjXlSAPjNVkRzmk/M37IEg9AxXzZrK/+oWaZRzzcMnuRd0qCmuJeohh+V55PjnV2E
         MBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tlf2cEuWqzi15jSc47YFX5cP+L61Uac1o8CP7Bpwcew=;
        b=MgyxmvXSM4kS1JUo+DIPN+lTzgxle4hK4gWfpiblo5mO4RtBtBum1QZ+8HaLn6f0/T
         nOSb6Z/XkBepj68c4dFbOlWFF29SvX1drNzc+YVVgyQxjkHIg0mvyx2YA9ifp6bHPcQo
         VNTyt6t6L7MxY9cxSvspCvAzRqIFvJIqJvRHwxoDwWaXG0QUF084uudlA/3gVJ/1AFE6
         bvpW75Ozagk26zZBBB6L9853KFwAKjrluCbNXb0a5a+YbLqm+hqRWq1Qd3f4mCOjXeQs
         rY9c992lHZSaqyxSS7h9X1hZGwgn2xOi0W23gTnUVIHPh7QmJwVP2TrAq+JxFmmPupsk
         imEA==
X-Gm-Message-State: APjAAAUEa/zkOu7twpALZoZQzY6XnwHjY7L4wn/GwBWCu4wZR6Y9a9KR
        Yu4EjXuePy920VUNfadXPII=
X-Google-Smtp-Source: APXvYqyZwyPua8T189yaRBv8FiTqbVEyZ+r+dZUf9JfJOlGKwQkcOGgyPA7flD9UyV4D1RYNmu65oQ==
X-Received: by 2002:a7b:ce18:: with SMTP id m24mr6425514wmc.123.1581020661501;
        Thu, 06 Feb 2020 12:24:21 -0800 (PST)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id c13sm539929wrx.9.2020.02.06.12.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 12:24:20 -0800 (PST)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v4 0/5] Add new series Micron SPI NAND devices
Date:   Thu,  6 Feb 2020 21:22:01 +0100
Message-Id: <20200206202206.14770-1-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

This patchset is for the new series of Micron SPI NAND devices, and the
following links are their datasheets.

M78A:
[1] https://www.micron.com/~/media/documents/products/data-sheet/nand-flash/70-series/m78a_1gb_3v_nand_spi.pdf
[2] https://www.micron.com/~/media/documents/products/data-sheet/nand-flash/70-series/m78a_1gb_1_8v_nand_spi.pdf

M79A:
[3] https://www.micron.com/~/media/documents/products/data-sheet/nand-flash/70-series/m79a_2gb_1_8v_nand_spi.pdf
[4] https://www.micron.com/~/media/documents/products/data-sheet/nand-flash/70-series/m79a_ddp_4gb_3v_nand_spi.pdf

M70A:
[5] https://www.micron.com/~/media/documents/products/data-sheet/nand-flash/70-series/m70a_4gb_3v_nand_spi.pdf
[6] https://www.micron.com/~/media/documents/products/data-sheet/nand-flash/70-series/m70a_4gb_1_8v_nand_spi.pdf
[7] https://www.micron.com/~/media/documents/products/data-sheet/nand-flash/70-series/m70a_ddp_8gb_3v_nand_spi.pdf
[8] https://www.micron.com/~/media/documents/products/data-sheet/nand-flash/70-series/m70a_ddp_8gb_1_8v_nand_spi.pdf

Changes since v3:
-----------------

1. Patch 3 and 4 reworked as follows
   - Patch 3 introducing the Continuous read feature
   - Patch 4 adding devices with the feature

Changes since v2:
-----------------

1. Patch commit messages have been modified.
2. Handled devices with Continuous Read feature with vendor specific flag.
3. Reworked die selection function as per the comment.

Changes since v1:
-----------------

1. The patch split into multiple patches.
2. Added comments for selecting the die.

Shivamurthy Shastri (5):
  mtd: spinand: micron: Generalize the OOB layout structure and function
    names
  mtd: spinand: micron: Add new Micron SPI NAND devices
  mtd: spinand: micron: identify SPI NAND device with Continuous Read
    mode
  mtd: spinand: micron: Add M70A series Micron SPI NAND devices
  mtd: spinand: micron: Add new Micron SPI NAND devices with multiple
    dies

 drivers/mtd/nand/spi/micron.c | 153 ++++++++++++++++++++++++++++++----
 include/linux/mtd/spinand.h   |   1 +
 2 files changed, 140 insertions(+), 14 deletions(-)

-- 
2.17.1

