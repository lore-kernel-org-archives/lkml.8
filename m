Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8B3C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691A320708
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338772;
	bh=cdy64Llt2CrnoRpFvT7GY/FOrx64tSVcA0GA/+o72Bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vTre6I2nU9aSXe/E3gM6ze0TIOc5/nSYaPJZhzYy6vurJC54LFZs57fGK19uP94b7
	 V6H3ZrGuQccCvhpQBjbCFHjSSJG5/HMQwpH0um+u+tDf5ZzOvy2+Ao2Mir4aUv08l6
	 EAMffRbw+s27jbFQz1EHyyEmrlWqzNkpradFTah4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgBJMqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:46:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:43710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729377AbgBJMl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:41:27 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 098E42085B;
        Mon, 10 Feb 2020 12:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338486;
        bh=cdy64Llt2CrnoRpFvT7GY/FOrx64tSVcA0GA/+o72Bw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kcFD6tGXYBLxGk2raDsNEIKh0Q3HWO6qZ7fsD2FnqaqT7IJkcXwCxzyWWdKpE+4D1
         p+GEnJN3JUwHb36cFtmVTabm3u5deHcgFapdCOT5PCkVusj2fNjuuus6X4JSll8vnW
         kPo7STI3jrYCVZT/z3MG11WHo+HFzWcWyYc6J88o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.5 266/367] drm/amdgpu/navi: fix index for OD MCLK
Date:   Mon, 10 Feb 2020 04:32:59 -0800
Message-Id: <20200210122448.989069154@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

commit 45826e9c4e9e952db43053f4fbed58ec602a410f upstream.

You can only adjust the max mclk, not the min.

Bug: https://gitlab.freedesktop.org/drm/amd/issues/1020
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 5.5.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -812,7 +812,7 @@ static int navi10_print_clk_levels(struc
 		if (!navi10_od_feature_is_supported(od_settings, SMU_11_0_ODFEATURE_UCLK_MAX))
 			break;
 		size += sprintf(buf + size, "OD_MCLK:\n");
-		size += sprintf(buf + size, "0: %uMHz\n", od_table->UclkFmax);
+		size += sprintf(buf + size, "1: %uMHz\n", od_table->UclkFmax);
 		break;
 	case SMU_OD_VDDC_CURVE:
 		if (!smu->od_enabled || !od_table || !od_settings)


