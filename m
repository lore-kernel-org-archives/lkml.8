Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6F6C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA9420724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p9YlGBNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgCRRix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:38:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40006 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgCRRix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:38:53 -0400
Received: by mail-wm1-f68.google.com with SMTP id z12so4344051wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:autocrypt:to:cc:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=AKNM+u4tFTDVzydrvk84DIfrMpJTc417JXmPwG7RBb0=;
        b=p9YlGBNdGxZQio4WtosEf3HduBi/ENY6P4nSfz/+csfCH9mlN3lSi4927XUjv7R0FW
         aHpzOoQmH7C2UxjlSdIRtpjeL9U6NjgqoUGLSDd+AtfhdW46XKnlz9Xy+0GbSDvlmktz
         rKf3SXO3YkvrVHE7Hus0OHYrcXtfJVhxgl9G9RkinTFvJcnJngeTT9VnycuSeSgVK4/U
         bkwNa0EaaAZNvjFyPqtuDNdNcYWpWFkdAPJ0sy8WiwJEAreVhwrwWMwCXGi7SZbIqHs1
         sM97hpIRiHdejlCcl+vwWDiXP1xfn3FvJX/hszkAejqeL56wEp0pvQmHCx+wf1HP5wzn
         zkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:autocrypt:to:cc:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=AKNM+u4tFTDVzydrvk84DIfrMpJTc417JXmPwG7RBb0=;
        b=Y4EZvT7CawctNa/om3yARwE7g7KLb4A4zqrr7eoLV5ndiZ0L97SGJq9TbutuVVwJgn
         8DdJzYXOo4lcQzBWleb9ezSrwuIvhycaHYbVzgeFnYc03typmMTPiKRQ7JkGsNDtdrND
         0JQeDXWC3aB2kDemMcn9ZseSVdn8Z6cj4tlmyrj2rLDM5y2RysDfEZRlGnmJT/HdlEbn
         MgneFyVWPSxRgVLEHBqZk9PIV/YrmysBTslkPeNEjrOe0AVR4AQ6YCZ2fDkrJYMYLGXg
         pIpjuC+JPH7ZJyI62V7h+f4RQ7sxbjbyX6HuoMKO30ocN1tBw3cmyRURuwhcvrcSGVVR
         IPvg==
X-Gm-Message-State: ANhLgQ1uJOkHWbKWhPAVQaQkCBVahH4gbCoXNNOBT8aUeW8hNL00fNzz
        Mho7rmYlvIfXy7GfFWA+C+0B7g==
