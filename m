Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C3FC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 17:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3432051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 17:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SNnJxl2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732134AbgCPRqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 13:46:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44801 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731664AbgCPRqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 13:46:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id b72so10337718pfb.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 10:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x8k/jVDU37gpRStc/a1cMXTfOGWyxVmD3DNhdHEzGuc=;
        b=SNnJxl2FEZewe1WY+S9vsiJVO/RvMY9rzFdwaiZRq6bKfSdG0MrbZomIRd57NTMGql
         grAJtsFcNQZL6qmZDeMWM+yYS93OQFB+r8a1yyLj/VxjxiNsopnrxT++XUTp7aQYGdQB
         81T38+qSDWHadjss5lqF/M96/i76BpNjBsJNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x8k/jVDU37gpRStc/a1cMXTfOGWyxVmD3DNhdHEzGuc=;
        b=dGogjLwIvRDMzaRakPj4ol+ataFXyWynDxX8ISTcRcDuMMlyEpt8KrYqvkoTT4GR1B
         PBlmWoIta8Spmm8Y283R3qxcI8Ta00bmD4QLb3JMV/kY07j7L1v6dUNcYOxgii8SgK/S
         f2KpJqdKuDAtnWNK5QvmyOm0ihKFDS3DZq16JpDOTt1qUg3xqKvfqLGk6JbZnR09Kxje
         y+jq87N/hCunvAiSKNfWKNvnxx/XRx77ynQIw3nNpfVJANHg9HBK2qNgkYM+VxmyHKrI
         I668gZUWGmDOrS8Q1zysJIDMe+3yrkeczf0q/+srGzw6PRoFk7N5x+xdzNSGQPWrcMp1
         cjSw==
X-Gm-Message-State: ANhLgQ3GiNoy6K5pRMGrCE9OlPIZ0X+TjJ8+1UmhmvpyO8KEaWEdhD2f
        kEq/FM8Ba/qlWk3Yvo998mm9dw==
X-Google-Smtp-Source: ADFU+vtljDaaENS/fxZFNy91odlW5ccQs77guzTCnMx9s1r6JqlQeTyMhwB/uC72V0pG3rBE4+aFeg==
X-Received: by 2002:a62:25c3:: with SMTP id l186mr783098pfl.52.1584380777006;
        Mon, 16 Mar 2020 10:46:17 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id u12sm478026pfm.165.2020.03.16.10.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2020 10:46:16 -0700 (PDT)
Date:   Mon, 16 Mar 2020 10:46:15 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rocky Liao <rjliao@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org
Subject: Re: [PATCH v1 1/2] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth SoC QCA6390
Message-ID: <20200316174615.GP144492@google.com>
References: <20200314094328.3331-1-rjliao@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200314094328.3331-1-rjliao@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 14, 2020 at 05:43:27PM +0800, Rocky Liao wrote:
> This patch adds support for QCA6390, including the devicetree and acpi
> compatible hwid matching, and patch/nvm downloading.
> 
> Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
> ---
>  drivers/bluetooth/btqca.c   | 44 +++++++++++++++++++++++++++++++----
>  drivers/bluetooth/btqca.h   |  8 +++++++
>  drivers/bluetooth/hci_qca.c | 46 +++++++++++++++++++++++++++++++------
>  3 files changed, 86 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index a16845c0751d..ca126e499c58 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -14,6 +14,9 @@
>  
>  #define VERSION "0.1"
>  
> +#define QCA_IS_3991_6390(soc_type)    \
> +	(soc_type == QCA_WCN3991 || soc_type == QCA_QCA6390)

This macro style is 3991 or 6390 is pretty ugly, IMO it's worse than the
problem it intends to solve.

I would either just spell out what the macro does, or if that becomes to
cumbersome (especially when more types are added) have a macro that checks
a bitmask like:

qca_soc_type_matches(soc_type, QCA_WCN3991 | QCA6390)

For this the SoC types read from FW would have to be mapped to a bit for
each SoC type, which could be done during initialization.

Another alternative could be to have a set of flags that indicate if a SoC
has certain characteristics (e.g. enhanced logging needs to be enabled),
these flags could be set during initialization.

