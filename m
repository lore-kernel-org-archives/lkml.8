Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8ACC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F50C2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgHLN15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 09:27:57 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:59765 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbgHLN1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 09:27:52 -0400
Received: from [192.168.1.155] ([77.7.70.104]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N2SXX-1kq4Il39SR-013vZ2; Wed, 12 Aug 2020 15:27:48 +0200
Subject: Re: [Q] devicetree overlays
To:     Sven Van Asbroeck <thesven73@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAGngYiVa9v9jGPNu4W+KHUnvemKU-BVE89-XNLcWOmoZjAPMTg@mail.gmail.com>
 <24f1687c-043a-a15e-0be4-8392e7b5c96b@metux.net>
 <CAGngYiVokqYkEiQTcqAMnvif3qEWkPOb1cAk+4rvwgxBKZ5Ukw@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <1acc987a-d844-fca7-77eb-cf1d466f35c1@metux.net>
Date:   Wed, 12 Aug 2020 15:27:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAGngYiVokqYkEiQTcqAMnvif3qEWkPOb1cAk+4rvwgxBKZ5Ukw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MIsNc+6wckw0bhN3I+OPYIOG5NscHslgh+KIMp0EpXcmxLAo2UV
 PKF2oEMIqd5jUQCZwGV8YWpxNVDXZeqQOuagMgN1gyJULvjaMozkci2csfUQJNFf8qb7eBN
 8/tGYAIAEe2/vwvK6LXg7ieiP8b91P73Zw4WOl4zHTWsSqMm6l+f+SZZCjNUR4IqSASFFqT
 yr1N4kJ7TGdZupAN628tw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ThtyLd1Fmwg=:tr/DyrIjMkrSSj6ONl15vD
 pq1HzKpqmn8sK/RxSFegjJtb9HSxrF4XYetGjWW8YEPtbfP/jZRiPUPW5TCvQ/JD7lwMZlbTW
 kQyAdFpMT9F+Vel9LRUE23hQgkK04chUPOvWpD8HMYT8MZuGlR8U6zthqTwku7NcqbZgUtUrA
 +C+KiwY0FyDNc0AGqQDWqYa6P2bUK0XH8p/f0+9+XXqLNP0y/Tv9uVVr3O73KJdkR8SRdwFOM
 2CBk1gpshPvN6ImcinftK9eK5CFWYflmccc+L+XfMe6YWT3rEgvDdlFvfk7oQwiNw4aswK/h7
 71ShuQemhmuWq89d9nWaS0VzMqB7G8AQPmw5DNIzE65b8UQL/nuLzPZJNXhu1Drv61G5nobqu
 iwV+ZJrQao1+mfNl1u32BNAvPi3qBk2NHA5WxBa+9Ej3zclh0oBqgewJcZRkdYa8EGc3VSJxv
 /7Go6fL5zF21pU7vvh9XMg5qhxougwlGFiavyZOi54lfRt/FZNQIHT1C02NlEJYcjqFhoH23B
 3yJGj4reee2NCerYuZThDNrIT63YkqixJOe4iJbdg+GW9il4JbkxD/fD3efW1I2p8E5gTZU3B
 GZoYQ9N50wNwb2ReWyE9IKFWdd/iMrZWApumMJrJhwRuF5NX5The6z7fCUk0syTqBN7dhwWA9
 ByksmrF8LxZYgTuLWx8B5+9lcsO/1o4pkv9At32hAW7rB0AV9Wpb2EZETXVYak4K0sf4J+oa9
 VzCV3VzcnbIZEuteK3AmNC4TleZEDWjY+WkggDlBrDqqc3EWT3TeUdTat39jFhc/DGBnMlwO9
 dNGtrZgB5LiPMVVukFtJLUlDYSwFlQc8pYXr9KTakiHIMmW+TdPAjtVXhEVdW5+SpICDY3C
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.08.20 16:17, Sven Van Asbroeck wrote:

Hi,

> I believe you're asking: "how do I associate device tree nodes to
> devices on a dynamically discoverable bus such as USB or PCI" right ?
> 
> I believe that already exists. You can describe the _expected_ pci or
> usb topology in the
> devicetree. If a device gets detected in a spot on the bus described
> in the tree, that
> snippet will be automatically associated with this device.
> 
> How to for usb:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/usb/usb-device.txt?h=v5.8
> 
> How to for pci:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pci/pci.txt?h=v5.8

Thanks, that looks good.

But I've still got another problem: how can I use DT along w/ ACPI ?

The scenario goes like this:

* machine boots and probes normally w/ ACPI
* device is detected via USB, PCI, DMI, etc -> driver gets active
* driver loads (or carries) a DT snippet
* devices on the bus are instantiated via this DT snippet

(driver could also be some udev vodoo)

Example a:

* generic usb i2c dongle w/ some i2c devices attached behind it
* config (or DT snippet) somewhere in the FS

Example b:

* x86 board driver (eg. apu2/3/4), probed via DMI
* just instantiates a bunch of generic drivers and wires up
  devices (gpio, leds, keys, ...)


Do you think we can already do that ?
Otherwise, what has to be done to achieve that ?	


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
