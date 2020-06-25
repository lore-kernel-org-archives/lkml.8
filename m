Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018D2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D15F9206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593112969;
	bh=dFUC84cI2RrhIGbMw8doLrj11Jb5vSXF9VndYmD0v5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fPBpvVz+xuw8b6Kvv/KYTKerBiQbbYFtCTaJwAui8X1lVrBvth/IslBujywupRogK
	 OEdVpk31aeQ3gyptfdhLNT76kqs22ZslJeM/iDM/2uo4sVGpeS1jBwk4Amj57LXLyb
	 bF8yjBADAO90ptzQjAHm1vabSa3M5QDKW+Ryi3HU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406345AbgFYTWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:22:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406068AbgFYTWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:22:45 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 474AD2076E;
        Thu, 25 Jun 2020 19:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593112965;
        bh=dFUC84cI2RrhIGbMw8doLrj11Jb5vSXF9VndYmD0v5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E8DtDBw2zM3rBU5kV4Y4NB1vKoqKavFb01t4SNMGsSc6bUzNShw9XpXvf+kBkHdU+
         GL0+MgmX3pHlV9wruwBXnDCwfnP3Z82qewQw7kbT+OI8ECZSDzW7lELvuPeYSQW5c9
         7qoZO0oQQZ93cbSjnkXZf3wAum366Zw6CJtagalQ=
From:   Will Deacon <will@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: Add KRYO{3,4}XX silver CPU cores to SSB safelist
Date:   Thu, 25 Jun 2020 20:22:37 +0100
Message-Id: <159311279136.67343.3617252681136458982.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200625103123.7240-1-saiprakash.ranjan@codeaurora.org>
References: <20200625103123.7240-1-saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jun 2020 16:01:23 +0530, Sai Prakash Ranjan wrote:
> QCOM KRYO{3,4}XX silver/LITTLE CPU cores are based on
> Cortex-A55 and are SSB safe, hence add them to SSB
> safelist -> arm64_ssb_cpus[].

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: Add KRYO{3,4}XX silver CPU cores to SSB safelist
      https://git.kernel.org/arm64/c/108447fd0d1a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