> +
>  int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version,
>  			 enum qca_btsoc_type soc_type)
>  {
> @@ -32,7 +35,7 @@ int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version,
>  	 * VSE event. WCN3991 sends version command response as a payload to
>  	 * command complete event.
>  	 */
> -	if (soc_type == QCA_WCN3991) {
> +	if (QCA_IS_3991_6390(soc_type)) {
>  		event_type = 0;
>  		rlen += 1;
>  		rtype = EDL_PATCH_VER_REQ_CMD;
> @@ -69,7 +72,7 @@ int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version,
>  		goto out;
>  	}
>  
> -	if (soc_type == QCA_WCN3991)
> +	if (QCA_IS_3991_6390(soc_type))
>  		memmove(&edl->data, &edl->data[1], sizeof(*ver));
>  
>  	ver = (struct qca_btsoc_version *)(edl->data);
> @@ -138,6 +141,29 @@ int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
>  }
>  EXPORT_SYMBOL_GPL(qca_send_pre_shutdown_cmd);
>  
> +int qca_send_enhancelog_enable_cmd(struct hci_dev *hdev)
> +{
> +	struct sk_buff *skb;
> +	int err;
> +	const u8 param[2] = {0x14, 0x01};
> +
> +	bt_dev_dbg(hdev, "QCA enhanced log enable cmd");
> +
> +	skb = __hci_cmd_sync_ev(hdev, QCA_ENHANCED_LOG_ENABLE_CMD, 2,
> +				param, HCI_EV_CMD_COMPLETE, HCI_INIT_TIMEOUT);
> +
> +	if (IS_ERR(skb)) {
> +		err = PTR_ERR(skb);
> +		bt_dev_err(hdev, "Enhanced log enable cmd failed (%d)", err);
> +		return err;
> +	}
> +
> +	kfree_skb(skb);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(qca_send_enhancelog_enable_cmd);
> +
>  static void qca_tlv_check_data(struct qca_fw_config *config,
>  		const struct firmware *fw, enum qca_btsoc_type soc_type)
>  {
> @@ -217,7 +243,7 @@ static void qca_tlv_check_data(struct qca_fw_config *config,
>  				tlv_nvm->data[0] |= 0x80;
>  
>  				/* UART Baud Rate */
> -				if (soc_type == QCA_WCN3991)
> +				if (QCA_IS_3991_6390(soc_type))
>  					tlv_nvm->data[1] = nvm_baud_rate;
>  				else
>  					tlv_nvm->data[2] = nvm_baud_rate;
> @@ -268,7 +294,7 @@ static int qca_tlv_send_segment(struct hci_dev *hdev, int seg_size,
>  	 * VSE event. WCN3991 sends version command response as a payload to
>  	 * command complete event.
>  	 */
> -	if (soc_type == QCA_WCN3991) {
> +	if (QCA_IS_3991_6390(soc_type)) {
>  		event_type = 0;
>  		rlen = sizeof(*edl);
>  		rtype = EDL_PATCH_TLV_REQ_CMD;
> @@ -301,7 +327,7 @@ static int qca_tlv_send_segment(struct hci_dev *hdev, int seg_size,
>  		err = -EIO;
>  	}
>  
> -	if (soc_type == QCA_WCN3991)
> +	if (QCA_IS_3991_6390(soc_type))
>  		goto out;
>  
>  	tlv_resp = (struct tlv_seg_resp *)(edl->data);
> @@ -442,6 +468,11 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  			    (soc_ver & 0x0000000f);
>  		snprintf(config.fwname, sizeof(config.fwname),
>  			 "qca/crbtfw%02x.tlv", rom_ver);
> +	} else if (soc_type == QCA_QCA6390) {
> +		rom_ver = ((soc_ver & 0x00000f00) >> 0x04) |
> +			    (soc_ver & 0x0000000f);
> +		snprintf(config.fwname, sizeof(config.fwname),
> +			 "qca/htbtfw%02x.tlv", rom_ver);
>  	} else {
>  		snprintf(config.fwname, sizeof(config.fwname),
>  			 "qca/rampatch_%08x.bin", soc_ver);
> @@ -464,6 +495,9 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  	else if (qca_is_wcn399x(soc_type))
>  		snprintf(config.fwname, sizeof(config.fwname),
>  			 "qca/crnv%02x.bin", rom_ver);
> +	else if (soc_type == QCA_QCA6390)
> +		snprintf(config.fwname, sizeof(config.fwname),
> +			 "qca/htnv%02x.bin", rom_ver);
>  	else
>  		snprintf(config.fwname, sizeof(config.fwname),
>  			 "qca/nvm_%08x.bin", soc_ver);
> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
> index e16a4d650597..bc703817c3d7 100644
> --- a/drivers/bluetooth/btqca.h
> +++ b/drivers/bluetooth/btqca.h
> @@ -14,6 +14,7 @@
>  #define EDL_NVM_ACCESS_SET_REQ_CMD	(0x01)
>  #define MAX_SIZE_PER_TLV_SEGMENT	(243)
>  #define QCA_PRE_SHUTDOWN_CMD		(0xFC08)
> +#define QCA_ENHANCED_LOG_ENABLE_CMD     (0xFC17)
>  
>  #define EDL_CMD_REQ_RES_EVT		(0x00)
>  #define EDL_PATCH_VER_RES_EVT		(0x19)
> @@ -127,6 +128,7 @@ enum qca_btsoc_type {
>  	QCA_WCN3990,
>  	QCA_WCN3991,
>  	QCA_WCN3998,
> +	QCA_QCA6390,

QCA_QCAxxxx seems a bit redundant, why not call it QCA_6390 or QCA6390?
I also wouldn't be opposed to scrap the QCA_ prefixes from the WCN399x
types, this is the QCA Bluetooth driver, so it's pretty evident that
these are Qualcomm chips.
