Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38223C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1528721D95
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596127936;
	bh=48kj/KpAT0YftWuuMbp2IoV23MYjAsh2YyFjGW5b7h8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MeftIUmaPQ/CjCsGmUNkb+AUN52Y50wYBvNYrOK8lSwQ5WQVS1mQqY/oacf/tmZKR
	 0EXR9dOBoJdQndcQGWmuWSjFft/ARt7MYaq72HRCx5RQNi0z1PMHwrFjlkzg9GvQAJ
	 WsYGDputd5Gqk4n9BhZcDJd/JP0x5ZOjIF9g01c0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbgG3QwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 12:52:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgG3QwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 12:52:14 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34BF620829;
        Thu, 30 Jul 2020 16:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596127933;
        bh=48kj/KpAT0YftWuuMbp2IoV23MYjAsh2YyFjGW5b7h8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CfnsF6V1H1yVIIWRWl/+umghrTxTzpjS1ITRvkuXqaFDP8FIzqGizZ2f9dsi+Wyi0
         GqU+62/YTcAXkDB4/bNuKq6oX3wEZntMwS977gyl9oUxO+3gP8HoQU4dYxRogm7E/s
         nCOEWbf60SAT4XvQMCeCLYXlzq6zQKPW+CRsdSa4=
From:   Will Deacon <will@kernel.org>
To:     mark.rutland@arm.com, John Garry <john.garry@huawei.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, zhangshaokun@hisilicon.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Include drivers subdirs for ARM PMU PROFILING AND DEBUGGING entry
Date:   Thu, 30 Jul 2020 17:52:07 +0100
Message-Id: <159612513463.1044769.11425867844459372721.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1592392648-128331-1-git-send-email-john.garry@huawei.com>
References: <1592392648-128331-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jun 2020 19:17:28 +0800, John Garry wrote:
> Ensure that the ARM PMU PROFILING AND DEBUGGING maintainers are included
> for the HiSilicon PMU driver.

Applied to arm64 (for-next/fixes), thanks!

[1/1] MAINTAINERS: Include drivers subdirs for ARM PMU PROFILING AND DEBUGGING entry
      https://git.kernel.org/arm64/c/6a7389f0312f

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
