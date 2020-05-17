Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95D6C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 22:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74CF6207C4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 22:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="S0eNyWfA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgEQWcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 18:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgEQWcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 18:32:12 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8EBC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 15:32:11 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l3so6844362edq.13
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 15:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IY9zS+ciSstxD/NCOg/Nwls054kIjwxMDZxFCipe6hE=;
        b=S0eNyWfA2fopxCroDGihEhhcZW8xaBIo/KUpm2LepunFcwLeBToH4YXfrfNfRXEgqL
         QcgaS+PFgFnQHF+MHA9yvkLF9/cbPWg5i0yb8Caj2rGIAwhYgVEu+kCS3SAQQxOS2/9N
         ezlXMBEzbn6qeA3U7MLQa/SxRaiQX6aA+MXDTAy4oSw7fuGk6CXOf/dZ8+GBHpLR124C
         d2qj2lGMPxPqnaCJfCNog1uTmTxsrcJJ6soozdqT/qvlpmbD4FWcsrkDHAwgASRp+UIf
         bchelc6IYVIwT/RdSz03EtHjUpE74+5t+ymH6dWmXWIRZxWdOvMzfHeSZ0RJ6NKOiId+
         nh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IY9zS+ciSstxD/NCOg/Nwls054kIjwxMDZxFCipe6hE=;
        b=RdEPlIuL5rGO84WcU2tGzaqkZb0hxLQDPpCuxdToQdDabY2cDiOKkkPOfVxBqjoxC0
         CKTQH3DD0LnE9/LqXWDeOO8Qle8lNzI6qnnhQ8u5GjdebkrGR789go52h6aZN5xtU0HE
         dK0E6qWPutvUbGHJc5fZFOwSh9SD0QsQJouTlRgaUKT0xkCt0zcCCxOpbh97367hwZMk
         lGlpXaVYX8XZGw4Xa6cHD6V0x3g3iBdowpzO//Hx8mdhipPLE35l/Bk3T78NNgywlYme
         q7o8dnTm16cZ9JPDcU8AcocBLewcGkDh737X2UEq7RNkUHRhh4U7Kv1KiTzrJ6OgANjv
         KUlA==
X-Gm-Message-State: AOAM531v6r4xQ34HpCyo4OM1wnZRYCVd5KH6L8UwKn2nvEP7u5oskg18
        5hb9rR/R1OA8VQ6AOqLlalu/MXEcbAnsoHREoT0=
X-Google-Smtp-Source: ABdhPJxWix1AovVBpXEwVGAxHQ9R2kNb0eLRBFOI6DIZP5JcSg67Q/IWOOjBt8j5rDb16WWams2NWT0R3BQh/zo2OWY=
X-Received: by 2002:a50:c014:: with SMTP id r20mr10680846edb.110.1589754730321;
 Sun, 17 May 2020 15:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <bcefba5b-107c-716b-bb60-5b4b2476894b@o2online.de>
 <CAFBinCD8-tr97GCVhBi5R1nzxLhy=_6VuLY8ubUO1SDTFjiELw@mail.gmail.com>
 <22af498b-44a0-ced3-86f3-114427a73910@o2online.de> <CAFBinCCGAkhPCwOW=mAvsV2qdixq8Gf8yQw1gYErHpz7KmuAZg@mail.gmail.com>
 <5de6db87-a71f-d14c-390d-b0caeab5d650@o2online.de> <CAFBinCDB9c2uMRXO9DKSX4hC7EBgnRfBa+BM5-VdEPZeieKn_w@mail.gmail.com>
 <813dfc08-f13a-dcac-0bd9-821d188bba08@o2online.de> <CAFBinCCgZF5Pu944q-_+V0yQ-nc6q82xDjJHjsnj6=uOQL+DEw@mail.gmail.com>
 <8cbbf90c-54ba-8fa3-3386-022c9c997a20@o2online.de>
In-Reply-To: <8cbbf90c-54ba-8fa3-3386-022c9c997a20@o2online.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 18 May 2020 00:31:59 +0200
Message-ID: <CAFBinCBukGbzgO-Y1dCRYXZHhX2PcSEQQ_XvhHqLcnw0fGDP8w@mail.gmail.com>
Subject: Re: RTL8723BS driver doesn't work for,me but I can help testing
To:     Tobias Baumann <017623705678@o2online.de>
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tobias,

On Sun, May 17, 2020 at 11:05 PM Tobias Baumann
<017623705678@o2online.de> wrote:
>
> hi martin
>
> sorry for cc -problem it was my fault in thunderbird
>
> thanks for dtb file but this file has problem kernel stop with
>
> [    6.122092] mmc0: new high speed SDIO card at address 0001
> [   35.804258] VCCK: disabling
> [   35.808781] platform pwmleds: deferred probe pending
> [   35.812625] platform sound: deferred probe pending
pwmleds was also there in your last dmesg
please ignore the sound part, I haven't tested it on that particular
board in a while


> [  215.804295] random: crng init done
>
> (last time deferred probe was gcc problem )
>
> please can you provide me with dts file and i complile at my linux box
> or maybe only the change line and i use the dtb from image and edit the
> lines like the usb patch
you can get all my patches from here: [0]
as always: some of them are not even in linux-next yet and there's a
reason for that ;-)
I have changed the GPIO_ACTIVE_* polarity for the two GPIOs in the
sdio_pwrseq node if you want to do that by yourself.


Best regards,
Martin


[0] https://github.com/xdarklight/linux/tree/meson-mx-integration-5.8-20200517
