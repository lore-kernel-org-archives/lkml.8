Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E96AC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 21:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 067D52145D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 21:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599514550;
	bh=mIiKWDg6aZKGEJqYWecJKNw7i1BpQK3I2M9oYlUl1jI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XPyuzXeBhdtjVd8/1c1Q5LSS9wcoZf1OCkxw6HmZSxjuIICS+UfQEdB8YegmFjYCr
	 iQ++doaxaw2V2U98xi66v/fZVxFJwjkC+0PkbpVYozCCJq+g+XQ8ugY96f5+jsqRCd
	 sSFivS+lp1IJhiJUcE9uzP1P24ICbWoosaJfiG4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgIGVfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 17:35:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbgIGVfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 17:35:46 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 206092080A;
        Mon,  7 Sep 2020 21:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599514546;
        bh=mIiKWDg6aZKGEJqYWecJKNw7i1BpQK3I2M9oYlUl1jI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kmx65nINHMkFMfqWaQThC+PS+Flt2pP5SZRUeUlzGjYG4lSwT7C7tSgbdJUmgdg4b
         IrGjqdy69LXxJNccIxAtRNYPaAo1dBPwFD91ZrbhoEcrPiHfPAC8btfJOKabO6p54h
         /bJhOF75MIHQWOVt+BUlxRj3ofVLwOrK5wudogcw=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH] arm64: topology: Stop using MPIDR for topology information
Date:   Mon,  7 Sep 2020 22:35:35 +0100
Message-Id: <159951413581.3126645.5011278165801551941.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200829130016.26106-1-valentin.schneider@arm.com>
References: <20200829130016.26106-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Aug 2020 14:00:16 +0100, Valentin Schneider wrote:
> In the absence of ACPI or DT topology data, we fallback to haphazardly
> decoding *something* out of MPIDR. Sadly, the contents of that register are
> mostly unusable due to the implementation leniancy and things like Aff0
> having to be capped to 15 (despite being encoded on 8 bits).
> 
> Consider a simple system with a single package of 32 cores, all under the
> same LLC. We ought to be shoving them in the same core_sibling mask, but
> MPIDR is going to look like:
> 
> [...]

Applied to arm64 (for-next/topology), thanks!

[1/1] arm64: topology: Stop using MPIDR for topology information
      https://git.kernel.org/arm64/c/3102bc0e6ac7

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
