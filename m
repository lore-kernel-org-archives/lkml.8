Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D38C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0312D20675
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645612;
	bh=4QJEQOKZynqx+5osBx7WAdPupqu0Gs4IifljY4vX/rU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pQ/OPUBQ/3IpbXd0zaXlpYyhk9NIAB3VzJ2LGU57TFCSvJas32VI7DsFc47inH3ad
	 b+ndaGK1+aOrCm1CsnJgMU/r/An+DqXY0hSPkbS8iLXYbb+RBFMUTUtcfE0GK8igQJ
	 ILBJLvsMSKlmjui8vU2J9rCIE1KwVCbD7WgWRhNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbgCaJGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730647AbgCaJGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:06:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57567208E0;
        Tue, 31 Mar 2020 09:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645598;
        bh=4QJEQOKZynqx+5osBx7WAdPupqu0Gs4IifljY4vX/rU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GnXFLPzZ/FxAU9orWWV7FaA97bvc/HbU+E0K+8mZzgRGRmVcgZCBXsElFd5CHKVjE
         dvzUgxLq2TjNgV5SenjJ93h3iM4MBL+lYyD6a/12S6wqwjs74VpgFFQaJeSsd4US03
         5/CX/qBmU2TCtefMKeQp2LrMIs8wAABYBKP/Y9dI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dirk Mueller <dmueller@suse.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 5.5 102/170] scripts/dtc: Remove redundant YYLOC global declaration
Date:   Tue, 31 Mar 2020 10:58:36 +0200
Message-Id: <20200331085435.053942582@linuxfoundation.org>
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

From: Dirk Mueller <dmueller@suse.com>

commit e33a814e772cdc36436c8c188d8c42d019fda639 upstream.

gcc 10 will default to -fno-common, which causes this error at link
time:

  (.text+0x0): multiple definition of `yylloc'; dtc-lexer.lex.o (symbol from plugin):(.text+0x0): first defined here

This is because both dtc-lexer as well as dtc-parser define the same
global symbol yyloc. Before with -fcommon those were merged into one
defintion. The proper solution would be to to mark this as "extern",
however that leads to:

  dtc-lexer.l:26:16: error: redundant redeclaration of 'yylloc' [-Werror=redundant-decls]
   26 | extern YYLTYPE yylloc;
      |                ^~~~~~
In file included from dtc-lexer.l:24:
dtc-parser.tab.h:127:16: note: previous declaration of 'yylloc' was here
  127 | extern YYLTYPE yylloc;
      |                ^~~~~~
cc1: all warnings being treated as errors

which means the declaration is completely redundant and can just be
dropped.

Signed-off-by: Dirk Mueller <dmueller@suse.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
[robh: cherry-pick from upstream]
Cc: stable@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 scripts/dtc/dtc-lexer.l |    1 -
 1 file changed, 1 deletion(-)

--- a/scripts/dtc/dtc-lexer.l
+++ b/scripts/dtc/dtc-lexer.l
@@ -23,7 +23,6 @@ LINECOMMENT	"//".*\n
 #include "srcpos.h"
 #include "dtc-parser.tab.h"
 
-YYLTYPE yylloc;
 extern bool treesource_error;
 
 /* CAUTION: this will stop working if we ever use yyless() or yyunput() */


