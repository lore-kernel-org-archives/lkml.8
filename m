Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C7BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19C32206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RNgBmriM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbgFJNw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 09:52:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27581 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729548AbgFJNwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 09:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591797140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YL2CUX+ytcqKztbtjkEaTAotWFK6JYYqCnPu2fBEOuA=;
        b=RNgBmriM4ahFUxcS7Fg9c2XAKyovRc1vbF3yWBevYkrsDtYMZYq+0YkfnznkHE7+87EJiz
        8cG3QCQqdrGNc0n8sVym0ptbpk5JY0AId2TxhStM8tX/tw86bzhGaE0OS+2A4XTehSFOHL
        SbVZ2Gna7dWtJJxjK6K+HwBkthAcMJ4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-J9FwTJV_N_6ZHEb4mrMM0g-1; Wed, 10 Jun 2020 09:52:18 -0400
X-MC-Unique: J9FwTJV_N_6ZHEb4mrMM0g-1
Received: by mail-ed1-f71.google.com with SMTP id c1so672474edd.21
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 06:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YL2CUX+ytcqKztbtjkEaTAotWFK6JYYqCnPu2fBEOuA=;
        b=EDBmob9t/rY4cDjunoGAyAyItyyDmf+ZN/9RqUXzXyRgC1zG1ilLlhz7X4Sg0vzizR
         yIgewtKn+9hTt2p8CPXU4n4whxdvhlmeQUzZgOLu2rJyblKC1s/xDfc/7H6I6/oZYpkH
         xNhKrC+46uO64ju8Jnw0faZePGP4I+TV/EmDnVACH/HhLYKmezKjsXKuV9uHRTq9brFn
         GMknlCenylPF20fLMbn0c8c/Vha1ztPOkkY4Z9/i99v1jrmIux5JxeUNHjkKSTvWBgvz
         Y1LN3u/OEwbLoWZKMrOZypj3Kcic+Y2jRTQ60uxQ3W5m3fek4ciDKb1CIoDYekKamomH
         UMEA==
X-Gm-Message-State: AOAM532UtkqFu/tkz3q2wyJe/e3Ny9ukDq7MuQtTAUDD04g0CRAt0hgF
        CnTHlHTjnc+avEIxuyVv6AKI6D81JN42SdpYbPHQLYGcsLdsamIMsXfJ1vsgbVmOwW3rOBh50oo
        DqWllkdVnM/l17VPZUiOtGhBA
X-Received: by 2002:a50:b2e1:: with SMTP id p88mr2582806edd.198.1591797137519;
        Wed, 10 Jun 2020 06:52:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEJek1TXZYUkZ6pG2p869jbxR9ODYMKVkeJa1/sT8kaPG7Zk4zmYdct4EtD9GIM7FcH0rbNA==
X-Received: by 2002:a50:b2e1:: with SMTP id p88mr2582761edd.198.1591797137192;
        Wed, 10 Jun 2020 06:52:17 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id dm1sm16655504ejc.99.2020.06.10.06.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2020 06:52:16 -0700 (PDT)
Subject: Re: [PATCH v4 0/7] Support inhibiting input devices
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>,
        linux-input@vger.kernel.org,
        linux-tegra <linux-tegra@vger.kernel.org>,
        patches@opensource.cirrus.com,
        ibm-acpi-devel@lists.sourceforge.net,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
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
        Nick Dyer <nick@shmanahar.org>,
        Ferruh Yigit <fery@cypress.com>,
        Sangwon Jee <jeesw@melfas.com>,
        Peter Hutterer <peter.hutterer@redhat.com>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Collabora Kernel ML <kernel@collabora.com>
References: <2336e15d-ff4b-bbb6-c701-dbf3aa110fcd@redhat.com>
 <20200608112211.12125-1-andrzej.p@collabora.com>
 <964ca07a-3da5-101f-7edf-64bdeec98a4b@redhat.com>
 <CAJZ5v0hB2ra2K=dd9ZjVyy1V2b1PmFHm79uDO2HtHU1D_4YUbw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <cd0dc625-c0bf-8322-fc31-c5eccb4be1cd@redhat.com>