X-Google-Smtp-Source: ADFU+vv4cTBCkZd7IMohtBSAg1jnlEkZsSz+DOS0iaxyjqwKMhhENU8EPyFl3xYfDW4umPdi3fkVMQ==
X-Received: by 2002:a7b:c414:: with SMTP id k20mr6241301wmi.119.1584553130878;
        Wed, 18 Mar 2020 10:38:50 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5d64:ea6:49bd:69d7? ([2a01:e34:ed2f:f020:5d64:ea6:49bd:69d7])
        by smtp.googlemail.com with ESMTPSA id j6sm5319276wrx.85.2020.03.18.10.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 10:38:50 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 xsFNBFv/yykBEADDdW8RZu7iZILSf3zxq5y8YdaeyZjI/MaqgnvG/c3WjFaunoTMspeusiFE
 sXvtg3ehTOoyD0oFjKkHaia1Zpa1m/gnNdT/WvTveLfGA1gH+yGes2Sr53Ht8hWYZFYMZc8V
 2pbSKh8wepq4g8r5YI1XUy9YbcTdj5mVrTklyGWA49NOeJz2QbfytMT3DJmk40LqwK6CCSU0
 9Ed8n0a+vevmQoRZJEd3Y1qXn2XHys0F6OHCC+VLENqNNZXdZE9E+b3FFW0lk49oLTzLRNIq
 0wHeR1H54RffhLQAor2+4kSSu8mW5qB0n5Eb/zXJZZ/bRiXmT8kNg85UdYhvf03ZAsp3qxcr
 xMfMsC7m3+ADOtW90rNNLZnRvjhsYNrGIKH8Ub0UKXFXibHbafSuq7RqyRQzt01Ud8CAtq+w
 P9EftUysLtovGpLSpGDO5zQ++4ZGVygdYFr318aGDqCljKAKZ9hYgRimPBToDedho1S1uE6F
 6YiBFnI3ry9+/KUnEP6L8Sfezwy7fp2JUNkUr41QF76nz43tl7oersrLxHzj2dYfWUAZWXva
 wW4IKF5sOPFMMgxoOJovSWqwh1b7hqI+nDlD3mmVMd20VyE9W7AgTIsvDxWUnMPvww5iExlY
 eIC0Wj9K4UqSYBOHcUPrVOKTcsBVPQA6SAMJlt82/v5l4J0pSQARAQABzSpEYW5pZWwgTGV6
 Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz7Cwa4EEwEIAEECGwEFCwkIBwIGFQoJ
 CAsCBBYCAwECHgECF4ACGQEWIQQk1ibyU76eh+bOW/SP9LjScWdVJwUCXAkeagUJDRnjhwAh
 CRCP9LjScWdVJxYhBCTWJvJTvp6H5s5b9I/0uNJxZ1Un69gQAJK0ODuKzYl0TvHPU8W7uOeu
 U7OghN/DTkG6uAkyqW+iIVi320R5QyXN1Tb6vRx6+yZ6mpJRW5S9fO03wcD8Sna9xyZacJfO
 UTnpfUArs9FF1pB3VIr95WwlVoptBOuKLTCNuzoBTW6jQt0sg0uPDAi2dDzf+21t/UuF7I3z
 KSeVyHuOfofonYD85FkQJN8lsbh5xWvsASbgD8bmfI87gEbt0wq2ND5yuX+lJK7FX4lMO6gR
 ZQ75g4KWDprOO/w6ebRxDjrH0lG1qHBiZd0hcPo2wkeYwb1sqZUjQjujlDhcvnZfpDGR4yLz
 5WG+pdciQhl6LNl7lctNhS8Uct17HNdfN7QvAumYw5sUuJ+POIlCws/aVbA5+DpmIfzPx5Ak
 UHxthNIyqZ9O6UHrVg7SaF3rvqrXtjtnu7eZ3cIsfuuHrXBTWDsVwub2nm1ddZZoC530BraS
 d7Y7eyKs7T4mGwpsi3Pd33Je5aC/rDeF44gXRv3UnKtjq2PPjaG/KPG0fLBGvhx0ARBrZLsd
 5CTDjwFA4bo+pD13cVhTfim3dYUnX1UDmqoCISOpzg3S4+QLv1bfbIsZ3KDQQR7y/RSGzcLE
 z164aDfuSvl+6Myb5qQy1HUQ0hOj5Qh+CzF3CMEPmU1v9Qah1ThC8+KkH/HHjPPulLn7aMaK
 Z8t6h7uaAYnGzjMEXZLIEhYJKwYBBAHaRw8BAQdAGdRDglTydmxI03SYiVg95SoLOKT5zZW1
 7Kpt/5zcvt3CwhsEGAEIACAWIQQk1ibyU76eh+bOW/SP9LjScWdVJwUCXZLIEgIbAgCvCRCP
 9LjScWdVJ40gBBkWCAAdFiEEbinX+DPdhovb6oob3uarTi9/eqYFAl2SyBIAIQkQ3uarTi9/
 eqYWIQRuKdf4M92Gi9vqihve5qtOL396pnZGAP0c3VRaj3RBEOUGKxHzcu17ZUnIoJLjpHdk
 NfBnWU9+UgD/bwTxE56Wd8kQZ2e2UTy4BM8907FsJgAQLL4tD2YZggwWIQQk1ibyU76eh+bO
 W/SP9LjScWdVJ5CaD/0YQyfUzjpR1GnCSkbaLYTEUsyaHuWPI/uSpKTtcbttpYv+QmYsIwD9
 8CeH3zwY0Xl/1fE9Hy59z6Vxv9YVapLx0nPDOA1zDVNq2MnutxHb8t+Imjz4ERCxysqtfYrv
 gao3E/h0c8SEeh+bh5MkjwmU8CwZ3doWyiVdULKESe7/Gs5OuhFzaDVPCpWdsKdCAGyUuP/+
 qRWwKGVpWP0Rrt6MTK24Ibeu3xEZO8c3XOEXH5d9nf6YRqBEIizAecoCr00E9c+6BlRS0AqR
 OQC3/Mm7rWtco3+WOridqVXkko9AcZ8AiM5nu0F8AqYGKg0y7vkL2LOP8us85L0p57MqIR1u
 gDnITlTY0x4RYRWJ9+k7led5WsnWlyv84KNzbDqQExTm8itzeZYW9RvbTS63r/+FlcTa9Cz1
 5fW3Qm0BsyECvpAD3IPLvX9jDIR0IkF/BQI4T98LQAkYX1M/UWkMpMYsL8tLObiNOWUl4ahb
 PYi5Yd8zVNYuidXHcwPAUXqGt3Cs+FIhihH30/Oe4jL0/2ZoEnWGOexIFVFpue0jdqJNiIvA
 F5Wpx+UiT5G8CWYYge5DtHI3m5qAP9UgPuck3N8xCihbsXKX4l8bdHfziaJuowief7igeQs/
 WyY9FnZb0tl29dSa7PdDKFWu+B+ZnuIzsO5vWMoN6hMThTl1DxS+jc7ATQRb/8z6AQgAvSkg
 5w7dVCSbpP6nXc+i8OBz59aq8kuL3YpxT9RXE/y45IFUVuSc2kuUj683rEEgyD7XCf4QKzOw
 +XgnJcKFQiACpYAowhF/XNkMPQFspPNM1ChnIL5KWJdTp0DhW+WBeCnyCQ2pzeCzQlS/qfs3
 dMLzzm9qCDrrDh/aEegMMZFO+reIgPZnInAcbHj3xUhz8p2dkExRMTnLry8XXkiMu9WpchHy
 XXWYxXbMnHkSRuT00lUfZAkYpMP7La2UudC/Uw9WqGuAQzTqhvE1kSQe0e11Uc+PqceLRHA2
 bq/wz0cGriUrcCrnkzRmzYLoGXQHqRuZazMZn2/pSIMZdDxLbwARAQABwsGNBBgBCAAgFiEE
 JNYm8lO+nofmzlv0j/S40nFnVScFAlv/zPoCGwwAIQkQj/S40nFnVScWIQQk1ibyU76eh+bO
 W/SP9LjScWdVJ/g6EACFYk+OBS7pV9KZXncBQYjKqk7Kc+9JoygYnOE2wN41QN9Xl0Rk3wri
 qO7PYJM28YjK3gMT8glu1qy+Ll1bjBYWXzlsXrF4szSqkJpm1cCxTmDOne5Pu6376dM9hb4K
 l9giUinI4jNUCbDutlt+Cwh3YuPuDXBAKO8YfDX2arzn/CISJlk0d4lDca4Cv+4yiJpEGd/r
 BVx2lRMUxeWQTz+1gc9ZtbRgpwoXAne4iw3FlR7pyg3NicvR30YrZ+QOiop8psWM2Fb1PKB9
 4vZCGT3j2MwZC50VLfOXC833DBVoLSIoL8PfTcOJOcHRYU9PwKW0wBlJtDVYRZ/CrGFjbp2L
 eT2mP5fcF86YMv0YGWdFNKDCOqOrOkZVmxai65N9d31k8/O9h1QGuVMqCiOTULy/h+FKpv5q
 t35tlzA2nxPOX8Qj3KDDqVgQBMYJRghZyj5+N6EKAbUVa9Zq8xT6Ms2zz/y7CPW74G1GlYWP
 i6D9VoMMi6ICko/CXUZ77OgLtMsy3JtzTRbn/wRySOY2AsMgg0Sw6yJ0wfrVk6XAMoLGjaVt
 X4iPTvwocEhjvrO4eXCicRBocsIB2qZaIj3mlhk2u4AkSpkKm9cN0KWYFUxlENF4/NKWMK+g
 fGfsCsS3cXXiZpufZFGr+GoHwiELqfLEAQ9AhlrHGCKcgVgTOI6NHg==
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Anson Huang <anson.huang@nxp.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        Zhou Yanjie <zhouyanjie@wanyeetech.com>,
        Suman Anna <s-anna@ti.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Joel Stanley <joel@jms.id.au>, matheus@castello.eng.br,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] timer drivers for v5.7
