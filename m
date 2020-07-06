Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3682C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 07:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8E1120760
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 07:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="l7oYazhd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgGFHbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 03:31:23 -0400
Received: from mout.web.de ([217.72.192.78]:48521 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728079AbgGFHbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 03:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1594020645;
        bh=QfjCKHMtlZHfoheYLH02gGSuk9Qg+re1L0gY3+r+k70=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=l7oYazhdyR2vohROj1obO28jr4B3yIg00hf4TJaufBJnE97RXjBvVPGxSRD71hImX
         Fl4Phan9ASwTrjnv910lURBsVP5AIs9BA7Bb0kbFZ0p2eXvvZJiZkqqaywIEcTsv4/
         zSGMIdJFsKXONn+jmEfxiwsZc0nHjmKoXTfuuGes=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.113.119]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mw9xG-1kk2hV1WgW-00s9go; Mon, 06
 Jul 2020 09:30:45 +0200
Subject: Re: [PATCH v5 14/14] irqchip/xilinx-intc: Fix potential resource leak
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <1593998365-25910-1-git-send-email-yangtiezhu@loongson.cn>
 <1593998365-25910-15-git-send-email-yangtiezhu@loongson.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 mQINBFg2+xABEADBJW2hoUoFXVFWTeKbqqif8VjszdMkriilx90WB5c0ddWQX14h6w5bT/A8
 +v43YoGpDNyhgA0w9CEhuwfZrE91GocMtjLO67TAc2i2nxMc/FJRDI0OemO4VJ9RwID6ltwt
 mpVJgXGKkNJ1ey+QOXouzlErVvE2fRh+KXXN1Q7fSmTJlAW9XJYHS3BDHb0uRpymRSX3O+E2
 lA87C7R8qAigPDZi6Z7UmwIA83ZMKXQ5stA0lhPyYgQcM7fh7V4ZYhnR0I5/qkUoxKpqaYLp
 YHBczVP+Zx/zHOM0KQphOMbU7X3c1pmMruoe6ti9uZzqZSLsF+NKXFEPBS665tQr66HJvZvY
 GMDlntZFAZ6xQvCC1r3MGoxEC1tuEa24vPCC9RZ9wk2sY5Csbva0WwYv3WKRZZBv8eIhGMxs
 rcpeGShRFyZ/0BYO53wZAPV1pEhGLLxd8eLN/nEWjJE0ejakPC1H/mt5F+yQBJAzz9JzbToU
 5jKLu0SugNI18MspJut8AiA1M44CIWrNHXvWsQ+nnBKHDHHYZu7MoXlOmB32ndsfPthR3GSv
 jN7YD4Ad724H8fhRijmC1+RpuSce7w2JLj5cYj4MlccmNb8YUxsE8brY2WkXQYS8Ivse39MX
 BE66MQN0r5DQ6oqgoJ4gHIVBUv/ZwgcmUNS5gQkNCFA0dWXznQARAQABtCZNYXJrdXMgRWxm
 cmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPokCVAQTAQgAPhYhBHDP0hzibeXjwQ/ITuU9
 Figxg9azBQJYNvsQAhsjBQkJZgGABQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEOU9Figx
 g9azcyMP/iVihZkZ4VyH3/wlV3nRiXvSreqg+pGPI3c8J6DjP9zvz7QHN35zWM++1yNek7Ar
 OVXwuKBo18ASlYzZPTFJZwQQdkZSV+atwIzG3US50ZZ4p7VyUuDuQQVVqFlaf6qZOkwHSnk+
 CeGxlDz1POSHY17VbJG2CzPuqMfgBtqIU1dODFLpFq4oIAwEOG6fxRa59qbsTLXxyw+PzRaR
 LIjVOit28raM83Efk07JKow8URb4u1n7k9RGAcnsM5/WMLRbDYjWTx0lJ2WO9zYwPgRykhn2
 sOyJVXk9xVESGTwEPbTtfHM+4x0n0gC6GzfTMvwvZ9G6xoM0S4/+lgbaaa9t5tT/PrsvJiob
 kfqDrPbmSwr2G5mHnSM9M7B+w8odjmQFOwAjfcxoVIHxC4Cl/GAAKsX3KNKTspCHR0Yag78w
 i8duH/eEd4tB8twcqCi3aCgWoIrhjNS0myusmuA89kAWFFW5z26qNCOefovCx8drdMXQfMYv
 g5lRk821ZCNBosfRUvcMXoY6lTwHLIDrEfkJQtjxfdTlWQdwr0mM5ye7vd83AManSQwutgpI
 q+wE8CNY2VN9xAlE7OhcmWXlnAw3MJLW863SXdGlnkA3N+U4BoKQSIToGuXARQ14IMNvfeKX
 NphLPpUUnUNdfxAHu/S3tPTc/E/oePbHo794dnEm57LuuQINBFg2+xABEADZg/T+4o5qj4cw
 nd0G5pFy7ACxk28mSrLuva9tyzqPgRZ2bdPiwNXJUvBg1es2u81urekeUvGvnERB/TKekp25
 4wU3I2lEhIXj5NVdLc6eU5czZQs4YEZbu1U5iqhhZmKhlLrhLlZv2whLOXRlLwi4jAzXIZAu
 76mT813jbczl2dwxFxcT8XRzk9+dwzNTdOg75683uinMgskiiul+dzd6sumdOhRZR7YBT+xC
 wzfykOgBKnzfFscMwKR0iuHNB+VdEnZw80XGZi4N1ku81DHxmo2HG3icg7CwO1ih2jx8ik0r
 riIyMhJrTXgR1hF6kQnX7p2mXe6K0s8tQFK0ZZmYpZuGYYsV05OvU8yqrRVL/GYvy4Xgplm3
 DuMuC7/A9/BfmxZVEPAS1gW6QQ8vSO4zf60zREKoSNYeiv+tURM2KOEj8tCMZN3k3sNASfoG
 fMvTvOjT0yzMbJsI1jwLwy5uA2JVdSLoWzBD8awZ2X/eCU9YDZeGuWmxzIHvkuMj8FfX8cK/
 2m437UA877eqmcgiEy/3B7XeHUipOL83gjfq4ETzVmxVswkVvZvR6j2blQVr+MhCZPq83Ota
 xNB7QptPxJuNRZ49gtT6uQkyGI+2daXqkj/Mot5tKxNKtM1Vbr/3b+AEMA7qLz7QjhgGJcie
 qp4b0gELjY1Oe9dBAXMiDwARAQABiQI8BBgBCAAmFiEEcM/SHOJt5ePBD8hO5T0WKDGD1rMF
 Alg2+xACGwwFCQlmAYAACgkQ5T0WKDGD1rOYSw/+P6fYSZjTJDAl9XNfXRjRRyJSfaw6N1pA
 Ahuu0MIa3djFRuFCrAHUaaFZf5V2iW5xhGnrhDwE1Ksf7tlstSne/G0a+Ef7vhUyeTn6U/0m
 +/BrsCsBUXhqeNuraGUtaleatQijXfuemUwgB+mE3B0SobE601XLo6MYIhPh8MG32MKO5kOY
 hB5jzyor7WoN3ETVNQoGgMzPVWIRElwpcXr+yGoTLAOpG7nkAUBBj9n9TPpSdt/npfok9ZfL
 /Q+ranrxb2Cy4tvOPxeVfR58XveX85ICrW9VHPVq9sJf/a24bMm6+qEg1V/G7u/AM3fM8U2m
 tdrTqOrfxklZ7beppGKzC1/WLrcr072vrdiN0icyOHQlfWmaPv0pUnW3AwtiMYngT96BevfA
 qlwaymjPTvH+cTXScnbydfOQW8220JQwykUe+sHRZfAF5TS2YCkQvsyf7vIpSqo/ttDk4+xc
 Z/wsLiWTgKlih2QYULvW61XU+mWsK8+ZlYUrRMpkauN4CJ5yTpvp+Orcz5KixHQmc5tbkLWf
 x0n1QFc1xxJhbzN+r9djSGGN/5IBDfUqSANC8cWzHpWaHmSuU3JSAMB/N+yQjIad2ztTckZY
 pwT6oxng29LzZspTYUEzMz3wK2jQHw+U66qBFk8whA7B2uAU1QdGyPgahLYSOa4XAEGb6wbI FEE=
