Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E79C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 527A52076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587046312;
	bh=VPbaPb5kW02bk8XcVeA/pqUhD1EkqkrHwDEd69VA218=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A1H3tfonSBbKJHI4dh7BVfhoxtZFBfNxf1tLj7mbzq62Kyq0wbs81MlH1DZ/3yjOT
	 BIqsPkqp/ATelY98tho+Yl2WuPBNq7zMjA1OVvZLZmc0VS8RQjdm90mgm1vriD8ZYA
	 wyIeQ7Dihl5yeg/RUd7Dsm/gu7rxDuCKw+kxqncQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731359AbgDPOLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:11:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898701AbgDPNrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:47:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19777208E4;
        Thu, 16 Apr 2020 13:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044862;
        bh=VPbaPb5kW02bk8XcVeA/pqUhD1EkqkrHwDEd69VA218=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UGYJE5by52iHadXuOIr4laMbGGOI9+VHqqB2P9XooqcHI1fioeQfHhyTzZi6nJliX
         QQeWUWQiGdqOTmQWia25Rxmtlqys2eDGXzGSaiv9DlpkychZx/iucrckIgPYko0jd9
         /pj7Sq0pvtiuvMv1V58UwPIXnVEBLtaYr/hktxek=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 5.4 091/232] seccomp: Add missing compat_ioctl for notify
Date:   Thu, 16 Apr 2020 15:23:05 +0200
Message-Id: <20200416131326.382449312@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131316.640996080@linuxfoundation.org>
References: <20200416131316.640996080@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Schnelle <svens@linux.ibm.com>

commit 3db81afd99494a33f1c3839103f0429c8f30cb9d upstream.

Executing the seccomp_bpf testsuite under a 64-bit kernel with 32-bit
userland (both s390 and x86) doesn't work because there's no compat_ioctl
handler defined. Add the handler.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Fixes: 6a21cc50f0c7 ("seccomp: add a return code to trap to userspace")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200310123332.42255-1-svens@linux.ibm.com
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/seccomp.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1205,6 +1205,7 @@ static const struct file_operations secc
 	.poll = seccomp_notify_poll,
 	.release = seccomp_notify_release,
 	.unlocked_ioctl = seccomp_notify_ioctl,
+	.compat_ioctl = seccomp_notify_ioctl,
 };
 
 static struct file *init_listener(struct seccomp_filter *filter)


