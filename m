Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DBCC2BBFD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0A872063A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H5NA28x/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732555AbgDMRMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727981AbgDMRMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 13:12:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C483EC0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 10:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=FrPpZW/67FvMCf81HynQ34ZVElAUVoMxfBwwvRHldqc=; b=H5NA28x/59qsKkhajuuSe6yvaT
        QDX94bCrmayuMAAS+QILAUHrXuyhxTwkrB3OgOydqUxHJyziPKLKg5PXiKEpUNzLKHg78/IVX1ZHa
        ho0Ch+1jbQtmyvefXIrSxdEeW0u5ASs6Jw+8OjBlNJ1iAiWkl5krD5Bcb6GjbmbE1fwbYu+gfV7B+
        dl1rAmik7YdyJbLY/Bz3z/jyBF4RFt+FUlOavWSTC+KyvJW4AQ0LJBCQvvyZeK9jbg9tN93fQFTzc
        dg1Jy+Nhs0zyPNxUxZ9HqWwhjM3GT4+WN2YbI2MotLI6ih9IRr0SW/RMJe++d8zkPzaD2OhU8Xw1g
        EPhemz8Q==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jO2dd-0006f0-Qr; Mon, 13 Apr 2020 17:12:49 +0000
Subject: Re: [PATCH v2,2/3] driver: rpmon: qmi message version 01
To:     Wang Wenhu <wenhu.wang@vivo.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
References: <20200411095301.18780-1-wenhu.wang@vivo.com>
 <20200412112405.24116-1-wenhu.wang@vivo.com>
 <20200412112405.24116-3-wenhu.wang@vivo.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <dbc89d13-a7ce-347f-0f7a-4b500b31f4fc@infradead.org>
Date:   Mon, 13 Apr 2020 10:12:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200412112405.24116-3-wenhu.wang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 4/12/20 4:24 AM, Wang Wenhu wrote:
> Implements a RPMON_QMI message set for connection checking service.
> RPMON_QMI defines its message types modularly. Each rpmon service
> binds to a message set and introduced as a module. This version 1.0
> message set could be used for connection checking of remote processors.
> 
> RPMON_QMI messages depend on QCOM_QMI_HELPERS and should be updated
> together with QMI related modules, and if so, RPMON_QMI_MAG_V2 would
> be introduced as a new module, in parallel with RPMON_QMI_MAG_V1.
> 
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
> ---
> Changes since v1:
>  - Addressed review comments from Randy
> 
> ---
>  drivers/rpmon/Kconfig            |  13 ++
>  drivers/rpmon/Makefile           |   1 +
>  drivers/rpmon/rpmon_qmi.h        |  77 ++++++++++
>  drivers/rpmon/rpmon_qmi_msg_v1.c | 242 +++++++++++++++++++++++++++++++
>  4 files changed, 333 insertions(+)
>  create mode 100644 drivers/rpmon/rpmon_qmi.h
>  create mode 100644 drivers/rpmon/rpmon_qmi_msg_v1.c
> 

> diff --git a/drivers/rpmon/rpmon_qmi_msg_v1.c b/drivers/rpmon/rpmon_qmi_msg_v1.c
> new file mode 100644
> index 000000000000..3fe6d6a4cf31
> --- /dev/null
> +++ b/drivers/rpmon/rpmon_qmi_msg_v1.c
> @@ -0,0 +1,242 @@

I am hoping that your patch:
[PATCH] soc: qmi: move tlv-micros to header file

will eventually allow the .tlv_type constants below to become #define values.

Otherwise these changes (patch 2/3) look good.  Thanks.

> +static struct qmi_elem_info register_req_v01_ei[] = {
> +	{
> +		.data_type      = QMI_OPT_FLAG,
> +		.elem_len       = 1,
> +		.elem_size      = sizeof(uint8_t),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x10,
> +		.offset         = offsetof(struct rpmon_register_req,
> +					   name_valid),
> +	},
> +	{
> +		.data_type      = QMI_STRING,
> +		.elem_len       = RP_NAME_LEN,
> +		.elem_size      = sizeof(char),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x10,
> +		.offset         = offsetof(struct rpmon_register_req,
> +					   name),
> +	},
> +	{
> +		.data_type      = QMI_OPT_FLAG,
> +		.elem_len       = 1,
> +		.elem_size      = sizeof(uint8_t),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x11,
> +		.offset         = offsetof(struct rpmon_register_req,
> +					   timeout_valid),
> +	},
> +	{
> +		.data_type      = QMI_UNSIGNED_4_BYTE,
> +		.elem_len       = 1,
> +		.elem_size      = sizeof(u32),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x11,
> +		.offset         = offsetof(struct rpmon_register_req,
> +					   timeout),
> +	},
> +	{
> +		.data_type      = QMI_EOTI,
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = QMI_COMMON_TLV_TYPE,
> +	},
> +};
> +
> +static struct qmi_elem_info conn_check_resp_v01_ei[] = {
> +	{
> +		.data_type      = QMI_OPT_FLAG,
> +		.elem_len       = 1,
> +		.elem_size      = sizeof(uint8_t),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x10,
> +		.offset         = offsetof(struct rpmon_conn_check_resp,
> +					   result_valid),
> +	},
> +	{
> +		.data_type      = QMI_SIGNED_4_BYTE_ENUM,
> +		.elem_len       = 1,
> +		.elem_size      = sizeof(enum rpmon_exec_result),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x10,
> +		.offset         = offsetof(struct rpmon_conn_check_resp,
> +					   result),
> +	},
> +	{
> +		.data_type      = QMI_EOTI,
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = QMI_COMMON_TLV_TYPE,
> +	},
> +};



-- 
~Randy

