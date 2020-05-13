Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB778C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2FDF2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9f+VXD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbgEMVqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 17:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729793AbgEMVqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 17:46:44 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0294FC061A0C;
        Wed, 13 May 2020 14:46:43 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g14so12828072wme.1;
        Wed, 13 May 2020 14:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ZhpfY5SsXwRMXVq8oG2SQckFQ1KlcXnx8okrJoqKCA=;
        b=J9f+VXD35N9xl7mX+0T+f83yVVR/BgYM8RMEZCYaz1RSjI+MkVij2f44TNmQ9iGE86
         6etFqrZUffKYP1M1wze/ps4CpisiMrwWTnMSr2L2m5nhNa5DdRhGtiWzYXGCcH4SCHOR
         6bCmg4p+pF7wkc1n7vujJNPXgs88iP/adct8b8CQYCOEt+lQFy8tdVg3kvLTiy1MZ6jP
         f3tO1rfpK8afd0A1SGtKTrY4qsre9OxjLK3sQ7TXtxEP9Sff2EyVlkXtvXZteu5nRCWR
         lo+fGAss0/qYhP8AefeSr+vcsIXkj77mG7qPVT6Roqq2qA6M+07ju8yV/+hXTmOmBSQa
         zFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ZhpfY5SsXwRMXVq8oG2SQckFQ1KlcXnx8okrJoqKCA=;
        b=iwlpSnesA003heahe3TXNA8WHJ+5hef3ZvDERHXgeW78TVsvwW3uitjTfIc+Dt1vbg
         P270oCZKA18rV5W0UAFNpgZrUWAu5XtwRYASj+O4AOVjkKeNtRndA+wJpx0Ldes4g/D7
         WL3Ucylb6368LOMI09UifLKnBFjRWcR0s7ljLX9uhc9ZxV8aul5eZGr8W7Rier4J2Itv
         P4Q7gHabLQkGDy9vNwQYb5ufrzHvefTQA/18bbcEDR6UgjiIX7waX/XI7ukixuG/aydF
         4NQqn4x521tKaVqJLqVnE1o1NGEdxcAc9gPKia/19/+8twazSYjuuDKnl+zPvgM7UNlm
         qdrg==
X-Gm-Message-State: AGi0PubGby046EE7y0YbCDUJasz82FRdQtFgHTX2D9WLeyU/DHxV/pZu
        6o8OahCeuJnfPMy57oIeV54=
X-Google-Smtp-Source: APiQypIZ4r5SZkRDB6NXjJjmJhzn7tVrsiIl9AH/93M3gz7vnmZP+aNiDzxAEY/+SIIWvDX/w43OYQ==
X-Received: by 2002:a1c:f012:: with SMTP id a18mr43223777wmb.116.1589406401788;
        Wed, 13 May 2020 14:46:41 -0700 (PDT)
Received: from localhost.localdomain (cpc91192-cmbg18-2-0-cust374.5-4.cable.virginm.net. [80.6.113.119])
        by smtp.gmail.com with ESMTPSA id m23sm1699734wmg.45.2020.05.13.14.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 14:46:41 -0700 (PDT)
From:   Emil Velikov <emil.l.velikov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     emil.l.velikov@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: [PATCH 04/11] alpha: constify sysrq_key_op
Date:   Wed, 13 May 2020 22:43:44 +0100
Message-Id: <20200513214351.2138580-4-emil.l.velikov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200513214351.2138580-1-emil.l.velikov@gmail.com>
References: <20200513214351.2138580-1-emil.l.velikov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With earlier commits, the API no longer discards the const-ness of the
sysrq_key_op. As such we can add the notation.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-kernel@vger.kernel.org
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
Please keep me in the CC list, as I'm not subscribed to the list.

IMHO it would be better if this gets merged this via the tty tree.
---
 arch/alpha/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index dd7f770f23cf..6fa802c495b4 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -431,7 +431,7 @@ register_cpus(void)
 arch_initcall(register_cpus);
 
 #ifdef CONFIG_MAGIC_SYSRQ
-static struct sysrq_key_op srm_sysrq_reboot_op = {
+static const struct sysrq_key_op srm_sysrq_reboot_op = {
 	.handler	= machine_halt,
 	.help_msg       = "reboot(b)",
 	.action_msg     = "Resetting",
-- 
2.25.1

