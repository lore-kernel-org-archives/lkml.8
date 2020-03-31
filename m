Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBD4C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C0C20B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645535;
	bh=eTsrk4rS2oByHAz2G34KbqfNarKNhRueHXowZf1Awo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f7dn5XLenhwKMGn7+tPrXRQTakUEnVQbgWEYxoCf0IPtGHfPlXULCDGOHae46C4x3
	 S/wyYqqPJJ7B1Mk/wXAFp7QsEjJphMWp8Ify4KFuMv4Uxhi7XzQQ/ARPJrt3HJJCGR
	 IoA444CRFnKM1kDYely76GTDD5xMaxJyz7+j7I/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbgCaJFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:05:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730541AbgCaJFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:05:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B07120B80;
        Tue, 31 Mar 2020 09:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645532;
        bh=eTsrk4rS2oByHAz2G34KbqfNarKNhRueHXowZf1Awo4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DUblurlyG+tcG3+W0+6KPmfCK0nhZvc+Eh4RGS1xxjHZp01BYZ6/UbjYikSSzqa41
         X7193yhnit7f4cvwq6c/gC3WKuS/Ms019XJIKxQLgkaAPW+vv4oYTQJBXaYDnEmcxg
         WcGkSIXTZPi1N4xfkl8HX5fziors5R/aNKAjGwk8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, teika kazura <teika@gmx.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.5 083/170] Input: fix stale timestamp on key autorepeat events
Date:   Tue, 31 Mar 2020 10:58:17 +0200
Message-Id: <20200331085433.125640559@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085423.990189598@linuxfoundation.org>
References: <20200331085423.990189598@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit 4134252ab7e2c339a54302b88496cb5a89cdbaec upstream.

We need to refresh timestamp when emitting key autorepeat events, otherwise
they will carry timestamp of the original key press event.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=206929
Fixes: 3b51c44bd693 ("Input: allow drivers specify timestamp for input events")
Cc: stable@vger.kernel.org
Reported-by: teika kazura <teika@gmx.com>
Tested-by: teika kazura <teika@gmx.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/input.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -190,6 +190,7 @@ static void input_repeat_key(struct time
 			input_value_sync
 		};
 
+		input_set_timestamp(dev, ktime_get());
 		input_pass_values(dev, vals, ARRAY_SIZE(vals));
 
 		if (dev->rep[REP_PERIOD])


