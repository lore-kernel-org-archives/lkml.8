Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135ECC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6EA4206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgCMRtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:49:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39241 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgCMRtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 13:49:49 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jCoRO-00020u-Lp; Fri, 13 Mar 2020 17:49:46 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/spelling.txt: add more spellings to spelling.txt
Date:   Fri, 13 Mar 2020 17:49:46 +0000
Message-Id: <20200313174946.228216-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Here are some of the more common spelling mistakes and typos that I've
found while fixing up spelling mistakes in the kernel since November 2019

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 scripts/spelling.txt | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 6d5243904e76..d9cd24cf0d40 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -177,7 +177,9 @@ atomatically||automatically
 atomicly||atomically
 atempt||attempt
 attachement||attachment
+attatch||attach
 attched||attached
+attemp||attempt
 attemps||attempts
 attemping||attempting
 attepmpt||attempt
@@ -235,11 +237,13 @@ brievely||briefly
 brigde||bridge
 broadcase||broadcast
 broadcat||broadcast
+bufer||buffer
 bufufer||buffer
 cacluated||calculated
 caculate||calculate
 caculation||calculation
 cadidate||candidate
+cahces||caches
 calender||calendar
 calescing||coalescing
 calle||called
@@ -338,7 +342,6 @@ conditon||condition
 condtion||condition
 conected||connected
 conector||connector
-connecetd||connected
 configration||configuration
 configuartion||configuration
 configuation||configuration
@@ -349,7 +352,9 @@ configuretion||configuration
 configutation||configuration
 conider||consider
 conjuction||conjunction
+connecetd||connected
 connectinos||connections
+connetor||connector
 connnection||connection
 connnections||connections
 consistancy||consistency
@@ -469,6 +474,7 @@ difinition||definition
 digial||digital
 dimention||dimension
 dimesions||dimensions
+disgest||digest
 dispalying||displaying
 diplay||display
 directon||direction
@@ -553,6 +559,7 @@ etsablishment||establishment
 etsbalishment||establishment
 excecutable||executable
 exceded||exceeded
+exceeed||exceed
 excellant||excellent
 execeeded||exceeded
 execeeds||exceeds
@@ -742,6 +749,7 @@ initialzing||initializing
 initilization||initialization
 initilize||initialize
 initliaze||initialize
+initilized||initialized
 inofficial||unofficial
 inrerface||interface
 insititute||institute
@@ -802,6 +810,7 @@ irrelevent||irrelevant
 isnt||isn't
 isssue||issue
 issus||issues
+iteraions||iterations
 iternations||iterations
 itertation||iteration
 itslef||itself
@@ -828,6 +837,7 @@ libary||library
 librairies||libraries
 libraris||libraries
 licenceing||licencing
+limted||limited
 logaritmic||logarithmic
 loggging||logging
 loggin||login
@@ -924,6 +934,7 @@ nerver||never
 nescessary||necessary
 nessessary||necessary
 noticable||noticeable
+notication||notification
 notications||notifications
 notifcations||notifications
 notifed||notified
@@ -1007,6 +1018,7 @@ pendantic||pedantic
 peprocessor||preprocessor
 perfoming||performing
 perfomring||performing
+periperal||peripheral
 peripherial||peripheral
 permissons||permissions
 peroid||period
@@ -1043,6 +1055,7 @@ prefferably||preferably
 premption||preemption
 prepaired||prepared
 preperation||preparation
+preprare||prepare
 pressre||pressure
 primative||primitive
 princliple||principle
@@ -1064,6 +1077,7 @@ processsed||processed
 processsing||processing
 procteted||protected
 prodecure||procedure
+progamming||programming
 progams||programs
 progess||progress
 programers||programmers
@@ -1151,12 +1165,14 @@ replys||replies
 reponse||response
 representaion||representation
 reqeust||request
+reqister||register
 requestied||requested
 requiere||require
 requirment||requirement
 requred||required
 requried||required
 requst||request
+requsted||requested
 reregisteration||reregistration
 reseting||resetting
 reseved||reserved
@@ -1227,10 +1243,12 @@ seqeuncer||sequencer
 seqeuencer||sequencer
 sequece||sequence
 sequencial||sequential
+serivce||service
 serveral||several
 servive||service
 setts||sets
 settting||setting
+shapshot||snapshot
 shotdown||shutdown
 shoud||should
 shouldnt||shouldn't
-- 
2.25.1

