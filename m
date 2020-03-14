Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2D3C0044D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914FE20637
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgCOCR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:17:27 -0400
Received: from smtprelay0153.hostedemail.com ([216.40.44.153]:39758 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727053AbgCOCR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:17:27 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id 46150180373CD
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 19:10:26 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 17EDB18029DAE;
        Sat, 14 Mar 2020 19:10:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: honey36_3b71627ac205
X-Filterd-Recvd-Size: 1364
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Sat, 14 Mar 2020 19:10:25 +0000 (UTC)
Message-ID: <f0b213d90e0c2138bedcc4822063dde2650f787f.camel@perches.com>
Subject: vim: linux-kernel: Add "fallthrough" as a keyword
From:   Joe Perches <joe@perches.com>
To:     Vivien Didelot <vivien.didelot@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Sat, 14 Mar 2020 12:08:40 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fallthrough as a keyword for source code highlighting as
fallthrough was added as a pseudo-keyword macro to replace the
various forms of switch/case /* fallthrough */ comments.

Signed-off-by: Joe Perches <joe@perches.com>
---
 plugin/linuxsty.vim | 1 +
 1 file changed, 1 insertion(+)

diff --git a/plugin/linuxsty.vim b/plugin/linuxsty.vim
index 18b28..44824 100644
--- a/plugin/linuxsty.vim
+++ b/plugin/linuxsty.vim
@@ -69,6 +69,7 @@ function s:LinuxFormatting()
 endfunction
 
 function s:LinuxKeywords()
+    syn keyword cStatement fallthrough
     syn keyword cOperator likely unlikely
     syn keyword cType u8 u16 u32 u64 s8 s16 s32 s64
     syn keyword cType __u8 __u16 __u32 __u64 __s8 __s16 __s32 __s64

