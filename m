Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36F2C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEADC20714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgCZHXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 03:23:37 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:61316
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726014AbgCZHXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 03:23:37 -0400
X-IronPort-AV: E=Sophos;i="5.72,307,1580770800"; 
   d="scan'208";a="343773967"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 08:23:35 +0100
Date:   Thu, 26 Mar 2020 08:23:34 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Simran Singhal <singhalsimran0@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel <outreachy-kernel@googlegroups.com>
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: Clean up tests
 if NULL returned on failure
In-Reply-To: <20200325222908.GA5370@simran-Inspiron-5558>
Message-ID: <alpine.DEB.2.21.2003260822280.3019@hadrien>
References: <20200325222908.GA5370@simran-Inspiron-5558>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Mar 2020, Simran Singhal wrote:

> Some functions like kmalloc/kzalloc return NULL on failure.
> When NULL represents failure, !x is commonly used.

Try for a shorter subject line.  "Simplify NULL tests" would do.  Then the
log message should be in the imperative.

julia


>
> This was done using Coccinelle:
> @@
> expression *e;
> identifier l1;
> @@
>
> e = \(kmalloc\|kzalloc\|kcalloc\|devm_kzalloc\)(...);
> ...
> - e == NULL
> + !e
>
> Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> index 29f36cca3972..5c27c11f006a 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> @@ -474,7 +474,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
>  			wep_key_len = wep_key_len <= 5 ? 5 : 13;
>  			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
>  			pwep = kzalloc(wep_total_len, GFP_KERNEL);
> -			if (pwep == NULL) {
> +			if (!pwep) {
>  				RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, (" wpa_set_encryption: pwep allocate fail !!!\n"));
>  				goto exit;
>  			}
> @@ -2137,7 +2137,7 @@ static int rtw_wx_set_enc_ext(struct net_device *dev,
>
>  	param_len = sizeof(struct ieee_param) + pext->key_len;
>  	param = kzalloc(param_len, GFP_KERNEL);
> -	if (param == NULL)
> +	if (!param)
>  		return -1;
>
>  	param->cmd = IEEE_CMD_SET_ENCRYPTION;
> @@ -3491,7 +3491,7 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
>  			wep_key_len = wep_key_len <= 5 ? 5 : 13;
>  			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
>  			pwep = kzalloc(wep_total_len, GFP_KERNEL);
> -			if (pwep == NULL) {
> +			if (!pwep) {
>  				DBG_871X(" r871x_set_encryption: pwep allocate fail !!!\n");
>  				goto exit;
>  			}
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20200325222908.GA5370%40simran-Inspiron-5558.
>
