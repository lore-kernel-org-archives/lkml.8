Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672EFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BBF6205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kocurkovo.cz header.i=@kocurkovo.cz header.b="wLrqAV70"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390554AbgEMTP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 15:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390513AbgEMTP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 15:15:57 -0400
Received: from mail.kocurkovo.cz (unknown [IPv6:2a02:2b88:2:1::5b29:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4F6C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 12:15:56 -0700 (PDT)
Received: by mail.kocurkovo.cz (Postfix, from userid 1000)
        id B580514A2; Wed, 13 May 2020 21:15:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.kocurkovo.cz B580514A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kocurkovo.cz;
        s=mail; t=1589397352;
        bh=osBZwaS/V/U2ht3ZNx2/3ZIGbRNWDA7p//Wi6GqI7Eo=;
        h=From:To:Cc:Subject:Date:From;
        b=wLrqAV70b/n3WvWQeOMjpsQvBoBYI7r7zqgJkkJMY2063NZWFMmoHvJIvp2eppjh5
         kjM/DwWAJGOMscJbk98Wr8ZReBSl7oCNjWTmaNJKvmSZ0eoUJxdC92Vd9BCqv8xfwY
         UtnbUT+BrrOzcLYeJ+/EutFq7Xf9JD84n0MWSlXk=
From:   Matej Dujava <mdujava@kocurkovo.cz>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        linux-kernel@vger.kernel.org, Matej Dujava <mdujava@kocurkovo.cz>
Subject: [PATCH v3 0/2] staging: vt6656: vt6655: cleaning Makefile
Date:   Wed, 13 May 2020 21:15:49 +0200
Message-Id: <1589397351-24655-1-git-send-email-mdujava@kocurkovo.cz>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset will remove unused definitions of C Macros, reorder variable
definition in Makefiles and increase indentation to match visual block.

Macros are removed from vt665x/Makefile and vt6655/device_main.c.

Indentation is fixed in vt6655/Makefile.

Order of variable declaration is changed in vt6656/Makefile.

---
v1: Initial patch
v2: This patch was split from original bigger patch
v3: Added more info about what and why it's removed

Matej Dujava (2):
  staging: vt6656: vt6655: removing unused macros definition Makefiles
  staging: vt6655: vt6656: change order of makefile variable definitions

 drivers/staging/vt6655/Makefile      | 27 ++++++++++++---------------
 drivers/staging/vt6655/device_main.c |  1 -
 drivers/staging/vt6656/Makefile      |  7 ++-----
 3 files changed, 14 insertions(+), 21 deletions(-)

-- 
2.26.2

