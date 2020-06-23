Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3817C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C422520723
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943695;
	bh=x6UTuA/WddaRqfwQKiLLn/GM/jW6mmC2cZEISdCLu6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=LzDxvrtcQoryA7+fV7xh9zEu3uLDIcJFMROT8Vsqr3H3DtO4G3feIdhuI+OiK4UBd
	 9CAIAHgCrKVWkYdZSqTW1MqTeCiB0Rz2aaRnK25Of5iPcS67KBuYq+RO0uzByJFyTb
	 QbodW1yErH3NOJmqEP3N0cj9g9sUWym3G2nNqgn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390053AbgFWUVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:21:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389698AbgFWUVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:21:20 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CB0E2080C;
        Tue, 23 Jun 2020 20:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943680;
        bh=x6UTuA/WddaRqfwQKiLLn/GM/jW6mmC2cZEISdCLu6o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HJWjyWXXM2pXhg0fQgG1kvauHo2jnKjUuz/KIrZIgMdeLKCahLAEEA+e/z2wO9gJQ
         4krWUBHL8+ZWLgUfE1JgIACwlTnhNNwRPQtia9KaCJUTEepM81uEP1wCdlpqiCk2MO
         /0lGWSy2kzy2crAsWxFRkpogn/lclXNSnwitIR+c=
Date:   Tue, 23 Jun 2020 13:21:19 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ronald =?UTF-8?B?VHNjaGFsw6Ry?= <ronald@innovation.ch>,
        Nicolai Stange <nicstange@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: debugfs_create_u32_array() memory leaks
Message-ID: <20200623132119.5c4f2041@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200622193109.GA2163148@kroah.com>
References: <20200619161734.25e99fa4@kicinski-fedora-PC1C0HJN>
        <20200620074542.GA2298609@kroah.com>
        <20200622122332.274c842e@kicinski-fedora-PC1C0HJN>
        <20200622193109.GA2163148@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jun 2020 21:31:09 +0200 Greg Kroah-Hartman wrote:
> > Ah, I wasn't sure how to fix but since you say that create functions
> > shouldn't allocate memory seems like the fix will be to make callers
> > pass an equivalent of struct debugfs_blob_wrapper for u32.  
> 
> Sounds good.
> 
> > I'm happy to send a patch to that effect - I have a process question
> > tho - I need this change in net-next, should I sent the patch to you?
> > Can it still make it into 5.8 (debugfs -> Linus -> net -> net-next) or
> > perhaps can it go via net-next since there is no de facto bug in 5.8?  
> 
> I can take a fix now, and get it into 5.8 if that makes things easier
> for you.

Having thought about it - since I'm changing the prototype I'd have to
wait with my networking changes for the patch to land in net-next.

So I'll just send the debugfs fix with my other code to DaveM and CC
appropriately..
