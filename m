Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02679C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 22:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D302120720
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 22:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rgps0+Rw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgHWWfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 18:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgHWWfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 18:35:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC37C061573
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 15:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=xn4BC+pQmW9NzzzhMuyq2NbKnTZIdMXNDhTAAA/sNnc=; b=rgps0+RwIrR1qFQh33q+l1IacG
        8saSJirXqMnVDOqRufaLA0mftIBXJpJd2Vh/SpbubUz6wUeiEUaazPRp0+z+jBTB7gewDoXa17mio
        sYMPVgxWOgVG6DVogpKvk8Z+kMdqgya49ZWwXpSJdqjB31pCR7InrCe3raYd8oNyD+EIcUZpASIoZ
        8rXwWrkgOMFuw+2tOmWzk4WGaPRSPlVjq+TlMWkLpOvPxg8AvS4EoX2iEDnfbTibzfNHFFuebAvev
        iPhydiM3egRy8b6yuRi0OCHwmfoNJ7Ev1+Brlu6dBM+RJDKvVVAttqroCV73oys4ZgW/Kww0bYTyC
        WVt/BO2A==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9yaS-0006kJ-0f; Sun, 23 Aug 2020 22:35:42 +0000
To:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     Evan Quan <evan.quan@amd.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] amdgpu: fix Documentation builds for pm/ file movement
Message-ID: <88d43daf-f29b-0fbe-cf58-930e8caca0e7@infradead.org>
Date:   Sun, 23 Aug 2020 15:35:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix Documentation errors for amdgpu.rst due to file rename (moved
to another subdirectory).

Error: Cannot open file ../drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
WARNING: kernel-doc '../scripts/kernel-doc -rst -enable-lineno -function hwmon ../drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c' failed with return code 1

Fixes: e098bc9612c2 ("drm/amd/pm: optimize the power related source code layout")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Evan Quan <evan.quan@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
---
 Documentation/gpu/amdgpu.rst |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- linux-next-20200821.orig/Documentation/gpu/amdgpu.rst
+++ linux-next-20200821/Documentation/gpu/amdgpu.rst
@@ -153,7 +153,7 @@ This section covers hwmon and power/ther
 HWMON Interfaces
 ----------------
 
-.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    :doc: hwmon
 
 GPU sysfs Power State Interfaces
@@ -164,52 +164,52 @@ GPU power controls are exposed via sysfs
 power_dpm_state
 ~~~~~~~~~~~~~~~
 
-.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    :doc: power_dpm_state
 
 power_dpm_force_performance_level
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    :doc: power_dpm_force_performance_level
 
 pp_table
 ~~~~~~~~
 
-.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    :doc: pp_table
 
 pp_od_clk_voltage
 ~~~~~~~~~~~~~~~~~
 
-.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    :doc: pp_od_clk_voltage
 
 pp_dpm_*
 ~~~~~~~~
 
-.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    :doc: pp_dpm_sclk pp_dpm_mclk pp_dpm_socclk pp_dpm_fclk pp_dpm_dcefclk pp_dpm_pcie
 
 pp_power_profile_mode
 ~~~~~~~~~~~~~~~~~~~~~
 
-.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    :doc: pp_power_profile_mode
 
 *_busy_percent
 ~~~~~~~~~~~~~~
 
-.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    :doc: gpu_busy_percent
 
-.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    :doc: mem_busy_percent
 
 gpu_metrics
 ~~~~~~~~~~~~~~~~~~~~~
 
-.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    :doc: gpu_metrics
 
 GPU Product Information
@@ -239,7 +239,7 @@ serial_number
 unique_id
 ---------
 
-.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    :doc: unique_id
 
 GPU Memory Usage Information
@@ -289,7 +289,7 @@ PCIe Accounting Information
 pcie_bw
 -------
 
-.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
    :doc: pcie_bw
 
 pcie_replay_count

