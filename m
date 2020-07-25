Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB99C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 11:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8420520674
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 11:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="Xwjcy1La"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgGYL0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 07:26:55 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:38571 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbgGYL0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 07:26:54 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BDP0r3qYnz4D;
        Sat, 25 Jul 2020 13:26:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1595676412; bh=L/BNcvROLxjZ1rfhEFzHdQ0i28PS8mEqlcC60AdsZak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xwjcy1La/33lpBqiemFmaAYxb4PNRMspC5H79u3InnXfp64Wrpebc9Z4AU0aCg8Pg
         jCdMIcjy5SnpmPfHjxmadbIfZIWnkJZXZ2jjy4pyRhpI6rJcl3prtM6/x382YNvJP9
         b/yTofHNXZ4xcfd9s5gY6QbyVNqibqIw50s4/rtGi4CNgQOJ7WV+f5gTw0uxp8X/QM
         iIn66pmENQHlQO3fYZzAShlk/m7X3QLsHeZ+dVhg/fYjH2ZbPXxy0GgxkGUN8fwpZY
         uqAOjDQB4BccGD5Cm9qKAMqX8ZqdvUBXdPbh7ADm8r3gq/qpa7L8gZ7YL1BXM/CHEO
         MzRX8UeLxucHw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.3 at mail
Date:   Sat, 25 Jul 2020 13:26:48 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     digetx@gmail.com, linux-i2c@vger.kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldewangan@nvidia.com, smohammed@nvidia.com, rgumasta@nvidia.com
Subject: Re: [PATCH 4/7] i2c: tegra: add high speed mode support
Message-ID: <20200725112648.GA26689@qmqm.qmqm.pl>
References: <1595506733-10307-1-git-send-email-kyarlagadda@nvidia.com>
 <1595506733-10307-4-git-send-email-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1595506733-10307-4-git-send-email-kyarlagadda@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 05:48:50PM +0530, Krishna Yarlagadda wrote:
> From: Shardar Shariff Md <smohammed@nvidia.com>
> 
> Add high speed mode support
[...]
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
[...]
> @@ -215,12 +218,14 @@ struct tegra_i2c_hw_feature {
>  	int clk_divisor_std_mode;
>  	int clk_divisor_fast_mode;
>  	u16 clk_divisor_fast_plus_mode;
> +	int clk_multiplier_hs_mode;
>  	bool has_multi_master_mode;
>  	bool has_slcg_override_reg;
>  	bool has_mst_fifo;
>  	const struct i2c_adapter_quirks *quirks;
>  	bool supports_bus_clear;
>  	bool has_reg_write_buffering;
> +	bool has_hs_mode_support;

This field seems redundant: == !clk_multiplier_hs_mode ?

Best Regards,
Micha³ Miros³aw
