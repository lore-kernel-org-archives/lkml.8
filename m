Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7561CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F3B20705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RWzDwV9Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgAaNvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 08:51:08 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35962 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729092AbgAaNvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 08:51:05 -0500
Received: by mail-pj1-f66.google.com with SMTP id gv17so2864025pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 05:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5Z7HXo4GP+f2mscCj2Lrc3wGR5IDDV26A7NOcH9deR4=;
        b=RWzDwV9YyJY9BKEGeGxbrwQfcofVdJzmm0E3P8P4NfiBqOv4mNdO9ttNeo5I5j0hIh
         /DyhcBfmxV5bAXGdytft6pTy9TxY+80pgfh8+aok1P7XVfX0LFRZ1ygOqmeycNCO0oQM
         RwQOgHDdJvyjNGchKlvBYz0qX50SaQeutuCmS7izpiuEdgwNmu7e/uOZeBhze7Joav+N
         qjshcHjpRk97nt2SACoYYPk6RJtii3+Rp4gt3rLlTngf3sFZsjhR9GJX1eUP1rvm+P5f
         8/Xh0dmiR5pY9wAlGwXXZXdG2TWAPSmp4EL94QWAMlRhUwm2AcHHjNHg2VmcxgS5OB53
         +VVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5Z7HXo4GP+f2mscCj2Lrc3wGR5IDDV26A7NOcH9deR4=;
        b=t+u66H2dUmWO3Ga6qwUyq8K40HD0iMs5x1TzPMUOlVX+oN3rx0buXumhElOxkOxGu8
         fB0kC6HldAXMvN+RU8U4VVZavPBNfaeidPCvQ2mJJuqslh24LQylbwxUM46wcaEfLzyV
         cd2d5UfvuMAOyHyKC5ZSTkLoe2fx/xL5kVJNQpYd/5V6iJPAYkxscnctQB1rSMBOdfQV
         LfP3saQUUGZjmboXxjmzv/vf7HHeoRXMoRs6bDWa4es8DzlD1EyXkZ6/pREyZbRPbtwu
         ueC9oqecrF/Y9My8ViVClYydxbD6ijgu+a5fnCA0VC5l+N2ISSVM8sPzuLDIjWG/i5VI
         isfA==
X-Gm-Message-State: APjAAAVZYGDP9VzK9ewVeSrRwE0uDZ58AhZbxKw1pYasmXTZqrH/XjR4
        TVsFWD03fraMS/vj7xvAGMt7
X-Google-Smtp-Source: APXvYqyfVuwEG3t4S7Sqc4pU7YzcIWgpNWfYK2gwf5iwlPh4gC6yAw57C6bBedXTUeEad2PjiRAKgw==
X-Received: by 2002:a17:902:7d8b:: with SMTP id a11mr5446352plm.99.1580478664653;
        Fri, 31 Jan 2020 05:51:04 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id p3sm10625632pfg.184.2020.01.31.05.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 05:51:03 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, bjorn.andersson@linaro.org,
        hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 13/16] MAINTAINERS: Add entry for MHI bus
Date:   Fri, 31 Jan 2020 19:20:06 +0530
Message-Id: <20200131135009.31477-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131135009.31477-1-manivannan.sadhasivam@linaro.org>
References: <20200131135009.31477-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for MHI bus.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf6ccca6e61c..9213d150041c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10777,6 +10777,16 @@ M:	Vladimir Vid <vladimir.vid@sartura.hr>
 S:	Maintained
 F:	arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
 
+MHI BUS
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+M:	Hemant Kumar <hemantk@codeaurora.org>
+L:	linux-arm-msm@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git
+S:	Maintained
+F:	drivers/bus/mhi/
+F:	include/linux/mhi.h
+F:	Documentation/mhi/
+
 MICROBLAZE ARCHITECTURE
 M:	Michal Simek <monstr@monstr.eu>
 W:	http://www.monstr.eu/fdt/
-- 
2.17.1

