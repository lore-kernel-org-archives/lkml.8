Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD3CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A05CA2063A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbgGHQ4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:56:21 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:48234 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726124AbgGHQ4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:56:21 -0400
Received: from [78.134.117.153] (port=33222 helo=[192.168.77.66])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jtDMm-000BDX-FZ; Wed, 08 Jul 2020 18:56:16 +0200
Subject: Re: [PATCH v2 1/4] dt-bindings: clk: versaclock5: fix 'idt' prefix
 typos
To:     linux-clk@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Adam Ford <aford173@gmail.com>
References: <20200708074035.31595-1-luca@lucaceresoli.net>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <84f1800d-e8a4-52d8-e7f7-a199601c2fea@lucaceresoli.net>
Date:   Wed, 8 Jul 2020 18:56:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708074035.31595-1-luca@lucaceresoli.net>
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

On 08/07/20 09:40, Luca Ceresoli wrote:
> 'idt' is misspelled 'itd' in a few places, fix it.
> 
> Fixes: 34662f6e3084 ("dt: Add additional option bindings for IDT VersaClock")

This line triggers a warning in patchwork:

WARNING: Unknown commit id '34662f6e3084', maybe rebased or not pulled?

The commit is in the clk-next branch of
git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git, and thus
supposed to be merged into mainline.

-- 
Luca
