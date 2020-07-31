Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77483C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 14:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FDCB2177B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 14:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WqzSmsye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbgGaOgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 10:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728961AbgGaOgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 10:36:06 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66615C061756
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 07:36:06 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e5so9033267qth.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 07:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q2m6QpaxCYFHVPlZEL2+5vv7eGY3gqCOfKrXEclIKvs=;
        b=WqzSmsye5HX9Zz23lh8/+PVQcQMOQwg6Hy3llCpDM+deJ1FPxUx1i/9hg4A/nFiiLh
         FPIcAFcl9UMuh8abfDQQmHlrrCDn5pI0jGNii4rCGD+4SP+XNUHvmZJX9NjktFx5A9ho
         j6VHCU0Mz/mF16KABA66xrQkGGmWxITe9pIPciK5xwmRNc8cD1sDYuDFld4lJZQb7OAq
         Nu2ps7V47GIjqIzBWXdsqTqMRjlgqqRypzT8WtpzLI+xleTXxtPXTQ0lqYp3/aWUZxmz
         FoNU8CwcQ3eeFVpmh2AUqS7tdwFM9jBWAHbT2vXrnJR+grWPZgSWfOeMhRWj0jHLpfv8
         K5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q2m6QpaxCYFHVPlZEL2+5vv7eGY3gqCOfKrXEclIKvs=;
        b=VDLNN3qvSQR/S1cjnrFuKiUpNxPj4qKy/usZGUU4M76nHLaJhLIm5uMEkHtNTiVF5Z
         T7yfhPYLTGGlhjytOtclhPIZSKbkfm/91B2/47EB3cQIYB4hDeAMHNN/RJjjSvvJBxnQ
         Y96htFhyB7fuMnfIJdMGrmL6YPg0SUJalPcHJxn5PXDtW93aK/MXYZuWFQd6k99R6T3q
         lJqklX8LQ5ToWLU2j/CK5YkH46/tyMfwvLsVPMbFXOh7qHm0PFHD58lwuWvbB0a2UZ5c
         ObWyBo6sAvlDJpP9oPFsblnsqefplyB2KBawQ0d0USEBYGgf24wLt/4980RpPbv+YJl3
         ofsA==
X-Gm-Message-State: AOAM531S2hxh6raz6VO4qRzaFpN8gh6oLP+Y5hcXqbMDTZVA2+SW+ODE
        Z0HHTRH6DCnJfvs/2+vDtEDXdA==
X-Google-Smtp-Source: ABdhPJxEL/OfhyQEkNLYkey/a7yMnab6C8+sylRgEPWKF2YcNOLc+iOfeiEiufgz9Qt5u9olATqJ4A==
X-Received: by 2002:ac8:7b85:: with SMTP id p5mr3994935qtu.196.1596206165402;
        Fri, 31 Jul 2020 07:36:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id q4sm7988142qkm.78.2020.07.31.07.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 07:36:04 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1k1W8i-001uoa-2Q; Fri, 31 Jul 2020 11:36:04 -0300
Date:   Fri, 31 Jul 2020 11:36:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH net] rds: Prevent kernel-infoleak
 in rds_notify_queue_get()
Message-ID: <20200731143604.GF24045@ziepe.ca>
References: <20200730192026.110246-1-yepeilin.cs@gmail.com>
 <20200731045301.GI75549@unreal>
 <20200731053306.GA466103@kroah.com>
 <20200731053333.GB466103@kroah.com>
 <20200731140452.GE24045@ziepe.ca>
 <20200731142148.GA1718799@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731142148.GA1718799@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 04:21:48PM +0200, Greg Kroah-Hartman wrote:

> > The spec was updated in C11 to require zero'ing padding when doing
> > partial initialization of aggregates (eg = {})
> > 
> > """if it is an aggregate, every member is initialized (recursively)
> > according to these rules, and any padding is initialized to zero
> > bits;"""
> 
> But then why does the compilers not do this?

Do you have an example?

> > Considering we have thousands of aggregate initializers it
> > seems likely to me Linux also requires a compiler with this C11
> > behavior to operate correctly.
> 
> Note that this is not an "operate correctly" thing, it is a "zero out
> stale data in structure paddings so that data will not leak to
> userspace" thing.

Yes, not being insecure is "operate correctly", IMHO :)
 
> > Does this patch actually fix anything? My compiler generates identical
> > assembly code in either case.
> 
> What compiler version?

I tried clang 10 and gcc 9.3 for x86-64.

#include <string.h>

void test(void *out)
{
	struct rds_rdma_notify {
		unsigned long user_token;
		unsigned int status;
	} foo = {};
	memcpy(out, &foo, sizeof(foo));
}

$ gcc -mno-sse2 -O2 -Wall -std=c99 t.c -S

test:
	endbr64
	movq	$0, (%rdi)
	movq	$0, 8(%rdi)
	ret

Just did this same test with gcc 4.4 and it also gave the same output..

Made it more complex with this:

	struct rds_rdma_notify {
		unsigned long user_token;
		unsigned char status;
		unsigned long user_token1;
		unsigned char status1;
		unsigned long user_token2;
		unsigned char status2;
		unsigned long user_token3;
		unsigned char status3;
		unsigned long user_token4;
		unsigned char status4;
	} foo;

And still got the same assembly vs memset on gcc 4.4.

I tried for a bit and didn't find a way to get even old gcc 4.4 to not
initialize the holes.

Jason
