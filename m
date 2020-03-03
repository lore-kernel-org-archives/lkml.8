Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095DBC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC77A20836
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583258634;
	bh=9JmEJ2YdNjH06+Nkw7LEfU4DK0/6CZECh7HT7bkrXC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cPOdcyM1Pm9ceHjqbl6gQ+RP4d2emPMkyQsu4mgKNIS7xgXqvrtgcC+ZWznWqMBg4
	 lRdQkKIT7JTwUTv5PTaW3sqV7AacTEFCkseK231LPEF3OW5dBwf8OyAwXuPwq8HKSj
	 ebUw8KcOpSuUWFz8c9QeDYxFJpN3UV2nqYWIy99Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388297AbgCCSDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:03:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:44878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387411AbgCCSAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 13:00:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C633A206E6;
        Tue,  3 Mar 2020 18:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583258455;
        bh=9JmEJ2YdNjH06+Nkw7LEfU4DK0/6CZECh7HT7bkrXC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K6dn5t5N9+OcUvX9ZriwSd15z71fiNMrGHP40q5Ti8s4fVKjey+q9qcwPjBa9N92E
         fMfGR3wkyykmHA74PAuPNbOLMQqd/tUF5isUR8t+1D/0i90OVv78SRveC8gpsz5BQa
         Ak5o5H4H9/iU++YwK30DPYcFTzaC+hPlW86imEU0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 4.19 28/87] sysrq: Remove duplicated sysrq message
Date:   Tue,  3 Mar 2020 18:43:19 +0100
Message-Id: <20200303174353.286230928@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174349.075101355@linuxfoundation.org>
References: <20200303174349.075101355@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Mladek <pmladek@suse.com>

commit c3fee60908db4a8594f2e4a2131998384b8fa006 upstream.

The commit 97f5f0cd8cd0a0544 ("Input: implement SysRq as a separate input
handler") added pr_fmt() definition. It caused a duplicated message
prefix in the sysrq header messages, for example:

[  177.053931] sysrq: SysRq : Show backtrace of all active CPUs
[  742.864776] sysrq: SysRq : HELP : loglevel(0-9) reboot(b) crash(c)

Fixes: 97f5f0cd8cd0a05 ("Input: implement SysRq as a separate input handler")
Signed-off-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Tommi Rantala  <tommi.t.rantala@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/sysrq.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -546,7 +546,6 @@ void __handle_sysrq(int key, bool check_
 	 */
 	orig_log_level = console_loglevel;
 	console_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
-	pr_info("SysRq : ");
 
         op_p = __sysrq_get_key_op(key);
         if (op_p) {
@@ -555,15 +554,15 @@ void __handle_sysrq(int key, bool check_
 		 * should not) and is the invoked operation enabled?
 		 */
 		if (!check_mask || sysrq_on_mask(op_p->enable_mask)) {
-			pr_cont("%s\n", op_p->action_msg);
+			pr_info("%s\n", op_p->action_msg);
 			console_loglevel = orig_log_level;
 			op_p->handler(key);
 		} else {
-			pr_cont("This sysrq operation is disabled.\n");
+			pr_info("This sysrq operation is disabled.\n");
 			console_loglevel = orig_log_level;
 		}
 	} else {
-		pr_cont("HELP : ");
+		pr_info("HELP : ");
 		/* Only print the help msg once per handler */
 		for (i = 0; i < ARRAY_SIZE(sysrq_key_table); i++) {
 			if (sysrq_key_table[i]) {


