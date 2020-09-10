Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8766C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 978DB20719
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgIJRCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgIJQ6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:58:14 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2645C061573;
        Thu, 10 Sep 2020 09:58:13 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8615D735;
        Thu, 10 Sep 2020 16:58:12 +0000 (UTC)
Date:   Thu, 10 Sep 2020 10:58:11 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc:it_IT: align Italian documentation
Message-ID: <20200910105811.0aea6a65@lwn.net>
In-Reply-To: <20200909223839.9000-1-federico.vaga@vaga.pv.it>
References: <20200909223839.9000-1-federico.vaga@vaga.pv.it>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Sep 2020 00:38:39 +0200
Federico Vaga <federico.vaga@vaga.pv.it> wrote:

> Translation for the following patches
> 
> commit 68e4cd17e218 ("docs: deprecated.rst: Add zero-length and one-element arrays")
> commit 5429ef62bcf3 ("compiler/gcc: Raise minimum GCC version for kernel builds to 4.8")
> commit 5b5bbb8cc51b ("docs: process: Add an example for creating a fixes tag")
> commit 858e6845654d ("docs: dt: convert submitting-patches.txt to ReST format")
> commit bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column warning")
> commit cca73e4946c4 ("docs: Correct the release date of 5.2 stable")
> 
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>

So this doesn't apply to current docs-next...care to respin?

Thanks,

jon
