Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C881C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 20:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E534A2063A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 20:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ExO2fH7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgD2UAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 16:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgD2UAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 16:00:54 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998B0C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 13:00:54 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id f3so3675382ioj.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 13:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ivR/S7GYo6YmuHq6apeA7QKo7Gig9pWiDmfkfQ66UQQ=;
        b=ExO2fH7W1PNbx3IWYXzNxZo54o6JBRsswBtN4UuK1Y6V8nmHdEsVsXT4HkjHKE46Fy
         oSjoO42PznX1Mqv4gNYthhpGCdla/+LEX8yH2IBKavYeos/sDYSMcDodudepdk3QrIAj
         DZWSX4WewN+pZn8sDz7swEwgIyO3AvnCKs/Aq/HwLFWnnd7ZBMuyWwLs38orfc1XotOS
         Q0EoTd6g8bksRbYtbcNq2uEIYWPlNZubXJnfLl4IHvgpLWcdAG7VQypLbKNLsb0ubgPc
         uTHPS7C9E3cJHUeCPejFsjPtdVsP5l1AV4Ue+5qW4Bwe1klqz/cGTuQRfleTkSDYlACL
         CeDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ivR/S7GYo6YmuHq6apeA7QKo7Gig9pWiDmfkfQ66UQQ=;
        b=q3rJEaFkS2LtIzFEFbRcL4D1N9p2jzSnuKpDK/Iot3J1tOBf/39eExhN85grIk0C0P
         +Rq2Umrd3JpNiNGTDAEUOAX3ypI3p5tkaAujEX7LtZ7B62JPmZAMXtOhZWhC3KZal4f1
         bNPgV6IMhiWeHQ44bYVlc/SaKMQR6jsfW4Jc+CqiK0gUmlX8/rK5dOfrOQv48KkBd5If
         ZJXxNEHE4usXhKaCLCRcwaH7vw+rr99RN49eXNsFzmp+ThI/GimeWYBPetjKilCVObqt
         3hsPz/kUs2voYKWzXgxU6gULyFnNC03Gs+HGOxD/5iWfpsoni6k4obo9x7LRoFJV7BKH
         V0ow==
X-Gm-Message-State: AGi0PubiKYD5IZO/7B/AY1r+oO3TxOlfGovYvnHdSfCoU1YPApDdOmc4
        x6D6lAvK5f5SZjYXngAkhC3j7A==
X-Google-Smtp-Source: APiQypLJYlgIkzUo0VrI2MJoIfEiY2Izq72/hXtGKLGfgtFLlCE+J5AWZYav1XxM1Q3A0EtD0zh1AA==
X-Received: by 2002:a02:90cd:: with SMTP id c13mr31100201jag.83.1588190452552;
        Wed, 29 Apr 2020 13:00:52 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id v9sm1173063iol.28.2020.04.29.13.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 13:00:51 -0700 (PDT)
Subject: Re: [greybus-dev] [PATCH] greybus: uart: fix uninitialized flow
 control variable
To:     Arnd Bergmann <arnd@arndb.de>, David Lin <dtwlin@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Axel Haslam <ahaslam@baylibre.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org,
        Greg Kroah-Hartman <gregkh@google.com>,
        Johan Hovold <johan@hovoldconsulting.com>
References: <20200429190022.12671-1-arnd@arndb.de>
From:   Alex Elder <elder@linaro.org>
Message-ID: <7146e1ca-1fc7-61ab-e798-7b017c7c974b@linaro.org>
Date:   Wed, 29 Apr 2020 15:00:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429190022.12671-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/20 2:00 PM, Arnd Bergmann wrote:
> gcc-10 points out an uninitialized variable use:

Wow, nice, checking individual uninitialized fields within
the structure.

The structure should really be zero-initialized anyway; it's
passed as a structure in a message elsewhere.  With your
change, all fields in the structure are written, but in
theory the structure could change and stack garbage could
be sent over the wire.

What do you think of doing this instead?  Or in addition?

        struct gb_tty_line_coding newline = { };

(Presumably that would also silence the warning.)

I endorse of your change, either way.

					-Alex

> drivers/staging/greybus/uart.c: In function 'gb_tty_set_termios':
> drivers/staging/greybus/uart.c:540:24: error: 'newline.flow_control' is used uninitialized in this function [-Werror=uninitialized]
>   540 |   newline.flow_control |= GB_SERIAL_AUTO_RTSCTS_EN;
> 
> Instead of using |= and &= on the uninitialized variable, use a
> direct assignment.
> 
> Fixes: e55c25206d5c ("greybus: uart: Handle CRTSCTS flag in termios")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/staging/greybus/uart.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
> index 55c51143bb09..4ffb334cd5cd 100644
> --- a/drivers/staging/greybus/uart.c
> +++ b/drivers/staging/greybus/uart.c
> @@ -537,9 +537,9 @@ static void gb_tty_set_termios(struct tty_struct *tty,
>  	}
>  
>  	if (C_CRTSCTS(tty) && C_BAUD(tty) != B0)
> -		newline.flow_control |= GB_SERIAL_AUTO_RTSCTS_EN;
> +		newline.flow_control = GB_SERIAL_AUTO_RTSCTS_EN;
>  	else
> -		newline.flow_control &= ~GB_SERIAL_AUTO_RTSCTS_EN;
> +		newline.flow_control = 0;
>  
>  	if (memcmp(&gb_tty->line_coding, &newline, sizeof(newline))) {
>  		memcpy(&gb_tty->line_coding, &newline, sizeof(newline));
> 

