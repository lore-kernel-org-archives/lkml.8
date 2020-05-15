Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7B6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE422207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589553092;
	bh=gP5XrtDkVl36YBcKpqfVXj78ZD+cOJsJiWhfi2AHj98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Bv4Q2RB7vJ8yRWqu0FbyoMFjrE+qqxYqV4UMFFKodbALUSex4zBf/YFsVpYKCE2uF
	 EpYFiodzd44nttUVKtcyBimIJqKrbhRgVZI506myCGSzU0VAvt0g6q/02tMn3HJ0r9
	 9QHZvUsFuhxbEvVodK8ez7p7jefR3r9FxptvnPiY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgEOObb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 10:31:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbgEOOba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 10:31:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A55C62076A;
        Fri, 15 May 2020 14:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589553090;
        bh=gP5XrtDkVl36YBcKpqfVXj78ZD+cOJsJiWhfi2AHj98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N9w3WDcd0+kTfyt+i5AOGsdrFL9qbj5cfCEyRgIo1NnDqSyI46zksTFz0bKumwnXX
         az2XfJ/Pl7vESoIk9NVb35CS4IsK1GQaYIwSujZpymMyx2DO8TZNNEBCIQx0QbsyBi
         dUbJ8jJUjNA/wvCgx23tUvbZKidJjxcHv9P/CXug=
Date:   Fri, 15 May 2020 16:31:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Siddharth Chandrasekaran <siddharth@embedjournal.com>,
        Siddharth Chandrasekaran <csiddharth@vmware.com>,
        srostedt@vmware.com, linux-kernel@vger.kernel.org,
        stable@kernel.org, srivatsab@vmware.com, dchinner@redhat.com,
        darrick.wong@oracle.com
Subject: Re: [PATCH] Backport security fixe to 4.9 and 4.4 stable trees
Message-ID: <20200515143127.GA2464197@kroah.com>
References: <cover.1589486724.git.csiddharth@vmware.com>
 <20200515124945.GA93755@csiddharth-a01.vmware.com>
 <20200515125701.GA1934886@kroah.com>
 <20200515132943.GA97579@csiddharth-a01.vmware.com>
 <20200515134009.GB2046686@kroah.com>
 <20200515095216.79fccd40@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515095216.79fccd40@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 09:52:16AM -0400, Steven Rostedt wrote:
> On Fri, 15 May 2020 15:40:09 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > > 
> > >   "[PATCH v2] Backport xfs security fix to 4.9 and 4.4 stable trees"  
> > 
> > Sorry, I see no such email in my staging patch queue.
> > 
> > Do you have a link to the series on lore.kernel.org?  lkml.org is a mess
> > and not under our control.
> 
> That's because it Cc'd stable@kernel.org and not stable@vger.kernel.org.
> 
> Should Siddharth resend?

Yes, stable@kernel.org is a direct path to /dev/null on the kernel.org
mail server.

thanks,

greg k-h
