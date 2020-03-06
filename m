Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746BBC10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 500EE20656
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uslm4aXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgCFRpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:45:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48364 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726178AbgCFRpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 12:45:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583516742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CMTg0TedaIFOhx4o5LKmMRYaCsUrpsNojDNW2nk+DDU=;
        b=Uslm4aXIqPcbneB/f0nldQek8/7fHw7R22yWDcHr+rw+QtE3Af6skCbh/L6AOX/sky61Wo
        YTsPyhl/qC/nVL+/YNnqJnbRems3ws8tuwAyV7Yww7isyMbZPn9cxVG+9ZLRuJsgkArawS
        hqnQ1esROZDkxzy2UoSi8z4SQs7ZKj4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-pc48ZVlIPW63wn0sR5CNQA-1; Fri, 06 Mar 2020 12:45:40 -0500
X-MC-Unique: pc48ZVlIPW63wn0sR5CNQA-1
Received: by mail-qt1-f200.google.com with SMTP id i6so1847389qtw.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 09:45:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CMTg0TedaIFOhx4o5LKmMRYaCsUrpsNojDNW2nk+DDU=;
        b=nPboWgw+a0KkuO6tWctj/ffOhyQE4E65Bj3+BOhOAbbzEW1iLjrZP+SLGjkH4bGGgh
         0jjWCuJGS4SSZWLv8JVpGhDhr1e2yZswkFJ6vYsO7zwp736+362Hk1ygYGhCf84LSwX8
         UkH6zWU0h5nfUu0cZZ++YQB2p3i4m76JwvSC5hFhxSkiBtbrENumf4e9nsAz3kF4fdWB
         NdzxWcs6HlvvL1lAXStialKGE9yLVuL7bfSCnQfX5OcJBbCXFZxNObA1n4j2UCECJH7e
         r4NgzLMW+Bv+7H9ApQm4VW6SqNcAgNYePD2Q4Hjn4nZ3mwQX2McNdrfQUbUQwr/NXwtn
         ksuQ==
X-Gm-Message-State: ANhLgQ30cEf7ohASQlAvh0MwQp+ZR3qE4p550UCDuaEXXOrEMEFeNHeq
        tY5v053zcH20J25bdc9bdk7Lk6LxUhMcSi8bA93/vVgn6XS3H/9njBJAFEG3JQa+5y5RWWtcM2z
        2N+LzmAwiUkF3khKNgM8AAW4eusjJ0jWEzqByVVQU
X-Received: by 2002:a37:a1cc:: with SMTP id k195mr4124004qke.169.1583516738499;
        Fri, 06 Mar 2020 09:45:38 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtLkMqmAAE5g6XIxPekB6iUZaExraKcxW50QFZu1+5KPDAHpDrbYIAx376mvnWlzfYRLHDphukJ91rmSpoaWRM=
X-Received: by 2002:a37:a1cc:: with SMTP id k195mr4123983qke.169.1583516738227;
 Fri, 06 Mar 2020 09:45:38 -0800 (PST)
MIME-Version: 1.0
References: <1582766000-23023-1-git-send-email-johnny.chuang.emc@gmail.com>
In-Reply-To: <1582766000-23023-1-git-send-email-johnny.chuang.emc@gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 6 Mar 2020 18:45:26 +0100
Message-ID: <CAO-hwJJo=oNTFNtS5DWtMP7FSiMXUYV5KTa1VDzH4LA4SBUCaQ@mail.gmail.com>
Subject: Re: [PATCH] Input: elants_i2c - Report resolution information for
 touch major
To:     Johnny Chuang <johnny.chuang.emc@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Johnny Chuang <johnny.chuang@emc.com.tw>,
        Jennifer Tsai <jennifer.tsai@emc.com.tw>,
        James Chen <james.chen@emc.com.tw>,
        Paul Liang <paul.liang@emc.com.tw>,
        Jeff Chuang <jeff.chuang@emc.com.tw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 2:13 AM Johnny Chuang
<johnny.chuang.emc@gmail.com> wrote:
>
> From: Johnny Chuang <johnny.chuang@emc.com.tw>
>
> This patch supports reporting resolution for ABS_MT_TOUCH_MAJOR event.
> This information is needed in showing pressure/width radius.
>
> Signed-off-by: Johnny Chuang <johnny.chuang@emc.com.tw>
> ---

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/input/touchscreen/elants_i2c.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
> index 4911799..14c577c 100644
> --- a/drivers/input/touchscreen/elants_i2c.c
> +++ b/drivers/input/touchscreen/elants_i2c.c
> @@ -1309,6 +1309,7 @@ static int elants_i2c_probe(struct i2c_client *client,
>         input_set_abs_params(ts->input, ABS_MT_PRESSURE, 0, 255, 0, 0);
>         input_abs_set_res(ts->input, ABS_MT_POSITION_X, ts->x_res);
>         input_abs_set_res(ts->input, ABS_MT_POSITION_Y, ts->y_res);
> +       input_abs_set_res(ts->input, ABS_MT_TOUCH_MAJOR, 1);
>
>         error = input_register_device(ts->input);
>         if (error) {
> --
> 2.7.4
>

