Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B43CC3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1851F215A4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583258519;
	bh=2dl2EyDbGRDd5Mjd5tpTxIts+FmRV8BUsLtK9qsQGy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dRo+1LYVPn3MehN1Ug2KXV4csNYpp3wu4omphH47WOQw4PoU0YIcU/HCBI6VV8r+g
	 /BMwkjQpfdqh35LZw3cYy071h9yJQhqHsJSN6WS44XsyNncXPNWy/AZCuhbgq2kDJB
	 kfOAsDdbyZdycOKtoX4tMwrKn88inyIYOCwZAYzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388102AbgCCSB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:01:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:46352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388093AbgCCSBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 13:01:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0881F20836;
        Tue,  3 Mar 2020 18:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583258514;
        bh=2dl2EyDbGRDd5Mjd5tpTxIts+FmRV8BUsLtK9qsQGy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bM/jaOuq7m/J6QtEZiJVG5jlpDy7Cm+Zd1xlu6i660xMMUAIdG9H/BMiY6UgRzDiW
         NKKj7eb6l6B80Ggz3hemAK2tZIPeoQcx3y2SQeKpMETB0FzzFG6QhahzZHp6/bFthS
         TOHE7lVs1XRIB13m52QPl0KKbC6NQjGD8sQMANQs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.19 79/87] perf hists browser: Restore ESC as "Zoom out" of DSO/thread/etc
Date:   Tue,  3 Mar 2020 18:44:10 +0100
Message-Id: <20200303174357.353299760@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174349.075101355@linuxfoundation.org>
References: <20200303174349.075101355@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

commit 3f7774033e6820d25beee5cf7aefa11d4968b951 upstream.

We need to set actions->ms.map since 599a2f38a989 ("perf hists browser:
Check sort keys before hot key actions"), as in that patch we bail out
if map is NULL.

Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: 599a2f38a989 ("perf hists browser: Check sort keys before hot key actions")
Link: https://lkml.kernel.org/n/tip-wp1ssoewy6zihwwexqpohv0j@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/ui/browsers/hists.c |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2931,6 +2931,7 @@ static int perf_evsel__hists_browse(stru
 
 				continue;
 			}
+			actions->ms.map = map;
 			top = pstack__peek(browser->pstack);
 			if (top == &browser->hists->dso_filter) {
 				/*


