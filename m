Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF49EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 20:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C52020706
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 20:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sxS3hCoq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgHXUBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 16:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHXUBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 16:01:18 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273E7C061573;
        Mon, 24 Aug 2020 13:01:18 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id i26so9208064edv.4;
        Mon, 24 Aug 2020 13:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C8lKf4ORmfqEPGg/u/S9g7wmze0cyqq99uKDJUmoY6g=;
        b=sxS3hCoqrdvLAzjdfIC3Q8aHGfsiccjZ3yuleXvJF78H8hcuJow6cb7aurAtd59Bni
         N042Cqv7KgPT+kfvm9k2B3r/1A7SEREtCarU4MNMBilQCerdh+pxWKRz3lQIkfcjZD/N
         jykow2vv7cUUdA92oQPqrRGhTVOfqKi+BJbIx1cqkrucrr+VFdlcwi1yhzeBXnl5odoU
         AGBW93GD2WV52VC8JXJlsbFSnIJ9hc5KNbX/F8v0EbYuC4lPRNz4zwcloS+iNcSBSNUh
         BpaZxm6Dx7ynVdu6B1CFGbfu6u9DAGLn9/F1mtterVW1bRL4OkJMq9U6n8CGMs/W73Q2
         m4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C8lKf4ORmfqEPGg/u/S9g7wmze0cyqq99uKDJUmoY6g=;
        b=YblAdF2HeoTyHJnWP1XdjpFwoCZmtww4A0/N2V6nFIngMwPCDL54ZZcCr0Btcj7DOY
         HmxvNnHJ9tJAsDs1vrIYpA4sBaL2g7wtQhz86pehQOM/XQOF3dnuDa9GW7wxuVzgXEDa
         fw/ggPKNjh1TTedNLndrdWfoZEk56Gn8CwjdDtk1lkxVMnhNBzkAhhQIjetcMHHpNu5F
         GLZAZc7rkli9lAGRBH8nIQvWYtJ2zEvYeg4MESEO2zowChnnmD6NwjvAZvvdwf/EAa7h
         08Mr8sI3mCnzSJlana2HbGI5O5IKgxes/mpfAuh5bFbQ+XU+cD0o6kLcDMAuXA+X9QIG
         LKOg==
X-Gm-Message-State: AOAM533c+FaqkNzAJdMOoIhkwitH753LoHNAWpfrCQ/v5VgThBqw9frn
        Trnz+rM6vtOKcNwdYmUPY1/LGyjimso=
X-Google-Smtp-Source: ABdhPJzxKx6i7dAfqTJsLy20vJypB4N5BuHtTeGENG25gH0Wti7clLH3SrAPkxHd2rd/1uFzO5BTgQ==
X-Received: by 2002:a50:8f44:: with SMTP id 62mr7338692edy.3.1598299274966;
        Mon, 24 Aug 2020 13:01:14 -0700 (PDT)
Received: from [192.168.43.227] ([148.252.128.110])
        by smtp.gmail.com with ESMTPSA id u10sm10295771edo.14.2020.08.24.13.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 13:01:14 -0700 (PDT)
Subject: Re: [likely PATCH] media: lmedm04: Fix misuse of comma
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>
References: <e6cd92faf09722fe729a7de03e7bde592f62499c.camel@perches.com>
From:   Malcolm Priestley <tvboxspy@gmail.com>
Message-ID: <d4b13e5d-6c97-2594-0ca6-346bb2129b88@gmail.com>
Date:   Mon, 24 Aug 2020 21:01:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <e6cd92faf09722fe729a7de03e7bde592f62499c.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good catch the interrupt URB is not running because usb_submit_urb is tangled with it.

It only really affects signal strength.

add

Fixes: 15e1ce33182d ("[media] lmedm04: Fix usb_submit_urb BOGUS urb xfer, pipe 1 != type 3 in interrupt urb")
Cc: <stable@vger.kernel.org>

Regards


Malcolm
