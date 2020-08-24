Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CE6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 22:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FD2D20706
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 22:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgHXWFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 18:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHXWFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 18:05:32 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6F0C061574;
        Mon, 24 Aug 2020 15:05:32 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 265302CB;
        Mon, 24 Aug 2020 22:05:32 +0000 (UTC)
Date:   Mon, 24 Aug 2020 16:05:31 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-doc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: add riscv entry in list of existing
 profiles
Message-ID: <20200824160531.0e0a349b@lwn.net>
In-Reply-To: <20200815115728.15128-1-lukas.bulwahn@gmail.com>
References: <20200815115728.15128-1-lukas.bulwahn@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Aug 2020 13:57:28 +0200
Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> As long as there are only a few maintainer entry profiles, i.e., three
> in v5.8, continue to maintain a complete a list of entries in the
> maintainer handbook.
> 
> Complete the list by adding the RISC-V ARCHITECTURE maintainer entry
> profile found in MAINTAINERS.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Applied, thanks.

jon
