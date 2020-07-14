Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A957FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A6582074A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgGNUhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:37:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbgGNUhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:37:47 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7790B2064B;
        Tue, 14 Jul 2020 20:37:41 +0000 (UTC)
Date:   Tue, 14 Jul 2020 21:37:39 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     mick@ics.forth.gr, linux@armlinux.org.uk, will@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, rppt@linux.ibm.com,
        akpm@linux-foundation.org, linus.walleij@linaro.org,
        mchehab+samsung@kernel.org, gregory.0xf0@gmail.com,
        masahiroy@kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        bgolaszewski@baylibre.com,
        Palmer Dabbelt <palmerdabbelt@google.com>, mingo@kernel.org,
        ben-linux@fluff.org, peterz@infradead.org, broonie@kernel.org,
        davem@davemloft.net, rdunlap@infradead.org, uwe@kleine-koenig.org,
        dan.j.williams@intel.com, mhiramat@kernel.org,
        matti.vaittinen@fi.rohmeurope.com, zaslonko@linux.ibm.com,
        willy@infradead.org, krzk@kernel.org, paulmck@kernel.org,
        pmladek@suse.com, brendanhiggins@google.com, keescook@chromium.org,
        glider@google.com, elver@google.com, davidgow@google.com,
        mark.rutland@arm.com, ardb@kernel.org, takahiro.akashi@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 3/3] arm64: Use the new generic copy_oldmem_page()
Message-ID: <20200714203738.GB992@gaia>
References: <20200711035544.2832154-1-palmer@dabbelt.com>
 <20200711035544.2832154-4-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200711035544.2832154-4-palmer@dabbelt.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 08:55:44PM -0700, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> This is exactly the same as the arm64 code, which I just into lib/ to
> avoid copying it into the RISC-V port.  This builds with defconfig.
> 
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
