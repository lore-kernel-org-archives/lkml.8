Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C155BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2BBF2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgHUIFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 04:05:17 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50100 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgHUIFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 04:05:14 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k922s-0004Cr-5y; Fri, 21 Aug 2020 18:05:07 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 21 Aug 2020 18:05:06 +1000
Date:   Fri, 21 Aug 2020 18:05:06 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 012/168] crypto: ccree - fix resource leak on error
 path
Message-ID: <20200821080506.GA25449@gondor.apana.org.au>
References: <20200817143733.692105228@linuxfoundation.org>
 <20200817143734.336080170@linuxfoundation.org>
 <20200818092231.GA10974@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818092231.GA10974@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 11:22:31AM +0200, Pavel Machek wrote:
>
> But it is freed unconditionally, and free_shash() is not robust
> against NULL pointer due to undefined behaviour in crypto_shash_tfm.

crypto_free_shash calls crypto_destroy_tfm with both the original
pointer as well as the crypto_shash_tfm pointer so it does the
right thing for NULL pointers.  Please check again.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
