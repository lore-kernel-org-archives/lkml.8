Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CBDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1336820829
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589788087;
	bh=B8BZX1tEa8YFlmLQI8RzC6u6+knqEquuZ1Wxf4akJ5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FftGmmqdtP60GRztsVmPjLQcbBo0Gvy2Rw8MXqg7uR2rReRaGGxpVUr3THONrLGkw
	 tG1bmNkfNViG5Yv2Zt0gmUJyfQFlWNcn2rS8ZqAjAjvciNuq/u587daUOylX91vHwB
	 xsJ+Dp55jezBlFlHKe/a6OiPVvvs9iqeD2isnX08=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgERHsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 03:48:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgERHsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 03:48:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0076A20825;
        Mon, 18 May 2020 07:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589788085;
        bh=B8BZX1tEa8YFlmLQI8RzC6u6+knqEquuZ1Wxf4akJ5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aXNt7F9MPKx+9varfW/wXddmdWJT70EBEbOPdVzPiqIF619UoaR6Hp3G/bIqv6IJV
         gawia3MBS58OU1kldkeoPy5E9vyw9yE82VP1BUq+g6IlgkYiDoer6sC1KJRiNirycA
         /hSZ/wxnHX1jG5DpgSPDaJXKZhXTB/yk7+OmHKs0=
Date:   Mon, 18 May 2020 09:48:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 1/3] tty: n_gsm: Improve debug output
Message-ID: <20200518074803.GA3095136@kroah.com>
References: <20200512115323.1447922-1-gregory.clement@bootlin.com>
 <20200512115323.1447922-2-gregory.clement@bootlin.com>
 <f957eb74-cdbe-848f-b345-7c9fb3d7b1e6@suse.com>
 <87tv0dg0ii.fsf@FE-laptop>
 <20200518073829.GA3055513@kroah.com>
 <87o8qlg00b.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8qlg00b.fsf@FE-laptop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 09:44:52AM +0200, Gregory CLEMENT wrote:
> Hello Greg,
> 
> > On Mon, May 18, 2020 at 09:33:57AM +0200, Gregory CLEMENT wrote:
> >> Hello Jiri,
> >> 
> >> > On 12. 05. 20, 13:53, Gregory CLEMENT wrote:
> >> >> Use appropriate print helpers for debug messages.
> >> >> 
> >> >> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> >> >> ---
> >> >>  drivers/tty/n_gsm.c | 14 ++------------
> >> >>  1 file changed, 2 insertions(+), 12 deletions(-)
> >> >> 
> >> >> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> >> >> index d77ed82a4840..67c8f8173023 100644
> >> >> --- a/drivers/tty/n_gsm.c
> >> >> +++ b/drivers/tty/n_gsm.c
> >> >> @@ -504,18 +504,8 @@ static void gsm_print_packet(const char *hdr, int addr, int cr,
> >> >>  	else
> >> >>  		pr_cont("(F)");
> >> >>  
> >> >> -	if (dlen) {
> >> >> -		int ct = 0;
> >> >> -		while (dlen--) {
> >> >> -			if (ct % 8 == 0) {
> >> >> -				pr_cont("\n");
> >> >> -				pr_debug("    ");
> >> >> -			}
> >> >> -			pr_cont("%02X ", *data++);
> >> >> -			ct++;
> >> >> -		}
> >> >> -	}
> >> >> -	pr_cont("\n");
> >> >> +	if (dlen)
> >> >
> >> > This test is superfluous. print_hex_dump_* won't write anything when
> >> > zero length is passed to it.
> >> 
> >> As I will send a v3 due to the issue found on the last patch, I am also
> >> going to fix this.
> >
> > Ugh, as I already applied this series, should I just revert them all, or
> > are you going to send fix-ups on top of what I have applied instead?
> 
> I was about to send a new series, but I can just send fix-ups. It's up
> to you.

fix-ups are less work for me :)
