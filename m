Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6913CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 05:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F6E5221E5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 05:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596865509;
	bh=A3HzZFYqgjH52azA3Qx3vH1BMJlp4qELJhyhFaQEuJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lN/UGT0L2KJPvbhvpjCxB0/vusMThvauz0aqsGR+pQ5UjfAPquGJDzHyywdmSSl6x
	 4ocANkwXugbI+wRx9iNV63N1UfAoDww894ns/MVcEoLoNPe25vn5X0boZWWlqGdx6F
	 kUCZSLVl9JT/axbCJGXlC9Gvm9rkvGLBlZt6MU8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgHHFpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 01:45:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbgHHFpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 01:45:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 672DF2177B;
        Sat,  8 Aug 2020 05:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596865507;
        bh=A3HzZFYqgjH52azA3Qx3vH1BMJlp4qELJhyhFaQEuJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WbXFGB1tTYMahSa3GxVVjpnLnbAVER98ZqskFruFs8rsn7cohv0dNwmYwNMM3azBj
         9Uh18P2sgXi24Xg89o/swb3Gd5lyBU4G3P7TdSlJ7kVAL5jsQkNqIgxpB6P8ijSzdw
         afULkJcKHPxOkaoSkfAsjN5/cHf59ELpyt0ezBoQ=
Date:   Sat, 8 Aug 2020 07:45:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Adams <jwadams@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [RFC PATCH 3/7] core/metricfs: metric for kernel warnings
Message-ID: <20200808054504.GD1037591@kroah.com>
References: <20200807212916.2883031-1-jwadams@google.com>
 <20200807212916.2883031-4-jwadams@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807212916.2883031-4-jwadams@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 02:29:12PM -0700, Jonathan Adams wrote:
> Count kernel warnings by function name of the caller.
> 
> Each time WARN() is called, which includes WARN_ON(), increment a counter
> in a 256-entry hash table. The table key is the entry point of the calling
> function, which is found using kallsyms.

Why is this needed?

As systems seem to like to reboot when WARN() is called, will this only
ever show 1?  :)

> 
> We store the name of the function in the table (because it may be a
> module address); reporting the metric just walks the table and prints
> the values.
> 
> The "warnings" metric is cumulative.

If you are creating specific files in a specific location that people
can rely on, shouldn't they show up in Documentation/ABI/ as well?

But again, is this feature something that anyone really needs/wants?
What can the number of warnings show you?

thanks,

greg k-h
