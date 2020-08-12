Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35848C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC90520675
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="nDjgx0ta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgHLQGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:06:50 -0400
Received: from vern.gendns.com ([98.142.107.122]:44788 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgHLQGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=E7W/4qlrWr36rTWtmYlZDWrVvvfKDlYHlV9Dn3Enrm8=; b=nDjgx0tamXa1PABTwLrsO1NWYa
        BmTCnFvoU1PcRCt0sEP4aA9hPBnpZw7RuH3nOhyLfW+JqHPtV8ABDSvVSpVpISL9732uZceRN3bsx
        WTT9P+ccgq0RoXjfAdPkMBw+DEkuNhBiswT+GdICGyWCPKQGjLuP7rSel2kyPxqJGQ/cQtoOg4dMV
        LwfO5SECQGfbj3NyrYuySPWYFKDJKvNmUW0A8kPmEPK/ACFSRWOGx8cB+ipDECaxJtb4aZUdK06GI
        Hpp1CvC2IplELyGuScZ4/uoMgZBZlI7qdkaFyx200Tksku0LZZ0biAhH2yZnufWImgSLCc1/NO/v9
        jc0Kat4Q==;
Received: from [2600:1700:4830:165f::19e] (port=56864)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <david@lechnology.com>)
        id 1k5tH1-0001qD-RD; Wed, 12 Aug 2020 12:06:43 -0400
Subject: Re: [PATCH] clk: davinci: Use the correct size when allocating memory
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>, nsekhar@ti.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20200809144959.747986-1-christophe.jaillet@wanadoo.fr>
From:   David Lechner <david@lechnology.com>
Message-ID: <4327a171-a937-c62e-ebad-9f92c0dea65d@lechnology.com>
Date:   Wed, 12 Aug 2020 11:06:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200809144959.747986-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/20 9:49 AM, Christophe JAILLET wrote:
> 'sizeof(*pllen)' should be used in place of 'sizeof(*pllout)' to avoid a
> small over-allocation.
> 
> Fixes: 2d1726915159 ("clk: davinci: New driver for davinci PLL clocks")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Reviewed-by: David Lechner <david@lechnology.com>
