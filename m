Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9821C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B708D23D3C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Y9S1R0tp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgDFOX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:23:56 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47092 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728539AbgDFOXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:23:55 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200406142351euoutp021c36b75fbfe822369dd0a4b6baa22bcc~DQRAyYFp00221902219euoutp02T
        for <linux-kernel@vger.kernel.org>; Mon,  6 Apr 2020 14:23:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200406142351euoutp021c36b75fbfe822369dd0a4b6baa22bcc~DQRAyYFp00221902219euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1586183031;
        bh=80HiovpSACSa5iKWuDtXEGNMjiGgvGqhBPfk2+6zg2I=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Y9S1R0tpk3yqYW2uH+9884TfpcTEYO2pF84lZFKPXhwoYBc3gkBFO6OqyCH1+jTGC
         T20P0WZ5F0EYNMBJc42m//fPODIqTgx52+aa81BSoufpKyfLnK3pQQn9XNc+MECcpD
         i1iSdMn2lfk0sAkq6grWcDGvAnsDJGNU5oTk1MkY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200406142351eucas1p176e16341c0ae5cba40259b3b3b64279e~DQRAfqxZE2343723437eucas1p1r;
        Mon,  6 Apr 2020 14:23:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id F5.1A.61286.77B3B8E5; Mon,  6
        Apr 2020 15:23:51 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200406142350eucas1p2524f266941cfedd66c0181f2fedcf388~DQRAJGFE81495514955eucas1p2N;
        Mon,  6 Apr 2020 14:23:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200406142350eusmtrp1d2e992634175bcb2ae0fea4a3e778668~DQRAIQ9ax0348903489eusmtrp1a;
        Mon,  6 Apr 2020 14:23:50 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-ea-5e8b3b77753e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 01.CF.08375.67B3B8E5; Mon,  6
        Apr 2020 15:23:50 +0100 (BST)
