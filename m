Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6849FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 15:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3466120FC3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 15:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgFQPsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 11:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgFQPsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 11:48:54 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61438C06174E;
        Wed, 17 Jun 2020 08:48:54 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jlaIu-0003ud-Qs; Wed, 17 Jun 2020 17:48:44 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 371661C0089;
        Wed, 17 Jun 2020 17:48:44 +0200 (CEST)
Date:   Wed, 17 Jun 2020 15:48:43 -0000
From:   "tip-bot2 for Guenter Roeck" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] cpu/speculation: Add prototype for cpu_show_srbds()
Cc:     kernel test robot <lkp@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200617141410.93338-1-linux@roeck-us.net>
References: <20200617141410.93338-1-linux@roeck-us.net>
MIME-Version: 1.0
Message-ID: <159240892396.16989.3644768387213731345.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     2accfa69050c2a0d6fc6106f609208b3e9622b26
Gitweb:        https://git.kernel.org/tip/2accfa69050c2a0d6fc6106f609208b3e9622b26
Author:        Guenter Roeck <linux@roeck-us.net>
AuthorDate:    Wed, 17 Jun 2020 07:14:10 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 17 Jun 2020 17:28:08 +02:00

cpu/speculation: Add prototype for cpu_show_srbds()

0-day is not happy that there is no prototype for cpu_show_srbds():

  drivers/base/cpu.c:565:16: error: no previous prototype for 'cpu_show_srbds'

Fixes: 7e5b3c267d25 ("x86/speculation: Add Special Register Buffer Data Sampling (SRBDS) mitigation")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200617141410.93338-1-linux@roeck-us.net
---
 include/linux/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 5269258..8aa84c0 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -64,6 +64,7 @@ extern ssize_t cpu_show_tsx_async_abort(struct device *dev,
 					char *buf);
 extern ssize_t cpu_show_itlb_multihit(struct device *dev,
 				      struct device_attribute *attr, char *buf);
+extern ssize_t cpu_show_srbds(struct device *dev, struct device_attribute *attr, char *buf);
 
 extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,
