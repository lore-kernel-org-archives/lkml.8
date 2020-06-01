Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9A5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D9DB206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Utd5qiWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgFAIRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 04:17:21 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36351 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbgFAIRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 04:17:18 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200601081716euoutp02f35b79711d183835b89c87bee48bcc0a~UXY7rb0Gu2192321923euoutp02Q
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 08:17:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200601081716euoutp02f35b79711d183835b89c87bee48bcc0a~UXY7rb0Gu2192321923euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590999436;
        bh=37JGf7EE9HaegulwiZqkIB0AWI45wJrwlmv0uHoMlfk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Utd5qiWW5rJlSReUL19M2i2PagglJE05zIeZjSbCaECwLu5v6r3o6jW/spFeAqwaz
         Ea19boC3tDMr/+u1TxmHaOqLsXqRONqGaf0dv7+PjmOKvSe8RwbF1r7CAw//EiMJ1D
         rRMjKfYCDtf4qScckQA0YvYwKiP8cfnYrXxc/ovA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200601081716eucas1p1e4889d2339eb5a9b52da54ff760e18dc~UXY7XKbnb2277422774eucas1p1J;
        Mon,  1 Jun 2020 08:17:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 33.72.60698.C89B4DE5; Mon,  1
        Jun 2020 09:17:16 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200601081716eucas1p1e7f30e33e5bfdf8922c2d693e165793c~UXY699sj31067710677eucas1p1B;
        Mon,  1 Jun 2020 08:17:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200601081716eusmtrp19d58a0adbf51b878348cc716bcd9715e~UXY69Lvlg2135421354eusmtrp15;
        Mon,  1 Jun 2020 08:17:16 +0000 (GMT)
X-AuditID: cbfec7f5-a0fff7000001ed1a-e9-5ed4b98c9045
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 82.64.07950.B89B4DE5; Mon,  1
        Jun 2020 09:17:15 +0100 (BST)
