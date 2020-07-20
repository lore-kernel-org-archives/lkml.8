Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EA3C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D82D62065E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261330;
	bh=bHelhK3clDn+qoCr3rSYuH+TCTiDqOABSBHwl2bweWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c0qN1BTbTtToBLF/nWuurJ/DcAwKVFPpiLXFCZ+/dcTh9tztkpHR54jeXm6XwxjAc
	 cMcG/9tQl7vad2ov9ivFuChacl+jExRCsO6ddrhFwh8AwpgHQv2L2F41s6uQXD/2UA
	 Pu9DPwdn44HpbdMKgsq91d01DPv07c1kE/gRd3u0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387444AbgGTQIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:08:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730996AbgGTQIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:08:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77D5E20734;
        Mon, 20 Jul 2020 16:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261326;
        bh=bHelhK3clDn+qoCr3rSYuH+TCTiDqOABSBHwl2bweWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JVJXlGm1zfOaHe/lsS6Zn0lvluRXdhl/u3Tdo5CMBNnxdo8RXlJneqI9WgaamFqz7
         3Mvd93ga4eCF5HOppapiVLGHI0cOhmnChYAT6/2krDEKiarlZBaNJlNGVf+T0JdAyQ
         gqrmEHlItC5ZGSb48c7FrxsSw8bM/P4Y/fuBHO/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marshall Midden <marshallmidden@gmail.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 045/244] cifs: prevent truncation from long to int in wait_for_free_credits
Date:   Mon, 20 Jul 2020 17:35:16 +0200
Message-Id: <20200720152828.000688742@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronnie Sahlberg <lsahlber@redhat.com>

[ Upstream commit 19e888678bac8c82206eb915eaf72741b2a2615c ]

The wait_event_... defines evaluate to long so we should not assign it an int as this may truncate
the value.

Reported-by: Marshall Midden <marshallmidden@gmail.com>
Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index c97570eb2c180..7fefd2bd111c4 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -528,7 +528,7 @@ wait_for_free_credits(struct TCP_Server_Info *server, const int num_credits,
 		      const int timeout, const int flags,
 		      unsigned int *instance)
 {
-	int rc;
+	long rc;
 	int *credits;
 	int optype;
 	long int t;
-- 
2.25.1