Received: from [106.210.85.205] (unknown [106.210.85.205]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200406142350eusmtip1eccb47d1871edabd5397fc2de3e805dc~DQQ-biU9_1810518105eusmtip1e;
        Mon,  6 Apr 2020 14:23:50 +0000 (GMT)
Subject: Re: [PATCH v5 0/5] Genericize DW MIPI DSI bridge and add i.MX 6
 driver
To:     Adrian Ratiu <adrian.ratiu@collabora.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-imx@nxp.com,
        kernel@collabora.com, linux-stm32@st-md-mailman.stormreply.com,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <7b95e129-8035-df7f-3d50-2ae3c2e8af8d@samsung.com>
Date:   Mon, 6 Apr 2020 16:23:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200330113542.181752-1-adrian.ratiu@collabora.com>
Content-Transfer-Encoding: 8bit
Content-Language: pl
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTYRDH83V3y7ahuBSQEYxiY6JouIIxm6Aoxod9EKM+qQlHkQ0Q21Ja
        DlEjBJBAOUTw4jAQjoggqFQQiCFQCEiQIkcJJDQQqA8QDsuloIi0i5G338z855v5Tz4SExsI
        FzJKEcuqFFKZhC/Em7o3BjwS/LKCvUsfiuiNvCaCLu3SE/TI2hKfNvyYxejeeQNOa/XZBJ35
        uNKGbpgZJWjN5muMHm4t4dPLU9sYrRk1EedtmWZjJWKKMwoJ5nPeEI+ZzOrhMdrKJOb9YjOP
        ac8pwJmONh9mpeHQFcFN4ZlwVhYVz6q8/EOFkbpOQmnad2ep7SeRjKpsNYgkgToFXYMyDRKS
        YqoawcJ8H48LVhF8+j2Oc8EKguWhZzYaJLB2mKe6Ma7wCsGX7dJd1RICY043z6JyoK6CfjCd
        b2FHKgb0jTWERYRRnTxYSa+3iviUO2xpx60iEeUPQ+W1yMI4dRTq5zKt7EQFgX56jOA09tBb
        aMItLKACYD3dbGWMOgypjcUYx44wNp2GLMOAMtvA8PYIj9v7IhjNjwiOHWCu58Oun4PQV5CN
        c5wEk9VpGNecgaDxXQvGFfxgQr/Jt5wM29n6basXlw6Aj4YKxF3SDsYW7Lkd7CC/6TnGpUWQ
        kS7m1Edgsr9x90FnqPq6xs9DkqI9zor2uCna46bo/9wyhNcgZzZOLY9g1T4KNsFTLZWr4xQR
        nrei5Q1o57P1/elZbkZrQ2E6RJFIYiu6LsgKFhPSeHWiXIeAxCSOIpeczGCxKFyaeJdVRYeo
        4mSsWodcSVziLPItnw0SUxHSWPY2yypZ1b8qjxS4JKPSXMPZurGZGGX9E8Elj7Jjvxbvvfwu
        7ovq/+bqWvGipeTCcZt2U8KD0yMzymKnXreClIYws/vTrRSTW5VyK1cwkqqr0cqlvuc2t94I
        BxbTah0TT3a4pdi1hOYYPZxv3J+A6fzlJEVI3eV1o2v0ag+L9N4Z+xXa1c5A3YGga4GTElwd
        KfU5ganU0r9uZjfdaAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsVy+t/xu7pl1t1xBr82mFj8nLCN1WL+kXOs
        Fle+vmezuPr9JbPFyTdXWSw2n+thteicuITdYtPja6wWXb9WMltc3jWHzeLTg//MFl3XnrA6
        8HjsuLuE0WN2x0xWjxMTLjF53O8+zuSxeUm9x8Z3O5g8DvROZvE4uM/Q4/MmuQDOKD2bovzS
        klSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MQ4dZC57wV7zf
        94O1gXEpTxcjJ4eEgInExwfHmEFsIYGljBKXe70g4uISu+e/ZYawhSX+XOti62LkAqp5yyix
        /fE2JpCEsECgxLmLbWwgtohAocSX6xvAipgFDjNJ7F02lR2iYwqjxIemVkaQKjYBTYm/m2+C
        dfAK2ElcWrQaLM4ioCKx7lUnmC0qECvR37ybEaJGUOLkzCcsIDangKPEt7aPYDazgJnEvM0P
        mSFseYnmrbOhbBGJG49aGCcwCs1C0j4LScssJC2zkLQsYGRZxSiSWlqcm55bbKhXnJhbXJqX
        rpecn7uJERjL24793LyD8dLG4EOMAhyMSjy8EZzdcUKsiWXFlbmHGCU4mJVEeKV6O+OEeFMS
        K6tSi/Lji0pzUosPMZoCPTeRWUo0OR+YZvJK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5ak
        ZqemFqQWwfQxcXBKNTD61jyd80V46Z2jM0M1Xwufq2LR3dcptittXrc7I3PXbcnnSk/cNvfs
        2nfkusDU3Q2GcdN7TlxxK7h1Pd3Tr6rmu0+44+9ZftXHtjwISiu3SQ5u99vductMaBWn3p5V
        pfKLprBp7P9fo2Z2Ri786nqLb0vL3QVPcM0wb1i1z9/7LfPF68+514orsRRnJBpqMRcVJwIA
        Q/GjXvsCAAA=
X-CMS-MailID: 20200406142350eucas1p2524f266941cfedd66c0181f2fedcf388
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200330113455eucas1p1441dc79d44de5081e9d90079e2020ca0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200330113455eucas1p1441dc79d44de5081e9d90079e2020ca0
References: <CGME20200330113455eucas1p1441dc79d44de5081e9d90079e2020ca0@eucas1p1.samsung.com>
        <20200330113542.181752-1-adrian.ratiu@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

Due to different ways of work I use different mail client, so forgive me 
if there are some misconfugrations.


W dniu 30.03.2020 o 13:35, Adrian Ratiu pisze:
> Hello everyone,
>
> The v5 series is a significantly cleaned up version from v4,
> started by Ezequiel Garcia's suggestion of splitting out the
> regmap infrastructure from the drivers (thank you!).
>
> Turns out no changes are required to the existing drivers and
> the bridge can transparently take care of the layout logic,
> so there's no need to expose the regmap via plat_data anymore.
>
> Starting from this version I also opted to add per-patch
> changelogs. All review comments up to now have been addressed.
>
> Tested on IMX6DL.
>
> Adrian Ratiu (5):
>    drm: bridge: dw_mipi_dsi: add initial regmap infrastructure
>    drm: bridge: dw_mipi_dsi: abstract register access using reg_fields
>    drm: bridge: synopsis: add dsi v1.01 support
>    drm: imx: Add i.MX 6 MIPI DSI host platform driver
>    dt-bindings: display: add i.MX6 MIPI DSI host controller doc
>
>   .../display/imx/fsl,mipi-dsi-imx6.yaml        | 134 ++++
>   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 683 +++++++++++++-----


So we have above 400 lines more just to add slightly different register 
layout of v1.01.

Quite big linecount for apparently small (?) functional change - I was 
too lazy to check how many reg fields are really used (some are not used 
at all), but it does not seem to be big enough to justyfy so big change IMO.

I will add more comments in specific patches.


Regards

Andrzej


>   drivers/gpu/drm/imx/Kconfig                   |   7 +
>   drivers/gpu/drm/imx/Makefile                  |   1 +
>   drivers/gpu/drm/imx/dw_mipi_dsi-imx6.c        | 399 ++++++++++
>   5 files changed, 1049 insertions(+), 175 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,mipi-dsi-imx6.yaml
>   create mode 100644 drivers/gpu/drm/imx/dw_mipi_dsi-imx6.c
>
