Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795A6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 05:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57E9C207D4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 05:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="DtDY2/wr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ek30kn0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgGBFsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 01:48:05 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:38095 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726010AbgGBFsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 01:48:04 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 698FF94A;
        Thu,  2 Jul 2020 01:48:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 02 Jul 2020 01:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=JB3g1T86OulfsPyCRI9e7ntQvyT
        c7xFzA0gJ9PMz5m4=; b=DtDY2/wrrcdn92RaoYD8HOQqdjSUr87M8Wl3mRj112e
        AhJXj++fXHPB4D1ebpbin//JoaIbHv5xOjEFo2EvgUN7yzpnHFBrqWFzJx2nXWl5
        /IWZISXMANNlitVUz25UPYXiZeLfHwhFaQvHHSm4DLAAEX6EiyAdQELSa4+6ydip
        81iZbbNdrvD+Ljvrj1oNeoujmNM5AobDhxNRiWlKHx1dRMcjJM8RyvXK16pV1fBQ
        WwkXOR9ZGY5hs6Li0pNYs4J1uGmmAYQPLX7La4NJ0/Ct3i6GbzF3vxmNEezxOR7N
        0gC6WVdqc9w62qy6sdloeLez6U5o56H/LmBtOLSw2oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=JB3g1T
        86OulfsPyCRI9e7ntQvyTc7xFzA0gJ9PMz5m4=; b=Ek30kn0DxjRAP6qf52qrHU
        /vkSj2Rxld7A99Z+M+O0JaSe5OY6ydfnL3XDKka4n3A0R555O/IE23yvyyzDAtgp
        qD444uaY6i8xgSlfFTOXG04K+fDK7jW5CASkHvhUrPSI2AAKFWekn7o2NnluWqQL
        m9BQaOaYTJmd3/waL3YvJckolDK73hTYCubMigcVhPC5xOs3lceUomvkcz98deQj
        wgcRFnyxlR6aPaAjRsISa+OytMjRbGeYfegvke6Is1o1drqkto8OE43HysKcLnER
        Z3mTxZ+/ddwq930f8gcNmQPcjIRnrHVKg0m8ZVll2Rq3Hl8CpQg5Q+J3S2ROJEHA
        ==
X-ME-Sender: <xms:EnX9XlbzXoRPtXhuFZxtlSF471kMilBshpjAuOK9wSumk-LAeKg2iQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrtdefgdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuheejgf
    ffgfeivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecukfhppeekfedr
    keeirdekledruddtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:EnX9Xsb7StqKgz3m8QQz4NbpYZgobipzh1uyy2KwJspsa-HaSyMmNg>
    <xmx:EnX9Xn9vCRZEBYNNP1Gw2JUWdX-QxJyirFI9gc-BD7B3sQp6LzXnbg>
    <xmx:EnX9Xjr_JwwsJ3tNJ4PiA0dAw2hkF82_dpiprOU-H33ta9gEnfl3Gw>
    <xmx:E3X9XtD3ZW2te6btvcSALpL8Z2vC8dBoxzZgjFma4JixrVcUswYJOA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 056803280059;
        Thu,  2 Jul 2020 01:48:01 -0400 (EDT)
Date:   Thu, 2 Jul 2020 07:48:05 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wade Mealing <wmealing@redhat.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the
 char-misc.current tree
Message-ID: <20200702054805.GA3616@kroah.com>
References: <20200702080110.24d42ffe@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702080110.24d42ffe@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 08:01:10AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   853eab68afc8 ("Revert "zram: convert remaining CLASS_ATTR() to CLASS_ATTR_RO()"")
> 
> is missing a Signed-off-by from its author.

Known issue, I had to override the check as I was trying to keep Wade's
authorship information here.

thanks,

greg k-h