Date:   Wed, 10 Jun 2020 15:52:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hB2ra2K=dd9ZjVyy1V2b1PmFHm79uDO2HtHU1D_4YUbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/10/20 12:38 PM, Rafael J. Wysocki wrote:
> On Wed, Jun 10, 2020 at 11:50 AM Hans de Goede <hdegoede@redhat.com> wrote:

<snip>

>> A different, but related issue is how to make devices actually use the
>> new inhibit support on the builtin keyboard + touchpad when say the lid
>> is closed.   Arguably this is an userspace problem, but it is a tricky
>> one. Currently on most modern Linux distributions suspend-on-lid-close
>> is handled by systemd-logind and most modern desktop-environments are
>> happy to have logind handle this for them.
>>
>> But most knowledge about input devices and e.g. heurisitics to decide
>> if a touchpad is internal or external are part of libinput. Now we could
>> have libinput use the new inhibit support (1), but then when the lid
>> closes we get race between whatever process is using libinput trying
>> to inhibit the touchpad (which must be done before to suspend to disable
>> it as wakeup source) and logind trying to suspend the system.
>>
>> One solution here would be to move the setting of the inhibit sysfs
>> attr into logind, but that requires adding a whole bunch of extra
>> knowledge to logind which does not really belong there IMHO.
>>
>> I've been thinking a bit about this and to me it seems that the kernel
>> is in the ideal position to automatically inhibit some devices when
>> some EV_SW transitions from 0->1 (and uninhibit again on 1->0). The
>> issue here is to chose on which devices to enable this. I believe
>> that the auto inhibit on some switches mechanism is best done inside
>> the kernel (disabled by default) and then we can have a sysfs
>> attr called auto_inhibit_ev_sw_mask which can be set to e.g.
>> (1 << SW_LID) to make the kernel auto-inhibit the input-device whenever
>> the lid is closed, or to ((1 << SW_LID) | (1 << SW_TABLET_MODE)) to
>> inhibit both when the lid is closed or when switched to tablet mode.
> 
> I agree that the kernel is the right place to handle this, but it
> requires some extra knowledge about dependencies between devices.
>
> It'd be kind of like power resources in ACPI, so for each state of a
> "master" device (in principle, there may be more states of it than
> just two) there would be a list of "dependent" intput devices that
> need to be inhibited when the "master" device goes into that state.

So a big part of the reason to punt the decision on which input
devices to enable this auto-inhibit is that we don't really have
information about those relationsships / device-links you are
suggesting here.  libinput is already doing inhibiting inside
userspace for e.g. the tablet-mode switch but it relies on heuristics
+ quirk tables to decide which keyboards should be inhibited and which
not.

E.g. for a 360 degree hinges 2-in-1 we want to disable the builtin
keyboard, when folded into in tablet mode, but not any external ones.

Mostly the builtin kbd will be PS2 but I have one such 2-in-1 here
in my home office with a USB kbd ...

In general of the master devices there will be only 1, there will be
only 1 lid switch and only 1 tablet-mode switch. So my idea with the
auto_inhibit_ev_sw_mask, is for it to be a per input-device setting.

So using your terms, all input devices with the (1 << SW_LID) bit
set in their auto_inhibit_ev_sw_mask will be dependents of the
(master) device which actually is reporting the SW_LID bit.

The idea here is for this to work the same as how the rfkill code
from net/rfkill/input.c works, except instead of binding e.g.
KEY_WLAN to toggling the sw-state of rfkill devices with a type
of RFKILL_TYPE_WLAN. This will bind SW_LID to inhibiting input
devices with the SW_LID bit set in their auto_inhibit_ev_sw_mask.

Regards,

Hans

