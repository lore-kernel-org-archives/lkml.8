Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A255C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 10:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72F9020768
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 10:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594980691;
	bh=gj8+8PFm/bqMCNQGJbLQD0cXNVjZl0TlXdUKqlLQi8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eBdbEXhUc2MyuOLIa+8kxOLHAt3uMNfu8U3PcJ8qCHQy0DS+xJmutflLAOok8Sd4S
	 Z0SiHi8xmAp+vfSzJdHgP7CiGNcibu7zuCul5Z723BHDiErr7nCTvcktsPyXpY73jV
	 4WyZJVxelzt1HWrvlxIATdvymeUgsFrGbJkS8xzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgGQKLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:11:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgGQKL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 06:11:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D698A20775;
        Fri, 17 Jul 2020 10:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594980689;
        bh=gj8+8PFm/bqMCNQGJbLQD0cXNVjZl0TlXdUKqlLQi8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bomO2fWDlIz3SCwC8oEf0pwPjYL9F6XH02mcGsy8ygfHXuEwMJ3MdeYySbPTjZYnv
         StE6SQSSd7YWZeLADnhZ5nixWcOyI2HGZ0md86ig3o1hPDTxmoUhGYID7yPX/IeCEX
         FokJkrPUK4N8UGVPI7/KFLuSKJqzOqyYDL014rsQ=
Date:   Fri, 17 Jul 2020 12:07:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     B K Karthik <bkkarthik@pesu.pes.edu>
Cc:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vlastimil Babka <vbabka@suse.cz>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Michel Lespinasse <walken@google.com>,
        Divyansh Kamboj <kambojdivyansh2000@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: comedi: comedi_fops.c: added casts to get
 rid of sparse warnings
Message-ID: <20200717100738.GB2553180@kroah.com>
References: <20200716152548.mzau4zhurwkzp5p6@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716152548.mzau4zhurwkzp5p6@pesu-pes-edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 11:25:48AM -0400, B K Karthik wrote:
> fixed sparse warnings by adding a cast in assignment from
> void [noderef] __user * to unsigned int __force *
> and a reverse cast in argument from
> unsigned int * to  unsigned int __user * .
> 
> v1 -> v2:
> - Add a reverse cast in argument
> v2 -> v3:
> - Change commit description as suggested by Ian Abott
> v3 -> v4:
> - Add versioning information in commit description

As Ian said, all of that goes below the --- line so it will not show up
in the changelog text.

As I don't want to hand-edit changelog text, as it does not scale, can
you please fix this up and resend as a v5?

thanks,

greg k-h
