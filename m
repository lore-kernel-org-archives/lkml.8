Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4561C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9288420738
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgHURkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:40:20 -0400
Received: from smtprelay0064.hostedemail.com ([216.40.44.64]:50468 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725820AbgHURkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 13:40:19 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id D9A8B182CED2A;
        Fri, 21 Aug 2020 17:40:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pen21_4a135492703b
X-Filterd-Recvd-Size: 1840
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Aug 2020 17:40:16 +0000 (UTC)
Message-ID: <1787fba7e252f053ef321b349f3bac39a8cdf503.camel@perches.com>
Subject: [PATCH] get_maintainer: Exclude MAINTAINERS file(s) from
 --git-fallback and --git-blame
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Rob Herring <robh@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 21 Aug 2020 10:40:15 -0700
In-Reply-To: <CAL_JsqLBfwXamvCB0C9ujhy-BS6P4BpU-MWPuZX+_+sYPVsUSg@mail.gmail.com>
References: <20200821154848.GI7871@localhost.localdomain>
         <CAL_JsqLBfwXamvCB0C9ujhy-BS6P4BpU-MWPuZX+_+sYPVsUSg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAINTAINERS files generally have no specific maintainer but are updated
by individuals for subsystems all over the source tree.

Exclude MAINTAINERS file(s) from --git-fallback and --git-blame searches
so the unlucky individuals that update the files the most are not shown.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/get_maintainer.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 484d2fbf5921..4d5196a11329 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -953,6 +953,7 @@ sub get_maintainers {
     }
 
     foreach my $file (@files) {
+	next if ($file =~ /MAINTAINERS$/);
 	if ($email &&
 	    ($email_git || ($email_git_fallback &&
 			    !$exact_pattern_match_hash{$file}))) {



