Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4234BC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8332084D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hJrBS8oG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgAORdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 12:33:18 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42158 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgAORdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 12:33:18 -0500
Received: by mail-pl1-f193.google.com with SMTP id p9so7110727plk.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 09:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wSehoxvwgPJ3qRcy4KOjaQ2g1YFkKXYLIvCDj5Tb0pc=;
        b=hJrBS8oGKaygMrG8r9UuJikZzYcublFntoivenmN00d1aDSkXeIVb8yvmE2J9kIOdp
         r6eEUQoeIUJ/9Amzhc3zgwwyx6+n0gGKyxx1rfr16BHudcW9/d3f+ZXApQaArzn8G0SD
         UpdrZ8d9SefG5vShZAVKNKTNsVVbeFeNpFSG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wSehoxvwgPJ3qRcy4KOjaQ2g1YFkKXYLIvCDj5Tb0pc=;
        b=bSV6ijUJ8X2X18YwQUR3nivwIb/wsvtIfelyDoHERAB7xOCvCpqDucU7nq3uB48bgP
         X63Ya7UvbXf0gSx61sdGpENX4tKH2w6T3i43kO7hripJhH68ixsHYB+jV2J6NV1CwyuR
         90v1HMJzprVB8kxpwk8NVp1aK4zcXIwSiBpiRIsKcdjfv/k4JYkHUmcsa5v36YBkqsup
         /FmMx4wTVP4BzK2n2VGb729dj/KfmCPzDXlSIploFtA67xD32LNH701XenUn/Q4DvReO
         p9KxxwHZV9qsL1obFADQp9lBWsiOCzExMqDeMAsuIc8UMdPnOrnstCSjjnxJISsWe8Mp
         qDfA==
X-Gm-Message-State: APjAAAVxH4VHRWmUOCzkSHc42zP9pyxpus/a178qQJY7iUbKQ0w23TEd
        KH0drI8pam8fS4lCIJdixEMdMQ==
X-Google-Smtp-Source: APXvYqy4QETPwQs32qvwl1MNKys41sAL/ljfhcu4krgU3mBi0kbRvnHa4tPpGG+bkv0uuAdRqV5nZQ==
X-Received: by 2002:a17:902:ab91:: with SMTP id f17mr33113263plr.172.1579109597426;
        Wed, 15 Jan 2020 09:33:17 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id f43sm402960pje.23.2020.01.15.09.33.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 09:33:16 -0800 (PST)
Date:   Wed, 15 Jan 2020 09:33:15 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rocky Liao <rjliao@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        hemantg@codeaurora.org
Subject: Re: [PATCH v4 2/3] Bluetooth: hci_qca: Retry btsoc initialize when
 it fails
Message-ID: <20200115173315.GN89495@google.com>
References: <20191225060317.5258-1-rjliao@codeaurora.org>
 <20200115085552.11483-1-rjliao@codeaurora.org>
 <20200115085552.11483-2-rjliao@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200115085552.11483-2-rjliao@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 04:55:51PM +0800, Rocky Liao wrote:
> This patch adds the retry of btsoc initialization when it fails. There are
> reports that the btsoc initialization may fail on some platforms but the
> repro ratio is very low. The symptoms is the firmware downloading failed
> due to the UART write timed out. The failure may be caused by UART,
> platform HW or the btsoc itself but it's very difficlut to root cause,
> given the repro ratio is very low. Add a retry for the btsoc initialization
> can work around most of the failures and make Bluetooth finally works.
> 
> Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
> ---
> 
> Changes in v2: None
> Changes in v3: None
> Changes in v4:
>   -rebased the patch with latet code
>   -refined macro and variable name
>   -updated commit message
> 
>  drivers/bluetooth/hci_qca.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index ecb74965be10..1139142e8eed 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -55,6 +55,9 @@
>  /* Controller debug log header */
>  #define QCA_DEBUG_HANDLE	0x2EDC
>  
> +/* max retry count when init fails */
> +#define MAX_INIT_RETRIES 3
> +
>  /* Controller dump header */
>  #define QCA_SSR_DUMP_HANDLE		0x0108
>  #define QCA_DUMP_PACKET_SIZE		255
> @@ -1539,6 +1542,7 @@ static int qca_setup(struct hci_uart *hu)
>  	struct hci_dev *hdev = hu->hdev;
>  	struct qca_data *qca = hu->priv;
>  	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
> +	unsigned int retries = 0;
>  	enum qca_btsoc_type soc_type = qca_soc_type(hu);
>  	const char *firmware_name = qca_get_firmware_name(hu);
>  	int ret;
> @@ -1559,6 +1563,7 @@ static int qca_setup(struct hci_uart *hu)
>  	bt_dev_info(hdev, "setting up %s",
>  		qca_is_wcn399x(soc_type) ? "wcn399x" : "ROME");
>  
> +retry:
>  	ret = qca_power_on(hdev);
>  	if (ret)
>  		return ret;
> @@ -1613,6 +1618,20 @@ static int qca_setup(struct hci_uart *hu)
>  		 * patch/nvm-config is found, so run with original fw/config.
>  		 */
>  		ret = 0;
> +	} else {
> +		if (retries < MAX_INIT_RETRIES) {
> +			qca_power_shutdown(hu);
> +			if (hu->serdev) {
> +				serdev_device_close(hu->serdev);
> +				ret = serdev_device_open(hu->serdev);
> +				if (ret) {
> +					bt_dev_err(hdev, "failed to open port");
> +					return ret;
> +				}
> +			}
> +			retries++;
> +			goto retry;
> +		}
>  	}
>  
>  	/* Setup bdaddr */
> -- 

Assuming that this is really a rare condition:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
