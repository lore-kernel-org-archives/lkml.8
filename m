Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD6CC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A0C20409
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846396;
	bh=H90vFTsgDPdrsCvAeNtiElugPFNI4njS2SrR+/PyRYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VVb+37Hi+u2OOUHOIIfNgGqjbPI2bBn+/K8/whRMuVKFyl7k/9QohHcr/ItGt71G9
	 FtGFTtDEbVlleHeipgTxb9cvvHtLedvfoSZIy+CsmiMYQhIeJHPrnngd2rzULj/dLy
	 rwbH0iXgQfORWnj2DXLuFDVxx6T2u7a+c8JZOkLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbgCJNIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:08:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731041AbgCJNH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:07:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D69C2071B;
        Tue, 10 Mar 2020 13:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845679;
        bh=H90vFTsgDPdrsCvAeNtiElugPFNI4njS2SrR+/PyRYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VNzUG+16PUHx7X7KF51CBWdkYfZ35dkWS1YRYyI8tIsYN6SdGYj/NLBfjzm89O5Hr
         dwP9ZOh4hRYomRetsygh/CT3eefGHdr5mXy8qWwM6evkarGmyRk5J53yj3IUj4PMen
         jer4diLz7/XcPjtEGOuqQyyocYV6P5Nf7sGqb/fQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.14 062/126] perf hists browser: Restore ESC as "Zoom out" of DSO/thread/etc
Date:   Tue, 10 Mar 2020 13:41:23 +0100
Message-Id: <20200310124208.083902324@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310124203.704193207@linuxfoundation.org>
References: <20200310124203.704193207@linuxfoundation.org>
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
@@ -3142,6 +3142,7 @@ static int perf_evsel__hists_browse(stru
 
 				continue;
 			}
+			actions->ms.map = map;
 			top = pstack__peek(browser->pstack);
 			if (top == &browser->hists->dso_filter) {
 				/*


