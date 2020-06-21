Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC4DC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 04:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 604FF24785
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 04:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592714195;
	bh=8Is6WO1ey0nQPFB5gupTXkIMpseo8Kyx5Z9+J6XFIkI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=LHFzlm4jclEMxkieEMps9oEpkx4mzwIk1gq0TWR8NEdyulGKnZ6gBHL40plw87Jza
	 XBOKZicSi8pv9j8cEFTojafqM9C5AzVOVKkGGQH+sw/UvjyykSGKuvlTKHbACl5zlp
	 VjNFITzBgCTAgssfA9k+Ow7eHYvnuWyHDWJdccMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgFUEge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 00:36:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgFUEgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 00:36:33 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1CD22477E;
        Sun, 21 Jun 2020 04:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592714193;
        bh=8Is6WO1ey0nQPFB5gupTXkIMpseo8Kyx5Z9+J6XFIkI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2rSDacdxSmtNbeXB/ki+X88EqpfdIdcDJEKcMmIXrAzCrCdYgyA3hT2pQk1pUfChv
         vK5yopJzDZa0Wly1PQ2bK427zhV5HMATTDrTudmt3qj4Awdvk8QFCf27vfUnRCV2Fs
         nqhY4BNtfsskJODq/AP2dfkTx7McM4F/3THyy/qo=
Date:   Sat, 20 Jun 2020 21:36:32 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     andy.shevchenko@gmail.com, arnd@arndb.de, emil.l.velikov@gmail.com,
        geert@linux-m68k.org, keescook@chromium.org,
        linus.walleij@linaro.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com, syednwaris@gmail.com,
        vilhelm.gray@gmail.com, yamada.masahiro@socionext.com
Subject: Re: [PATCH v3 2/2] bits: Add tests of GENMASK
Message-Id: <20200620213632.60c2c6b99ec9cf9392fa128d@linux-foundation.org>
In-Reply-To: <20200608221823.35799-2-rikard.falkeborn@gmail.com>
References: <20200608184222.GA899@rikard>
        <20200608221823.35799-1-rikard.falkeborn@gmail.com>
        <20200608221823.35799-2-rikard.falkeborn@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  9 Jun 2020 00:18:23 +0200 Rikard Falkeborn <rikard.falkeborn@gmail.com> wrote:

> Add tests of GENMASK and GENMASK_ULL.
> 
> A few test cases that should fail compilation are provided
> under #ifdef TEST_GENMASK_FAILURES

WARNING: modpost: missing MODULE_LICENSE() in lib/test_bits.o


Could you please send a fix?
