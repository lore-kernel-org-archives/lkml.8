Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18C5C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6396020714
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="rLUNpPmE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FZ2B42/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgEFGvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 02:51:41 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:51685 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727067AbgEFGvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 02:51:41 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 6696F7B0;
        Wed,  6 May 2020 02:51:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 06 May 2020 02:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=L
        jf9NVpB6+fQn2DUe7yPpp8SyonqgkHzd+GrRNImkaA=; b=rLUNpPmE4erFO1IyF
        7QG3TU2eRvDuv73H0xXrbJXFHTi8ko+ePF+kfOb2V/WuEX+60DUtWjWtq3l9wivo
        /ZL9cAfHwgp4ZQFjWvamLWlFYPh3KWLDSUS1CHrT0oygFX3WFop3oWEIH+iEHI8q
        PxqYkt2wjsCVsEjv8Ba2MzrtyFsYph3U+kldtd0WvSkn4L2DU07IkoGr50ye7YsZ
        ZKJCJiv/hKcS0UKahTRo9rMObFLpi9zkkC47V5v1dLe53CJDlcwm8mbU1vo9zs2R
        wZx8R7fQXOuDXa0zaW8K8zfSdTK5TdH/Oj/iYLA7yDZR6Eb4hYdplmR7gdEC7zP/
        q4g5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=Ljf9NVpB6+fQn2DUe7yPpp8SyonqgkHzd+GrRNImk
        aA=; b=FZ2B42/PjXAFwfpsYgYAYcE3ajtcJrLqPIFyGXfLNdEOT2BWGoyjm/Jbn
        JEh2Yr2gV3ZN54Jduv4SJmo7TpcBCqT4gRP3kH2jEajq8OXfeN6RH6OK1TKaeHMG
        v9XZqgh5c+jAaqwqfF3/jNNdfXsoVYLX+2xzI6+xFuCaiCTQAshNzmxwhjhglpdz
        k+2FSgMFP/BBUwUYbyx8NTqm4lu4mGadoeHymJj6njPFdwPRPFEB1HRLWI0yr7V1
        8Bc6QcBMK4vdrXJh8LqEeNrlN89h3mOQOg1mekmwAXMf/wD71S0wrxkJFINwTD2J
        a2nvfiCj6Txuj2gsVV1y9d2Abydiw==
X-ME-Sender: <xms:eV6yXj_Xx1apATZ3rQsEsNH8eBMDK9lDFIHq16GEG8aMy72L2VnKBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrjeejgddufeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggugfgjsehtke
    ertddttddunecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeevtdeileeuteeggefgueefhfevgfdttefgtefgtddvge
    ejheeiuddvtdekffehffenucfkphepkeefrdekiedrkeelrddutdejnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrd
    gtohhm
X-ME-Proxy: <xmx:eV6yXgauPB1D9nkz_2ZQsJEmkLiLERgYz3fJbWkHhmiA4gq8wCsgPA>
    <xmx:eV6yXvNQbOC3NMP1RoA3PjQDZvZ0KcQ9euyD9AwrfCqmRyWtiCEwyQ>
    <xmx:eV6yXkApKotVI9mxd4_xipG2ELrIx7LqP8oio-0xwZPecBOC_X2-yw>
    <xmx:el6yXnXFEnnvVT27O07FRAdKxIS3nqQX62K-VB-NqVGtg_huGc5slw>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4BBD43066106;
        Wed,  6 May 2020 02:51:37 -0400 (EDT)
Date:   Wed, 6 May 2020 08:51:34 +0200
From:   Greg KH <greg@kroah.com>
To:     Akira shimahara <akira215corp@gmail.com>
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/9] w1_therm: creating w1_therm.h
Message-ID: <20200506065134.GA2279499@kroah.com>
References: <20200429225915.198956-1-akira215corp@gmail.com>
 <20200505144811.GD838641@kroah.com>
 <d4a8e881f2f715f17254a840a9a05b088146c2aa.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4a8e881f2f715f17254a840a9a05b088146c2aa.camel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 11:04:39PM +0200, Akira shimahara wrote:
> Le mardi 05 mai 2020 à 16:48 +0200, Greg KH a écrit :
> > > Creating w1_therm.h header to organize code. Organize the
> > > w1_therm.c file
> > > to gather hardware functions, device specific functions, interface
> > > functions and sysfs functions.
> > > Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
> > > ---
> > >   drivers/w1/slaves/w1_therm.c | 302 +++++++++++++++---------------
> > > -----
> > >   drivers/w1/slaves/w1_therm.h | 138 ++++++++++++++++
> > >   2 files changed, 269 insertions(+), 171 deletions(-)
> > >   create mode 100644 drivers/w1/slaves/w1_therm.h
> > 
> > 
> > Wait, why is a .h file needed for just a single .c file?
> > 
> > 
> > 
> > 
> > 
> > <snip>
> > 
> > 
> > 
> > >   static ssize_t read_therm(struct device *device,
> > 
> > 
> > 
> > 
> > > +/** read_therm()
> > > + * @param sl pointer to the slave to read
> > > + * @param info pointer to a structure to store the read results
> > > + * @return 0 if success, -kernel error code otherwise
> > > + */
> > > +static ssize_t read_therm(struct device *device,
> > > +                     struct w1_slave *sl, struct therm_info
> > > *info);
> > > +
> > 
> > 
> > Why is this function needed to be declared in this .h file?
> > 
> > 
> > 
> > Why is any of this needed?  For some reason I thought you needed a .h
> > 
> > file to make things simpler for other .c files, but if all of this is
> > 
> > static, it's not needed at all, right?
> > 
> > 
> > 
> > thanks,
> > 
> > 
> > 
> > greg k-h
> 
> Hello,
> 
> Yes, you are right, header file could be avoided. But we separate it
> from .c for clarity purpose, and to ease future developpment (for
> example adding support of new devices).
> 
> If you absolutely want to put everything in the .c file, I can do it,
> let me know.

Keep it all in a .c file, only use .h files for when you need to share
it across multiple .c files, otherwise it's not needed.

thanks,

greg k-h
