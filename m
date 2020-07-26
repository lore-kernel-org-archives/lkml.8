Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE441C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 05:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CF76206E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 05:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbSLNcKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgGZF67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 01:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgGZF66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 01:58:58 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C50C0619D2;
        Sat, 25 Jul 2020 22:58:58 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id kq25so903791ejb.3;
        Sat, 25 Jul 2020 22:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=I6XqHb7TKjXhnvSm7JahxLKLF4M+094vQnTCeqVNkHk=;
        b=SbSLNcKWPh/7qYRAnSvGzuWEbZLO0+h4lWXaEWXhD8litGtRAL5ahdgeWCB8Ig6ObI
         YwDN/HiSHJJWP0blpaimpJAZuhynLX3oyprm/rD1l/TktDVmW5Zo2Z1ulMFxDGiGuJ4c
         pTrBLjPbELZUTd6hcDItI9tsy1WlHYbnPQBPpospWcZsA9st9ivkHdo+6T3ohIRYeR/u
         +0hBoAM0ldTuWvO+lD75TEdcIf/mTRAkmpvwqjikqkLnEof+OQZPuZbSrN9SA2IYQr7x
         nd1XW2vBU75ytINPwFe0dF8kHFZaHWhbJv7nQJ/DKJvogCREKVa8+XDwkKFyQ6LrXULv
         wg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I6XqHb7TKjXhnvSm7JahxLKLF4M+094vQnTCeqVNkHk=;
        b=Sc3rSq+Nbvwneohl0dpzJCOVZKdLS2kCYkxCuW8GrtHXW2cYthMqmEPQvrwkEJjBTG
         nvZAJHXQ7KGM4ED5Mghmbn7oBcJ1A0XpYOQcT4IGIWsSjyiZYruVu47V1dgCVK4ahs5G
         pPMczUEIOixHRq+ictCSu0MbewpYVdJgG+yoflumCPu46gb0M/ZsmrqcsSjEC9w+8ief
         djb+AA8IWaToUbiUjSGeDSG5rm15SkDF/WrEP3AtXuvIYYiUOCvvmkRKPSS6Qvxd/y+A
         tIUrby9DYgH5H0Yw1TrpbbniPBVDFfYV4/KrH6uhgCWmy8wbK3aiVJ9y46bz+8W2SUNu
         rD6w==
X-Gm-Message-State: AOAM530QyupElmOxgIcVSO1oDSo5S2mTb/45b4UwpcE8GvqmRdyJb0Yq
        eoBMR6LIKAIPRolcqhRJ4gI=
X-Google-Smtp-Source: ABdhPJyYrrVsodgMC9gZ4llhHzEPMHbnt08nWJ8IY+E5/yyfN9of4njsydsSLWRk1eKWk0ChImYkbA==
X-Received: by 2002:a17:906:430a:: with SMTP id j10mr14945339ejm.163.1595743136995;
        Sat, 25 Jul 2020 22:58:56 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2ddd:7800:e9bf:bff0:c68e:55b7])
        by smtp.gmail.com with ESMTPSA id r9sm4556620edt.1.2020.07.25.22.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 22:58:56 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust kprobes.rst entry to new location
Date:   Sun, 26 Jul 2020 07:58:43 +0200
Message-Id: <20200726055843.10783-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2165b82fde82 ("docs: Move kprobes.rst from staging/ to trace/")
moved kprobes.rst, but missed to adjust the MAINTAINERS entry.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:

  warning: no file matches    F:    Documentation/staging/kprobes.rst

Adjust the entry to the new file location.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Naveen, Masami-san, please ack.
Jonathan, please pick this minor non-urgent patch into docs-next.

applies cleanly on next-20200724

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 960f7d43f9d7..416fc4555834 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9676,7 +9676,7 @@ M:	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
 M:	"David S. Miller" <davem@davemloft.net>
 M:	Masami Hiramatsu <mhiramat@kernel.org>
 S:	Maintained
-F:	Documentation/staging/kprobes.rst
+F:	Documentation/trace/kprobes.rst
 F:	include/asm-generic/kprobes.h
 F:	include/linux/kprobes.h
 F:	kernel/kprobes.c
-- 
2.17.1

