Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5181FC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 07:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA5E20675
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 07:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgCIHut convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 03:50:49 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51779 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgCIHus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 03:50:48 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jBDBX-0005LI-A5; Mon, 09 Mar 2020 08:50:47 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jBDBW-0003BH-H9; Mon, 09 Mar 2020 08:50:46 +0100
Message-ID: <90f0fb037c2160816e74d8efcdf41177b6e80a77.camel@pengutronix.de>
Subject: Re: [PATCH v3] reset: hi6220: Add support for AO reset controller
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Peter Griffin <peter.griffin@linaro.org>,
        Enrico Weigelt <info@metux.net>
Date:   Mon, 09 Mar 2020 08:50:46 +0100
In-Reply-To: <20200306172113.50738-1-john.stultz@linaro.org>
References: <20200306172113.50738-1-john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Fri, 2020-03-06 at 17:21 +0000, John Stultz wrote:
> From: Peter Griffin <peter.griffin@linaro.org>
> 
> This is required to bring Mali450 gpu out of reset.
> 
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Peter Griffin <peter.griffin@linaro.org>
> Cc: Enrico Weigelt <info@metux.net>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> [jstultz: Added comment, Fix void return build issue
> Reported-by: kbuild test robot <lkp@intel.com>]
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v2:
> * Updated to v2 of Peter's patch from here:
>     https://lkml.org/lkml/2019/4/19/253
> * Added a comment to explain ordering question brought
>   up on the list.
> v3:
> * Fix build issue Reported-by: kbuild test robot <lkp@intel.com>

Thank you, applied to reset/next.

regards
Philipp
