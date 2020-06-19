Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FFDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E90B820786
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592581121;
	bh=v0Zd5Rs0YH8uIevjCSBDYRBNv85ywamxvHaq+t/dqNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Mx7trAhleFWRWEJrWlP8FWltwIIpr3Z4arr4SA7zd3x3MX+8Bytn0DWjmhfNqvRC
	 496RD1HxcefwSfNDSs55GO9V7emaX7AL7C1WRmK9x9MW2MgNr6tyz2RlU6CtkVK6j7
	 PCnews9NTgh421nmQ7OMiQmlUP3Ry/NxrHl11dRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405162AbgFSPii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:38:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404623AbgFSP31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:29:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2E1D20734;
        Fri, 19 Jun 2020 15:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580566;
        bh=v0Zd5Rs0YH8uIevjCSBDYRBNv85ywamxvHaq+t/dqNU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B31QJQv92jsngK3uv11RsERssONZaVWEzK4v3Ki+MPLWzQtEgYjNANX7+0ZpGKV7d
         VGeWhq5a8Hf+TlRSGDX2OGU94WG9ztZTdHKTePUaKWbt44Rv+QY45+1YcflgkIAOag
         IgHXRt5GHFVfhtLKax3JvfYMCJxreY/pyU7B0gIw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 5.7 298/376] clocksource: Remove obsolete ifdef
Date:   Fri, 19 Jun 2020 16:33:36 +0200
Message-Id: <20200619141724.446789613@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

commit c7f3d43b629b598a2bb9ec3524e844eae7492e7e upstream.

CONFIG_GENERIC_VDSO_CLOCK_MODE was a transitional config switch which got
removed after all architectures got converted to the new storage model.

But the removal forgot to remove the #ifdef which guards the
vdso_clock_mode sanity check, which effectively disables the sanity check.

Remove it now.

Fixes: f86fd32db706 ("lib/vdso: Cleanup clock mode storage leftovers")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Miklos Szeredi <mszeredi@redhat.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20200606221531.845475036@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/time/clocksource.c |    2 --
 1 file changed, 2 deletions(-)

--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -928,14 +928,12 @@ int __clocksource_register_scale(struct
 
 	clocksource_arch_init(cs);
 
-#ifdef CONFIG_GENERIC_VDSO_CLOCK_MODE
 	if (cs->vdso_clock_mode < 0 ||
 	    cs->vdso_clock_mode >= VDSO_CLOCKMODE_MAX) {
 		pr_warn("clocksource %s registered with invalid VDSO mode %d. Disabling VDSO support.\n",
 			cs->name, cs->vdso_clock_mode);
 		cs->vdso_clock_mode = VDSO_CLOCKMODE_NONE;
 	}
-#endif
 
 	/* Initialize mult/shift and max_idle_ns */
 	__clocksource_update_freq_scale(cs, scale, freq);


