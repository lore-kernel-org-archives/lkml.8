Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA103C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0FBF2072D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583257856;
	bh=tCTuDfKPPmcVCVvBzYFAN8oMQCdtn+euLHGRYEqWOaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YC9q9Fvpl+Xerk8Om/xxIvOeAuD1tnmrfcatuVQcnDQWV/oUQ+pI988seh7BTr52B
	 kAC3CE48X/OP+aP4TSKtL/P35bbS53MJWR2CuVwHQvMC6K7/WjG0TosY1fdvYA6En+
	 ZVRiuf0+R2uLTOEht4iawhPg0iSs3/ZBq5IPmoS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbgCCRuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:50:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:58744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731240AbgCCRux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:50:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D74F7206E6;
        Tue,  3 Mar 2020 17:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583257852;
        bh=tCTuDfKPPmcVCVvBzYFAN8oMQCdtn+euLHGRYEqWOaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LzhoMEs3kEijyUJo3mpYsh/stdr+oDlU0DhrcNeb5X0hQ4DZ6jJXFu19Fb6ccsS/2
         zW5OZ8/YidJJHKaApjHJFXxqVNpCyNv/gEyMaLF8FZ8xS2rxrQXev3dIGkfEVVDQrp
         R7mFt8+5jpQM+Y8zAZmLQXihYnjtvxLGD+QO2YNI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5.5 153/176] perf hists browser: Restore ESC as "Zoom out" of DSO/thread/etc
Date:   Tue,  3 Mar 2020 18:43:37 +0100
Message-Id: <20200303174322.265649176@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174304.593872177@linuxfoundation.org>
References: <20200303174304.593872177@linuxfoundation.org>
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
@@ -3062,6 +3062,7 @@ static int perf_evsel__hists_browse(stru
 
 				continue;
 			}
+			actions->ms.map = map;
 			top = pstack__peek(browser->pstack);
 			if (top == &browser->hists->dso_filter) {
 				/*


