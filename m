Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1707C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA0B32078C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588616172;
	bh=RMLWuBEV/LmPOhN8ZRn45upPYmqFgDB4TZ1V9KzBJGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SN6C2PU8dnAHpKDbiXxMMdDS3+j5a/UUdXyuJpwxu+5OWGLXMg+4Qsxuw6lZDC+zA
	 9lAMU/ehZfaH5lOxkg8Zke7Ck0L9k3GF4wliE+Fd1bMKxA0v3SUu2cXamGMgvDl1W3
	 03LB5ieCrV2jPbSLta/h13vjTLwE+KQXH2HpyYKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730664AbgEDR7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:59:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730627AbgEDR67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:58:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36F1920707;
        Mon,  4 May 2020 17:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615138;
        bh=RMLWuBEV/LmPOhN8ZRn45upPYmqFgDB4TZ1V9KzBJGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LcKsGtsIQJzrbzlBtaJetA0ySu1kbo/eYXnQ0C3HikA3U15VkK168ZffRimZ2Ic0w
         yqJxc+Zj9WkOvOBQ4lzhip1UCahQLs+cIlsPJbex3swfTN2KBbvhcRx1Or0ZKpMLXA
         qZ7zXrtt8oDuoR5U091L4dp83R3qNisWmB+IdWCk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.4 11/18] perf hists: Fix HISTC_MEM_DCACHELINE width setting
Date:   Mon,  4 May 2020 19:57:09 +0200
Message-Id: <20200504165443.876938763@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165441.533160703@linuxfoundation.org>
References: <20200504165441.533160703@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

commit 0805909f59e02036a4e2660159f27dbf8b6084ac upstream.

Set correct width for unresolved mem_dcacheline addr.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Don Zickus <dzickus@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Fixes: 9b32ba71ba90 ("perf tools: Add dcacheline sort")
Link: http://lkml.kernel.org/r/1453290995-18485-3-git-send-email-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/hist.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -131,6 +131,8 @@ void hists__calc_col_len(struct hists *h
 			symlen = unresolved_col_width + 4 + 2;
 			hists__new_col_len(hists, HISTC_MEM_DADDR_SYMBOL,
 					   symlen);
+			hists__new_col_len(hists, HISTC_MEM_DCACHELINE,
+					   symlen);
 		}
 
 		if (h->mem_info->iaddr.sym) {


