Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD16C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71A472075F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgGNJ2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:28:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58197 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgGNJ2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:28:40 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jvHEr-0003hO-Oe; Tue, 14 Jul 2020 09:28:37 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/spelling.txt: add more spellings to spelling.txt
Date:   Tue, 14 Jul 2020 10:28:37 +0100
Message-Id: <20200714092837.173796-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Here are some of the more common spelling mistakes and typos that I've
found while fixing up spelling mistakes in the kernel since April 2020.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 scripts/spelling.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index c45e9afaab2d..f253681e7e2a 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -149,6 +149,7 @@ arbitary||arbitrary
 architechture||architecture
 arguement||argument
 arguements||arguments
+arithmatic||arithmetic
 aritmetic||arithmetic
 arne't||aren't
 arraival||arrival
@@ -454,6 +455,7 @@ destorys||destroys
 destroied||destroyed
 detabase||database
 deteced||detected
+detectt||detect
 develope||develop
 developement||development
 developped||developed
@@ -545,6 +547,7 @@ entires||entries
 entites||entities
 entrys||entries
 enocded||encoded
+enought||enough
 enterily||entirely
 enviroiment||environment
 enviroment||environment
@@ -556,11 +559,14 @@ equivelant||equivalent
 equivilant||equivalent
 eror||error
 errorr||error
+errror||error
 estbalishment||establishment
 etsablishment||establishment
 etsbalishment||establishment
+evalution||evaluation
 excecutable||executable
 exceded||exceeded
+exceds||exceeds
 exceeed||exceed
 excellant||excellent
 execeeded||exceeded
@@ -583,6 +589,7 @@ explictly||explicitly
 expresion||expression
 exprimental||experimental
 extened||extended
+exteneded||extended||extended
 extensability||extensibility
 extention||extension
 extenstion||extension
@@ -610,10 +617,12 @@ feautures||features
 fetaure||feature
 fetaures||features
 fileystem||filesystem
+fimrware||firmware
 fimware||firmware
 firmare||firmware
 firmaware||firmware
 firware||firmware
+firwmare||firmware
 finanize||finalize
 findn||find
 finilizes||finalizes
@@ -661,6 +670,7 @@ globel||global
 grabing||grabbing
 grahical||graphical
 grahpical||graphical
+granularty||granularity
 grapic||graphic
 grranted||granted
 guage||gauge
@@ -906,6 +916,7 @@ miximum||maximum
 mmnemonic||mnemonic
 mnay||many
 modfiy||modify
+modifer||modifier
 modulues||modules
 momery||memory
 memomry||memory
@@ -915,6 +926,7 @@ monochromo||monochrome
 monocrome||monochrome
 mopdule||module
 mroe||more
+multipler||multiplier
 mulitplied||multiplied
 multidimensionnal||multidimensional
 multipe||multiple
@@ -952,6 +964,7 @@ occassionally||occasionally
 occationally||occasionally
 occurance||occurrence
 occurances||occurrences
+occurd||occurred
 occured||occurred
 occurence||occurrence
 occure||occurred
@@ -1058,6 +1071,7 @@ precission||precision
 preemptable||preemptible
 prefered||preferred
 prefferably||preferably
+prefitler||prefilter
 premption||preemption
 prepaired||prepared
 preperation||preparation
@@ -1101,6 +1115,7 @@ pronunce||pronounce
 propery||property
 propigate||propagate
 propigation||propagation
+propogation||propagation
 propogate||propagate
 prosess||process
 protable||portable
@@ -1316,6 +1331,7 @@ sturcture||structure
 subdirectoires||subdirectories
 suble||subtle
 substract||subtract
+submited||submitted
 submition||submission
 suceed||succeed
 succesfully||successfully
@@ -1324,6 +1340,7 @@ successed||succeeded
 successfull||successful
 successfuly||successfully
 sucessfully||successfully
+sucessful||successful
 sucess||success
 superflous||superfluous
 superseeded||superseded
@@ -1409,6 +1426,7 @@ transormed||transformed
 trasfer||transfer
 trasmission||transmission
 treshold||threshold
+triggerd||triggered
 trigerred||triggered
 trigerring||triggering
 trun||turn
@@ -1421,6 +1439,7 @@ uknown||unknown
 usccess||success
 usupported||unsupported
 uncommited||uncommitted
+uncompatible||incompatible
 unconditionaly||unconditionally
 undeflow||underflow
 underun||underrun
-- 
2.27.0

