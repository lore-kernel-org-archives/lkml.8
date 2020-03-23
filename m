Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39527C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B1620714
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgCWN7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:59:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:32719 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728530AbgCWN7S (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 09:59:18 -0400
IronPort-SDR: s5mHNkrDBxv1gRMLe3MYhrgqRx60yGeOUk4Z89NuyHexrcg37Ksq2HgTFU3BoBXbm7UE+I04F1
 ofE8IqM5QmXw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 06:59:18 -0700
IronPort-SDR: DqH60UWVJ8o+GzONqrr9LzVitrkLS8sMk0GSBjgE6Tqd5YokA3vDXTEPUpQm7u96p0CfC71lKI
 Krzpd3KU3GAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,296,1580803200"; 
   d="scan'208";a="357101009"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.254.213.220]) ([10.254.213.220])
  by fmsmga001.fm.intel.com with ESMTP; 23 Mar 2020 06:59:14 -0700
Subject: Re: [PATCH v2 00/14] perf: Stream comparison
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200313071118.11983-1-yao.jin@linux.intel.com>
 <20200323110514.GG1534489@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <ed2686f2-a370-4113-5148-e75c194b25bd@linux.intel.com>
Date:   Mon, 23 Mar 2020 21:59:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200323110514.GG1534489@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 3/23/2020 7:05 PM, Jiri Olsa wrote:
> On Fri, Mar 13, 2020 at 03:11:04PM +0800, Jin Yao wrote:
>> Sometimes, a small change in a hot function reducing the cycles of
>> this function, but the overall workload doesn't get faster. It is
>> interesting where the cycles are moved to.
> 
> I'm getting compilation fail:
> 
> 	  BUILD:   Doing 'make -j1' parallel build
> 	  CC       util/srclist.o
> 	util/srclist.c: In function ‘srclist__node_new’:
> 	util/srclist.c:388:35: error: ‘%s’ directive output may be truncated writing up to 4095 bytes into a region of size 4091 [-Werror=format-truncation=]
> 	  388 |  snprintf(cmd, sizeof(cmd), "diff %s %s",
> 	      |                                   ^~
> 	......
> 	  456 |  ret = init_src_info(b_path, a_path, rel_path, &node->info);
> 	      |                      ~~~~~~
> 	In file included from /usr/include/stdio.h:867,
> 			 from util/srclist.c:8:
> 	/usr/include/bits/stdio2.h:67:10: note: ‘__builtin___snprintf_chk’ output between 7 and 8197 bytes into a destination of size 4096
> 	   67 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
> 	      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 	   68 |        __bos (__s), __fmt, __va_arg_pack ());
> 	      |        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 	cc1: all warnings being treated as errors
> 	mv: cannot stat 'util/.srclist.o.tmp': No such file or directory
> 	make[4]: *** [/home/jolsa/kernel/linux-perf/tools/build/Makefile.build:97: util/srclist.o] Error 1
> 	make[3]: *** [/home/jolsa/kernel/linux-perf/tools/build/Makefile.build:139: util] Error 2
> 	make[2]: *** [Makefile.perf:617: perf-in.o] Error 2
> 	make[1]: *** [Makefile.perf:225: sub-make] Error 2
> 	make: *** [Makefile:70: all] Error 2
> 
> 
> [jolsa@krava ~]$ gcc --version
> gcc (GCC) 9.3.1 20200317 (Red Hat 9.3.1-1)
> 
> jirka
> 

Can you help to add following patch on top of the patch-set? Looks we 
need to check the return value of snprintf for truncation checking.

jinyao@kbl:~/kbl-ws/perf-dev/lck-7589/acme/tools/perf$ git diff
diff --git a/tools/perf/util/srclist.c b/tools/perf/util/srclist.c
index 8060e4855d11..51ca69eaa9fd 100644
--- a/tools/perf/util/srclist.c
+++ b/tools/perf/util/srclist.c
@@ -385,8 +385,12 @@ static int src_info__create_line_mapping(struct 
src_info *info, char *b_path,
                 goto out;
         }

-       snprintf(cmd, sizeof(cmd), "diff %s %s",
-                b_path, a_path);
+       ret = snprintf(cmd, PATH_MAX, "diff %s %s",
+                      b_path, a_path);
+       if (ret == PATH_MAX) {
+               ret = -1;
+               goto out;
+       }

         pr_debug("Execute '%s'\n", cmd);

Thanks
Jin Yao

