Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F25C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 232B721D79
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753645;
	bh=UX1Wegt7Ui0ykQnZ5X64GWQ6m2Lm9rwaN7IFfHvRiWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZFCheIA/8BvdxM705tvW9DlIelRdCgBBMkoguj2XMI5IIMuLi4+Uv3yBwcxUy/RRg
	 fAW72/qVPJZeAh6t4y4tLOLvkJHUfsKvbc6yrq3W8XLqH0iBoyPz+5nYdtBfdU4/f+
	 Y9qWjAa5BFTQ5XFEW2qdgtmKp/gHyvdJn69t7FmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbgGNSwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:52:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730476AbgGNSwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:52:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF5E122B3B;
        Tue, 14 Jul 2020 18:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752731;
        bh=UX1Wegt7Ui0ykQnZ5X64GWQ6m2Lm9rwaN7IFfHvRiWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cC0RS27jxtWt4DP3hrQMTvM8gpHWJ96ApOXfExlWhX9ZDM/O+ruppNmi4ECB2VtWP
         upvl6KPK6X6qeVqTVhJNPglgiygh/RNLmupZE8v1kk9lIZnxAM1FvxMCEks2W0cMgg
         2v8UASkq0MER2hTcLgtTbI0xh4Q6E/S0aIApWl10=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dominik Czarnota <dominik.czarnota@trailofbits.com>,
        Jessica Yu <jeyu@kernel.org>, Kees Cook <keescook@chromium.org>
Subject: [PATCH 5.4 089/109] module: Do not expose section addresses to non-CAP_SYSLOG
Date:   Tue, 14 Jul 2020 20:44:32 +0200
Message-Id: <20200714184109.811303236@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184105.507384017@linuxfoundation.org>
References: <20200714184105.507384017@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

commit b25a7c5af9051850d4f3d93ca500056ab6ec724b upstream.

The printing of section addresses in /sys/module/*/sections/* was not
using the correct credentials to evaluate visibility.

Before:

 # cat /sys/module/*/sections/.*text
 0xffffffffc0458000
 ...
 # capsh --drop=CAP_SYSLOG -- -c "cat /sys/module/*/sections/.*text"
 0xffffffffc0458000
 ...

After:

 # cat /sys/module/*/sections/*.text
 0xffffffffc0458000
 ...
 # capsh --drop=CAP_SYSLOG -- -c "cat /sys/module/*/sections/.*text"
 0x0000000000000000
 ...

Additionally replaces the existing (safe) /proc/modules check with
file->f_cred for consistency.

Reported-by: Dominik Czarnota <dominik.czarnota@trailofbits.com>
Fixes: be71eda5383f ("module: Fix display of wrong module .text address")
Cc: stable@vger.kernel.org
Tested-by: Jessica Yu <jeyu@kernel.org>
Acked-by: Jessica Yu <jeyu@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/module.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1527,8 +1527,8 @@ static ssize_t module_sect_read(struct f
 	if (pos != 0)
 		return -EINVAL;
 
-	return sprintf(buf, "0x%px\n", kptr_restrict < 2 ?
-		       (void *)sattr->address : NULL);
+	return sprintf(buf, "0x%px\n",
+		       kallsyms_show_value(file->f_cred) ? (void *)sattr->address : NULL);
 }
 
 static void free_sect_attrs(struct module_sect_attrs *sect_attrs)
@@ -4394,7 +4394,7 @@ static int modules_open(struct inode *in
 
 	if (!err) {
 		struct seq_file *m = file->private_data;
-		m->private = kallsyms_show_value(current_cred()) ? NULL : (void *)8ul;
+		m->private = kallsyms_show_value(file->f_cred) ? NULL : (void *)8ul;
 	}
 
 	return err;


