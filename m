Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9322BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75DE020716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GXqhKU6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731556AbgHQRmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731544AbgHQRm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 13:42:27 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB20C061342
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 10:42:26 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id m71so8584013pfd.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 10:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dOiaQirXBI3rQ6qT+kTTGtB6bOoUlvCJmrcPgoAcFag=;
        b=GXqhKU6YA+o0z+HzDuOj1wrYpCBvfRBexpZQHyS0GUUx+GzyM0VfexnpuHmqXovRgw
         ibR94ySpDu1Mvk8/yRLNFsBhOkav76Jd3gAqNGlw86D9WuzxNtPswfqjrNle6Cw5BONA
         //OPKcywsNON0CBA0/EzKmHeffwzlRuvDMuBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dOiaQirXBI3rQ6qT+kTTGtB6bOoUlvCJmrcPgoAcFag=;
        b=TeKitIB9+9YheE6ZkqEEmSfewxb7H8SoVo1iXkXZK6EL0rb4kn5BhcTOot4miM4qv1
         9mIuJMl6y5t0cwSTH0FQB5Vm5vUPjNBUMNzTb7AteLGO7px5RqZ5HKi6vW+Yjlxooarh
         HdZYdhj0hO+vU9RBh6VyDirTzlT5dt2XqvLnxp6wUe9bUHwGPJK/EOOFwAA9ZYugX14F
         F4oGGSGPANNxDzaOFu0cDBrkRgsiUT14KGyb3p/uegtllvjYKuLDmIDLGo6Lv+R5aYxU
         RYZijBYHDiSUqjGWWzEFtkd44nVD91s5KHSOfESrJjN0v60SouS8SAsRGV2/3VpJM1vv
         9oIA==
X-Gm-Message-State: AOAM530NgCtCaU52ccwJpYoFNbW1+zJ0xdGqZCzxar8oQVZxO/7VsinZ
        MykC5G0gkCQ3Lfr6lXbaCcB55g==
X-Google-Smtp-Source: ABdhPJyHQmuEwO2cQ7Y9JRh9ksUJUsr15yCYIESJvvghfsOXzwabIpJ9rsWYsfbyI5WvYGNtVBWcBQ==
X-Received: by 2002:a63:7a06:: with SMTP id v6mr10410151pgc.441.1597686145978;
        Mon, 17 Aug 2020 10:42:25 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id h1sm21195366pfr.39.2020.08.17.10.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 10:42:24 -0700 (PDT)
Date:   Mon, 17 Aug 2020 10:42:22 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        gregkh@linuxfoundation.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, akashast@codeaurora.org,
        rojay@codeaurora.org, msavaliy@qti.qualcomm.com
Subject: Re: [PATCH V2 3/3] tty: serial: qcom_geni_serial: Fix the UART
 wakeup issue
Message-ID: <20200817174222.GC2995789@google.com>
References: <1595563082-2353-1-git-send-email-skakit@codeaurora.org>
 <1595563082-2353-4-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1595563082-2353-4-git-send-email-skakit@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 09:28:02AM +0530, satya priya wrote:
> As a part of system suspend we call uart_port_suspend from the
> Serial driver, which calls set_mctrl passing mctrl as NULL. This
> makes RFR high(NOT_READY) during suspend.
> 
> Due to this BT SoC is not able to send wakeup bytes to UART during
> suspend. Included if check for non-suspend case to keep RFR low
> during suspend.
> 
> Signed-off-by: satya priya <skakit@codeaurora.org>
> ---
> Changes in V2:
>  - This patch fixes the UART flow control issue during suspend.
>    Newly added in V2.
> 
>  drivers/tty/serial/qcom_geni_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 07b7b6b..7108dfc 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -242,7 +242,7 @@ static void qcom_geni_serial_set_mctrl(struct uart_port *uport,
>  	if (mctrl & TIOCM_LOOP)
>  		port->loopback = RX_TX_CTS_RTS_SORTED;
>  
> -	if (!(mctrl & TIOCM_RTS))
> +	if ((!(mctrl & TIOCM_RTS)) && (!(uport->suspended)))

Why all these parentheses, instead of:

    	if (!(mctrl & TIOCM_RTS) && !uport->suspended)

?
