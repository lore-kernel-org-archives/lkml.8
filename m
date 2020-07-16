Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929D7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5634720771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594888097;
	bh=YxhuErSY7hPG2bLUcjeLPf4DC8nPtwGliFlH7qYFgE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c9rZAM4XYqN19oUUwyGBJaG06V2I6hgKmg4YLjQZH0WTD3zGg24idq+m2O6Ay/o5J
	 xsIE83No2PKbl881DAKwakzTzRW+OdyQMRkB43/fAOe42mUaEqqT1KLl4m+uoZ2kjY
	 N3w31eWqQVUnLZ9ez3vv+57uKdekY+YIew2/KMl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgGPI2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 04:28:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgGPI2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:28:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 078A1206C1;
        Thu, 16 Jul 2020 08:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594888094;
        bh=YxhuErSY7hPG2bLUcjeLPf4DC8nPtwGliFlH7qYFgE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=usUJcDVAnfoiPDOUZ3Y0lsNOYcuHOLb/qrRM8Ki2nPnm7ly2zpnq+VhR3zCR31stt
         jPzP0GpVtGJdlkiWkvoAqXruT5XunyplMIjmeT/nfH3Qo9iGFTcHRIEwSh4TA7qafK
         DfxsSItvd91a7sGGykgFN4V5nRww4fO4kY0lL8FY=
Date:   Thu, 16 Jul 2020 10:28:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        rafael.j.wysocki@intel.com, sakari.ailus@linux.intel.com,
        heikki.krogerus@linux.intel.com
Subject: Re: kernel oops in 'typec_ucsi' due to commit 'drivers property:
 When no children in primary, try secondary'
Message-ID: <20200716082807.GA1335446@kroah.com>
References: <7affdd923186c5ce8c7dcf7cbe7b826eaa3ac8b2.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7affdd923186c5ce8c7dcf7cbe7b826eaa3ac8b2.camel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 11:17:03AM +0300, Maxim Levitsky wrote:
> Hi!
> 
> Few days ago I bisected a regression on 5.8 kernel:
> 
> I have nvidia rtx 2070s and its USB type C port driver (which is open source)

Is that driver merged into the tree?  If not, do you have a pointer to
it somewhere?

thanks,

greg k-h
