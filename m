Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2612C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97D79204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597927847;
	bh=7eNJZAeIQkdSSX3mtplbLXopuSMEszyWowDGIwirGi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uDZ6HkkPdbt85wHVNoJUlOnS/wky1mpmvjy/wkLjW2qErV7w1wETYBDoaNJIOIKUL
	 lHJLJe2F0aDec0iMNqHBXy+9pWBS0UtvG3rf+o3r7W1tI481BlZPe8Tzd5RRsIogXN
	 7NcfAfIDqljVQugpt9AaPdg8OEPa4/5vVtqxdt24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbgHTMuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:50:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729197AbgHTJpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:45:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E79D222D03;
        Thu, 20 Aug 2020 09:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916676;
        bh=7eNJZAeIQkdSSX3mtplbLXopuSMEszyWowDGIwirGi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0kMn5ZhZSca7dDPW0VF+FOO4XDOmN303w8IcvB6HvQjMR2DGR38CFO9JL4YQNwvlC
         xQQbAx4/U3dbYl7R9tSBr2rC22ztg6d91oSX8RY/no9dye1XtQ9iuaeFnJ+ARqHk2Q
         pIbPsvpyptsEB5IVNK6swFp+CnBB41zkXd5B90P0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Len Brown <len.brown@intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 187/204] perf/x86/rapl: Fix missing psys sysfs attributes
Date:   Thu, 20 Aug 2020 11:21:24 +0200
Message-Id: <20200820091615.534836231@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
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
index ece043fb7b494..fbc32b28f4cb8 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -642,7 +642,7 @@ static const struct attribute_group *rapl_attr_update[] = {
 	&rapl_events_pkg_group,
 	&rapl_events_ram_group,
 	&rapl_events_gpu_group,
-	&rapl_events_gpu_group,
+	&rapl_events_psys_group,
 	NULL,
 };
 
-- 
2.25.1



