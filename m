Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94244C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7161724693
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgB0MX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:23:26 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:48377 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728929AbgB0MXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:23:25 -0500
X-Originating-IP: 81.250.144.103
Received: from [10.30.1.20] (lneuilly-657-1-5-103.w81-250.abo.wanadoo.fr [81.250.144.103])
        (Authenticated sender: alex@ghiti.fr)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 72A7E240003;
        Thu, 27 Feb 2020 12:23:19 +0000 (UTC)
To:     Masami Hiramatsu <mhiramat@kernel.org>
From:   Alexandre Ghiti <alex@ghiti.fr>
Subject: Perf tool regression from 07d369857808
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Message-ID: <2bb02f9b-1413-97c3-684b-104a0fab9144@ghiti.fr>
Date:   Thu, 27 Feb 2020 13:23:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

The commit 07d369857808 ("perf probe: Fix wrong address verification) 
found its way in kernel 4.19.98 (and debian 10) and I observed some 
regressions when I try to add probes in shared libraries.
The symptoms are:

$ perf probe -f --exec=/home/aghiti/lib/libdpuhw.so --add 
'log_rank_path=log_rank_path rank path:string'
   Failed to find symbol at 0x3bf0
     Error: Failed to add events.

Whereas when I revert this patch, on the same shared library:

$ perf probe -f --exec=/home/aghiti/lib/libdpuhw.so --add 
'log_rank_path=log_rank_path rank path:string'
Added new event:
   probe_libdpuhw:log_rank_path_4 (on log_rank_path in 
/home/aghiti/lib/libdpuhw.so.2020.1.0 with rank path:string)

You can now use it in all perf tools, such as:

	perf record -e probe_libdpuhw:log_rank_path_4 -aR sleep 1

Actually, I noted that this patch reverts a previous patch that stated 
that dwfl_module_addrsym could fail on shared libraries 664fee3dc379 
("perf probe: Do not use dwfl_module_addrsym if dwarf_diename finds 
symbol name").

Let me know if I can be of any help,

Thanks,

Alexandre Ghiti