Message-ID: <5a2564f9-9280-9223-3e24-439fec81ab75@web.de>
Date:   Mon, 6 Jul 2020 09:30:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1593998365-25910-15-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vHXuIF/3iIJjG7wqyPCGTOnE/3/6TtDh8kA409b4YClZxAFDju6
 f33Vv5jQbe65a+Bn/hiFEodf5zpUG8rFrbsja+EKxIdrXNIDpd/crCwsEY1ZsH3w/Ry3KNd
 HWqXLzYbaBfuWe/PaISB/1bqmTsJagNNI60V2QAOH/8zijL7FEbIOpvW4UKDAw3mGRGZvOt
 sC8gf1yL80ax5A/cf26+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0m87Wpx0wNU=:y/H9uwOLXS/Gt1G97SPeUo
 8XWNEVjT4CpuVeID2VcwSw7mrvarWtFDLbLA5EerPfsMotKzlZawYGhvzs0FLDNy1+zVmDSif
 i8xBtqycnuatbxOtR9GP6cR1w1kBvznWusWtPm40bnDO+eosHP+iG69kGlHm5aIs5X7rF1AC/
 gZt1X4EE/Y27ylO4JuyXtjOsROyMmugTzRP7t0IBCUtKQO+LbNOqE4MsBpRaeZtTvoQ971XYJ
 ZdpEVcBNZIIG7zaYHjxoX3i/sUE6ZYs5+I4SsGvKvQDJ5U67IvJEiA/94r4ImAyWd8i8I3Ci4
 pP4drL+aOniqMhLvkDwGprF9JQW2xoFROoXNHDQeuymhlpzJ5KUJhPRRuTANc0k3KxCgaYeO2
 E9bVZypO0J5yqnS43T6+hF8cP81Ghz4Hc7y9jINGZfYXGG5p25zqS6XcZW6cWdcgqDTDRKXjc
 DsuzdnsBHIkk0YlKpckrcXh+H5NmMUv4gLXo4eV8tDkElc07A/8Mm/SQ8BLBMGdFR9kSpYRrD
 nhPEgyldjOkNk5gVGWvlqm+JEXx2raTRXKonFm4dKLs8oAOMDC5HbRkm59JPaf2X+Vi/LH4SM
 CraMLW+oG8MQI/rC2URbSl2o5jmkXgME9fpoLH+vkJqtUaI8F9uaPnby4FqSGhOqbsKQ6ddKW
 mJqSrsX8xZigxL92Zkq12n28VuosySurRpeEW4yp9b9y0iquw5eUXth2oj/G/LZTZVUcxFeiV
 nv4zbsx1Ic8dMFA6VrpYbTbgyYNUbG4juWMrnEbuGwnuuuW8xsyJse5HPmRoxXRdF7txjKysN
 Xjjc+6jdwBEvMmKtMjjyGi8Twz01rX52bUDHWTPe3ZXbNA7e2U0OnTlRZVuwYDa0ebLEFS2TF
 BpN4pJBOig/su8XdC4htPlqlwQPqU2if11DxxSuSxp2UxyDThpanNQ7XyHVZPilnkHUtGoOUf
 cAGgGT3jtYhFJmamTVpZBKKkCyy9WUWfbcGl8NdItfQIiLuxLNX5vx9A3Ham/CmPZHx+sIHO9
 CxZXbamznn20WTuiWJAG0bOgwiydgjrm1eJIcYhSKUjHJ0Nf9Srj1Q+L38953BzDQMGT23WpA
 c2u/Ql0SNOEpXNkEEkYHGD8FEtOhl4Z325La15RTGBYVfkPJjYgspxGkFlGcO1p28o/qFyTW6
 LvVaEz/6XiyPW3ZMR+6bKFrpNFXMVnJ5uPqA1dcvPN2bi45sz4GMWH/ANOQ5halfMa7232ZCf
 tF+sU5fOmdlHezRe8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In the function xilinx_intc_of_init(), system resource "irqc->root_domai=
n"
> was not released in an error case. Thus add a jump target to call the
> function "irq_domain_remove" for the completion of the desired exception
> handling.

Do the corresponding diff hunks express also a renaming of the label =E2=
=80=9Cerror=E2=80=9D?

Is there a need to split such an adjustment?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?id=3Ddcb7fd82c75ee2d6e6f9d8cc71=
c52519ed52e258#n138

Regards,
Markus
