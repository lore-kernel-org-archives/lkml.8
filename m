Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989E1C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C0CE2076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587045202;
	bh=57XLkEo9IUFW0ke8/XfWMYUe3XW5lyxCAG3v48t6+k8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mJG9ukeQmI8HUCRStvLvby4GxuVyWa+eeNX8rzZn54rRX99B4kZJoihyDTqrovHIx
	 614xVfvPGkMWVFJeGlhyFRECr2pDyGQW6UDATCoRX4sQ8Ijlqg8RpB+K9h2emRoqa6
	 8X1wZYAQURJ9sju8q5B+WUYMuJLeErLUHyazgc7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408984AbgDPNxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:53:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896697AbgDPNhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:37:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3E84221EB;
        Thu, 16 Apr 2020 13:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044227;
        bh=57XLkEo9IUFW0ke8/XfWMYUe3XW5lyxCAG3v48t6+k8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=deHeMl5cFZzExItriaA22KYZ9weq91im5cP8ujadxTAO+mO6gbjiBs3/NMxR7Qwb8
         1rPDLDb8VJ3Su3kNvBwjyUvVip/F4S9Zo3kFtJ8776OpvCAczt7ZUUEcNttzxe4AF3
         Gr0zr9kOi/C4LCtQoGtYZtyeqtQ2R+Mp5FUCXxhE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.5 133/257] PM / Domains: Allow no domain-idle-states DT property in genpd when parsing
Date:   Thu, 16 Apr 2020 15:23:04 +0200
Message-Id: <20200416131343.047986818@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

commit 56cb26891ea4180121265dc6b596015772c4a4b8 upstream.

Commit 2c361684803e ("PM / Domains: Don't treat zero found compatible idle
states as an error"), moved of_genpd_parse_idle_states() towards allowing
none compatible idle state to be found for the device node, rather than
returning an error code.

However, it didn't consider that the "domain-idle-states" DT property may
be missing as it's optional, which makes of_count_phandle_with_args() to
return -ENOENT. Let's fix this to make the behaviour consistent.

Fixes: 2c361684803e ("PM / Domains: Don't treat zero found compatible idle states as an error")
Reported-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Cc: 4.20+ <stable@vger.kernel.org> # 4.20+
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/power/domain.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2615,7 +2615,7 @@ static int genpd_iterate_idle_states(str
 
 	ret = of_count_phandle_with_args(dn, "domain-idle-states", NULL);
 	if (ret <= 0)
-		return ret;
+		return ret == -ENOENT ? 0 : ret;
 
 	/* Loop over the phandles until all the requested entry is found */
 	of_for_each_phandle(&it, ret, dn, "domain-idle-states", NULL, 0) {