Received: from [106.210.123.115] (unknown [106.210.123.115]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200601081714eusmtip29e6bd48a3316bef61f1612f5a42ddd77~UXY51GyEv2457424574eusmtip2a;
        Mon,  1 Jun 2020 08:17:14 +0000 (GMT)
Subject: Re: [RFC PATCH v5 0/6] Exynos: Simple QoS for exynos-bus using
 interconnect
To:     georgi.djakov@linaro.org, cw00.choi@samsung.com, krzk@kernel.org
Cc:     a.swigon@samsung.com, myungjoo.ham@samsung.com,
        inki.dae@samsung.com, sw0312.kim@samsung.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <5cd5166b-2b18-2a8f-8940-b3ccf7b1a533@samsung.com>
Date:   Mon, 1 Jun 2020 10:17:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200529163200.18031-1-s.nawrocki@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHe/Ze9jpcPU7Fg4XBGJWBVmT4VHZRCkYfKj9UUGitfFNLp2xp
        GkGmeamZil1cy0wi0UbDWmpei5a51FLQZRezgVt5KYvIEC0ttzfJb7/z/58/5xw4HCXrY/y5
        ePUJXqNWJchZCV3XNtkdlN9gi17dMATEXpaNyH19NUNejw8x5GZrF0NsP7+xpKTFzJJiexFN
        urvviYnZ0ceQ3sZSlui7H4mIqXVATPrPVrEku6VVTPSXRtiti5Rm43lW+b6vmVXadVaR8sHt
        M8qCGiNS/jAH7Gb3S8Ji+IT4VF6zavMhSdzlMp/krGVpVyYKmQx0LuAC8uAAh0D/ww7qApJw
        MlyF4NbUWVYoxhE4XwwxQvEDwdM3w9RcpOp5plgwKhHk9mbSLkOGvyMwdmEXe+O98G7gs8jF
        Pngb5Hwso10BCg+KYObudcZlsHgNXHxWgFwsxZshu6DWzTRWwJhD5w774ijIt49SQo8XtF9z
        uod54DDQ/da7dQr7wTvnTZHASyGr9vq/TSfFMNS8U+Bt8CFDzwrsDaPWGrHAS6DzUr57OcBZ
        CPKb+sVCUYTAbi1HQtdGeN81NZvmZicEQnXjKkEOh8f9FrFLBrwQ3ox5CTsshOK6EkqQpZCX
        IxO6FfDLWCIS2B90zj90EZIb5l1mmHeNYd41hv9zyxFtRH58ijYxlteuVfMng7WqRG2KOjb4
        SFKiGc1+W+eM9Wc9evT7sAVhDsk9pSt6eqNljCpVm55oQcBRch9pxMvOaJk0RpV+itckHdSk
        JPBaC1rM0XI/6dpbI1EyHKs6wR/n+WReM+eKOA//DDTgTRQ9hXVXb28JedJJ2yLjTEpNU6Vz
        +m3bxM5QiWL5C6ZxweXQCtMNx6hDF6k+UNqY/Knj2vCTzNLtg2kR6+Er+SJtCfTN+/Z6x6a9
        cSG2knDDOklBrip418XQo0HmO6bpV6GnUXlT0rHwV5PODY4KRXsq1O/JjLSZrJ77LDo5rY1T
        rVlJabSqvzAvNzppAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsVy+t/xe7rdO6/EGWw+YG1xf14ro8XGGetZ
        La5/ec5qMf/IOVaLK1/fs1lM37uJzWLS/QksFufPb2C32PT4GqvF5V1z2CxmnN/HZLH2yF12
        i9uNK9gsWvceYbeYMfklmwO/x6ZVnWwed67tYfO4332cyWPzknqPvi2rGD0+b5ILYIvSsynK
        Ly1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy5gyT6SgWa1i
        6vd+1gbGFrkuRk4OCQETiRUnmti7GLk4hASWMkpMObmDtYuRAyghJTG/RQmiRljiz7UuNoia
        94wSBzb3sYEkhAXCJG7dfc0EYosIuEi0PZ3HAlLELPCISWJpUx8zREc/o8StGdPYQarYBAwl
        eo/2MYLYvAJ2Eq19W8FsFgEVibePu8EmiQrESnQv/sEOUSMocXLmExYQm1PARqL7zwxmEJtZ
        QF3iz7xLULa4xK0n85kgbHmJ5q2zmScwCs1C0j4LScssJC2zkLQsYGRZxSiSWlqcm55bbKRX
        nJhbXJqXrpecn7uJERjN24793LKDsetd8CFGAQ5GJR7eC+cvxwmxJpYVV+YeYpTgYFYS4XU6
        ezpOiDclsbIqtSg/vqg0J7X4EKMp0HMTmaVEk/OBiSavJN7Q1NDcwtLQ3Njc2MxCSZy3Q+Bg
        jJBAemJJanZqakFqEUwfEwenVANj9Na6z2LRnYZrn9ke+RdZFWSXcuaP3wJP1qp3KoefFjM+
        4BW+dyFuxv3CXQrH+zcn/4pTrlzNtfRm47UtrzhVFgadkdrAGWrK3ztv7sK9d3OXv/Ha/uH6
        xqVnFiY2T8y5t1Rfb8fWaXIGW61vyd7pPf3RXmi6l6qLROuUsr+eIt+bnLY8W+A3S4mlOCPR
        UIu5qDgRAMJtcaj8AgAA
X-CMS-MailID: 20200601081716eucas1p1e7f30e33e5bfdf8922c2d693e165793c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200529163213eucas1p1ac148f9238214ac84f3d0cc199c4398b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200529163213eucas1p1ac148f9238214ac84f3d0cc199c4398b
References: <CGME20200529163213eucas1p1ac148f9238214ac84f3d0cc199c4398b@eucas1p1.samsung.com>
        <20200529163200.18031-1-s.nawrocki@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Rob, devicetree ML

On 29.05.2020 18:31, Sylwester Nawrocki wrote:
> This patchset adds interconnect API support for the Exynos SoC "samsung,
> exynos-bus" compatible devices, which already have their corresponding 
> exynos-bus driver in the devfreq subsystem.  Complementing the devfreq driver 
> with an interconnect functionality allows to ensure the QoS requirements 
> of devices accessing the system memory (e.g. video processing devices) 
> are fulfilled and to avoid issues like the one discussed in thread [1].
> 
> This patch series depends on 3 patches from Artur for the interconnect API 
> [2], which introduce following changes:
> 
>  - exporting of_icc_get_from_provider() to avoid hard coding every graph 
>    edge in the DT or driver source,
>  - relaxing the requirement on #interconnect-cells, so there is no need 
>    to provide dummy node IDs in the DT, 
>  - adding new field in struct icc_provider to explicitly allow configuring 
>    node pairs from two different providers.
> 
> This series adds implementation of interconnect provider per each "samsung,
> exynos-bus" compatible DT node, with one interconnect node per provider.
> The interconnect code which was previously added as a part of the devfreq
> driver has been converted to a separate platform driver.  In the devfreq 
> a corresponding virtual child platform device is registered.  Integration 
> of devfreq and interconnect frameworks is achieved through the PM QoS API.
> 
> A sample interconnect consumer for exynos-mixer is added in patches 5/6, 
> 6/6, it is currently added only for exynos4412 and allows to address the 
> mixer DMA underrun error issues [1].
> 
> The series has been tested on Odroid U3 board. It is based on icc-next 
> branch with devfreq-next branch merged and patches [2] applied.
> 
> --
> Regards,
> Sylwester
> 
> --
> Changes since v3 [3] (v4 skipped to align with patchset [1]), detailed 
> changes are listed at each patch:
>  - conversion to a separate interconnect (platform) driver,
>  - an update of the DT binding documenting new optional properties:
>    #interconnect-cells, samsung,interconnect-parent in "samsung,exynos-bus"
>    nodes,
>  - new DT properties added to the SoC, rather than to the board specific 
>    files.
> 
> Changes since v2 [5]:
>  - Use icc_std_aggregate().
>  - Implement a different modification of apply_constraints() in
>    drivers/interconnect/core.c (patch 03).
>  - Use 'exynos,interconnect-parent-node' in the DT instead of
>    'devfreq'/'parent', depending on the bus.
>  - Rebase on DT patches that deprecate the 'devfreq' DT property.
>  - Improve error handling, including freeing generated IDs on failure.
>  - Remove exynos_bus_icc_connect() and add exynos_bus_icc_get_parent().
> 
> Changes since v1 [4]:
>  - Rebase on coupled regulators patches.
>  - Use dev_pm_qos_*() API instead of overriding frequency in
>    exynos_bus_target().
>  - Use IDR for node ID allocation.
>  - Reverse order of multiplication and division in
>    mixer_set_memory_bandwidth() (patch 07) to avoid integer overflow.
> 
> 
> References:
> [1] https://patchwork.kernel.org/patch/10861757/ (original issue)
> [2] https://www.spinics.net/lists/linux-samsung-soc/msg70014.html
> [3] https://lore.kernel.org/linux-pm/20191220115653.6487-1-a.swigon@samsung.com
> [4] https://patchwork.kernel.org/cover/11054417/ (v1 of this RFC)
> [5] https://patchwork.kernel.org/cover/11152595/ (v2 of this RFC)
> 
> 
> Artur Świgoń (1):
>   ARM: dts: exynos: Add interconnects to Exynos4412 mixer
> 
> Marek Szyprowski (1):
>   drm: exynos: mixer: Add interconnect support
> 
> Sylwester Nawrocki (4):
>   dt-bindings: exynos-bus: Add documentation for interconnect properties
>   interconnect: Add generic interconnect driver for Exynos SoCs
>   PM / devfreq: exynos-bus: Add registration of interconnect child
>     device
>   ARM: dts: exynos: Add interconnect properties to Exynos4412 bus nodes
> 
>  .../devicetree/bindings/devfreq/exynos-bus.txt     |  15 +-
>  arch/arm/boot/dts/exynos4412.dtsi                  |   6 +
>  drivers/devfreq/exynos-bus.c                       |  17 ++
>  drivers/gpu/drm/exynos/exynos_mixer.c              |  73 +++++++-
>  drivers/interconnect/Kconfig                       |   1 +
>  drivers/interconnect/Makefile                      |   1 +
>  drivers/interconnect/exynos/Kconfig                |   6 +
>  drivers/interconnect/exynos/Makefile               |   4 +
>  drivers/interconnect/exynos/exynos.c               | 185 +++++++++++++++++++++
>  9 files changed, 301 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/interconnect/exynos/Kconfig
>  create mode 100644 drivers/interconnect/exynos/Makefile
>  create mode 100644 drivers/interconnect/exynos/exynos.c

