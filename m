Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3AAC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC21D206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbgEEPmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729629AbgEEPmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:42:42 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0323C061A0F;
        Tue,  5 May 2020 08:42:41 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AB78731A;
        Tue,  5 May 2020 15:42:41 +0000 (UTC)
Date:   Tue, 5 May 2020 09:42:40 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc:it_IT: align Italian translation
Message-ID: <20200505094240.5b525754@lwn.net>
In-Reply-To: <20200430222037.4480-1-federico.vaga@vaga.pv.it>
References: <20200430222037.4480-1-federico.vaga@vaga.pv.it>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  1 May 2020 00:20:37 +0200
Federico Vaga <federico.vaga@vaga.pv.it> wrote:

> Translation for the following patches:
> 
> commit c4f4af4094d6 ("docs: Add documentation for Symbol Namespaces")
> commit 36bc683dde0a ("kernel-doc: rename the kernel-doc directive 'functions' to 'identifiers'")
> commit a035d552a93b ("Makefile: Globally enable fall-through warning")
> commit b9918bdcac1f ("Documentation/process: Add fallthrough pseudo-keyword")
> commit 58ad30cf91f0 ("docs: fix reference to core-api/namespaces.rst")
> commit fb0e0ffe7fc8 ("Documentation: bring process docs up to date")
> commit 7af51678b6d3 ("docs: deprecated.rst: Add BUG()-family")
> commit 7929b9836ed0 ("docs: Remove :c:func: from process/deprecated.rst")
> commit 76136e028d3b ("docs: deprecated.rst: Clean up fall-through details")
> commit d8401f504b49 ("docs: deprecated.rst: Add %p to the list")
> commit b1735296cef9 ("docs: locking: Drop :c:func: throughout")
> commit 6adb7755996f ("docs: locking: Add 'need' to hardirq section")
> 
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> ---
>  .../it_IT/doc-guide/kernel-doc.rst            |  25 ++-
>  .../it_IT/kernel-hacking/hacking.rst          |  18 ++
>  .../it_IT/kernel-hacking/locking.rst          | 172 +++++++++---------
>  .../translations/it_IT/process/2.Process.rst  |  95 +++++-----
>  .../it_IT/process/coding-style.rst            |   6 +-
>  .../translations/it_IT/process/deprecated.rst | 130 +++++++++++--
>  6 files changed, 287 insertions(+), 159 deletions(-)

Applied, thanks.

jon
