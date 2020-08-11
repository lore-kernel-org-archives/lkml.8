Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89412C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72BFF206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgHKGPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 02:15:17 -0400
Received: from mleia.com ([178.79.152.223]:41242 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbgHKGPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 02:15:15 -0400
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id C28C93FDBB3;
        Tue, 11 Aug 2020 06:15:13 +0000 (UTC)
Subject: Re: [PATCH 5/7] regulator: plug of_node leak in
 regulator_register()'s error path
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <cover.1597107682.git.mirq-linux@rere.qmqm.pl>
 <f106ae5b37612b36cb817691fb690e5456aea0ee.1597107682.git.mirq-linux@rere.qmqm.pl>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <e8caa9cd-f3e2-8a33-12f4-81dfd6f9c551@mleia.com>
Date:   Tue, 11 Aug 2020 09:15:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <f106ae5b37612b36cb817691fb690e5456aea0ee.1597107682.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20200811_061513_819030_95435139 
X-CRM114-Status: GOOD (  10.54  )
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michał,

On 8/11/20 4:07 AM, Michał Mirosław wrote:
> By calling device_initialize() earlier and noting that kfree(NULL) is
> ok, we can save a bit of code in error handling and plug of_node leak.
> Fixed commit already did part of the work.
> 
> Cc: stable@vger.kernel.org
> Fixes: 9177514ce349 ("regulator: fix memory leak on error path of regulator_register()")
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

thank you for the patch!

I was worried about a potentially remaining of_node reference leak,
but I was not able to reproduce it on practice without code fuzzing.

The change looks valid and it's a nice simplification.

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir
