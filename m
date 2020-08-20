Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E7DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B79D2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597931123;
	bh=hYpdoeMtS7l6OvSWp7k6NO+QjgxRPzAZL6142S/BCYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D76k+mxlW37ADyKpUEO0i3Vtd5cQFDjVEQ4C6g1HjR3Qsg+wMad53+6RlUe2obdxR
	 tPA9L97r/94iI6oGzfoj8gBbspAWx5AWLv030ZhipMkKFRZdGik8gkXch2eNH01KEr
	 fN3OqTTtUL05cLkHh9PiIvkaYwFwOLdVSIMWwm5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbgHTNpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:45:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726815AbgHTJ2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:28:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A90F22D0B;
        Thu, 20 Aug 2020 09:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915694;
        bh=hYpdoeMtS7l6OvSWp7k6NO+QjgxRPzAZL6142S/BCYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jp8en4IZ6/S8DJRYd18oorp6MxKhHvmQopGDRIeX0r4J1Rx/ETu8CwROG0BZ9M/DF
         YIuplCcHHz9w23IMMoung7HBoGb7U48gwL4i6RWAZS2OsksFhFm1QdlIrx65S5OzbV
         YQ0/TcWycCork0r4sjqEO1Hw5j4wnV93WlwrMIkk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5.8 103/232] perf probe: Fix memory leakage when the probe point is not found
Date:   Thu, 20 Aug 2020 11:19:14 +0200
Message-Id: <20200820091617.814266024@linuxfoundation.org>
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

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 12d572e785b15bc764e956caaa8a4c846fd15694 upstream.

Fix the memory leakage in debuginfo__find_trace_events() when the probe
point is not found in the debuginfo. If there is no probe point found in
the debuginfo, debuginfo__find_probes() will NOT return -ENOENT, but 0.

Thus the caller of debuginfo__find_probes() must check the tf.ntevs and
release the allocated memory for the array of struct probe_trace_event.

The current code releases the memory only if the debuginfo__find_probes()
hits an error but not checks tf.ntevs. In the result, the memory allocated
on *tevs are not released if tf.ntevs == 0.

This fixes the memory leakage by checking tf.ntevs == 0 in addition to
ret < 0.

Fixes: ff741783506c ("perf probe: Introduce debuginfo to encapsulate dwarf information")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: stable@vger.kernel.org
Link: http://lore.kernel.org/lkml/159438668346.62703.10887420400718492503.stgit@devnote2
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/probe-finder.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1467,7 +1467,7 @@ int debuginfo__find_trace_events(struct
 	if (ret >= 0 && tf.pf.skip_empty_arg)
 		ret = fill_empty_trace_arg(pev, tf.tevs, tf.ntevs);
 
-	if (ret < 0) {
+	if (ret < 0 || tf.ntevs == 0) {
 		for (i = 0; i < tf.ntevs; i++)
 			clear_probe_trace_event(&tf.tevs[i]);
 		zfree(tevs);


