Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9538DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 22:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E6AF207BB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 22:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594245779;
	bh=MWU4kJ0nkGwimztIOo454Vh5f+VjVSsWXcEKuNnvrrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cRTSftFtDrVr47H5bf+Tg1+3epxBQGQPIlJ5fvykKYX16vGDGPzRHVr0IX3K4ZaNN
	 pN1gCnbyDKSzilSGTjIJUmUJ6e73soGONowKG7w+Bo0DD9kaudbZZJ9BQKd/WwOo2C
	 5arKq19A/O+My3eaLIGG69P2dW3yBfVSUBj3yUv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgGHWC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 18:02:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgGHWC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 18:02:57 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B0DC2078A;
        Wed,  8 Jul 2020 22:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594245777;
        bh=MWU4kJ0nkGwimztIOo454Vh5f+VjVSsWXcEKuNnvrrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bV+2k9QtMZZQy0Ppk/AugnbFbyrUNpWYyAa0XOl6I/MV2FHY21EtZCLWLGAsQKQ91
         mpVInOboIUI7sHJmDnNLG/JZVLSrqWrHKaMfP4Z7NGcw+8sq0PMUWi4pshpVjN69BN
         e7pBiOxXeiVwhPPSo3usvDNzvrLsXF0zfE3arGlk=
From:   Will Deacon <will@kernel.org>
To:     mark.rutland@arm.com, daniel.thompson@linaro.org,
        davem@davemloft.net, mhiramat@kernel.org, catalin.marinas@arm.com,
        jason.wessel@windriver.com, dianders@chromium.org,
        Wei Li <liwei391@huawei.com>, maz@kernel.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, liwei1412@163.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] arm64: kgdb/kdb: Fix single-step debugging issues
Date:   Wed,  8 Jul 2020 23:02:35 +0100
Message-Id: <159424314252.2156246.1455628570494600510.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200509214159.19680-1-liwei391@huawei.com>
References: <20200509214159.19680-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 May 2020 05:41:55 +0800, Wei Li wrote:
> This patch set is to fix several issues of single-step debugging
> in kgdb/kdb on arm64.
> 
> It seems that these issues have been shelved a very long time,
> but i still hope to solve them, as the single-step debugging
> is an useful feature.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: kgdb: Fix single-step exception handling oops
      https://git.kernel.org/arm64/c/8523c006264d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
