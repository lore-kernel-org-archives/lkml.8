Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFF0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F6B21501
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQBb6VNk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgFQHoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:44:44 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55911 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725894AbgFQHom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 03:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592379879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LdQWvEMUJWYJ0ayIlG9RiKefcYkYap4fRHuTq5TItU8=;
        b=hQBb6VNk5VZ6n6dWI+MiTg3s6OBWkdKILGkGMubVROqy3a/Rgqi55GDqau2Gcc3kpXjhW6
        BH4tz8lO+10eS5fDDJjfTB/EI4XP9cI51RQtKrDCMOblhX2V4swm7etwHqaQa4LuyuGn03
        PpE8w/F1Lk4t2YzWPnAY48Z5JFFIEHk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-gh9eek83NM-3B0IrREb7dQ-1; Wed, 17 Jun 2020 03:44:38 -0400
X-MC-Unique: gh9eek83NM-3B0IrREb7dQ-1
Received: by mail-ej1-f72.google.com with SMTP id bg25so639799ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 00:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LdQWvEMUJWYJ0ayIlG9RiKefcYkYap4fRHuTq5TItU8=;
        b=C8wl9ggjGdFOMt+jIjcs8Bz7MioXQqoj72JYGY2GiHHNFRZNeLMsBSBt1GbDO/Kahd
         bEU1Y0Q2LyMele3yrFMpYoI/ote2iGYCfMAttiMDBU5KK3JSELRCwX/m4feUxtcDC6Ke
         2egQ0GPXOAh8++UUjpl/zYfnSVw9mRM/2c6JLMTR8ma+lq5+iJZf2FbvBk6hWKxOb3tR
         BYS/5u2kdvRh1jsUgU8c0m97yyO4nfZJ564F5P0dGa/FE9CNKcUQ7C2xoxJV4TF4wV/f
         g4ch24BB5mi3VQVeyPSTkGRA4ZgSTepwUba93eOgeneDLULWz7h6WUBZTs8ltXJP4IY3
         fVOQ==
X-Gm-Message-State: AOAM532VZ51BR2kHxOd4ZQCKSiKUQTfDDCrDy255QDXbXKBGqnk9/l3P
        zE7YdA6mEvQ74v5A2OvPqxm01+1T+MfBDe9utd7b6Vn8xUx1LvUvEbsfVwuEPW9A41y4hpUbNrR
        7YV0zD7t43b2NraXISPGLudJm
X-Received: by 2002:a17:906:e47:: with SMTP id q7mr6349221eji.279.1592379877124;
        Wed, 17 Jun 2020 00:44:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztAsLsgDaFxPRHVMxQyWpwuzemyHiIKlOYzD7aKaYp8CK5bsLlyAMtEHuAjaMc+cKU/OAdZw==
X-Received: by 2002:a17:906:e47:: with SMTP id q7mr6349200eji.279.1592379876894;
        Wed, 17 Jun 2020 00:44:36 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id i12sm12619661ejz.122.2020.06.17.00.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 00:44:36 -0700 (PDT)
Subject: Re: [PATCH] Input: document inhibiting
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org,
        linux-tegra@vger.kernel.org, patches@opensource.cirrus.com,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Barry Song <baohua@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Nick Dyer <nick@shmanahar.org>, Sangwon Jee <jeesw@melfas.com>,
        Peter Hutterer <peter.hutterer@redhat.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        kernel@collabora.com
References: <40988408-8f36-3a52-6439-34084de6b129@redhat.com>
 <20200616172909.21625-1-andrzej.p@collabora.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f9007f37-c526-5fa4-3188-a554d2434177@redhat.com>
Date:   Wed, 17 Jun 2020 09:44:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616172909.21625-1-andrzej.p@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/16/20 7:29 PM, Andrzej Pietrasiewicz wrote:
> Document inhibiting input devices and its relation to being
> a wakeup source.
> 
> Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
> ---
> 
> @Hans, @Dmitry,
> 
> My fist attempt at documenting inhibiting. Kindly look at it to see if I haven't got anything
> wrong.
> 
> Andrzej
> 
>   Documentation/input/input-programming.rst | 36 +++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
> 
> diff --git a/Documentation/input/input-programming.rst b/Documentation/input/input-programming.rst
> index 45a4c6e05e39..0cd1ad4504fb 100644
> --- a/Documentation/input/input-programming.rst
> +++ b/Documentation/input/input-programming.rst
> @@ -164,6 +164,42 @@ disconnects. Calls to both callbacks are serialized.
>   The open() callback should return a 0 in case of success or any nonzero value
>   in case of failure. The close() callback (which is void) must always succeed.
>   
> +Inhibiting input devices
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Inhibiting a device means ignoring input events from it. As such it is about maintaining
> +relationships with input handlers - either an already existing relationships, or
> +relationships to be established while the device is in inhibited state.
> +
> +If a device is inhibited, no input handler will receive events from it.
> +
> +The fact that nobody wants events from the device is exploited further, by calling device's
> +close() (if there are users) and open() (if there are users) on inhibit and uninhibit
> +operations, respectively. Indeed, the meaning of close() is to stop providing events
> +to the input core and that of open() is to start providing events to the input core.

Maybe add the following here? :

Calling the device's close() method on inhibit (if there are users) allows the driver
to save power. Either by directly powering down the device or by releasing the
runtime-pm reference it got in open() when the driver is using runtime-pm.

Otherwise this looks good to me. Thank you for doing this, we (including myself)
really need to get better at doucmenting all sorts of kernel things. Often we have
these long discussions about something on the mailinglist and then everyone is
expected to just know what was decided from the on, which really doesn't work all
that well.

> +
> +Inhibiting and uninhibiting is orthogonal to opening and closing the device by input
> +handlers. Userspace might want to inhibit a device in anticipation before any handler is
> +positively matched against it.
> +
> +Inhibiting and uninhibiting is orthogonal to device's being a wakeup source, too. Being a
> +wakeup source plays a role when the system is sleeping, not when the system is operating.
> +How drivers should program their interaction between inhibiting, sleeping and being a wakeup
> +source is driver-specific.
> +
> +Taking the analogy with the network devices - bringing a network interface down doesn't mean
> +that it should be impossible to be wake the system up on LAN through this interface. So, there
> +may be input drivers which should be considered wakeup sources even when inhibited. Actually,
> +in many i2c input devices their interrupt is declared a wakeup interrupt and its handling
> +happens in driver's core, which is not aware of input-specific inhibit (nor should it be).
> +Composite devices containing several interfaces can be inhibited on a per-interface basis and
> +e.g. inhibiting one interface shouldn't affect the device's capability of being a wakeup source.
> +
> +If a device is to be considered a wakeup source while inhibited, special care must be taken when
> +programming its suspend(), as it might need to call device's open(). Depending on what close()
> +means for the device in question not opening() it before going to sleep might make it impossible
> +to provide any wakeup events. The device is going to sleep anyway.
> +
>   Basic event types
>   ~~~~~~~~~~~~~~~~~
>   
> 


Regards,

Hans

