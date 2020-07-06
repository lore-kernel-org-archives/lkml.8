Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F11C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 597B620720
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgGFUbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:31:49 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:34856 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725860AbgGFUbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 16:31:48 -0400
Received: from [78.134.117.153] (port=50270 helo=[192.168.77.62])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jsXmC-0009kI-Iz; Mon, 06 Jul 2020 22:31:44 +0200
Subject: Re: [PATCH 5/5] clk: vc5: optionally configure the output drive mode
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>
References: <20200702212837.10657-1-luca@lucaceresoli.net>
 <20200702212837.10657-5-luca@lucaceresoli.net>
 <CAHCN7xLz-xuHgQRPmqRes7tKjcEjrnqpG9o-3Dee81UkSDfE-Q@mail.gmail.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <9fd338d7-5009-dfb5-bcb7-4e299fbc7786@lucaceresoli.net>
Date:   Mon, 6 Jul 2020 22:31:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAHCN7xLz-xuHgQRPmqRes7tKjcEjrnqpG9o-3Dee81UkSDfE-Q@mail.gmail.com>
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

Hi Adam,

On 06/07/20 22:03, Adam Ford wrote:
> On Thu, Jul 2, 2020 at 5:40 PM Luca Ceresoli <luca@lucaceresoli.net> wrote:
>>
>> The Versaclock chips can drive the output pins in several modes: LVDS,
>> CMOS, LVPECL etc. Allow configuring the output mode from device tree.
>>
>> The configuration is optional. If not specified, the mode will not be
>> configured and the drive mode will be the chip default.
>>
>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> 
> This might be duplicating what's been applied to linux-next already.

Oh dear, it is! I hadn't found this patch when I needed it...

Please consider this series superseded. There are still some (minor-ish)
improvements, but they definitely need to be rebased and partially
rewritten.

-- 
Luca
