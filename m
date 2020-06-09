Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DE9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 06:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFB2E207C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 06:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgFIGrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 02:47:07 -0400
Received: from smtprelay0022.hostedemail.com ([216.40.44.22]:43134 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726917AbgFIGrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 02:47:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id E1047180424AA;
        Tue,  9 Jun 2020 06:47:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: face18_3117c7126dc0
X-Filterd-Recvd-Size: 2021
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Tue,  9 Jun 2020 06:47:04 +0000 (UTC)
Message-ID: <e32b0a42aa00c20ef3868edd987c39a95ba68e95.camel@perches.com>
Subject: Re: [PATCH v2] overflow.h: Add flex_array_size() helper
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date:   Mon, 08 Jun 2020 23:47:03 -0700
In-Reply-To: <20200609012233.GA3371@embeddedor>
References: <20200609012233.GA3371@embeddedor>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-06-08 at 20:22 -0500, Gustavo A. R. Silva wrote:
> Add flex_array_size() helper for the calculation of the size, in bytes,
> of a flexible array member contained within an enclosing structure.
[]
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
[]
> +/**
> + * flex_array_size() - Calculate size, in bytes, of a flexible array member
> + * within an enclosing structure. Read on for more details.

IMO: "Read on for more details" isn't useful here.
Perhaps better would be something like:

 * flex_array_size() - size of a flexible array (sizeof(typeof(member)) * count)

> + *
> + * @p: Pointer to the structure.
> + * @member: Name of the flexible array member.
> + * @count: Number of elements in the array.
> + *
> + * Calculates size, in bytes, of a flexible array @member of @count elements

IMO: "in bytes, " is redundant.  size is always bytes.

> + * within structure @p.
> + *
> + * Return: number of bytes needed or SIZE_MAX on overflow.
> + */
> +#define flex_array_size(p, member, count)					\
> +	array_size(count,							\
> +		    sizeof(*(p)->member) + __must_be_array((p)->member))
> +
>  #endif /* __LINUX_OVERFLOW_H */

