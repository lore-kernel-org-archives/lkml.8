Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E142BC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C089422B40
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597929924;
	bh=HZ8n1v18IYPmsqxlP9MdsQM6TcwUypHENjI4SX7XlMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MR/VpqXLPuiFElNY5/ay9lE7qbddDhsgsWpj/r4pI0mv0eERxyfoIzVj355OMasyh
	 v9ZYkdktbIZeWSb/lk7lmd7AC8QXFt8P/faKTqX2pjDMJIYqTU2SBsYMmFsa+jrC2h
	 Yi0v244xT3UHQA5nipQ144VXcsqMcSvM6scnqYmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbgHTNZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:25:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbgHTJeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:34:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD13F22B43;
        Thu, 20 Aug 2020 09:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916028;
        bh=HZ8n1v18IYPmsqxlP9MdsQM6TcwUypHENjI4SX7XlMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CCWNHf/3v/Zq6l5kMPE/2YzOpTuW/Q9yvadwzDkZ+0aPJqY0oxgTBb12fCVfQKINH
         Q20ayMnPFDsJ0HB/zlYLAspRPQWB4eZLOzsqKE2VWDT9WtmSaqu49ufl5yap/gcFbd
         A6x0ulmXApuv49BCi689CMl94VBJapNfG1KekpHM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Len Brown <len.brown@intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 217/232] perf/x86/rapl: Fix missing psys sysfs attributes
Date:   Thu, 20 Aug 2020 11:21:08 +0200
Message-Id: <20200820091623.308974872@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

[ Upstream commit 4bb5fcb97a5df0bbc0a27e0252b1e7ce140a8431 ]

This fixes a problem introduced by commit:

  5fb5273a905c ("perf/x86/rapl: Use new MSR detection interface")

that perf event sysfs attributes for psys RAPL domain are missing.

Fixes: 5fb5273a905c ("perf/x86/rapl: Use new MSR detection interface")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Link: https://lore.kernel.org/r/20200811153149.12242-2-rui.zhang@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/rapl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 0f2bf59f43541..51ff9a3618c95 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -665,7 +665,7 @@ static const struct attribute_group *rapl_attr_update[] = {
 	&rapl_events_pkg_group,
 	&rapl_events_ram_group,
 	&rapl_events_gpu_group,
-	&rapl_events_gpu_group,
+	&rapl_events_psys_group,
 	NULL,
 };
 
-- 
2.25.1



