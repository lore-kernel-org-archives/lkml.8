Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCC8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75459207D4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593708740;
	bh=1Dc4a88o2pgoyERwCLj8WwiC1rEHywYQ+2ewNscYFH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WGCNyvxu/YuFPnvrRxxoZiYlDAZSfUciihDKleCUA+sg0JTx756AZ4lEap9DGffy/
	 OvQS0XhghZFnprmneRo1tX1oVxbhbDa9nQ/1ZnZDln4jVmYUDrFRiVd5Kq/vLUYw07
	 p8vcgyzvNpVx5f/IbAGApU2exs/e/DIzAhEqe81o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgGBQwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 12:52:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbgGBQwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:52:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAA7A20780;
        Thu,  2 Jul 2020 16:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593708738;
        bh=1Dc4a88o2pgoyERwCLj8WwiC1rEHywYQ+2ewNscYFH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zkPRoev13M9+q3yl0+fzuz1JWfpkTl3Yuma+DodmWnvoWpqRPd7xs4FgANUaeikIv
         kaCXZw78sf7qQP53iD3KFOycXvRROFTJWRoeiuWW8zEi+B0BUvqytDW+KBVee++V4I
         Vud/owNgOair3sQg+lTF3yGTpupEPJsdxVoSGEVA=
Date:   Thu, 2 Jul 2020 18:52:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        John Warthog9 Hawley <warthog9@kernel.org>
Subject: Re: [for-next][PATCH 8/8] ktest.pl: Add MAIL_MAX_SIZE to limit the
 amount of log emailed
Message-ID: <20200702165221.GB2147773@kroah.com>
References: <20200701231717.757834010@goodmis.org>
 <20200701231756.790637968@goodmis.org>
 <20200702074103.GA1076415@kroah.com>
 <20200702081949.2bfd2417@oasis.local.home>
 <20200702123402.GA1773770@kroah.com>
 <20200702085849.16999b39@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702085849.16999b39@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 08:58:49AM -0400, Steven Rostedt wrote:
> On Thu, 2 Jul 2020 14:34:02 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > > I can add an option to do that if you want. My full logs end up being a
> > > few hundred megabytes. Perhaps I could add a compress option too.  
> > 
> > It's fine, the default should be good enough for me for now.  If not,
> > I'll just bump the value, or add compression.
> 
> If we compress, it would need to be an attachment. I'm guessing you are
> fine with that. Do you already make it an attachment?

Yes I do, so attachments are fine.

thanks,

greg k-h
