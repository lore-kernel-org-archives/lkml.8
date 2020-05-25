Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7123EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F1132070A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590396018;
	bh=GL159ZQNLTlj2WGGQuKXAGi8lVtqHdeHMIsD6BmONC0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=xmL8ppsEA9NgEUJQ3v/SZkHNTchxczhbGxPWzpOH8ndRCmZIULMWS1Bk8iP3xJt6O
	 +aERj5rv35XkbdijVO0TcyPSn1skh+miSqSkOR7z3A2dd8Cj38Y6KZfDTLpEtOVnSI
	 OyCDZiTGelA/3wCkA2bvVUc02VfWX/D3yv7CRv70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389209AbgEYIkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 04:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388367AbgEYIkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 04:40:16 -0400
Received: from [192.168.0.50] (89-70-52-201.dynamic.chello.pl [89.70.52.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C2FE206C3;
        Mon, 25 May 2020 08:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590396016;
        bh=GL159ZQNLTlj2WGGQuKXAGi8lVtqHdeHMIsD6BmONC0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=vqcq27tKaqWpr2bu+p4rvaNWHiBH9SFiUHGgkSNz2qWurwhKBRcYZ7Wgwa9XT+tYI
         5ZCU/f7UIuTx/PYDcGbRmMkEUQoV1Ww71wkpqptMTvdZZb4FUtv12lQ7f2jBQM1RRR
         HA1AG4NZHDl3VlKZZptPu168RbCwdkvYkAM9fSU8=
Subject: Re: [PATCH] media: exynos4-is: Fix runtime PM imbalance in
 isp_video_open
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
References: <20200524033404.23227-1-dinghao.liu@zju.edu.cn>
From:   Sylwester Nawrocki <snawrocki@kernel.org>
Message-ID: <bde57b79-dc52-6fca-4efd-e8c7b1c57373@kernel.org>
Date:   Mon, 25 May 2020 10:40:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200524033404.23227-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/20 05:34, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> when it returns an error code. Thus a pairing decrement is needed on
> the error handling path to keep the counter balanced.
> 
> Signed-off-by: Dinghao Liu<dinghao.liu@zju.edu.cn>

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

