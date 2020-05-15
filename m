Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC82C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F3B2206D4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589550014;
	bh=YlRqbizbDUDTopYguDtmZlRZK5uhZ+T9IBMGLE6FFG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qwNGGTZq4FoUHl6OMziU0/SYVRsBXgP2XlhuepAppPPAnM46pyUuFmUOOd4VW9zU3
	 yaZFLAOtApQFV54bUfWlZsAnevEQeogIS5N/K4BtQRhjrhZ3fcjh/i4kHhiANXUyWX
	 t8go9rQrdCMW0LrCt5Gr/f3UGX/GMmykGS35PFzw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgEONkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgEONkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:40:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 846D920657;
        Fri, 15 May 2020 13:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589550013;
        bh=YlRqbizbDUDTopYguDtmZlRZK5uhZ+T9IBMGLE6FFG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KlUTF3UXugwuu3yKgH5TogMJAH/ih9w9swdWI23cKog/YdmcgNajgD7JQaQOium79
         l1gyIMRH4I8nZE4z0NYoN5mNnYdgPtdw7fU0jeawQonOADvzEBLdg0bl+1UgFBRGHt
         rvVgOe5sIfH/xtaIB0HisqTEzyT2babOWbHuQPFU=
Date:   Fri, 15 May 2020 15:40:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Siddharth Chandrasekaran <siddharth@embedjournal.com>
Cc:     Siddharth Chandrasekaran <csiddharth@vmware.com>,
        srostedt@vmware.com, linux-kernel@vger.kernel.org,
        stable@kernel.org, srivatsab@vmware.com, dchinner@redhat.com,
        darrick.wong@oracle.com
Subject: Re: [PATCH] Backport security fixe to 4.9 and 4.4 stable trees
Message-ID: <20200515134009.GB2046686@kroah.com>
References: <cover.1589486724.git.csiddharth@vmware.com>
 <20200515124945.GA93755@csiddharth-a01.vmware.com>
 <20200515125701.GA1934886@kroah.com>
 <20200515132943.GA97579@csiddharth-a01.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515132943.GA97579@csiddharth-a01.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 06:59:43PM +0530, Siddharth Chandrasekaran wrote:
> On Fri, May 15, 2020 at 02:57:01PM +0200, Greg KH wrote:
> > On Fri, May 15, 2020 at 06:19:45PM +0530, Siddharth Chandrasekaran wrote:
> > > Please ignore this patch set, I accidentally added another patch I was
> > > working on. Will send v2 with the right patches.
> > 
> > What patch set?  I see nothing in this email, so I have no idea what you
> > are referring to :(
> 
> Apologies! Looks like my email thread was broken. I was referring to
> the thread here: https://lkml.org/lkml/2020/5/14/1326 with subject:
>   
>   "[PATCH] Backport security fixe to 4.9 and 4.4 stable trees"
> 
> The corrected version (v2) of this patch should have reached you
> (hopefully) with the subject:
> 
>   "[PATCH v2] Backport xfs security fix to 4.9 and 4.4 stable trees"

Sorry, I see no such email in my staging patch queue.

Do you have a link to the series on lore.kernel.org?  lkml.org is a mess
and not under our control.

greg k-h
