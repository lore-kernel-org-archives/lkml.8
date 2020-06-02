Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C48C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07D0E206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgFBLxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 07:53:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51186 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBLxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:53:43 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id CFCB12A3182;
        Tue,  2 Jun 2020 12:53:41 +0100 (BST)
Date:   Tue, 2 Jun 2020 13:53:38 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Bean Huo <huobean@gmail.com>
Cc:     miquel.raynal@bootlin.com, vigneshr@ti.com, s.hauer@pengutronix.de,
        derosier@gmail.com, Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Subject: Re: [PATCH v6 0/5] Micron SLC NAND filling block
Message-ID: <20200602135338.7b66f395@collabora.com>
In-Reply-To: <aabedbd547708a52b8bf8e0d10ba10e994acb54f.camel@gmail.com>
References: <20200525121814.31934-1-huobean@gmail.com>
        <829d76189beff5a50ddc56123d22bff3aa6a3378.camel@gmail.com>
        <0a4fc94213ca5c2040796a66942f626587483721.camel@gmail.com>
        <20200602094825.26396b06@collabora.com>
        <aabedbd547708a52b8bf8e0d10ba10e994acb54f.camel@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Jun 2020 10:59:46 +0200
Bean Huo <huobean@gmail.com> wrote:

> On Tue, 2020-06-02 at 09:48 +0200, Boris Brezillon wrote:
> > Hi Bean,
> > 
> > On Mon, 01 Jun 2020 23:10:43 +0200
> > Bean Huo <huobean@gmail.com> wrote:
> >   
> > > Hi Richard 
> > > would you please help us confirm below question??  
> > 
> > Miquel suggested an approach that would allow us to deal with both
> > JFFS2
> > and UBI/UBIFS without having any FS/wear-leveling specific code at
> > the
> > NAND level, but you decided to ignore his comments. Sorry but there's
> > nothing we can do to help you if you don't listen to our
> > recommendations.  
> 
> Expose this issue to FS layer, it is not good idea. that will impact
> more code, and involve duplicated code.

Sorry but as far as I'm concerned, you've lost the right to have your
word in such design choices a long time ago. You can't deliberately lie
to us for several weeks/months and expect us to trust you (your
judgment) after that.

Back to the actual proposal, it's something that came from a discussion
we had with Miquel and Richard. It's certainly not perfect, but neither
is the option of hardcoding a quirk for JFFS2/UBI/UBIFS in the Micron
NAND driver.

BTW, I think you completely occluded Miquel's suggestion to have a
generic implementation at the MTD level for users who don't care about
the pattern that's written to those 'soon-to-be-erased' blocks. See,
that's one of the things I'm complaining about. You seem to ignore
(don't know if it's deliberate or not) some of the suggestions we do.

> > 
> > I've been quite disappointed by your behavior in the past, and it  
> 
> > continues. Recently you've taken Miquel's patches and claimed
> > ownership  
> did you seem my recent patch? you can ignore that see this.

I don't understand what you mean here, sorry.

> 
> 
> > on them (probably not intentionally, but still) while you were
> > clearly
> > unable to rework your original series the way I suggested (which
> > Miquel
> > did after seeing you would never send new versions).   
> 
> seriously?

Yes, seriously!

> 
> > And when Miquel
> > suggested a change to the implementation he had done based on the
> > discussion we had with Richard, you decided to ignore it and pursue
> > in
> > the original direction. So, quite frankly, I'm really not convinced
> > you
> > can conduct such a change.
> >   
> 
> As Miquel mentioned, we need richard's final comfirmation,
> If he agrees with this proposal, I give up my current patch.
> 

Actually, you need more than Richard's blessing. Miquel has to agree on
the NAND changes, and even if I can't block the solution, I think I can
at least give my opinion: anything that involves FS/wear-leveling
specific code at the NAND level should be avoided. Given the discussion
we had regarding JFFS2 and the cleanmarkers, I don't think we can come
up with a solution that's safe for every users, hence the proposal to
empower users with this responsibility.
