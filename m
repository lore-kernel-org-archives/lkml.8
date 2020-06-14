Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39A1C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 20:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 778B82071A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 20:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgFNUCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 16:02:02 -0400
Received: from smtprelay0188.hostedemail.com ([216.40.44.188]:39492 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726844AbgFNUB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 16:01:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id ABA7C15C6;
        Sun, 14 Jun 2020 20:01:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: light02_2e08cc026df0
X-Filterd-Recvd-Size: 1857
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Sun, 14 Jun 2020 20:01:53 +0000 (UTC)
Message-ID: <803557cc672ef0bcd9565c7d5d78e7053388f5d7.camel@perches.com>
Subject: Re: [PATCH] coccinelle: api: add kzfree script
From:   Joe Perches <joe@perches.com>
To:     efremov@linux.com, Julia Lawall <Julia.Lawall@lip6.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Date:   Sun, 14 Jun 2020 13:01:51 -0700
In-Reply-To: <345c783b-a8cf-9dd1-29c6-d32b9b29053f@linux.com>
References: <20200604140805.111613-1-efremov@linux.com>
         <e4981fd76a88e18376c4e634c235501b57d321e7.camel@perches.com>
         <345c783b-a8cf-9dd1-29c6-d32b9b29053f@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-06-14 at 22:42 +0300, Denis Efremov wrote:
> On 6/4/20 7:27 PM, Joe Perches wrote:
> > On Thu, 2020-06-04 at 17:08 +0300, Denis Efremov wrote:
> > > Check for memset() with 0 followed by kfree().
> > 
> > Perhaps those uses should be memzero_explicit or kvfree_sensitive.
> > 
> Is it safe to suggest to use kzfree instead of memzero_explicit && kfree?
> Or it would be better to use kvfree_sensitive in this case.
> kzfree uses memset(0) with no barrier_data.
> 
> For example:
> diff -u -p a/drivers/crypto/inside-secure/safexcel_hash.c b/drivers/crypto/inside-secure/safexcel_hash.c
[]
> @@ -1081,8 +1081,7 @@ static int safexcel_hmac_init_pad(struct
>                 }
>  
>                 /* Avoid leaking */
> -               memzero_explicit(keydup, keylen);
> -               kfree(keydup);
> +               kzfree(keydup);

It would be better to use kvfree_sensitive()


