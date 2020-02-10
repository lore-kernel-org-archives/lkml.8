Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C896AC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 07:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A6D20733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 07:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="OjR2hfzm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgBJHl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 02:41:28 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:32146 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727429AbgBJHl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 02:41:27 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581320487; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=uQ1CFdzgmAFqyyBigIzwbQQb6E7RnAIID7E2Ta0bdUY=; b=OjR2hfzmY7mJrdlZ8VNRmzdVMPPeYav0q07VsCgR2aD8GD/TJzc25psDs9XOF5/p2DNIbir1
 YQql+KBR3BaoyJW2NlIy0dFYkd5GelXeWy2ZrBKXM+q8WDGy54KaDeNxbKPhSk7hl07P5fmk
 upneVSrMiaCKXVDKxEddz26PY9E=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e41091c.7fb6bfac7ab0-smtp-out-n03;
 Mon, 10 Feb 2020 07:41:16 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 88CB8C447A0; Mon, 10 Feb 2020 07:41:15 +0000 (UTC)
Received: from smasetty-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: smasetty)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D078FC43383;
        Mon, 10 Feb 2020 07:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D078FC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=smasetty@codeaurora.org
From:   Sharat Masetty <smasetty@codeaurora.org>
To:     freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     dri-devel@freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        jcrouse@codeaurora.org, mka@chromium.org, dianders@chromium.org,
        Sharat Masetty <smasetty@codeaurora.org>
Subject: [PATCH v6]  sc7180: Add A618 GPU bindings
Date:   Mon, 10 Feb 2020 13:11:04 +0530
Message-Id: <1581320465-15854-1-git-send-email-smasetty@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I used this branch qcom/arm64-for-5.6-to-be-rebased as suggested by Matthias.
This patch needs the clock patches and the clock patches have not yet landed, so
please apply the following series and patches in order

a) All patches from https://patchwork.kernel.org/project/linux-clk/list/?series=203517&state=%2a&archive=both
b) Patches 1 and 2 from https://patchwork.kernel.org/project/linux-clk/list/?series=203527&archive=both&state=%2a
c) All patches from https://patchwork.kernel.org/project/linux-clk/list/?series=221739&archive=both&state=%2a
d) https://lore.kernel.org/linux-arm-msm/20200124144154.v2.10.I1a4b93fb005791e29a9dcf288fc8bd459a555a59%40changeid/raw
e) https://patchwork.kernel.org/project/linux-clk/list/?series=238893
f) This patch "arm64: dts: qcom: sc7180: Add A618 gpu dt blob"

v3: Addressed review comments from previous submits. Also removed the
interconnect bindings from this patch and I will submit as a new patch with its
dependencies listed. Also I will be sending a new patch for updating the
bindings documentation.

v4: Add GX_GDSC power domain binding for GMU

v5: Change to a dummy GX_GDSC binding for faster landing

v6: Rebased changes on top of Taniyas lastet post((e) in the list above) and
adding back the GX_GDSC binding.

Sharat Masetty (1):
  arm64: dts: qcom: sc7180: Add A618 gpu dt blob

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 102 +++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

--
1.9.1
