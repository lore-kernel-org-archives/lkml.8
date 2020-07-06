Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF00C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 17:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66FDF205CB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 17:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbgGFRBM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 13:01:12 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:60400 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbgGFRBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 13:01:11 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jsUUL-0005pc-ND; Mon, 06 Jul 2020 11:01:05 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jsUUJ-0005CJ-SN; Mon, 06 Jul 2020 11:01:05 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Lee Jones <lee.jones@linaro.org>
Cc:     gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Yinghai Lu <yhlu.kernel@gmail.com>,
        Jason Wessel <jason.wessel@windriver.com>
References: <20200706133341.476881-1-lee.jones@linaro.org>
        <20200706133341.476881-26-lee.jones@linaro.org>
Date:   Mon, 06 Jul 2020 11:56:24 -0500
In-Reply-To: <20200706133341.476881-26-lee.jones@linaro.org> (Lee Jones's
        message of "Mon, 6 Jul 2020 14:33:34 +0100")
Message-ID: <87imf0mvk7.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1jsUUJ-0005CJ-SN;;;mid=<87imf0mvk7.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18khkDaZc3axoG/t6YW4c9dVrDhOpL38K0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 25/32] usb: early: ehci-dbgp: Remove set but never checked variable 'ret'
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Jones <lee.jones@linaro.org> writes:

> 'ret' hasn't  been checked since the driver's inception in 2009.

Minor quibble the inception was in 5c05917e7fe3 ("x86: usb debug port
early console, v4") in July of 2008.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

> Fixes the following W=1 kernel build warning(s):
>
>  drivers/usb/early/ehci-dbgp.c: In function ‘early_dbgp_write’:
>  drivers/usb/early/ehci-dbgp.c:915:13: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
>  915 | int chunk, ret;
>  | ^~~
>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Yinghai Lu <yhlu.kernel@gmail.com>
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/usb/early/ehci-dbgp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/early/ehci-dbgp.c b/drivers/usb/early/ehci-dbgp.c
> index 775cf70cfb3ed..b075dbfad730f 100644
> --- a/drivers/usb/early/ehci-dbgp.c
> +++ b/drivers/usb/early/ehci-dbgp.c
> @@ -912,7 +912,7 @@ int __init early_dbgp_init(char *s)
>  
>  static void early_dbgp_write(struct console *con, const char *str, u32 n)
>  {
> -	int chunk, ret;
> +	int chunk;
>  	char buf[DBGP_MAX_PACKET];
>  	int use_cr = 0;
>  	u32 cmd, ctrl;
> @@ -951,8 +951,8 @@ static void early_dbgp_write(struct console *con, const char *str, u32 n)
>  			buf[chunk] = *str;
>  		}
>  		if (chunk > 0) {
> -			ret = dbgp_bulk_write(USB_DEBUG_DEVNUM,
> -				      dbgp_endpoint_out, buf, chunk);
> +			dbgp_bulk_write(USB_DEBUG_DEVNUM,
> +					dbgp_endpoint_out, buf, chunk);
>  		}
>  	}
>  	if (unlikely(reset_run)) {
