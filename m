Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B678FC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E8220768
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgDHJBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 05:01:16 -0400
Received: from foss.arm.com ([217.140.110.172]:35890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbgDHJBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 05:01:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73DF731B;
        Wed,  8 Apr 2020 02:01:15 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D77F3F73D;
        Wed,  8 Apr 2020 02:01:14 -0700 (PDT)
Date:   Wed, 8 Apr 2020 10:01:12 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Fredrik Strupe <fredrik@strupe.net>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        will.deacon@arm.com
Subject: Re: [PATCH] arm64: armv8_deprecated: Fix undef_hook mask for thumb
 setend
Message-ID: <20200408090111.GA27331@gaia>
References: <911db2f1-e078-a460-32ee-154a0b4de5d4@strupe.net>
 <20200407092744.GA2665@gaia>
 <a2b345a4-30a0-3218-8c8d-e84ec2317dc9@arm.com>
 <0d7b582a-1bd0-9db2-2fdc-04fc887f64c6@strupe.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d7b582a-1bd0-9db2-2fdc-04fc887f64c6@strupe.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 01:18:21PM +0200, Fredrik Strupe wrote:
> (Sorry for duplicate, something went terribly wrong with the formatting of
> the previous email.)

It's still wrong here with tabs converted to spaces. The patch doesn't
apply. Could you please send the patch separately as a v2? It looks fine
otherwise.

Thanks.

-- 
Catalin
