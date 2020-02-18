Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E14EC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353812464E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582050930;
	bh=3BdkFnYPLhOhBdpCJtbJp9xRUqLuC+0bft4+KFYk3bE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Xj8rN7SvYzXbyhVuZ0xEe0TJwBvKEq4WEympuLaVTtKyr+rT7QPszSu8/36MzzRfM
	 bBU5HyuYk/N6IAWeyAOyC3TOULtn3pXQQZo/1aVmzMSQMTPOiO5qd4zI/nt7D9J+/d
	 ofKh1aalIbBO91kW+Al2IWXIJ/uXCxZwNy1cmOCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgBRSf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:35:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:57964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbgBRSf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:35:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8A5421D56;
        Tue, 18 Feb 2020 18:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582050928;
        bh=3BdkFnYPLhOhBdpCJtbJp9xRUqLuC+0bft4+KFYk3bE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WzqCoK+Ecqn06hqNFk0zCX+iF36AycyV9vA21tteU1RmExbfn6DQVALLxifEE6xKS
         kmwJSgcUm7/biv2NCNMbcwWYKSQUFDM14jWDPbFje9Pnycri6lRsCd8Lw9DkKUmz9d
         YJxOHL/o+PuAeE5EUIWLhvBCruAJjkZaPCjqiiB4=
Date:   Tue, 18 Feb 2020 19:35:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Sudarikov, Roman" <roman.sudarikov@linux.intel.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        bgregg@netflix.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        alexander.antonov@intel.com
Subject: Re: [PATCH v7 0/3] perf x86: Exposing IO stack to IO PMON mapping
 through sysfs
Message-ID: <20200218183526.GB2665507@kroah.com>
References: <20200214140159.9267-1-roman.sudarikov@linux.intel.com>
 <34ec945b-2456-7398-44c2-d523973e8e61@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34ec945b-2456-7398-44c2-d523973e8e61@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 05:35:36PM +0300, Sudarikov, Roman wrote:
> Hi Greg,
> 
> Could you please take a look at the patch set?

Could you please relax and wait?  You sent this less than 48 hours ago:

> On 14.02.2020 17:01, roman.sudarikov@linux.intel.com wrote:

For a subsystem that I am not the maintainer of, and for a totally
low-priority issue, for a feature that I don't have hardware to test it
for.

You now have moved to the back of my pending review queue:
	$ mdfrm -c ~/mail/todo/
	437 messages in /home/gregkh/mail/todo/

As you well know, Intel is already on my "short list of companies to
ignore patches from" as it is, so I am going to force the issue now and
REQUIRE you to follow the internally documented Intel rules on how to
send patches to Greg.  Hint, how you did it is _not_ how I have required
for it to happen.  No idea how this snuck through my filters, I need to
go fix that up...

greg k-h
