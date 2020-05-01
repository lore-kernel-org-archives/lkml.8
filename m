Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC66C47256
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 06:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DA142070B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 06:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="SazpHWuj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vpx3e/q4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgEAGza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 02:55:30 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:59149 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728126AbgEAGza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 02:55:30 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id EBE7F5C009C;
        Fri,  1 May 2020 02:55:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 01 May 2020 02:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=kmqR2R8N33Xggva+RT+PcI2on9I
        oOK26ShAjr/4Kync=; b=SazpHWujaUpxMsMmwm42TypkWZNbeG4hKqaU8v0nqSe
        vK/fqygmC6xhqs7xBPxjJX0rDLuVIaFMGk268ZEGOcFZo7LUEQOnF/Oy622FsdTx
        ah3KtJgYWOhYDZVSq0cYXkY7xw56oLFbH0KRgI//0tM9pJF95S8gR/5fN+ODxxlp
        ycaU6iSAsV1EjbiwJvuw2cllNjahSYs/4lslTefLl11i3d9qF/j0dCnmBlF+6mLP
        oobDO9mexWuDWCR0B5EXtjgtgWOYzKl5d+LqDSKdHdqp7MLLFyGBaQMnvMxyNjo+
        Vbsnaas3173YRisrEbgCQDul5kBb63dmX9xnuRN2KAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=kmqR2R
        8N33Xggva+RT+PcI2on9IoOK26ShAjr/4Kync=; b=Vpx3e/q4VUE3Q4SgaVrALa
        lW1/1oSbMsh03RomhH1gdG/CEGguUxwsQhTl+FkatayHrdhyJPd4cNBdRelMAquo
        pqAeaJEOBhpX/azf73Nu8i+6p7/2/VBmIZR5hpYqLQ8iQirftzkNF4HzuEBAaTh3
        VJLqqg+NCZ0FxzHQL/5VK4lvRTSuovp13k5fazsnzHD0dAE+YN6mJERwvxSCOaJH
        PmkHW1YSukTrnXTiYlR+Cxv/4Os3igL56GkjUVaR7uwOVpCzZLnrD69fpEPDBA7D
        xn1GcsEUCeGogRGPkpoH/TpUZ5Op6gbmMx6RZdQYBhDKTyVWu5jYynxPW8xfLIsw
        ==
X-ME-Sender: <xms:4MerXpwxZd2-UdhlRDKj87MbwvbzdyEsnC3dZKH3sc_FgGukYv27Gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrieeigdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucfkphepkeef
    rdekiedrkeelrddutdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:4MerXvIGvjL5U4-8-v_wEo-kD-liDvCAUUrOU0q7xGZcEEz5Xd885A>
    <xmx:4MerXlyBBjQH36IBVGPoIRPSFfigZhQ1iw5RekfK0hZDhBuDwV8GuQ>
    <xmx:4MerXsqBIkFFdPfxSg0PIraFoGD_FoMBU6wJyjgmC546S6noFVsItA>
    <xmx:4MerXoMrBti1L609HkzV4Ihvg9lZ7vUwC49sKCYWKtgfJYTkn7aqww>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id D602D3065F5D;
        Fri,  1 May 2020 02:55:27 -0400 (EDT)
Date:   Fri, 1 May 2020 08:55:26 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the char-misc tree
Message-ID: <20200501065526.GA886609@kroah.com>
References: <20200501162806.155c44ed@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501162806.155c44ed@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 04:28:06PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the char-misc tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> drivers/crypto/xilinx/zynqmp-aes-gcm.c: In function 'zynqmp_handle_aes_req':
> drivers/crypto/xilinx/zynqmp-aes-gcm.c:137:5: warning: 'status' may be used uninitialized in this function [-Wmaybe-uninitialized]
>   137 |  if (status) {
>       |     ^
> drivers/crypto/xilinx/zynqmp-aes-gcm.c:87:15: note: 'status' was declared here
>    87 |  unsigned int status;
>       |               ^~~~~~
> 
> Introduced by commit
> 
>   bc86f9c54616 ("firmware: xilinx: Remove eemi ops for aes engine")

Rajan, can you send me a patch to fix this up please?

thanks,

greg k-h
