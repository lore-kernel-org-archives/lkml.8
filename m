Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4D7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96C5420702
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XFCjAT0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388669AbgF3NxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388389AbgF3NvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:51:22 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5B6C03E979
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:21 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j4so17828546wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KJS/keN17J0QH5GuMuvB98PgdVtEKXtUDk7tuwa3qBk=;
        b=XFCjAT0Fm2Ktek2vUmuOq+8tn3ROAtbgpJk64jEsnz+2NgMKEmCjQVVJiJw26bM0Jp
         jU+fBCIwnQ6kZyreKOOLT9bP2ruK+Lv/HnpktY370ivsAanhrBUWmAPNLh0s8vnVerwO
         atcn4KvjOovczEXJuU9OrLI34JUVUq0ZZ3hoAd3yw77gPdqsSoLmX+hUivb8eEwk9oI+
         mHsFEavVDJuvmzCMV7qeQ9C8td2nhnr8vG+MVxa7jOsrGmGKWTqoEqyia6KKpCHhpxPs
         oQbx8xurNvuThuNuImiFXtrfph9OG4buS8F9VlXr3Zianl+H0ZpJKydwEo0E/oKpTULn
         e5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KJS/keN17J0QH5GuMuvB98PgdVtEKXtUDk7tuwa3qBk=;
        b=DpjvMtsgfegFwB8Bl0jRvcJlbK9cbn8k+j8BcpnxAuhTRg/9BRWiStZiTQ6YrQsRzR
         8GU8MxewVFxL7rOfvBL56eSxYVhfH++lFVJtkEB+JeIadwQzavliAm0StUaQQwO48LQA
         PTncudDWOQGYeaQ69r45EeqeJbL5CzkPKQC9946mWz6ULou/+m2oS/DMQooaVDmI7wPw
         /QDc1ieE9KGZzmnDDd7DgcfUwADgLm7la9Q2QLM76vfeb2Hv7STm6hJphLeiQc+IWpHQ
         5glky86bloiZ0z9pnmGCc64Yb5xYfU3kz7W2f6/+3LQ+IE125azMKyb1DMOi3cWKE3n5
         uQMw==
X-Gm-Message-State: AOAM5329WB7iZB83r9S7c+ksmx5qjDa8/jZtwddA4E4iWCZoi7h1Hhup
        0PaVDgyhvVBr+qbyJ8dPefLiCDnglUs=
X-Google-Smtp-Source: ABdhPJy9deKfqIJP8pIRE38cgy1gIRpXGQWSZKp0s1rjHDZKFWj+i5L71stp9jmlT9v2RxSlGNzVYA==
X-Received: by 2002:adf:c44d:: with SMTP id a13mr22553613wrg.205.1593525080501;
        Tue, 30 Jun 2020 06:51:20 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id t4sm3876746wmf.4.2020.06.30.06.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:51:19 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Max=20Asb=C3=B6ck?= <amax@us.ibm.com>
Subject: [PATCH 06/30] misc: ibmasm: command: Demote function headers from kerneldoc
Date:   Tue, 30 Jun 2020 14:50:46 +0100
Message-Id: <20200630135110.2236389-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630135110.2236389-1-lee.jones@linaro.org>
References: <20200630135110.2236389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct format is not used and no attempt has been made
to document the function arguments.  Makes sense to just demote
the header back down to a simple comment.

Fixes the following W=1 warnings:

 drivers/misc/ibmasm/command.c:106: warning: Function parameter or member 'sp' not described in 'ibmasm_exec_command'
 drivers/misc/ibmasm/command.c:106: warning: Function parameter or member 'cmd' not described in 'ibmasm_exec_command'
 drivers/misc/ibmasm/command.c:149: warning: Function parameter or member 'cmd' not described in 'ibmasm_wait_for_response'
 drivers/misc/ibmasm/command.c:149: warning: Function parameter or member 'timeout' not described in 'ibmasm_wait_for_response'
 drivers/misc/ibmasm/command.c:162: warning: Function parameter or member 'sp' not described in 'ibmasm_receive_command_response'
 drivers/misc/ibmasm/command.c:162: warning: Function parameter or member 'response' not described in 'ibmasm_receive_command_response'
 drivers/misc/ibmasm/command.c:162: warning: Function parameter or member 'size' not described in 'ibmasm_receive_command_response'

Cc: "Max Asböck" <amax@us.ibm.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/ibmasm/command.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/ibmasm/command.c b/drivers/misc/ibmasm/command.c
index 2863657fa2683..733dd30fbaccf 100644
--- a/drivers/misc/ibmasm/command.c
+++ b/drivers/misc/ibmasm/command.c
@@ -94,7 +94,7 @@ static inline void do_exec_command(struct service_processor *sp)
 	}
 }
 
-/**
+/*
  * exec_command
  * send a command to a service processor
  * Commands are executed sequentially. One command (sp->current_command)
@@ -140,7 +140,7 @@ static void exec_next_command(struct service_processor *sp)
 	}
 }
 
-/**
+/*
  * Sleep until a command has failed or a response has been received
  * and the command status been updated by the interrupt handler.
  * (see receive_response).
@@ -153,7 +153,7 @@ void ibmasm_wait_for_response(struct command *cmd, int timeout)
 				timeout * HZ);
 }
 
-/**
+/*
  * receive_command_response
  * called by the interrupt handler when a dot command of type command_response
  * was received.
-- 
2.25.1

