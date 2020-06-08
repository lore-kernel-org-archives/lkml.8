Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8748FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 22:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60FD72068D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 22:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgFHWez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 18:34:55 -0400
Received: from smtprelay0188.hostedemail.com ([216.40.44.188]:51220 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726725AbgFHWez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 18:34:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 47DA98019A3E;
        Mon,  8 Jun 2020 22:34:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: dress29_2b1397c26dbd
X-Filterd-Recvd-Size: 1866
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Mon,  8 Jun 2020 22:34:53 +0000 (UTC)
Message-ID: <05ab102b936ce922c4fae67bf5dd3e323aff0b93.camel@perches.com>
Subject: Re: [PATCH] overflow.h: Add flex_array_size() helper
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date:   Mon, 08 Jun 2020 15:34:52 -0700
In-Reply-To: <20200608221723.GA23644@embeddedor>
References: <20200608221723.GA23644@embeddedor>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-06-08 at 17:17 -0500, Gustavo A. R. Silva wrote:
> Add flex_array_size() helper for the calculation of the size, in bytes,
> of a flexible array member contained within an enclosing structure.
> 
> Example of usage:
> foo
> struct something {
> 	size_t count;
> 	struct foo items[];
> };
> 
> struct something *instance;
[]
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
[]
> +/**
> + * flex_array_size() - Calculate size of a flexible array member within
> + * an enclosing structure.

These comment descriptions do not match

> + * Calculates size of memory needed for flexible array @member of @count
> + * elements within structure @p.

The first comment shows the size of an array member.
The second shows the size of an array member * count

Also the struct_size and flex_array_size definitions
are using two different forms:

		sizeof(*(p)->member) + __must_be_array((p)->member),\
and
		sizeof((p)->member[0]) + __must_be_array((p)->member))

Consistency would be nice.


