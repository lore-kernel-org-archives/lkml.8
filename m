Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CA8C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA73924695
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844269;
	bh=ZS4NWjPF89qGwdTMi7uro6qcefhdn5CGU51aYRCvVuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v8ieQS84ZdgHoyeuRs0Zf0garDNJGnFaITWXnklTVNxIfEbrRF7J5NZ7R5srYdjaW
	 goEQyEpNV/nkhgpKoZI+as3xo9Xdj6hbj4k3qCM7R+3335htyX2zVdw9NZXLcEujTI
	 6Cnsmph3SFndckG0UgAO3wfw0bvX05q9BgJ5ieuM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgCJMo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727113AbgCJMoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:44:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E074246B0;
        Tue, 10 Mar 2020 12:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844265;
        bh=ZS4NWjPF89qGwdTMi7uro6qcefhdn5CGU51aYRCvVuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SGBULySQQu+rz0FNoHPUFLfjS4Hr7PCMZrCjKSuiiJAwxlLSUIYFlkMQ5Fg3HE2hn
         k3Trt6D79wX7K1ILlw8GRh4QnLLAJQ5kHHITlp6PKv2JPV0vBXgYbMVLn2FncT8kMV
         1UdbG1oGG1c+72GGMRa1Tk+nXJE1zKEdPXBoCNaM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 4.9 19/88] sysrq: Restore original console_loglevel when sysrq disabled
Date:   Tue, 10 Mar 2020 13:38:27 +0100
Message-Id: <20200310123610.895390183@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123606.543939933@linuxfoundation.org>
References: <20200310123606.543939933@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Mladek <pmladek@suse.com>

commit 075e1a0c50f59ea210561d0d0fedbd945615df78 upstream.

The sysrq header line is printed with an increased loglevel
to provide users some positive feedback.

The original loglevel is not restored when the sysrq operation
is disabled. This bug was introduced in 2.6.12 (pre-git-history)
by the commit ("Allow admin to enable only some of the Magic-Sysrq
functions").

Signed-off-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Tommi Rantala <tommi.t.rantala@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/sysrq.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -557,6 +557,7 @@ void __handle_sysrq(int key, bool check_
 			op_p->handler(key);
 		} else {
 			pr_cont("This sysrq operation is disabled.\n");
+			console_loglevel = orig_log_level;
 		}
 	} else {
 		pr_cont("HELP : ");


