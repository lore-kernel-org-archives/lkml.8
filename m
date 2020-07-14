Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03148C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D589522CAD
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752792;
	bh=/6OqGyB6j1Y5RgqtxHPkVz0xAsQg57VglVJYD2HVQ2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z2z1ATY+nVne6QXDJktOlhinZNLjOj29Qsvy3KYKZgzETgj5iL2NQ9P73K6PTrslp
	 /orII+gFx3vxaaG/wSU30uqz3CwL279NYGVZWVmDnUGX+KBiWpPnFSyg7BK/e4NziF
	 IPn0cg44kBg1o4avymSaWy1k48Yti+7C6Qebg5Gc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbgGNSxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:53:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730573AbgGNSw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:52:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1806223B0;
        Tue, 14 Jul 2020 18:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752778;
        bh=/6OqGyB6j1Y5RgqtxHPkVz0xAsQg57VglVJYD2HVQ2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nabMPTILMiSWREPsKssfWxN/Kx9rDgjupI94YYFTQXtbqJLwp6ZUghx9CeTE78AXx
         lRuWCS1/8ArDEvEwzSAOfxdssVvXr2dyII83OyQWRUNaCmq3O/OEZFGR4NRYF15Huo
         uNT3gvXa1+Vo2ETLKEu6tFfYAEoC0rucrGaLPGzk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5.4 105/109] perf scripts python: export-to-postgresql.py: Fix struct.pack() int argument
Date:   Tue, 14 Jul 2020 20:44:48 +0200
Message-Id: <20200714184110.594681401@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184105.507384017@linuxfoundation.org>
References: <20200714184105.507384017@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

commit 640432e6bed08e9d5d2ba26856ba3f55008b07e3 upstream.

Python 3.8 is requiring that arguments being packed as integers are also
integers.  Add int() accordingly.

 Before:

   $ perf record -e intel_pt//u uname
   $ perf script --itrace=bep -s ~/libexec/perf-core/scripts/python/export-to-postgresql.py perf_data_db branches calls
   2020-06-25 16:09:10.547256 Creating database...
   2020-06-25 16:09:10.733185 Writing to intermediate files...
   Traceback (most recent call last):
     File "/home/ahunter/libexec/perf-core/scripts/python/export-to-postgresql.py", line 1106, in synth_data
       cbr(id, raw_buf)
     File "/home/ahunter/libexec/perf-core/scripts/python/export-to-postgresql.py", line 1058, in cbr
       value = struct.pack("!hiqiiiiii", 4, 8, id, 4, cbr, 4, MHz, 4, percent)
   struct.error: required argument is not an integer
   Fatal Python error: problem in Python trace event handler
   Python runtime state: initialized

   Current thread 0x00007f35d3695780 (most recent call first):
   <no Python frame>
   Aborted (core dumped)

 After:

   $ dropdb perf_data_db
   $ rm -rf perf_data_db-perf-data
   $ perf script --itrace=bep -s ~/libexec/perf-core/scripts/python/export-to-postgresql.py perf_data_db branches calls
   2020-06-25 16:09:40.990267 Creating database...
   2020-06-25 16:09:41.207009 Writing to intermediate files...
   2020-06-25 16:09:41.270915 Copying to database...
   2020-06-25 16:09:41.382030 Removing intermediate files...
   2020-06-25 16:09:41.384630 Adding primary keys
   2020-06-25 16:09:41.541894 Adding foreign keys
   2020-06-25 16:09:41.677044 Dropping unused tables
   2020-06-25 16:09:41.703761 Done

Fixes: aba44287a224 ("perf scripts python: export-to-postgresql.py: Export Intel PT power and ptwrite events")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Link: http://lore.kernel.org/lkml/20200629091955.17090-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/scripts/python/export-to-postgresql.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/perf/scripts/python/export-to-postgresql.py
+++ b/tools/perf/scripts/python/export-to-postgresql.py
@@ -1055,7 +1055,7 @@ def cbr(id, raw_buf):
 	cbr = data[0]
 	MHz = (data[4] + 500) / 1000
 	percent = ((cbr * 1000 / data[2]) + 5) / 10
-	value = struct.pack("!hiqiiiiii", 4, 8, id, 4, cbr, 4, MHz, 4, percent)
+	value = struct.pack("!hiqiiiiii", 4, 8, id, 4, cbr, 4, int(MHz), 4, int(percent))
 	cbr_file.write(value)
 
 def mwait(id, raw_buf):


