Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28685C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02997206A5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DRgHK2Rb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgICQvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgICQvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:51:01 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38A0C061246
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 09:51:00 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u20so2811752pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 09:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tYswq0INUnCXDjKxKIlArRe/7d70YANql2ROlnI+buo=;
        b=DRgHK2RbTx2vSGyzMiXUH8rTd9nawtq6hdIIwJ2t1AS6MXHt7VP+6oUKf/aKWykrqR
         XX5W9+4UVu4miJ0qlbYZW7EcwoIPRQv/2p/TB1S00FYjdceD6gf5sTjQOIFGjKuj70JP
         WbeefPKTvlM1bhI2uvoiH9s5zgp0U+zHxPiLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tYswq0INUnCXDjKxKIlArRe/7d70YANql2ROlnI+buo=;
        b=oAqrKY1bVSEYjnpq5NxaqKceIxLx0fAQLKHM7o005aJduBHk7xJ74kU18GRVuYIeq4
         v8Ryp1vfpyDMGEwBtXMiMv9im5I+e3A4LTX7BKO2ykQ3r/bPcSOKj7Q2HJIu5q/qXKxJ
         ObfzalZnactVaeut9SclnWHpj260i4H500lhn0+Jf5QFnnEQthubO2qHVySQ0fB/FHue
         sGHHEuw3JNxosbZf2X1A58pKlYxkwPer/pkxuCyMvujBpuACh/0ZNj87W9ZlCHWoLu9w
         Rbdr5iE3fjWwyE1A0dPqvsh6K1B0kdLliH+vxevLep4/JAYiz7u4XWw5Av20i6kpYaLZ
         KDKA==
X-Gm-Message-State: AOAM531yrQGS7WY2gVHDuSFNgpb71rkw3cl51jykxe6D8qFI0KuZoxGS
        007AUr0722eYkXsUFZ+k7/LlDQ==
X-Google-Smtp-Source: ABdhPJxe0+f43E5C2y6BmpiWR2I624iFFvdWU7omKgeAVYClcZCTt7hfqW1mcf1BOPFfo071tiYWLQ==
X-Received: by 2002:a63:500e:: with SMTP id e14mr3701731pgb.36.1599151859998;
        Thu, 03 Sep 2020 09:50:59 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id gx5sm2966059pjb.57.2020.09.03.09.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 09:50:59 -0700 (PDT)
Date:   Thu, 3 Sep 2020 09:50:58 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        gregkh@linuxfoundation.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, akashast@codeaurora.org,
        rojay@codeaurora.org, msavaliy@qti.qualcomm.com
Subject: Re: [PATCH V4 4/4] tty: serial: qcom_geni_serial: Fix the UART
 wakeup issue
Message-ID: <20200903165058.GK3419728@google.com>
References: <1599145498-20707-1-git-send-email-skakit@codeaurora.org>
 <1599145498-20707-5-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1599145498-20707-5-git-send-email-skakit@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 08:34:58PM +0530, satya priya wrote:
> As a part of system suspend uart_port_suspend is called from the
> Serial driver, which calls set_mctrl passing mctrl as NULL. This

nit: s/NULL/0/

> makes RFR high(NOT_READY) during suspend.
> 
> Due to this BT SoC is not able to send wakeup bytes to UART during
> suspend. Include if check for non-suspend case to keep RFR low
> during suspend.

Is this patch actually needed?

With the other patches in this series the UART doesn't control RFR
on IDP, and I suppose corresponding pinconf changes should also be
done on other devices that want to support wakeup. Effectively,
I see Bluetooth wakeup working without this patch on a sc7180
device.

> Signed-off-by: satya priya <skakit@codeaurora.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Akash Asthana <akashast@codeaurora.org>
> ---
> Changes in V2:
>  - This patch fixes the UART flow control issue during suspend.
>    Newly added in V2.
> 
> Changes in V3:
>  - As per Matthias's comment removed the extra parentheses.
> 
> Changes in V4:
>  - No change.
> 
>  drivers/tty/serial/qcom_geni_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 07b7b6b..2aad9d7 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -242,7 +242,7 @@ static void qcom_geni_serial_set_mctrl(struct uart_port *uport,
>  	if (mctrl & TIOCM_LOOP)
>  		port->loopback = RX_TX_CTS_RTS_SORTED;
>  
> -	if (!(mctrl & TIOCM_RTS))
> +	if (!(mctrl & TIOCM_RTS) && !uport->suspended)
>  		uart_manual_rfr = UART_MANUAL_RFR_EN | UART_RFR_NOT_READY;
>  	writel(uart_manual_rfr, uport->membase + SE_UART_MANUAL_RFR);
>  }
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
> of Code Aurora Forum, hosted by The Linux Foundation
> 
