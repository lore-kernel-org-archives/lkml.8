Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603BBC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 18:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ABF32084D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 18:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgHESQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 14:16:24 -0400
Received: from smtprelay0072.hostedemail.com ([216.40.44.72]:57264 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728631AbgHESOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 14:14:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id BA88F173085A;
        Wed,  5 Aug 2020 18:14:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pen53_200df7926fb1
X-Filterd-Recvd-Size: 1809
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Wed,  5 Aug 2020 18:14:39 +0000 (UTC)
Message-ID: <91ea17761845500f161ab343ea6e3415d3564d7b.camel@perches.com>
Subject: [PATCH] spelling.txt: Remove some duplicate entries
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>
Cc:     Colin King <colin.king@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 05 Aug 2020 11:14:38 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Found when Colin King fixed a typo for falied/failed
and a git grep showed 2 entries in this file.

Signed-off-by: Joe Perches <joe@perches.com>
---

 scripts/spelling.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index f253681e7e2a..b703e4fd51e8 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -596,7 +596,6 @@ extenstion||extension
 extracter||extractor
 faied||failed
 faield||failed
-falied||failed
 faild||failed
 failded||failed
 failer||failure
@@ -793,7 +792,6 @@ interrup||interrupt
 interrups||interrupts
 interruptted||interrupted
 interupted||interrupted
-interupt||interrupt
 intial||initial
 intialisation||initialisation
 intialised||initialised
@@ -968,7 +966,6 @@ occurd||occurred
 occured||occurred
 occurence||occurrence
 occure||occurred
-occured||occurred
 occuring||occurring
 offser||offset
 offet||offset
@@ -1437,7 +1434,6 @@ udpate||update
 uesd||used
 uknown||unknown
 usccess||success
-usupported||unsupported
 uncommited||uncommitted
 uncompatible||incompatible
 unconditionaly||unconditionally


