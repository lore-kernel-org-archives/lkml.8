Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9779C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A46322076B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="rc3ag+89"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgD2QXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:23:46 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:43476 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726423AbgD2QXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 12:23:46 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id D514D2E1553;
        Wed, 29 Apr 2020 19:23:43 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id b98cjrG6HS-NfWaP9SY;
        Wed, 29 Apr 2020 19:23:43 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1588177423; bh=sVu4JE7WqgmqM/438DD1bULi7xTIvT7qkJucvZOE+K0=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=rc3ag+89lIFVwL+62KnL/y2DfetmlMN1lv67L2Rq4XxfgNep/34YGGUbHqLfx8OYd
         20bQdJIVGIFLsFFAh7fJIoF5/cM6tXW7C1jpYpFE85NFZTlhT9XbTVvup/mYYu8Yhm
         0Y0S2hQXliAkQy8glO9LaQ1/P52etarX1O+OhB7s=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:7913::1:4])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id lMImo4CcXB-NfWGqr9S;
        Wed, 29 Apr 2020 19:23:41 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH v2 3/3] perf tool: simplify checking active smt
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Date:   Wed, 29 Apr 2020 19:23:41 +0300
Message-ID: <158817741394.748034.9273604089138009552.stgit@buzz>
In-Reply-To: <158817718710.747528.11009278875028211991.stgit@buzz>
References: <158817718710.747528.11009278875028211991.stgit@buzz>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SMT now could be disabled via "/sys/devices/system/cpu/smt/control".
Status shown in "/sys/devices/system/cpu/smt/active" simply as "0" / "1".

If this knob isn't here then fallback to checking topology as before.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 tools/perf/util/smt.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
index dc37b5abd1c3..c398528d1006 100644
--- a/tools/perf/util/smt.c
+++ b/tools/perf/util/smt.c
@@ -19,6 +19,9 @@ int smt_on(void)
 	if (cached)
 		return cached_result;
 
+	if (sysfs__read_int("devices/system/cpu/smt/active", &active) > 0)
+		goto done;
+
 	ncpu = sysconf(_SC_NPROCESSORS_CONF);
 	for (cpu = 0; cpu < ncpu; cpu++) {
 		char fn[256];
@@ -37,6 +40,7 @@ int smt_on(void)
 	active = str && (strchr(str, ',') != NULL || strchr(str, '-') != NULL);
 	free(str);
 
+done:
 	if (!cached) {
 		cached_result = active;
 		cached = true;

