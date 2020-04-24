Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DB6C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBD5820706
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PAHXOs1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgDXQDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 12:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgDXQDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 12:03:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37742C09B046
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 09:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=GuD1sH7vk/ZSVXd9NBfQkK4zJMu2eCP8fwMoTYSOuU0=; b=PAHXOs1hjhelzQJU2Uo1C5f0lB
        Schix1EIJa5i3uxeovl7c4zZYg31+r1bP4FEqXzUxdXekP3VJunEOEGIcERFq+hg6o14vTpCUFnaO
        1kCg4EmyTzAOl50GN8fKQhdQCLF6Zjm3iie17I5NkC01tgGfDnKs8L9WPFYx/JJsnV2uCiEeosSG6
        2euIbWh0vsVUnd1D0HKxIi37HV7pIOEp8G9CiQokCXP5ubF/fpzCFXllxjR9JeKhOlGXKymT94U/U
        eplllKBzjizjDrF+XZo3glFLXPEbsuJH/m4FlS9XyoFiPH2a4OhtgJ0Yk10io00qKlb3tAuMqLwEU
        yOpy8OFA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jS0nR-0001pq-7a; Fri, 24 Apr 2020 16:03:21 +0000
Subject: Re: [PATCH] random: Document add_hwgenerator_randomness() with other
 input functions
To:     Mark Brown <broonie@kernel.org>, Theodore Ts'o <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org
References: <20200424123959.45559-1-broonie@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1465fdf4-3197-f184-04c2-8a0882f19557@infradead.org>
Date:   Fri, 24 Apr 2020 09:03:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424123959.45559-1-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/20 5:39 AM, Mark Brown wrote:
> The section at the top of random.c which documents the input functions
> available does not document add_hwgenerator_randomness() which might lead
> a reader to overlook it. Add a brief note about it.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/char/random.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 0d10e31fd342..ba2dc45bf718 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -228,6 +228,14 @@
>   * particular randomness source.  They do this by keeping track of the
>   * first and second order deltas of the event timings.
>   *
> + * There is also an interface for true hardware RNGs:
> + *
> + *	void add_hwgenerator_randomness(const char *buffer, size_t count,
> + *				size_t entropy);
> + *
> + * This will credit entropy as specified by the caller, if the entropy

Use a ';' or '.' instead of ','. (and "If" if a period is used)

> + * pool is full it will block until more entropy is needed.
> + *
>   * Ensuring unpredictability at system startup
>   * ============================================
>   *
> 

Otherwise looks good. Thanks.

-- 
~Randy

