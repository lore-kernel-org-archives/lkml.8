Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AC0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04C7320791
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KZFE1eXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgHMLXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 07:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgHMLXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 07:23:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAC5C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 04:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bMRBGcKt+bU8uAPr5Wn9gP6oItYBvFq1FIEisxr/UUQ=; b=KZFE1eXd1CWdppiZQ3jh6dA+N/
        SImJmnPw5zL3u53vOECKyXOKHoCU0Im5fYnfmCdyg8cfXtRN7hfkQZCaWIWDHD2sj5EOKyAVlYE9m
        yaliy3/OfuiGAo5LJEDCwWt3BCjDlWPZhDE9d1enXhLTNBugDaGTITNUJz7kSxfj4lAcZFxhE60PI
        0xs1RGe4iD72L+B1/kwLa/Px7iO5dQzVrXidtr/LFR2BtVLUapF8a4z26vOqQmM+O9OF4DjLTf9Vz
        plec0ktW0KvsTntw4Qj8134GCWIF1ZcFumdkm7IhMh9dOvzR+zNtJt3UY9yqtmoR9sGPuY79HbP+8
        FE4fS7tQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6BKR-0001TK-E8; Thu, 13 Aug 2020 11:23:27 +0000
Date:   Thu, 13 Aug 2020 12:23:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH] overflow: Add __must_check attribute to check_*() helpers
Message-ID: <20200813112327.GF17456@casper.infradead.org>
References: <202008121450.405E4A3@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008121450.405E4A3@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 02:51:52PM -0700, Kees Cook wrote:
> +/*
> + * Allows to effectively us apply __must_check to a macro so we can have
> + * both the type-agnostic benefits of the macros while also being able to
> + * enforce that the return value is, in fact, checked.
> + */
> +static inline bool __must_check __must_check_bool(bool condition)
> +{
> +	return unlikely(condition);
> +}

I'm fine with the concept, but this is a weirdly-generically-named
function that has a very specific unlikely() in it.  So I'd call
this __must_check_overflow() and then it's obvious that overflow is
unlikely(), whereas it's not obvious that __must_check_bool() is going
to be unlikely().

