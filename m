Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52578C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 12:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BD1A21527
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 12:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592569477;
	bh=NgZT449b3Tjszh2iaHpBq2sm55Q1GXGCww56Rd+tq8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ov8v6dZpIwtDa9AYbr90a+50zwddUsOFdZmRe5tM4hmD+KsaQSZN5WAZUqEhubvtC
	 7qw7kG4cPKMjIEL8iGYWkUt9ppxtEmqJEPGaexvMBLmLlPubyZ1iLM1nqNgAiZ9Kdg
	 Q0QNxLBZaKLULILHf9xbz5GgikcKRRfuyzdZqAnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732976AbgFSMYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 08:24:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732956AbgFSMYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 08:24:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 263B221527;
        Fri, 19 Jun 2020 12:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592569472;
        bh=NgZT449b3Tjszh2iaHpBq2sm55Q1GXGCww56Rd+tq8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A2tLbrRnfrG2lBiMrFuGqr8q4JuYAt4dq3a0/8s3di6IUQUw89cE5f+TWcf05iinu
         frmvCXo96EpsesXRBmrdyd4rYtifuXy559caYiI3jB1kXWuPVkVo9Qlk485n6uQj4V
         FxI+ABSadn3Pq/zmThEJA71fMazuCuFk29hJyD9Q=
Date:   Fri, 19 Jun 2020 14:24:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Richard Dodd <richard.o.dodd@gmail.com>,
        Jonathan Cox <jonathan@jdcox.net>,
        =?iso-8859-1?Q?Thi=E9baud?= Weksteen <tweek@google.com>,
        Nishad Kamdar <nishadkamdar@gmail.com>
Subject: Re: [PATCH 1/8] USB: rename USB quirk to USB_QUIRK_ENDPOINT_IGNORE
Message-ID: <20200619122429.GA1037991@kroah.com>
References: <20200618094300.1887727-1-gregkh@linuxfoundation.org>
 <20200618094300.1887727-2-gregkh@linuxfoundation.org>
 <484c84b62140f6536f841e7027ddd9ddcf179a72.camel@hadess.net>
 <62b8ddc4-8d26-1160-6934-fe6a68231938@redhat.com>
 <f57cd2a9a27fb148f0bdfd0ad5e92b4d01ca77c6.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f57cd2a9a27fb148f0bdfd0ad5e92b4d01ca77c6.camel@hadess.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 01:08:53PM +0200, Bastien Nocera wrote:
> On Fri, 2020-06-19 at 12:53 +0200, Hans de Goede wrote:
> > A note for future reference, not sure what you mean with driver
> > 
> > API here. If you mean the in kernel API, the kernel rules are
> > 
> > that we are always free to change that (Linux does not have a
> > 
> > stable driver API).
> > 
> > 
> > 
> > So if a header does not sit under include/uapi (indicating that
> > 
> > it is an userspace API) then a change like this is fine.
> 
> I meant the internal driver API, which might break out-of-tree drivers.

There is no such thing.  Well, there might be, but we don't care and
have to act as if there are no such thing otherwise we would never be
able to change anything :)

> I know that this API is fluid, and that there are no stability
> guarantees, but I'd still expect at least a note in the commit message
> to that effect.

Why?  Who cares?  Anyone who lives outside of the kernel already knows
they have to dig in the kernel if their code breaks, that's the cost of
living outside of the kernel.

thanks,

greg k-h
