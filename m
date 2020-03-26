Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31BCC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40202070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gf5zVKKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgCZLce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 07:32:34 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43293 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbgCZLce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 07:32:34 -0400
Received: by mail-pl1-f196.google.com with SMTP id v23so2002727ply.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 04:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=PHcs4GB3AoNw6GTKIzaWPrLDhOAMwn19frkFdnLFbkE=;
        b=Gf5zVKKMsc5hD/OTXIgHwmE5TJY0TNUX98X4+6mpDQZE6rshNeMhbuw6VuBz8ZNASR
         I39FDvDX0PTynGwTyTcSueFrz/QCyEuO94YnZM6hxweS+ja6YkhQJBclQwIK5NT4pJBE
         +yxLkSFvcOOHzNlxBRNAklgD19kU/P+tmi0MqT4MwyXPIE4rGYFJ9vEuME2n0R89hehD
         HvjpctL/lhDMSZMLRsic6KC/I3o07MSyYhj87G4HT3mthePcCNG27N8wrlT2Tg4OAcyZ
         iJW+fddEDO+Y30KB1yYeyaTvmJ+pt5a0QCgNqlB7zpUzLPcYj5euu0YfSJOl3FYHuhcx
         +nUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=PHcs4GB3AoNw6GTKIzaWPrLDhOAMwn19frkFdnLFbkE=;
        b=t4oaATQYQG/wrQh5iDIZbDjbqDW3voyIaIk7jjdG8+wK2OLTgxFhEwHCMEDI7i4NUj
         urdDvV1aCyY5cvuhJn59lLMVZnMbGstIg0RJez1IRuSWpAqMw4YnMrw4JrrLG/AymglI
         gdSn063JZriEeaOuCHn0vpJ8NQ0Xo0/uQQaWA+rgBRvq/3QEtFvWn9rM/k0sK0+0/Wpv
         utYdqhHKTu0Hy5Kd+nYh/aga12d3UHtvokK3TNS81J+LRzToi5V2+o7ANRF7UXPrByGn
         WI5U84awuykRw5fioJSHWkgfIS969imJM8Ntkzlo0evO1JuGuGy4xbN2cmHb+U7tiGMf
         fn8w==
X-Gm-Message-State: ANhLgQ3G1Rdx4UBrtWhEkWbL9pyQiUqK0zJ93G50SeR0m0KT7orYjkJe
        /cyvHGTzPFt5ld4UeJtQ4Ks=
X-Google-Smtp-Source: ADFU+vvXKyDWYHQQuH3sh15+gZxkW32AeuMz6G3NYnqD0Qc9tENjpefUBcb2K5tOWHPzXyTqGyulBg==
X-Received: by 2002:a17:90a:5d0a:: with SMTP id s10mr2650362pji.166.1585222352911;
        Thu, 26 Mar 2020 04:32:32 -0700 (PDT)
Received: from simran-Inspiron-5558 ([2405:205:1208:56c8:8124:5e4b:ea06:7595])
        by smtp.gmail.com with ESMTPSA id 132sm1479454pfc.183.2020.03.26.04.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 04:32:32 -0700 (PDT)
Date:   Thu, 26 Mar 2020 17:02:10 +0530
From:   Simran Singhal <singhalsimran0@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel <outreachy-kernel@googlegroups.com>
Subject: [PATCH] staging: rtl8723bs: hal: Remove unnecessary cast on void
 pointer
Message-ID: <20200326113210.GA29951@simran-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assignment to a typed pointer is sufficient in C.
No cast is needed.

The following Coccinelle script was used to detect this:
@r@
expression x;
void* e;
type T;
identifier f;
@@
(
  *((T *)e)
|
  ((T *)x)[...]
|
  ((T*)x)->f
|

- (T*)
  e
)

Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_CfoTracking.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c b/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
index 34d83b238265..3ea1972545e5 100644
--- a/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
+++ b/drivers/staging/rtl8723bs/hal/odm_CfoTracking.c
@@ -298,7 +298,7 @@ void ODM_CfoTracking(void *pDM_VOID)
 void ODM_ParsingCFO(void *pDM_VOID, void *pPktinfo_VOID, s8 *pcfotail)
 {
 	PDM_ODM_T pDM_Odm = (PDM_ODM_T)pDM_VOID;
-	struct odm_packet_info *pPktinfo = (struct odm_packet_info *)pPktinfo_VOID;
+	struct odm_packet_info *pPktinfo = pPktinfo_VOID;
 	PCFO_TRACKING pCfoTrack = &pDM_Odm->DM_CfoTrack;
 	u8 i;
 
-- 
2.17.1

