Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123CCC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 08:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D661920702
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 08:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EVcta/+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgA2IDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 03:03:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34000 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgA2IDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 03:03:30 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so19012147wrr.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 00:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=G6NVfjnf+2wI9Kb71Q+m8fQvu5IYQ+TJQVOTRCuEuaY=;
        b=EVcta/+f/X/6+jhozt2aSz6eCaPCtI8SWUMDLDPY05wIjOMzGFJFAWEptCplEeT8WQ
         7dNayoGj1lZbX024CwyAd3Rv8aFljgvYIlb1j9rcRTr5eAZvOES2ka/NKCpCgMJBlyJ3
         b1kC6kKbKyI7rDIXpuSpGRqxaX+g91zABG1QvzJdNB+Y7VPH+pJI/NqhZbjD7XR3knjz
         XX9eiGawEd0qzu1wA7aPa9NCYos2yc57DPB/ddkhC7OsE5kDbwISBRuf9DN1WwXbco4Z
         6ViWqU3e549dtiFLzOrEeCtCwPd6Wr2kb57EoKD0YQSDmuy1VN7QCHhk4MGxo62RxLeR
         mfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G6NVfjnf+2wI9Kb71Q+m8fQvu5IYQ+TJQVOTRCuEuaY=;
        b=hExju8o8pvXnpXo2+RLp8fbGNFb7ETmCIRC3+4pl87uGTnf/VMqE5VI3LB8RcHiUF/
         durPQqieBzB/r3iuNehZkgzxRqGTKUqu1q0KD0bK7ukZVzo8jiFRHGIF2ZXwgfKcjnbz
         OQ/dNlkCcSuW/dLagj5O8e5ImLgV39B7tuJ6jJOH6h9fYM1ik0kdW1DVW2ZfxW8NZm/X
         CQm1qfcprGRZ9Aw61nPA9Y2zj/Vv72k7Rm/jfTLFpf67yTxO8VSvReVkyq+EV7nZtvVA
         wz6PREKmYybT/xmdbYOT1pfIivv8X5ph6pkeKUhJq4YLBdnQ8xtebZX9Rvr6949FNY1Y
         4X2w==
X-Gm-Message-State: APjAAAVqTVdzvPF3AnvKryYM4f1vWXvRl3SF5qkSiTmvzlCgm5DIil4+
        8BV9WRc8w406syvBq8EHLIA06vxXGN8=
X-Google-Smtp-Source: APXvYqwoKks1q7FdLLF+8ULYtxzJVQzSZqmRmoasrF+BdGBxIqvfEoBFp+UNV8lhh/c8UjdHSw6Ijg==
X-Received: by 2002:a5d:66c3:: with SMTP id k3mr33982048wrw.370.1580285008617;
        Wed, 29 Jan 2020 00:03:28 -0800 (PST)
Received: from localhost.localdomain (amontpellier-651-1-419-170.w92-133.abo.wanadoo.fr. [92.133.102.170])
        by smtp.gmail.com with ESMTPSA id o15sm1761215wra.83.2020.01.29.00.03.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Jan 2020 00:03:28 -0800 (PST)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH] tty_port: Restore tty port default ops on unregistering
Date:   Wed, 29 Jan 2020 09:07:04 +0100
Message-Id: <1580285224-7712-1-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a port is unregistered from serdev, its serdev specific client_ops
pointer is nullified, which can lead to future null pointer dereference.
Fix that by restoring default client_ops when port is unregistered from
serdev.

port registering/unregistering can happen several times, at least it
happens when statically registered 8250 ISA port are replaced at boot
time by e.g. device-tree defined 8250 ports.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/tty/tty_port.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 044c3cb..bf893da 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -203,8 +203,10 @@ void tty_port_unregister_device(struct tty_port *port,
 	int ret;
 
 	ret = serdev_tty_port_unregister(port);
-	if (ret == 0)
+	if (ret == 0) {
+		port->client_ops = &default_client_ops;
 		return;
+	}
 
 	tty_unregister_device(driver, index);
 }
-- 
2.7.4

