Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F222DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0BA0206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594232743;
	bh=CtkLW3kxasoTq4awuFtg1p7oAJW5ekoW+rXmuHiBQr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cbIP4SKZlWVrs7IsJQT7jGhufyqdYb31fyVWZOLUix0xkHZyARI3fREQAFs/yY9iT
	 1YjD/rx4E7pOUPF3Kq6VqD8Ffs4b3S4deoJ2KOa/arEFyX8JLtzsKcPT6Cj+xvvdBV
	 5NUBvoNJ2KPIUKFCnggvL5ijfWXculUCCVx1hsHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgGHSZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:25:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:44290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgGHSZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 14:25:42 -0400
Received: from embeddedor (unknown [201.162.240.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C5AC206F6;
        Wed,  8 Jul 2020 18:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594232741;
        bh=CtkLW3kxasoTq4awuFtg1p7oAJW5ekoW+rXmuHiBQr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nSPMjHR8lApE/KcvGThsAawCWPVrWWpDw0d7DKyg76UHBmffc53pDrq9M3dv0kArC
         rJgQTHOO1mdm+FZfMsQZw/LnwkFiB7lOXpaVJu8Cd/6RBtpViylZPZhl7G2IXY3j5y
         /tGQnl69GP237sqImx9OtHs/iKw22JXepJpRZYQo=
Date:   Wed, 8 Jul 2020 13:31:10 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: Use fallthrough pseudo-keyword
Message-ID: <20200708183110.GH11533@embeddedor>
References: <20200707195747.GA4354@embeddedor>
 <20200708125830.GO3453@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708125830.GO3453@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 02:58:30PM +0200, Johan Hovold wrote:
> On Tue, Jul 07, 2020 at 02:57:47PM -0500, Gustavo A. R. Silva wrote:
> > Replace the existing /* fall through */ comments and its variants with
> > the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
> > fall-through markings when it is the case.
> > 
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Applied, thanks.
> 

Thanks, Johan.

--
Gustavo
