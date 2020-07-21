Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0F0C433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B35132073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbgGUKKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 06:10:36 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:49592 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726147AbgGUKKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:10:35 -0400
Received: from [78.134.114.177] (port=47974 helo=[192.168.77.67])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jxpEH-000CHc-Ad; Tue, 21 Jul 2020 12:10:33 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
Subject: Re: [PATCH V3] clk: vc5: Add memory check to prevent oops
To:     Stephen Boyd <sboyd@kernel.org>, Adam Ford <aford173@gmail.com>,
        linux-clk@vger.kernel.org
Cc:     dan.carpenter@oracle.com, aford@beaconembedded.com,
        Marek Vasut <marek.vasut@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org
References: <20200716122620.4538-1-aford173@gmail.com>
 <159532318111.3847286.6874293188283317151@swboyd.mtv.corp.google.com>
Message-ID: <f6da2a16-0e6f-c865-dea3-f8b16c546f3f@lucaceresoli.net>
Date:   Tue, 21 Jul 2020 12:10:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <159532318111.3847286.6874293188283317151@swboyd.mtv.corp.google.com>
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

Hi Stephen,

On 21/07/20 11:19, Stephen Boyd wrote:
> Quoting Adam Ford (2020-07-16 05:26:20)
>> When getting the names of the child nodes, kasprintf is used to
>> allocate memory which is used to create the string for the node
>> name.  Unfortunately, there is no memory check to determine
>> if this allocation fails, it may cause an error when trying
>> to get child node name.
>>
>> This patch will check if the memory allocation fails, and returns
>> and -ENOMEM error instead of blindly moving on.
>>
>> Fixes: 260249f929e8 ("clk: vc5: Enable addition output configurations of the Versaclock")
>>
>> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
>> Signed-off-by: Adam Ford <aford173@gmail.com>
>> Reviewed-by: Luca Ceresoli <luca@lucaceresoli.net>
>> ---
>> V3:   Fix spelling error, and use the style of checking (!variable) instead of
>>       (variable == NULL)
>>
>> V2:   Fix an issue where a goto was going to use an unitialized variable.
> 
> Is the patch from Colin also needed?
> https://lore.kernel.org/r/20200625132736.88832-1-colin.king@canonical.com

The two patches look completely orthogonal.

-- 
Luca
