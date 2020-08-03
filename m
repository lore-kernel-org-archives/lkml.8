Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516BCC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2506E2083B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596457760;
	bh=pPLMt+TyjFNT7l3WxNhNb9IrLTc7yKu/fEg5hGC/7gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ah67l+7z6ShD67EcSSfCS8YUCjlj0HHAq/mPaOqL21kFes53HdKf/iVWJPRA9TRkK
	 cF/K1JTK4Ap3aSJ9GkVbE0tr5mUVFvYXCR2iRuQrLBltOzmG/786ltsODz6Blh0SVe
	 qU33WwTpoQ3nsatFQc3Owr7jIDXfxlx3wmEL+HKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgHCM3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:29:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728877AbgHCM3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:29:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04E582086A;
        Mon,  3 Aug 2020 12:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457755;
        bh=pPLMt+TyjFNT7l3WxNhNb9IrLTc7yKu/fEg5hGC/7gw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1AbOmEUBv54zdtqa3MKqBecToMmye8LmofEoDDRrxwF2DQVfaAgFxa2WuzzW57D84
         6a2jn76xoxA7mbZaIqFfMV4OujU3ICw4MDrGutc4rte83L8R8AmDFDUxg6jh1JRLyE
         LsVe93spUaMKiD+uI75BgvgBfC2C0qbtvNWp4GSw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5.4 32/90] libtraceevent: Fix build with binutils 2.35
Date:   Mon,  3 Aug 2020 14:18:54 +0200
Message-Id: <20200803121859.168687426@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121857.546052424@linuxfoundation.org>
References: <20200803121857.546052424@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Hutchings <ben@decadent.org.uk>

commit 39efdd94e314336f4acbac4c07e0f37bdc3bef71 upstream.

In binutils 2.35, 'nm -D' changed to show symbol versions along with
symbol names, with the usual @@ separator.  When generating
libtraceevent-dynamic-list we need just the names, so strip off the
version suffix if present.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
Tested-by: Salvatore Bonaccorso <carnil@debian.org>
Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-devel@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/lib/traceevent/plugins/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/lib/traceevent/plugins/Makefile
+++ b/tools/lib/traceevent/plugins/Makefile
@@ -196,7 +196,7 @@ define do_generate_dynamic_list_file
 	xargs echo "U w W" | tr 'w ' 'W\n' | sort -u | xargs echo`;\
 	if [ "$$symbol_type" = "U W" ];then				\
 		(echo '{';                                              \
-		$(NM) -u -D $1 | awk 'NF>1 {print "\t"$$2";"}' | sort -u;\
+		$(NM) -u -D $1 | awk 'NF>1 {sub("@.*", "", $$2); print "\t"$$2";"}' | sort -u;\
 		echo '};';                                              \
 		) > $2;                                                 \
 	else                                                            \


