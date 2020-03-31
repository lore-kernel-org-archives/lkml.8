Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53DAC2D0E8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE1420675
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585646560;
	bh=hxaACYMgVkwhDkMiuBu1XAJBQziyl4HbwW2YSQDvWU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J3X/7Xq8Mz1kHXPqfEqEe6iMLk2vUCY4uBQX08PUm8Ac0qBGh/pEQUrsOBQQDpBau
	 IOD8kv+NMJWXy1YHvYNp7GYmQ0lUUe7iJ7fOSc3KK2/cgBE+uQFDo7HPYwfbCYDHPH
	 8sSJeJ0y++hvz5zq3VS5mjjqfKcKIxZbM5FM+LUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbgCaJGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:06:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730719AbgCaJG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:06:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D94FE20787;
        Tue, 31 Mar 2020 09:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645587;
        bh=hxaACYMgVkwhDkMiuBu1XAJBQziyl4HbwW2YSQDvWU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qKlBB3ekxUptMDjgc23y2hFslpuQkRswsUkYBI6ZXkHKCH2GAfsSZWHIDQsA5pQRa
         d5Am0GLBa6cy1XleF3MCaXnhyZcVioB+/hv58g4pZjxzb83gel+ZNeQL1f+8VBiMho
         LhwM0QGpJemeJIiywb7qaaDKTh97doz/1RYuXCqI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 5.5 098/170] perf probe: Fix to delete multiple probe event
Date:   Tue, 31 Mar 2020 10:58:32 +0200
Message-Id: <20200331085434.639847190@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085423.990189598@linuxfoundation.org>
References: <20200331085423.990189598@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 6b8d68f1ce9266b05a55e93c62923ff51daae4c1 upstream.

When we put an event with multiple probes, perf-probe fails to delete
with filters. This comes from a failure to list up the event name
because of overwrapping its name.

To fix this issue, skip to list up the event which has same name.

Without this patch:

  # perf probe -l \*
    probe_perf:map__map_ip (on perf_sample__fprintf_brstackoff:21@
    probe_perf:map__map_ip (on perf_sample__fprintf_brstackoff:25@
    probe_perf:map__map_ip (on append_inlines:12@util/machine.c in
    probe_perf:map__map_ip (on unwind_entry:19@util/machine.c in /
    probe_perf:map__map_ip (on map__map_ip@util/map.h in /home/mhi
    probe_perf:map__map_ip (on map__map_ip@util/map.h in /home/mhi
  # perf probe -d \*
  "*" does not hit any event.
    Error: Failed to delete events. Reason: No such file or directory (Code: -2)

With it:

  # perf probe -d \*
  Removed event: probe_perf:map__map_ip
  #

Fixes: 72363540c009 ("perf probe: Support multiprobe event")
Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Reported-by: He Zhe <zhe.he@windriver.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: stable@vger.kernel.org
Link: http://lore.kernel.org/lkml/158287666197.16697.7514373548551863562.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/probe-file.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -206,6 +206,9 @@ static struct strlist *__probe_file__get
 		} else
 			ret = strlist__add(sl, tev.event);
 		clear_probe_trace_event(&tev);
+		/* Skip if there is same name multi-probe event in the list */
+		if (ret == -EEXIST)
+			ret = 0;
 		if (ret < 0)
 			break;
 	}


