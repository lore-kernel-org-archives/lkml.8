Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAA0C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7252072D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583258153;
	bh=rkezNTsilgSGKrW4OUz+0tZo+L5uoL6GV1O/cTXX1GU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PY3VUSEwm2LwN7SS1LnN9feh+0Ftowl0PWXrNdJdmbK4rX8c4pkIM6e4dh1493wE8
	 6oV9Ri4KcwCs5fuJK7SIrRKkha1FRU7olc2don28GrdV6T6tptmwVA18WO2PUUrYbd
	 Sk8sXY+DZGQr0MvFSgJjpuAH5edNYiHVB8iDKlfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732776AbgCCRzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:55:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:37454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729240AbgCCRzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:55:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4168F206D5;
        Tue,  3 Mar 2020 17:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583258139;
        bh=rkezNTsilgSGKrW4OUz+0tZo+L5uoL6GV1O/cTXX1GU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2cB+Hywv6HZvgkUVaHyof1vNzQSiQ/wrFRopSBTpYJSZfDUel0ZOoDXrxUPWu8vrR
         Q/aSOq588RMZMAFY6ET2OxkkAizIRuUAGO4fpxFENX/TO4jO9AFMt8w9OqVHGQFtQt
         bsnYJv2l1f8yFodMS/BPwdEIklSaducuYMEJbZFU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Artem Bityutskiy <dedekind1@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 5.4 085/152] cpufreq: Fix policy initialization for internal governor drivers
Date:   Tue,  3 Mar 2020 18:43:03 +0100
Message-Id: <20200303174312.215998619@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174302.523080016@linuxfoundation.org>
References: <20200303174302.523080016@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit f5739cb0b56590d68d8df8a44659893b6d0084c3 upstream.

Before commit 1e4f63aecb53 ("cpufreq: Avoid creating excessively
large stack frames") the initial value of the policy field in struct
cpufreq_policy set by the driver's ->init() callback was implicitly
passed from cpufreq_init_policy() to cpufreq_set_policy() if the
default governor was neither "performance" nor "powersave".  After
that commit, however, cpufreq_init_policy() must take that case into
consideration explicitly and handle it as appropriate, so make that
happen.

Fixes: 1e4f63aecb53 ("cpufreq: Avoid creating excessively large stack frames")
Link: https://lore.kernel.org/linux-pm/39fb762880c27da110086741315ca8b111d781cd.camel@gmail.com/
Reported-by: Artem Bityutskiy <dedekind1@gmail.com>
Cc: 5.4+ <stable@vger.kernel.org> # 5.4+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpufreq/cpufreq.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1071,9 +1071,17 @@ static int cpufreq_init_policy(struct cp
 			pol = policy->last_policy;
 		} else if (def_gov) {
 			pol = cpufreq_parse_policy(def_gov->name);
-		} else {
-			return -ENODATA;
+			/*
+			 * In case the default governor is neiter "performance"
+			 * nor "powersave", fall back to the initial policy
+			 * value set by the driver.
+			 */
+			if (pol == CPUFREQ_POLICY_UNKNOWN)
+				pol = policy->policy;
 		}
+		if (pol != CPUFREQ_POLICY_PERFORMANCE &&
+		    pol != CPUFREQ_POLICY_POWERSAVE)
+			return -ENODATA;
 	}
 
 	return cpufreq_set_policy(policy, gov, pol);


