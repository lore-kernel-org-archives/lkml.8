Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23C7C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791CA2168B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581599047;
	bh=JzuXVZMjhJuQSJ5hGh5JfZlVw6AYi3gKS44RcKZi8yI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KXgTvGYZOn6NYdlWmCDwaGN7ya6LM1xxVFi+jhtVlTmRni6Lzj+Zh5DT0Xb7laN15
	 EdKtQddsFWfZ3A4vac1CNJ359pqvosTEfqjKM1b6C78M8WAC2znZZw1ryAwnWR4Imu
	 I84LB1Zmt6Uj2NXtmiflEN9PiFuyb27841bpl1Ek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbgBMNEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:04:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:49778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729801AbgBMNEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:04:06 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F6DB2168B;
        Thu, 13 Feb 2020 13:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581599044;
        bh=JzuXVZMjhJuQSJ5hGh5JfZlVw6AYi3gKS44RcKZi8yI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rKcZlkdb1MfHMvC/XJXfgmNFUkssnjWs2ADRkmHXZ9mvIr//KwkdCC50/Ltj/M0PG
         I0m89eojS5KcAIjAWPsFPJfX/rRcXDDOHLTe7buofpKbFgASMcaiXNIkdsCwflkNtZ
         VEBeoqqUxZD/8RNhH9Bp8nCx7FJv1ZIdiVzuNRLU=
Date:   Thu, 13 Feb 2020 05:04:04 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Colin King <colin.king@canonical.com>, linux-usb@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: remove redundant assignment to
 variable num
Message-ID: <20200213130404.GA3369961@kroah.com>
References: <20200208165022.30429-1-colin.king@canonical.com>
 <20200213113423.GK1498@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213113423.GK1498@kuha.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 01:34:23PM +0200, Heikki Krogerus wrote:
> On Sat, Feb 08, 2020 at 04:50:22PM +0000, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > Variable num is being assigned with a value that is never read, it is
> > assigned a new value later in a for-loop. The assignment is redundant
> > and can be removed.
> > 
> > Addresses-Coverity: ("Unused value")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/usb/typec/ucsi/ucsi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> > index d5a6aac86327..b1b72cb7af10 100644
> > --- a/drivers/usb/typec/ucsi/ucsi.c
> > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > @@ -400,7 +400,7 @@ static int ucsi_register_altmodes(struct ucsi_connector *con, u8 recipient)
> >  	struct typec_altmode_desc desc;
> >  	struct ucsi_altmode alt[2];
> >  	u64 command;
> > -	int num = 1;
> > +	int num;
> >  	int ret;
> >  	int len;
> >  	int j;
> 
> Greg! I'll pick this, and to you with a few other patches that I have
> in my queue for the ucsi driver. I hope that's OK.

Thats fine.
