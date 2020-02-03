Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC81C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 14:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7329320CC7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 14:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="Fk0E8Tfu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BP6EjgtX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgBCO6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 09:58:37 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:50361 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727824AbgBCO6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 09:58:36 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 6D376790;
        Mon,  3 Feb 2020 09:58:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 03 Feb 2020 09:58:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=UdM+Slc/O+rORqRWT038kmUBeaR
        7sEVX6Zilo6E1Q94=; b=Fk0E8TfuBc7J1DA05FLClqHx2e5CcVpzjsufGJOJNuQ
        FHc4IdrV34Y+TYl/uXC+CJ9e9mvrJkFrsHnhmXlW4eGNVmumZ27InfAxoaAMXJxP
        VWs1NoXVo1PwQFapz4YVkv6vcz+/lSs81h6Ly1BGSY+ayono3Xr610L8foOuGSrI
        Sl3efc/s4uK2SHIjqge4GqRoDuaXfziexiU44allK9+a3WYXMsnq/GnCW9r2tBh5
        mnRT3ih/mTtlvG7DpIjtk9AZmL6cZjNLYUm+oShS/gqgWFiStucJHGpYkEqxNZLf
        mJA2o/HtlNqj8XJptBpXzyQw9UHG5+4vcjqOfAN2paQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=UdM+Sl
        c/O+rORqRWT038kmUBeaR7sEVX6Zilo6E1Q94=; b=BP6EjgtX7QZ36ZzYy+6laI
        Ox/n7CZH92SdCMfSwVSL7nTDCTb+WD2TNfj4cpsc6luO2Yz1oitQJPrxPQhoaDzg
        u+ft/+c/msytjFJ/qWxQHqFx/A7pa0cPZijTmwMdXvrmOTB1v4vITtW+UxvLFpix
        B4HOBxitJ9++9CPwl30iym31EP8VONOyO7jwalgX9m0lJrgpNfz0bxmlJh5fioDU
        S1EyTqZZtMnQ72ItF20UM8unlQTto/rlBEMbLDAJm/BgZUlb+vLV72GZ6ylZB5RW
        XsfR/YQzuXnT6CxNzOVpop5JbrxKh/qZ9ikApKaovV4uZpYrgY5XB2yFppFFu6IQ
        ==
X-ME-Sender: <xms:GDU4XtfUH4HfvhZbhxs9h7FGwjqPADbpyi1WADWcUy7mxdoiwxniFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrgeejgdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppedutdegrddufedvrdeghedrle
    elnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhr
    vghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:GDU4Xsc90Ofnvkj0W4zvL_5vsdcleg7bfvW54g76uT7tPN6GQnR94w>
    <xmx:GDU4Xjl1seuv7jUxRSd0ki5fvZgNu78yXiD5nN_OAvcc8gDCqGypkQ>
    <xmx:GDU4Xp8hkBstJNrGQ02faEDQUfy7qYhkRZSOX65vrBIhNeffJ6dG8g>
    <xmx:GzU4XgXV4PCCggqodEn3iKaMm9yqeQtQK98TlJRjqfli5iuj1J5Vfw>
Received: from localhost (unknown [104.132.45.99])
        by mail.messagingengine.com (Postfix) with ESMTPA id 858103280059;
        Mon,  3 Feb 2020 09:58:32 -0500 (EST)
Date:   Mon, 3 Feb 2020 14:58:31 +0000
From:   Greg KH <greg@kroah.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] media: si470x-i2c: Move free() past last use of
 'radio'
Message-ID: <20200203145831.GA3238182@kroah.com>
References: <20200203132130.12748-1-lee.jones@linaro.org>
 <20200203143245.GA3220000@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203143245.GA3220000@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 02:32:45PM +0000, Greg KH wrote:
> On Mon, Feb 03, 2020 at 01:21:30PM +0000, Lee Jones wrote:
> > A pointer to 'struct si470x_device' is currently used after free:
> > 
> >   drivers/media/radio/si470x/radio-si470x-i2c.c:462:25-30: ERROR: reference
> >     preceded by free on line 460
> > 
> > Shift the call to free() down past its final use.
> > 
> > NB: Not sending to Mainline, since the problem does not exist there.
> 
> It doesn't exist there because of a bad merge?  What commit caused the
> problem?

Ah, found it, it was 2df200ab234a ("media: si470x-i2c: add missed
operations in remove")
