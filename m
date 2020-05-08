Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1513EC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7BF3218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942630;
	bh=os/rM898h0GWxPAxlsSRkIi4ZajVCplOuaeMIrU9njg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g2JH160sMnU2B5pp3LvPBP8C87myQzS8XABXChTGDU2wkigQeSeDF8m1g2Dj46V0n
	 dKPSUHu8VY+cLPVIaN+AQTc3Bqwd2rU9+WNrXjLPr7VIw1hqeCiGTlTevi+7a6AgCv
	 VgSJn94DZfYo+t4CDxV0BpRakih4KwqTmf6NnuRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbgEHM5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:57:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728482AbgEHMz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:55:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F21982054F;
        Fri,  8 May 2020 12:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942557;
        bh=os/rM898h0GWxPAxlsSRkIi4ZajVCplOuaeMIrU9njg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lLdVzcbHvuW6M8ZiLCVN+LCXLgDhopTvTGdC91ivUijIocNZa82LsmF1382jeZSfe
         UmIzNPZosBCP8JEid+hhqRMUcUYJBwYqHI5okydvLSnzp9v0n4RoTlsf6FHxqqjh5p
         1A2bP6I99B70fNJ3sw4yGaWxmi7Pz+sArD/a59x0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaron Ma <aaron.ma@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.6 42/49] drm/amdgpu: Fix oops when pp_funcs is unset in ACPI event
Date:   Fri,  8 May 2020 14:35:59 +0200
Message-Id: <20200508123048.762117644@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123042.775047422@linuxfoundation.org>
References: <20200508123042.775047422@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Ma <aaron.ma@canonical.com>

commit 5932d260a8d85a103bd6c504fbb85ff58b156bf9 upstream.

On ARCTURUS and RENOIR, powerplay is not supported yet.
When plug in or unplug power jack, ACPI event will issue.
Then kernel NULL pointer BUG will be triggered.
Check for NULL pointers before calling.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -91,7 +91,8 @@ void amdgpu_pm_acpi_event_handler(struct
 			adev->pm.ac_power = true;
 		else
 			adev->pm.ac_power = false;
-		if (adev->powerplay.pp_funcs->enable_bapm)
+		if (adev->powerplay.pp_funcs &&
+		    adev->powerplay.pp_funcs->enable_bapm)
 			amdgpu_dpm_enable_bapm(adev, adev->pm.ac_power);
 		mutex_unlock(&adev->pm.mutex);
 	}


