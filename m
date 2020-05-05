Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66E3C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD7D72073B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="PHmJhoPh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OjxFi5C3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgEEOtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:49:05 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:50103 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729065AbgEEOtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:49:04 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 6B2C05C0046;
        Tue,  5 May 2020 10:49:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 05 May 2020 10:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=INHoB98235GOmhH+y895Y9SIg9f
        7TddnJXoFzIT6SJY=; b=PHmJhoPhmNnTwF2JGUXNLEDNld7ESuqYxq70qS6sMxX
        /vVIyzmaAsK43wr7m5/A6+Bdn/3Q/Ij+laGoClSDizChoYyciEa1vwTCg3I7EneL
        fLiKMGoDrbLEXjHv7JtMdXm6dq6agHo36LX/7KN7c1dqktqQt1xQQ9PdcGUhYRMO
        q7DPC2/vCHvwTuK0xGAw7gx4OP7oDnGeBfK9+a8YqAZ3dYL+/FvOUQxKrSjSbqdi
        7fB6KnS+oxbzjxTslF6fsTyhiLyUR0DBrVmFO83fJ4BSNoFQ9Bgq94magqyx+IBb
        THxFco2mKiMRdJ3SWH3C2+Vk4MuHa8sq+ZPNqSoLuGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=INHoB9
        8235GOmhH+y895Y9SIg9f7TddnJXoFzIT6SJY=; b=OjxFi5C3XNK7xTvRVKIiwp
        9Bno+GKBD7fFtU3pGExjhNG6Hlh5PVvMFXmLvsPA7UojbLlBPZLBMbfdPSM1ReHo
        AgUT5Iapq/+/5c6uS8nN7LRnJre+4ysX+9HTENHDdwmZcPNAJHe+YmGmz2kkTgMV
        NtZlVQhQcOlc3HuiPXRS6wnjZ6owv0RIJpNnK9dPvsJQX2fwcy9ViTWAOBKJew//
        cBiaiQCQ2r2Bg3i9LqtMdJMk9R+ulSoKYTXe40Y9SZIgd3FWwjmEPy9R47SVpFfk
        XQ9SL4+7FyfDJIMWC/n7YexEyvbBAoDM1jIiSkOKobz9RfyuSDVqxS4YXDl9d7+w
        ==
X-ME-Sender: <xms:3nyxXhSe3IK4jKxDY23RiyrINrA7WoJQzSsGmdoPmCN3YmVdA3lTjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrjeeigdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeen
    ucggtffrrghtthgvrhhnpeevueehjefgfffgiedvudekvdektdelleelgefhleejieeuge
    egveeuuddukedvteenucfkphepkeefrdekiedrkeelrddutdejnecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtoh
    hm
X-ME-Proxy: <xmx:3nyxXmRNPVc3M0mBL1ruPWpiDBRQQbBrvNbrtHGUFGbWKFlosvYL4Q>
    <xmx:3nyxXs2CgjBmBwE-_vXvIO_hDQ6kytTvu0B1KWslExkqJAQBFfIa2w>
    <xmx:3nyxXmy0mXqlFVyA-udDq3SarlxGY2yFKZO8K-KdGBM-1NKsvJ3Q7g>
    <xmx:33yxXjkQJ6-pQ3v-XkHXgt3R6fNm9gUzACfSMTdbsc4__ODSxCDQEQ>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 47CBB30660EC;
        Tue,  5 May 2020 10:49:02 -0400 (EDT)
Date:   Tue, 5 May 2020 16:49:00 +0200
From:   Greg KH <greg@kroah.com>
To:     Akira Shimahara <akira215corp@gmail.com>
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/9] w1_therm: fix reset_select_slave at beginning of
 search process
Message-ID: <20200505144900.GE838641@kroah.com>
References: <20200429225943.199249-1-akira215corp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429225943.199249-1-akira215corp@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 12:59:43AM +0200, Akira Shimahara wrote:
> Fix reset_select_slave issue during devices discovery by the master on
> bus. The w1_reset_select_slave() from w1_io.c, which was previously used,
> assume that if the slave count is 1 there is only one slave attached on
> the bus. This is not always true. For example when discovering devices,
> when the first device is discover by the bus master, its slave count is
> 1, but some other slaves may be on the bus.
> 
> In that case instead of adressing command to the attached slave the 
> master throw a SKIP ROM command so that all slaves attached on the bus
> will answer simultenaously causing data collision.
> 
> A dedicated reset_select_slave() function is implemented here,
> it always perform an adressing to each slave using the MATCH ROM
> command.
> 
> Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
> ---
>  drivers/w1/slaves/w1_therm.c | 29 ++++++++++++++++++++++-------
>  drivers/w1/slaves/w1_therm.h | 13 +++++++++++++
>  2 files changed, 35 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
> index f027360..6245950 100644
> --- a/drivers/w1/slaves/w1_therm.c
> +++ b/drivers/w1/slaves/w1_therm.c
> @@ -235,7 +235,7 @@ static inline int w1_DS18B20_precision(struct device *device, int val)
>  	while (max_trying--) {
>  		crc = 0;
>  
> -		if (!w1_reset_select_slave(sl)) {
> +		if (!reset_select_slave(sl)) {
>  			int count = 0;
>  
>  			/* read values to only alter precision bits */
> @@ -248,7 +248,7 @@ static inline int w1_DS18B20_precision(struct device *device, int val)
>  			if (rom[8] == crc) {
>  				rom[4] = (rom[4] & ~mask) | (precision_bits & mask);
>  
> -				if (!w1_reset_select_slave(sl)) {
> +				if (!reset_select_slave(sl)) {
>  					w1_write_8(dev, W1_WRITE_SCRATCHPAD);
>  					w1_write_8(dev, rom[2]);
>  					w1_write_8(dev, rom[3]);
> @@ -319,6 +319,21 @@ static void w1_therm_remove_slave(struct w1_slave *sl)
>  
>  /*------------------------Hardware Functions--------------------------*/
>  
> +/* Safe version of reser_select_slave - avoid using the one in w_io.c */
> +static int reset_select_slave(struct w1_slave *sl)
> +{
> +	u8 match[9] = { W1_MATCH_ROM, };
> +	u64 rn = le64_to_cpu(*((u64 *)&sl->reg_num));
> +
> +	if (w1_reset_bus(sl->master))
> +		return -ENODEV;
> +
> +	memcpy(&match[1], &rn, 8);
> +	w1_write_block(sl->master, match, 9);
> +
> +	return 0;
> +}

If you put this higher up in the .c file, no function definition is
needed in the .h file at all, right?

thanks,

greg k-h
