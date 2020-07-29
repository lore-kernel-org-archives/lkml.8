Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DEAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 05:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7797F2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 05:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596001607;
	bh=pePAJ4Ia9ZHBwn/lH6/j1CE/q64jj5R/LOQFr37raXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=voP+ef/oKQbE4X/ahm9/mNDDR9cII0Dl6iB1ifjHiGRowAKf6y97EzzJCRBHXOj1p
	 70uv0fZRczlPJV2cZ9OniQmoTfHmPsLhnwTvWsu9Rl1fxh8MRhgdpvfBfnuN5sIwsM
	 lgWb2E6gt5oW60913UcvdngY2by8N6bLC1jBZx4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgG2Fqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 01:46:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgG2Fqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 01:46:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E05042076E;
        Wed, 29 Jul 2020 05:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596001605;
        bh=pePAJ4Ia9ZHBwn/lH6/j1CE/q64jj5R/LOQFr37raXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r7OIaT4YSgbGCT8Sm9BK18kqONhv+6wxyKCKzRm4k8T1jE+ejTGXOA/TITV+pVVjX
         T+hfrA3ErOUDIuv1McMGwSesdssOW+zzdhwNrBApfwlbOXlz/Q2c7XgQlI3uDengld
         mBWgJm7Na/CIqeJG8HHu4JOFzO3RXh7hWbBjpj5I=
Date:   Wed, 29 Jul 2020 07:46:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dhiraj Sharma <dhiraj.sharma0024@gmail.com>
Cc:     manishc@marvell.com, devel@driverdev.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: qlge: qlge_dbg: removed comment repition
Message-ID: <20200729054637.GA437093@kroah.com>
References: <20200728182610.2538-1-dhiraj.sharma0024@gmail.com>
 <CAPRy4h2Kzqj449PYPjPFmd7neKLR4TTZY8wq51AWqDrTFEFGJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPRy4h2Kzqj449PYPjPFmd7neKLR4TTZY8wq51AWqDrTFEFGJA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Wed, Jul 29, 2020 at 11:06:56AM +0530, Dhiraj Sharma wrote:
> Hello,

<snip>

It has been less than 24 hours for a simple comment cleanup patch.
Please give maintainers time, they deal with thousands of patches a
week.

Usually, if after 2 weeks, you have not gotten a response, you can
resend it.

>  I know that I should ask for reviews etc after a week but the change
> is for my eudyptula task and until it doesn't get merged little
> penguin will not pass the task for me so please look at it.

If you knew that you should wait for at least a week, and yet you did
not, that implies that you somehow feel this comment cleanup patch is
more important than everyone else, which is a bit rude, don't you think?

There are no such things as deadlines when it comes to upstream kernel
development, sorry.

greg k-h
