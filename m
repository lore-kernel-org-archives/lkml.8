Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68332C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 06:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D2A821741
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 06:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dexb87pG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgIIGh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 02:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgIIGh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 02:37:56 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB22FC061755
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 23:37:55 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id o20so1259136pfp.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 23:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zecV6RuB4y2mB3liQOpyZpbo7kgRDtaYDwp3K0dNDoc=;
        b=Dexb87pGwDw4pV9xV4pfHE89/qFy4yJ0Zk8peQjmLkglfG9xkJ57jQm1GJNmEz1MCo
         Ykxk5lFLvx6ckJb7sZu0muGYTORoL4Fa7c7lvIlZSk1PoRbeRSSxUBlKa1fz2YaFKjTS
         dBp9vz1p14QbXV5lTdhdnLEozsONmNDPgYZlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zecV6RuB4y2mB3liQOpyZpbo7kgRDtaYDwp3K0dNDoc=;
        b=Aw/LPKyR45Nefp+P+Nnh1Qw52vK/zgtA/Huc2aPAA8dOIzBaib9EMnM/oEDqIe39tA
         1eSOPnEq+/6qwun/LtJ60JBuLZxIIHQ0pw35auFR/JRVf322dp0dTL9WEVQ+aUU8idwF
         u9kQHP5VXI2grHHsVlfGo7uZZZ+WF8D86HgcSSch8VX0pKqOh+195qZQqzGuZcceDlXF
         cumJa20p9rUgqXreh4BvOKuLDGIjZ/MAEazoUB6U039GNApSdMxuMYyAcROjcrigHOjz
         kWdgOXjzVctt+EtjY4VqWXhA1ktkjzQ4h3UdPiYFiLt59KK1/Ts1walVeaVTYZQmHDDo
         J4UQ==
X-Gm-Message-State: AOAM533AQfaSmpbUhpsGXL0zpOX+OcatdOq2A3I3IhlDg2JGZi6ZsiKg
        k+OD/qI1Id+Gq4QpWIbLgWPRXA==
X-Google-Smtp-Source: ABdhPJzVFpj31Mp6r4rw+U259cnsxp1tUF+KbnPij8BOKuYTU5G32u3HLnEPowDoLMO/s7kOfLCVlQ==
X-Received: by 2002:a63:30c:: with SMTP id 12mr1942293pgd.66.1599633473538;
        Tue, 08 Sep 2020 23:37:53 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id z26sm1405769pfa.55.2020.09.08.23.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 23:37:52 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH] docs: stable-ABI: Document /sys/kernel/notes
Date:   Tue,  8 Sep 2020 23:37:52 -0700
Message-Id: <20200909063752.931283-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the notes file in sysfs as the running vmlinux's .note section
in binary format. Hopefully this helps someone like me realize the
kernel exposes the note section in sysfs in the future. Take the date
from when the file was introduced. It's been a while so presumably this
is stable and not testing material.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 Documentation/ABI/stable/sysfs-kernel-notes | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 Documentation/ABI/stable/sysfs-kernel-notes

diff --git a/Documentation/ABI/stable/sysfs-kernel-notes b/Documentation/ABI/stable/sysfs-kernel-notes
new file mode 100644
index 000000000000..2c76ee9e67f7
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-kernel-notes
@@ -0,0 +1,5 @@
+What:		/sys/kernel/notes
+Date:		July 2009
+Contact:	<linux-kernel@vger.kernel.org>
+Description:	The /sys/kernel/notes file contains the binary representation
+		of the running vmlinux's .notes section.
-- 
Sent by a computer, using git, on the internet

