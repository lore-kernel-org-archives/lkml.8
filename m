Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6ECC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4384A207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgGWHwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 03:52:46 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:41681 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726108AbgGWHwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 03:52:46 -0400
Received: from [78.134.114.177] (port=35610 helo=[192.168.77.62])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jyW1z-000CEs-PR; Thu, 23 Jul 2020 09:52:43 +0200
Subject: Re: [PATCH v3 1/4] dt-bindings: clk: versaclock5: fix 'idt' prefix
 typos
To:     Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Adam Ford <aford173@gmail.com>, Rob Herring <robh@kernel.org>
References: <20200721164655.422-1-luca@lucaceresoli.net>
 <159546896402.3847286.10939445139729414539@swboyd.mtv.corp.google.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <6ec39f11-85ee-1343-4448-80469dc1d00f@lucaceresoli.net>
Date:   Thu, 23 Jul 2020 09:52:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <159546896402.3847286.10939445139729414539@swboyd.mtv.corp.google.com>
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

On 23/07/20 03:49, Stephen Boyd wrote:
> Quoting Luca Ceresoli (2020-07-21 09:46:52)
>> 'idt' is misspelled 'itd' in a few places, fix it.
>>
>> Fixes: 34662f6e3084 ("dt: Add additional option bindings for IDT VersaClock")
>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>>
>> ---
> 
> Please use a cover-letter for multi-patch series.

Just sent v4 with a cover letter and marked this series as superseded in
patchwork. I've also split out patch 3/4 and sent it separately as it is
orthogonal to the rest of the series.

-- 
Luca
