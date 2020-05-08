Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253C9C35280
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 02:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00FED2070B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 02:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="mLom0gmh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yq8NIafU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgEHC1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 22:27:44 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:36881 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726509AbgEHC1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 22:27:43 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id B22B4AC1;
        Thu,  7 May 2020 22:27:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 07 May 2020 22:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=JXHbhurBc2XgH5qUJKyr4SD4gSI
        tfGt7+CAU5SKeknE=; b=mLom0gmh9+Lu2QAi+LWm5GS4FKqTdMcvbVveiwhOn5D
        Llx5rzpJOan2eDXFzhVRfWV6WVhOL/HBOFANt705KeMHYDiGKrqtSmGcoB4KAC+n
        COYpW6Aa9bj9GLDamUyZVxKkZqe4tW9nRfuOR2Wxp3JyJvdgHHwxRZcW+em0oSui
        kPVmS1MZub+WThhCSPKXF4IKQR4/7vp+O5vh2D221uTjoGES66eeRXabMWDgqB01
        xk7fijtcU85Bf1DZfYyrebnuKAjQLdLDuWRhYFPqrge0t84tZwRvv1KbNwspf1nL
        UTZXVa0HdbpPwFMfPNyLrN3V7LfYgt1tJ+HsFIU5jYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=JXHbhu
        rBc2XgH5qUJKyr4SD4gSItfGt7+CAU5SKeknE=; b=Yq8NIafUCtoJD7odyVw/mC
        StgQvlRHG3/jE0V5pvltdVctApsytiRTENLjHBX5n5luxTgyf68zu6rMqRpQYnOK
        +MqampiYVkEtq7z2p3TftC7n0Wfgkn+s8EhnzzJBljky+uvUYKj6uuUJaeJi7Qg3
        yZ6HSk/6/B+rLT/bfCGeMqeIIMEgxj3cqPpk7ufNwpgvChc+hw6Fb1Ry4KPJKUiB
        OCmcncIWk34yGILYXdYZDIjw4Nnuoa8WSiI/z08HGWs6n5wThmzMzqiYolTTSg4u
        7kawR1syPacTDM+S6oEukzbq+1cnH4yLEwFlxiKtxYYCF+XQ8Bf0Qtgbu8MEXB+g
        ==
X-ME-Sender: <xms:ncO0Xk6rOQ8nKYx6A0zN4w9tU7fnAovlB0MYkPXd6zKFn4SmcRXfHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrkedugdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgrshhh
    ihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
    eqnecuggftrfgrthhtvghrnhepfeejhfevvefgledujeetffduteekteffudevudejffeh
    tdelteduledukeehkefgnecuffhomhgrihhnpehgnhhurdhorhhgpdhgihhthhhusgdrtg
    homhenucfkphepudektddrvdefhedrfedrheegnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthh
    hirdhjph
X-ME-Proxy: <xmx:ncO0Xh3DoiRSj3o067rLg0kkTTHbWfsqHDENxQEJELBg6-05gvd7MQ>
    <xmx:ncO0Xpm9NpyBZE47MZHxeK7yQ441RkHsavlEngwsbkYHgY5TTFPs0w>
    <xmx:ncO0XvgIWEuBQseV89SzklA0SZKHmQAoZb3Dsoc4gjkJ5CAugYzYgg>
    <xmx:nsO0XmnJGSSDBbt6bVWIU0SIL7-TtGGERFcRE7Ey2NTo24UXIAPyvA>
Received: from workstation (ad003054.dynamic.ppp.asahi-net.or.jp [180.235.3.54])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2836B3280060;
        Thu,  7 May 2020 22:27:40 -0400 (EDT)
Date:   Fri, 8 May 2020 11:27:37 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: fireworks: Replace zero-length array with
 flexible-array
Message-ID: <20200508022737.GA332087@workstation>
Mail-Followup-To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20200507185245.GA14270@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507185245.GA14270@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 01:52:45PM -0500, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  sound/firewire/fireworks/fireworks.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
 
Acked-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

> diff --git a/sound/firewire/fireworks/fireworks.h b/sound/firewire/fireworks/fireworks.h
> index dda797209a27..654e28a6669f 100644
> --- a/sound/firewire/fireworks/fireworks.h
> +++ b/sound/firewire/fireworks/fireworks.h
> @@ -177,7 +177,7 @@ struct snd_efw_phys_meters {
>  	u32 in_meters;
>  	u32 reserved4;
>  	u32 reserved5;
> -	u32 values[0];
> +	u32 values[];
>  } __packed;
>  enum snd_efw_clock_source {
>  	SND_EFW_CLOCK_SOURCE_INTERNAL	= 0,


Thanks

Takashi Sakamoto
