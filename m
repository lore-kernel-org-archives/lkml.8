Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4519C4741C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D3824670
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581707501;
	bh=lQZK6Dg+l0EX6rzgoMQuf6IdtDTM3IuJnjUlOGpQJuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PjmQCPT2kSk27FTGLMt7lSWMUnDThZNDRWjVQ18gni8wB1WMXrJuAe5PLoSstbper
	 Bv5YFnGs0QDxRk/3oyGUBc/aQoPnihWlUnYelnfCRHIC5r2qXJcGEZ7DQzM4MpTOva
	 M66CEnZbLeiP4rOwDN4AMoXt+sF6lgermk8fA6FE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388503AbgBNTLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:11:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:49266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388456AbgBNTLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:11:37 -0500
Received: from quaco.ghostprotocols.net (187-26-102-114.3g.claro.net.br [187.26.102.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56B4724654;
        Fri, 14 Feb 2020 19:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581707496;
        bh=lQZK6Dg+l0EX6rzgoMQuf6IdtDTM3IuJnjUlOGpQJuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=syv8+sVUpzMS2GY30FYUCzi0eP4oKZJ3WaZk9Sq2+sgY+f/TbYzpO/537RvpOSjEw
         TqUavREgySSIWud65FsexDOYQalg/+sjQFea32NwXoJPwzWJiqki6pYt+0bmJme1Lq
         BHklwLEmSIyAEwvG10vdO0lvm7bMmfoBbbETm7dw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/23] perf maps: Mark module DSOs with kernel type
Date:   Fri, 14 Feb 2020 16:10:39 -0300
Message-Id: <20200214191057.26266-6-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200214191057.26266-1-acme@kernel.org>
References: <20200214191057.26266-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We add kernel module map into machine->kmaps, so it needs to be created
as 'struct kmap', which is dependent on its dso having kernel type.

Reported-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Kim Phillips <kim.phillips@amd.com>
Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200210143218.24948-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index c8c5410315e8..e3e5490f6de5 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -686,6 +686,7 @@ static struct dso *machine__findnew_module_dso(struct machine *machine,
 
 		dso__set_module_info(dso, m, machine);
 		dso__set_long_name(dso, strdup(filename), true);
+		dso->kernel = DSO_TYPE_KERNEL;
 	}
 
 	dso__get(dso);
-- 
2.21.1

