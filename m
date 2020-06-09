Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B515C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0CD62076C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591663372;
	bh=V7sPRt5t1bPdgkFLTtlp3s+mAuZDhKkTlH4OAYkopVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S6x0OJtIZoSoip/tUk7uUvlRDy748WQE++2o7H/gVJBFgktoJkXOcG4QnvWfiy6Xa
	 SF//sa3WF932YHROcUcrDvfY+Z008aD+qHbiqJJ/fitaa0Vlt3xkdwTHWeKJ0Dq7qS
	 I5Xr5k1JtCfUKK7MhcLmgvTbF2aHiTuZJx3BFydw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbgFIAmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:42:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728552AbgFIAmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 20:42:46 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2502D20737;
        Tue,  9 Jun 2020 00:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591663365;
        bh=V7sPRt5t1bPdgkFLTtlp3s+mAuZDhKkTlH4OAYkopVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NkQ6oQQy24UsfoH9EPwlmMoqOD65lnqnabQ6xuLoQSsTcCn01weXzK9IRCvy8mknt
         mriLOEa+8G6FBI5ZgdT3iq8H8zFIXXDyBFzLf6Rj0N3RzruZiZ0OZKXX+5N3s8tIGA
         ILRxZuIxO2SHLbrTmEQWPbDGXQwSPsTVcxm8ZQo8=
Date:   Mon, 8 Jun 2020 19:47:56 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] overflow.h: Add flex_array_size() helper
Message-ID: <20200609004756.GH10051@embeddedor>
References: <20200608221723.GA23644@embeddedor>
 <05ab102b936ce922c4fae67bf5dd3e323aff0b93.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05ab102b936ce922c4fae67bf5dd3e323aff0b93.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 03:34:52PM -0700, Joe Perches wrote:
> On Mon, 2020-06-08 at 17:17 -0500, Gustavo A. R. Silva wrote:
> > Add flex_array_size() helper for the calculation of the size, in bytes,
> > of a flexible array member contained within an enclosing structure.
> > 
> > Example of usage:
> > foo
> > struct something {
> > 	size_t count;
> > 	struct foo items[];
> > };
> > 
> > struct something *instance;
> []
> > diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> []
> > +/**
> > + * flex_array_size() - Calculate size of a flexible array member within
> > + * an enclosing structure.
> 
> These comment descriptions do not match
> 
> > + * Calculates size of memory needed for flexible array @member of @count
> > + * elements within structure @p.
> 
> The first comment shows the size of an array member.
> The second shows the size of an array member * count
> 
> Also the struct_size and flex_array_size definitions
> are using two different forms:
> 
> 		sizeof(*(p)->member) + __must_be_array((p)->member),\
> and
> 		sizeof((p)->member[0]) + __must_be_array((p)->member))
> 

Good catch.

Thanks
--
Gustavo
