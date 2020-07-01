Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E7DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 880282077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbgGAJK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgGAJK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:10:56 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB2BC061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 02:10:56 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id ACDD22A0CAB
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_spi: Document missing function
 parameters
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org, gwendal@chromium.org
References: <20200625170241.224780-1-enric.balletbo@collabora.com>
Message-ID: <07adffbf-477e-8550-39c2-706d740a77bb@collabora.com>
Date:   Wed, 1 Jul 2020 11:10:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625170241.224780-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gwendal,

Thank you for the review.

On 25/6/20 19:02, Enric Balletbo i Serra wrote:
> Kerneldoc expects all kernel function members to be documented.
> 
> Fixes the following W=1 level warnings:
> 
>   cros_ec_spi.c:153: warning: Function parameter or member 'ec_dev' not described in 'receive_n_bytes'
>   cros_ec_spi.c:153: warning: Function parameter or member 'buf' not described in 'receive_n_bytes'
>   cros_ec_spi.c:153: warning: Function parameter or member 'n' not described in 'receive_n_bytes'
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Applied for 5.9

> ---
> 
>  drivers/platform/chrome/cros_ec_spi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
> index f7cf7c6a04507..d17f5c74ae976 100644
> --- a/drivers/platform/chrome/cros_ec_spi.c
> +++ b/drivers/platform/chrome/cros_ec_spi.c
> @@ -148,6 +148,10 @@ static int terminate_request(struct cros_ec_device *ec_dev)
>   * receive_n_bytes - receive n bytes from the EC.
>   *
>   * Assumes buf is a pointer into the ec_dev->din buffer
> + *
> + * @ec_dev: ChromeOS EC device.
> + * @buf: Pointer to the buffer receiving the data.
> + * @n: Number of bytes received.
>   */
>  static int receive_n_bytes(struct cros_ec_device *ec_dev, u8 *buf, int n)
>  {
> 