Message-ID: <e6cd8adf-60df-437a-003f-58e3403e4697@linaro.org>
Date:   Wed, 18 Mar 2020 18:38:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

here is the new material for v5.7.

It merges an immutable branch available for pwm on TI as asked by Tony
Lindgren.

	https://lkml.org/lkml/2020/3/16/411

The following changes since commit 5fb1c2a5bbf79ccca8d17cf97f66085be5808027:

  posix-timers: Pass lockdep expression to RCU lists (2020-02-17
20:12:19 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/daniel.lezcano/linux.git tags/timers-v5.7

for you to fetch changes up to 4f41fe386a94639cd9a1831298d4f85db5662f1e:

  clocksource/drivers/timer-probe: Avoid creating dead devices
(2020-03-17 13:10:07 +0100)

----------------------------------------------------------------
- Avoid creating dead devices by flagging the driver with OF_POPULATED
  in order to prevent the platform to create another device (Saravana
Kannan)

- Remove unused includes from imx family drivers (Anson Huang)

- timer-dm-ti rework to prepare for pwm and suspend support (Lokesh Vutla)

- Fix the rate for the global clock on the pit64b (Claudiu Beznea)

- Fix timer-cs5535 by requesting an irq with non-NULL dev_id (Afzal
Mohammed)

- Replace setup_irq() by request_irq() (Afzal Mohammed)

- Add support for the TCU of X1000 (Zhou Yanjie)

- Drop the bogus omap_dm_timer_of_set_source() function (Suman Anna)

- Do not update the counter when updating the period in order to
  prevent a disruption when the pwm is used (Lokesh Vutla)

- Improve owl_timer_init() failure messages (Matheus Castello)

- Add driver for the Ingenic JZ47xx OST (Maarten ter Huurne)

- Pass the interrupt and the shutdown callbacks in the init function
  for ast2600 support (Joel Stanley)

- Add the ast2600 compatible string for the fttmr010 (Joel Stanley)

----------------------------------------------------------------
Anson Huang (2):
      clocksource/drivers/imx-tpm: Remove unused includes
      clocksource/drivers/imx-sysctr: Remove unused includes

Claudiu Beznea (1):
      clocksource/drivers/timer-microchip-pit64b: Fix rate for gck

Daniel Lezcano (1):
      Merge branch 'timers/drivers/timer-ti-dm' into timers/drivers/next

Joel Stanley (3):
      clocksource/drivers/fttmr010: Parametrise shutdown
      clocksource/drivers/fttmr010: Set interrupt and shutdown
      dt-bindings: fttmr010: Add ast2600 compatible

Lokesh Vutla (6):
      clocksource/drivers/timer-ti-dm: Do not update counter on updating
the period
      clocksource/drivers/timer-ti-dm: Convert to SPDX identifier
      clocksource/drivers/timer-ti-dm: Implement cpu_pm notifier for
context save and restore
      clocksource/drivers/timer-ti-dm: Do not update counter on updating
the period
      clocksource/drivers/timer-ti-dm: Add support to get pwm current status
      clocksource/drivers/timer-ti-dm: Enable autoreload in set_pwm

Maarten ter Huurne (1):
      clocksource: Add driver for the Ingenic JZ47xx OST

Matheus Castello (1):
      clocksource/drivers/owl: Improve owl_timer_init fail messages

Saravana Kannan (1):
      clocksource/drivers/timer-probe: Avoid creating dead devices

Suman Anna (1):
      clocksource/drivers/timer-ti-dm: Drop bogus
omap_dm_timer_of_set_source()

Tony Lindgren (1):
      clocksource/drivers/timer-ti-dm: Prepare for using cpuidle

afzal mohammed (2):
      clocksource: Replace setup_irq() by request_irq()
      clocksource/drivers/timer-cs5535: Request irq with non-NULL dev_id

周琰杰 (Zhou Yanjie) (2):
      dt-bindings: timer: Add X1000 bindings.
      clocksource/drivers/ingenic: Add support for TCU of X1000

 .../devicetree/bindings/timer/faraday,fttmr010.txt |   1 +
 .../devicetree/bindings/timer/ingenic,tcu.txt      |   1 +
 drivers/clocksource/Kconfig                        |   8 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/bcm2835_timer.c                |   8 +-
 drivers/clocksource/bcm_kona_timer.c               |  10 +-
 drivers/clocksource/dw_apb_timer.c                 |  11 +-
 drivers/clocksource/exynos_mct.c                   |  12 +-
 drivers/clocksource/ingenic-ost.c                  | 189 ++++++++++++++++++
 drivers/clocksource/ingenic-timer.c                |   3 +-
 drivers/clocksource/mxs_timer.c                    |  10 +-
 drivers/clocksource/nomadik-mtu.c                  |  11 +-
 drivers/clocksource/samsung_pwm_timer.c            |  12 +-
 drivers/clocksource/timer-atlas7.c                 |  50 +++--
 drivers/clocksource/timer-cs5535.c                 |   9 +-
 drivers/clocksource/timer-efm32.c                  |  10 +-
 drivers/clocksource/timer-fsl-ftm.c                |  10 +-
 drivers/clocksource/timer-fttmr010.c               |  68 +++++--
 drivers/clocksource/timer-imx-gpt.c                |  10 +-
 drivers/clocksource/timer-imx-sysctr.c             |   2 -
 drivers/clocksource/timer-imx-tpm.c                |   2 -
 drivers/clocksource/timer-integrator-ap.c          |  11 +-
 drivers/clocksource/timer-meson6.c                 |  11 +-
 drivers/clocksource/timer-microchip-pit64b.c       |   1 +
 drivers/clocksource/timer-orion.c                  |   9 +-
 drivers/clocksource/timer-owl.c                    |  15 +-
 drivers/clocksource/timer-prima2.c                 |  14 +-
 drivers/clocksource/timer-probe.c                  |   2 +
 drivers/clocksource/timer-pxa.c                    |  10 +-
 drivers/clocksource/timer-sp804.c                  |  11 +-
 drivers/clocksource/timer-ti-dm.c                  | 217
+++++++++++----------
 drivers/clocksource/timer-u300.c                   |   9 +-
 drivers/clocksource/timer-vf-pit.c                 |  10 +-
 drivers/clocksource/timer-vt8500.c                 |  11 +-
 drivers/clocksource/timer-zevio.c                  |  13 +-
 drivers/pwm/pwm-omap-dmtimer.c                     |   8 +-
 include/clocksource/timer-ti-dm.h                  |   4 +-
 include/linux/dw_apb_timer.h                       |   1 -
 include/linux/platform_data/dmtimer-omap.h         |   6 +-
 39 files changed, 471 insertions(+), 330 deletions(-)
 create mode 100644 drivers/clocksource/ingenic-ost.c


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

