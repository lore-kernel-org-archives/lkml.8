Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78915C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48ABB20663
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594135612;
	bh=Fn40Bh6XmR023pbItA4RzWAlYFqihqakYIkoCXfnP6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DiX+5A/O1u+rbwhayDjBad0BD+07MyVXn1IRgGKWppl4WdpEB109i7uK+wGMGQzGY
	 +NSNlAMOhqo8yJ/uT51bfAQw61yTrMgRTlvEupnbBdbfq/yskaInOExPspRSdRbTDR
	 v6YtqySAqkH31B+Peq0a83SY6p54leY4JznV4qn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbgGGP0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:26:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730293AbgGGP0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:26:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8815120663;
        Tue,  7 Jul 2020 15:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594135600;
        bh=Fn40Bh6XmR023pbItA4RzWAlYFqihqakYIkoCXfnP6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Os3miBK/My1s6L7QZLQ2T6xx2OIv7HfgznVS+mRlwDsDlOinod3S3e0lytg9jqTJ0
         rUdCrwrx/0yLwgIVDXVh+oPLfqeA+Wn1bTtNzkPptnPrULzRq+OkyyFZDvhn16YECO
         djsFpn93MZ61C6G/ZEm7wNU9/i1jgzqCULKYbizE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nirmoy Das <nirmoy.das@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.7 105/112] drm/amdgpu: use %u rather than %d for sclk/mclk
Date:   Tue,  7 Jul 2020 17:17:50 +0200
Message-Id: <20200707145805.967772049@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145800.925304888@linuxfoundation.org>
References: <20200707145800.925304888@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

commit beaf10efca64ac824240838ab1f054dfbefab5e6 upstream.

Large clock values may overflow and show up as negative.

Reported by prOMiNd on IRC.

Acked-by: Nirmoy Das <nirmoy.das@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -2590,7 +2590,7 @@ static ssize_t amdgpu_hwmon_show_sclk(st
 	if (r)
 		return r;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", sclk * 10 * 1000);
+	return snprintf(buf, PAGE_SIZE, "%u\n", sclk * 10 * 1000);
 }
 
 static ssize_t amdgpu_hwmon_show_sclk_label(struct device *dev,
@@ -2622,7 +2622,7 @@ static ssize_t amdgpu_hwmon_show_mclk(st
 	if (r)
 		return r;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", mclk * 10 * 1000);
+	return snprintf(buf, PAGE_SIZE, "%u\n", mclk * 10 * 1000);
 }
 
 static ssize_t amdgpu_hwmon_show_mclk_label(struct device *dev,


