Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89FDC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 836222076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587047159;
	bh=LY47aTPPMAmsiUBhTInmnH4kGMQUiyaa/B9hGY7Hsd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2uqHf6czyXz/2Py46Wm9FRs1RTJ/Xzvw9DUlJkuR5pXBniSe34XK6rN/s9NIlS0mI
	 486qqA3ss28C8I6CdRHDLJ2aGnw57sW7Gvx0jzJAbO2OSGwHODx6ni1jj2QX2sbUg+
	 y41GBUh4HUddPKzmFYJb+L0wIcK0g7HL6khlmRsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410021AbgDPOZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:25:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728926AbgDPN6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:58:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1D5B21744;
        Thu, 16 Apr 2020 13:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045503;
        bh=LY47aTPPMAmsiUBhTInmnH4kGMQUiyaa/B9hGY7Hsd8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Li4StG1GgoqCnu7On+Swp6GftdHmG28viKEnxQ3SSX7qQ48HvJe3wUz+vsvkdSrZ/
         IPIsmoenbk2JemQKVQA1uq+speLfLvSPj5NMiwILlr2ZFyqdpqpA8eROzXe993EMFj
         zitAcIHm8Ouv7QeKexpmmSRMlGejFv0M+3/mJqbg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Kerrisk <mtk.manpages@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH 5.6 161/254] time/namespace: Fix time_for_children symlink
Date:   Thu, 16 Apr 2020 15:24:10 +0200
Message-Id: <20200416131346.748653817@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>

commit b801f1e22c23c259d6a2c955efddd20370de19a6 upstream.

Looking at the contents of the /proc/PID/ns/time_for_children symlink shows
an anomaly:

$ ls -l /proc/self/ns/* |awk '{print $9, $10, $11}'
...
/proc/self/ns/pid -> pid:[4026531836]
/proc/self/ns/pid_for_children -> pid:[4026531836]
/proc/self/ns/time -> time:[4026531834]
/proc/self/ns/time_for_children -> time_for_children:[4026531834]
/proc/self/ns/user -> user:[4026531837]
...

The reference for 'time_for_children' should be a 'time' namespace, just as
the reference for 'pid_for_children' is a 'pid' namespace.  In other words,
the above time_for_children link should read:

/proc/self/ns/time_for_children -> time:[4026531834]

Fixes: 769071ac9f20 ("ns: Introduce Time Namespace")
Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dmitry Safonov <dima@arista.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Acked-by: Andrei Vagin <avagin@gmail.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/a2418c48-ed80-3afe-116e-6611cb799557@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/time/namespace.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -446,6 +446,7 @@ const struct proc_ns_operations timens_o
 
 const struct proc_ns_operations timens_for_children_operations = {
 	.name		= "time_for_children",
+	.real_ns_name	= "time",
 	.type		= CLONE_NEWTIME,
 	.get		= timens_for_children_get,
 	.put		= timens_put,


