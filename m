Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B329AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 16:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 959F12071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 16:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbgEYQSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 12:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgEYQSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 12:18:00 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3ABC061A0E;
        Mon, 25 May 2020 09:18:00 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D2B724A2;
        Mon, 25 May 2020 16:17:59 +0000 (UTC)
Date:   Mon, 25 May 2020 10:17:58 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] Documentation/features: Correct RISC-V kprobes support
 entry
Message-ID: <20200525101758.5cf2d32c@lwn.net>
In-Reply-To: <20200523210005.59140-1-bjorn.topel@gmail.com>
References: <20200523210005.59140-1-bjorn.topel@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 May 2020 23:00:05 +0200
Björn Töpel <bjorn.topel@gmail.com> wrote:

> The Documentation/features/debug/kprobes/arch-support.txt incorrectly
> states that RISC-V has kprobes support. This is not the case.
> 
> Note that entries that have been incorrectly marked with 'ok' will not
> be changed back to 'TODO' by the features-refresh.sh script.
> 
> Fixes: 7156fc292850 ("Documentation/features: Refresh the arch support status files in place")
> Signed-off-by: Björn Töpel <bjorn.topel@gmail.com>

Applied, thanks.

jon
