Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C82C2BB84
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFD5121789
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599494801;
	bh=6wTTRBbeW3FM1NjVQBOWSSQZT6g2KoUSUFtzj9LAM7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bkwOs9521DBxg7M3XO0eL5WVtXqgy5SgZCGa4YfvO5W8HCfgqykYSuE6dBQyWYocZ
	 uVc7mA070lc3TaHCyKKyCRmBaojnjyxWw6Xgw7B/6RccwYzPJhK3NCepfBeOdlQh8R
	 Za8TtYj9m62MOBN2V7tcuw6pDkCKOYq3H3zRDSy4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbgIGQGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:06:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730006AbgIGQF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:05:59 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34EBD21775;
        Mon,  7 Sep 2020 16:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599494759;
        bh=6wTTRBbeW3FM1NjVQBOWSSQZT6g2KoUSUFtzj9LAM7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qwDOw7Mdb4WWtVbpzMk3V9UKARma1EefBskVYmDBcDnUm21leO9HK5bdxMthVsQW/
         RzkQLyG6z540T5KP5i8bdhBXR7GfMbIrDlIvVFy8ejvsPWxoQ8+EMPHevi+I/WLthM
         9G+If2lOIrfLPtIUtQc2Oiq4dtKQ/7PP9LKT63bc=
From:   Will Deacon <will@kernel.org>
To:     "yanfei.xu@windriver.com" <yanfei.xu@windriver.com>,
        catalin.marinas@arm.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64/numa: Fix a typo in comment of arm64_numa_init
Date:   Mon,  7 Sep 2020 17:05:37 +0100
Message-Id: <159948480700.583270.7928580144786342882.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200901091154.10112-1-yanfei.xu@windriver.com>
References: <20200901091154.10112-1-yanfei.xu@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Sep 2020 17:11:54 +0800, yanfei.xu@windriver.com wrote:
> Fix a typo in comment of arm64_numa_init. 'encomapssing' should
> be 'encompassing'.

Applied to arm64 (for-next/tpyos), thanks!

[1/1] arm64/numa: Fix a typo in comment of arm64_numa_init
      https://git.kernel.org/arm64/c/9a747c91e8d6

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
