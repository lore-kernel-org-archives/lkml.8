Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8256BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6269420781
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593006948;
	bh=msJljTZ30DHOALc4NDJXZALraFGHPtuYMSdFceXl97w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pG4jybY0vqZsMtdwx5mpY+8qhMSG8cPQjh21++Riyzv7ow1OV4QWBnIEf1XwB1eVL
	 nWzqBc5YUzF1Of3coxnID2G7MrUUDNihCJ83Wn2lmcW2Kcaev/DH+5VKXpUIr9JQ1M
	 48Y52f9slq+K/672Pg+Wh8Db5OgLt20deUBIfKg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403977AbgFXNzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:55:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391147AbgFXNzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:55:43 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF7C420781;
        Wed, 24 Jun 2020 13:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593006943;
        bh=msJljTZ30DHOALc4NDJXZALraFGHPtuYMSdFceXl97w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tFC0RUC/hyrX5PVAPN8kUZnTOKOA2PJYthyMqUpMEyjsmrmoufWL032+MBMGsQRUM
         bfBAxJoUaPSFDMUprsNGSYcwjgsqGUvTtHyhuZn5B8GMWe1m76+1fCp31pcGqSWNGn
         1Lr0TFqKUpesC4p8ncY/wW2BsWH966A3RD8Yb1w4=
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Douglas Anderson <dianders@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] arm64: kpti: Add KRYO{3, 4}XX silver CPU cores to kpti safelist
Date:   Wed, 24 Jun 2020 14:54:52 +0100
Message-Id: <159300510700.57173.9996277859967187926.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200624123406.3472-1-saiprakash.ranjan@codeaurora.org>
References: <20200624123406.3472-1-saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jun 2020 18:04:06 +0530, Sai Prakash Ranjan wrote:
> QCOM KRYO{3,4}XX silver/LITTLE CPU cores are based on Cortex-A55
> and are meltdown safe, hence add them to kpti_safe_list[].

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: kpti: Add KRYO{3, 4}XX silver CPU cores to kpti safelist
      https://git.kernel.org/arm64/c/f4617be35b4b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
