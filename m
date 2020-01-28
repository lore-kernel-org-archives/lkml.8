Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8EBC32771
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 01:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E38F2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 01:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="WkKctAqq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O9gxMthR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgA1BFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 20:05:48 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:51093 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726083AbgA1BFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 20:05:48 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id DB72A539;
        Mon, 27 Jan 2020 20:05:46 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Mon, 27 Jan 2020 20:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=p44JX6UjfFs1gkO+lyEnsqEIVLu+Il9
        jCbYlJgqj58A=; b=WkKctAqqqXR7qokRVYOeEduPKDCdutwcHQsIqoHj+dpoXmu
        AjzwPeuQmHUoAI6mEeTi0Fr9ktxqFOYCTz4XH/CL+k3Mswi9HHQn+EddmS1Q2BzQ
        rCtBqOkh/OEuli3flwNXCOrMdPJp+kp2uokPZpMXl3P7pjQtEcVY1iji2VufQmmo
        N0yLQLj9P1hxOucDc54Z1QytRrdjfArbQh5PQDKnpbccylglkQsrncfU1fKrGiPI
        GFq/BzsYC/+OuG4DXXb0eAtt7pedKFo5AARxamRgxbb3rFfPvmc/XYATX1gdY+JR
        iWBAvR6VlSPpJty94MYQ2z8ScQUH2O1KrG45X2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=p44JX6
        UjfFs1gkO+lyEnsqEIVLu+Il9jCbYlJgqj58A=; b=O9gxMthRUr+pNgi7X8OQLA
        XvLVS1o6OrWfFfPndNZAPCUBwNDfU1k+TxnxG3/V3RAl4+Xa9YvxhXWs5ECdL4Iu
        S56ZPv1m6p4XidsmwcKL8cb8CkVx/apMX7HiRgIgWkqy64VO2tFDKYyBtE9PdPuP
        7lCUvWKGe2AY/BEJVfIgQ6UddaE45a2wvwd7uftG0UWV8TMUwaWFUwTaSgT3zrIV
        hMKE+RwBWAB5B9+UajfMIJ3sfRbML5QojF1u9DTSlsPGn8dLH/msiWTdOwcOIWlD
        0WYy3f72Xv3KbnhlYw0zt4dnuEULnNVggkhB5mP6WCEHVNqcKhhZ2ATNq/+bV8OA
        ==
X-ME-Sender: <xms:6IgvXsp0bkEMaGfdUJnId3Gxr3ePV1cJVI91DJvTnHYCYvfwS5jd-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrfeefgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehnughr
    vgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghj
    rdhiugdrrghu
X-ME-Proxy: <xmx:6IgvXsVDf-VIrMHtC3vD7s2zEkB1TduObJsc_31o8_te_1ClHcdA0Q>
    <xmx:6IgvXoK4Jxl1LJCe6qvtk3vkIbI1sj4tE_dCBbccmbem8iE0mN_oCw>
    <xmx:6IgvXn94vt32ccAeUBA3jBr-sj3GZwRTuceyphL1XaU2LtZiKpL1cw>
    <xmx:6ogvXlFGGeRb9E1O7EZkl_h36sxzc6ZP2BQ9TixOzx5noq905TcI2A>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9BA03E00A2; Mon, 27 Jan 2020 20:05:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-781-gfc16016-fmstable-20200127v1
Mime-Version: 1.0
Message-Id: <78f934a3-ec7a-479e-9f63-4df7c4428ae5@www.fastmail.com>
In-Reply-To: <20200121103722.1781-4-geert+renesas@glider.be>
References: <20200121103413.1337-1-geert+renesas@glider.be>
 <20200121103722.1781-1-geert+renesas@glider.be>
 <20200121103722.1781-4-geert+renesas@glider.be>
Date:   Tue, 28 Jan 2020 11:35:27 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Kevin Hilman" <khilman@kernel.org>,
        "Olof Johansson" <olof@lixom.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Joel Stanley" <joel@jms.id.au>
Subject: Re: [PATCH 04/20] ARM: aspeed: Drop unneeded select of HAVE_SMP
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Jan 2020, at 21:07, Geert Uytterhoeven wrote:
> Support for the 6th generation Aspeed SoCs depends on ARCH_MULTI_V7.
> As the latter selects HAVE_SMP, there is no need for MACH_ASPEED_G6 to
> select HAVE_SMP.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
