Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4A7C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 000D02087D
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599494895;
	bh=QeHIkF/ix+36XFjoiPIijp204FQoC8LDlQRpbEiIysg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t/iDREIJfGbNrZ60yBR3G1D8ROb9uwh4UMUgG2ysiHkKPRzIdDS7Tk8L2ibL6at8T
	 ntbJp3Mvwb2BhSAxiuwFrAkIq8zkewq0jl7h+Z3PikenuvAeM6M37C1kU2QCUsensc
	 0kBFKZxQfNj3FO+Oz0ZLaR9wx/rrgLRPZSr4zPnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbgIGQIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:08:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730239AbgIGQF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:05:57 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E42802087D;
        Mon,  7 Sep 2020 16:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599494755;
        bh=QeHIkF/ix+36XFjoiPIijp204FQoC8LDlQRpbEiIysg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Socdqn0EXGvMtm8FRILCbjcfp7AsK5TCutrjKh1GILpklZ7512+lBf83RxCbPJ5vD
         K8gojHaAp54F2cRf2AYGcCnGy1PXXc36qTauT2r+yEPXfm/n2cvkwjmWDp4XBUvedq
         krEp9gJL+uWIzpUt6HDaFZg1vcbXeJOY4rMgHl4I=
From:   Will Deacon <will@kernel.org>
To:     maz@kernel.org, julien.thierry.kdev@gmail.com,
        linux-kernel@vger.kernel.org, Xiaoming Ni <nixiaoming@huawei.com>,
        mark.rutland@arm.com, catalin.marinas@arm.com,
        suzuki.poulose@arm.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        wangle6@huawei.com
Subject: Re: [PATCH] arm64: fix some spelling mistakes in the comments by codespell
Date:   Mon,  7 Sep 2020 17:05:35 +0100
Message-Id: <159948473119.582952.94642666556393887.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828031822.35928-1-nixiaoming@huawei.com>
References: <20200828031822.35928-1-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Aug 2020 11:18:22 +0800, Xiaoming Ni wrote:
> 


Applied to arm64 (for-next/tpyos), thanks!

[1/1] arm64: fix some spelling mistakes in the comments by codespell
      https://git.kernel.org/arm64/c/ad14c19242b5

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
