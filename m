Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21094C4724C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 23:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2CD620CC7
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 23:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588892401;
	bh=preWQqOp8Pc/BQDK/HCdOhJQwQn4MK7nty1kqAPm9tU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MsUIz2d6BX76VeU4/ubd5uB6qKWWkvZRdisXMtuIyPcbJWFelk0TRwq4ZYkdvo/GX
	 G3WvYIuol0KncdID1+T96RWxY7lLCdOk5/VuG0/y4qLFur18XxzffBMdplq0GryFa1
	 zf2yWOiYz8LROmd9N6GW6//vrZF7RXIbAOx/32vU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgEGXAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 19:00:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgEGW77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 18:59:59 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23ED3208D6;
        Thu,  7 May 2020 22:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588892399;
        bh=preWQqOp8Pc/BQDK/HCdOhJQwQn4MK7nty1kqAPm9tU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t55/I/+/iE+EQgrlSGQQr0+atvBKNAl4fmwb1o42u7jZn42+O8OpABbPyrbIP6WtH
         Mr6vU/bRtpUpltPkiPsLraTCN8keUWkWQdrisBRzA53yaG45XjcYEzTbUayr7ygoEw
         5vi/rBn3e0iYEV4YwhZN6iipPDMvQ+iQclYxWUfE=
Date:   Thu, 7 May 2020 18:04:26 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/testing: Replace zero-length array with
 flexible-array
Message-ID: <20200507230426.GA23186@embeddedor>
References: <20200507185608.GA14779@embeddedor>
 <94b19470-9ade-5fcc-00c7-324056d049de@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94b19470-9ade-5fcc-00c7-324056d049de@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 01:04:14PM -0600, Shuah Khan wrote:
> > 
> > diff --git a/tools/testing/selftests/nsfs/pidns.c b/tools/testing/selftests/nsfs/pidns.c
> > index e0d86e1668c0..e3c772c6a7c7 100644
> > --- a/tools/testing/selftests/nsfs/pidns.c
> > +++ b/tools/testing/selftests/nsfs/pidns.c
> > @@ -27,7 +27,7 @@
> >   #define __stack_aligned__	__attribute__((aligned(16)))
> >   struct cr_clone_arg {
> >   	char stack[128] __stack_aligned__;
> > -	char stack_ptr[0];
> > +	char stack_ptr[];
> >   };
> >   static int child(void *args)
> > 
> 
> Thanks for the patch. I will pull this in for 5.7-rc6
> 

Thanks, Shuah.

--
Gustavo

