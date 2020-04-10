Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E66C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 17:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3CC20801
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 17:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgDJRCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:02:12 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:56542 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbgDJRCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 13:02:12 -0400
Received: from [5.157.111.77] (port=58938 helo=[192.168.77.62])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jMx2b-005q14-4P; Fri, 10 Apr 2020 19:02:05 +0200
Subject: Re: [RFC PATCH v2 4/6] i2c: of: error message unification
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-i3c@lists.infradead.org,
        Kieran Bingham <kieran@ksquared.org.uk>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <20200318150059.21714-1-wsa+renesas@sang-engineering.com>
 <20200318150059.21714-5-wsa+renesas@sang-engineering.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <d8f9b77f-9530-bbd6-3323-a0170bba5e6c@lucaceresoli.net>
Date:   Fri, 10 Apr 2020 19:02:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200318150059.21714-5-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18/03/20 16:00, Wolfram Sang wrote:
> - don't prefix the device if %pOF is provided. That information is
>   enough.
> - move the prefix to pr_fmt
> - change prefix from "of_i2c" to "i2c_of" because the code was moved
>   out of the of-domain long ago
> - drop error string for callers of of_i2c_register_device because it
>   already reports enough (thanks to Tang Bin for the report!)
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Luca Ceresoli <luca@lucaceresoli.net>

-- 
Luca
