Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CF9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 20:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDAB2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 20:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JVrBnaCJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404309AbgAXUYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 15:24:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37334 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392088AbgAXUX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 15:23:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dI15mVTzCi+gGAV9o/iOXkOXan3t0Vgap5WIuCnA5H4=; b=JVrBnaCJO2kxOHjSfLs3JvXpl
        J2u9N2QO5KAZY9TfdOJSl9EFQ/nMbrFza+6IxFSiIcQenlv3IhQro03R2rhnd5SQ+X4QuoxBvj1eQ
        uo5KynW7h3KNEIbOH+SVqjZNrzWzbH/JFDaRo4XtaGYG0B3rI/eU+NE2mlIJfbhytAWHcDQvZBIS2
        u7RzhNBPfKIEva/CD8K8aqy08fRGMrZkLA2KzusHZGAfsoND6tkYRZc/QlY3ZrDt0n80MRTCOH+jM
        4DfDTu5QJie5JJ0U/PKQv2lqRBZhEOXZsWhjJ4RlcmmFcpCqFIZRlH/azkFtxCl3bwOhPidGby3Hh
        n7DKtkPVw==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iv5Uk-0003Hp-VA; Fri, 24 Jan 2020 20:23:59 +0000
Subject: Re: [PATCH] random: Document add_hwgenerator_randomness() with other
 input functions
To:     Mark Brown <broonie@kernel.org>, Theodore Ts'o <tytso@mit.edu>
Cc:     linux-kernel@vger.kernel.org
References: <20200124134106.8472-1-broonie@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <825bf310-8ae6-ba62-1b70-709c738a7aa5@infradead.org>
Date:   Fri, 24 Jan 2020 12:23:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200124134106.8472-1-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/20 5:41 AM, Mark Brown wrote:
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
> index c7f9584de2c8..16070c36add3 100644
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

Not a comma there. Either a ';' or "caller. If ..."

> + * pool is full it will block until more entropy is needed.
> + *
>   * Ensuring unpredictability at system startup
>   * ============================================
>   *
> 

thanks.
-- 
~Randy

