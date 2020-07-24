Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4B9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47BAD2074A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgGXMPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:15:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbgGXMO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 08:14:59 -0400
Received: from localhost.localdomain (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 290922065E;
        Fri, 24 Jul 2020 12:14:58 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "gregory.herrero@oracle.com" <gregory.herrero@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, rostedt@goodmis.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] recordmcount: only record relocation of type R_AARCH64_CALL26 on arm64.
Date:   Fri, 24 Jul 2020 13:14:56 +0100
Message-Id: <159559281273.30177.1152636464895708228.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200717143338.19302-1-gregory.herrero@oracle.com>
References: <20200717143338.19302-1-gregory.herrero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jul 2020 16:33:38 +0200, gregory.herrero@oracle.com wrote:
> Currently, if a section has a relocation to '_mcount' symbol, a new
> __mcount_loc entry will be added whatever the relocation type is.
> This is problematic when a relocation to '_mcount' is in the middle of a
> section and is not a call for ftrace use.
> 
> Such relocation could be generated with below code for example:
>     bool is_mcount(unsigned long addr)
>     {
>         return (target == (unsigned long) &_mcount);
>     }
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] recordmcount: only record relocation of type R_AARCH64_CALL26 on arm64.
      https://git.kernel.org/arm64/c/ea0eada45632

-- 
Catalin

