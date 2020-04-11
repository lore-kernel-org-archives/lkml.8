Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6F0C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 19:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D30E20708
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 19:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eqDqDL59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgDKTHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 15:07:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38028 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgDKTHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 15:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:To:Subject:
        From:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=GdDKDgejd7lsHVtz+D1n+0JwcD2b8JVMGVjeJuEFVQM=; b=eqDqDL5979AulIdM2+Pv+w0hRX
        XElNbQteU7XNZCBMIOxfMXfmLTRTnS15rodFJ0DhyFJa/pqqdPPkJSNoT889Idiz2guFiC2VUYii+
        zQB5oreVN8LXJgBsjLDT4vVveuMeBhsZ+tQWzX+11EUFvM3IJPzqjynrNf2kg9il7gumFn3v64wog
        jUKgRD36waz747Nf1evRasK/L17uGZc3Kla/9P1/sjmBY6CiZN1ZDkJsYv13Zr/u80gzYfJnsGd8D
        k6D8TvnCPMjoIUKh0TyE0LDsOr4+9DflYzQoS8BFkmK7TChoNIOpyHeIHcdNEwx7OD665kIYoSrzE
        jz5aGXQg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jNLTE-0000BL-C9; Sat, 11 Apr 2020 19:07:12 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 2/3] driver: rpmon: qmi message version 01
To:     Wang Wenhu <wenhu.wang@vivo.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20200411095301.18780-1-wenhu.wang@vivo.com>
 <20200411095301.18780-3-wenhu.wang@vivo.com>
Message-ID: <36d40370-f55a-2b71-68c0-1c777f35f85c@infradead.org>
Date:   Sat, 11 Apr 2020 12:07:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200411095301.18780-3-wenhu.wang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 4/11/20 2:53 AM, Wang Wenhu wrote:
> Implements a RPMON_QMI message set for a certain rpmon service.
> RPMON_QMI defines its message types modularly. Each rpmon service
> binds to a message set and introduced as a module. This version 1.0
> message set could be used for connection checking of remote processors.
> 
> RPMON_QMI messages depend on QCOM_QMI_HELPERS and should be updated
> together with QMI related modules.
> 
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
> ---
>  drivers/rpmon/Kconfig            |  13 ++
>  drivers/rpmon/Makefile           |   1 +
>  drivers/rpmon/rpmon_qmi.h        |  77 ++++++++++
>  drivers/rpmon/rpmon_qmi_msg_v1.c | 240 +++++++++++++++++++++++++++++++
>  4 files changed, 331 insertions(+)
>  create mode 100644 drivers/rpmon/rpmon_qmi.h
>  create mode 100644 drivers/rpmon/rpmon_qmi_msg_v1.c
> 

> diff --git a/drivers/rpmon/rpmon_qmi.h b/drivers/rpmon/rpmon_qmi.h
> new file mode 100644
> index 000000000000..f6e7cfc97a3f
> --- /dev/null
> +++ b/drivers/rpmon/rpmon_qmi.h
> @@ -0,0 +1,77 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2020 Vivo Communication Technology Co. Ltd.
> + * Copyright (C) 2020 Wang Wenhu <wenhu.wang@vivo.com>
> + * All rights reserved.
> + */
> +
> +#ifndef RPMON_QMI_INTERFACE_H
> +#define RPMON_QMI_INTERFACE_H
> +
> +#define RP_NAME_LEN 255
> +#define RPQMI_BUF_SIZE	4096
> +#define QMI_TLV_TL_SIZE	3
> +
> +enum rpmon_exec_result {
> +	RPMON_EXEC_SUCCESS = 0,
> +	RPMON_EXEC_FAILURE = 1,
> +};
> +
> +struct rpmon_register_req {
> +	uint8_t name_valid;
> +	char name[RP_NAME_LEN + 1];
> +	uint8_t timeout_valid;
> +	u32 timeout;
> +};

Is this struct packed or padded?
Is it shared with/used by other drivers?

> +
> +struct rpmon_conn_indication {
> +	char placeholder;
> +};
> +
> +struct rpmon_conn_check_resp {
> +	uint8_t result_valid;
> +	struct qmi_response_type_v01 result;
> +};
> +
> +struct rpmon_response {
> +	struct qmi_response_type_v01 resp;
> +};
> +
> +struct rpmon_qmi_device {
> +	struct list_head		list;
> +	struct sockaddr_qrtr	addr;
> +	u32			timeout;
> +	u32			flag;
> +	struct ratelimit_state	ratelimit;
> +
> +	atomic_t		checks;
> +	atomic_t		reports;
> +
> +	struct rpmon_info *info;
> +	struct rpmon_qmi  *rqmi;
> +};
> +
> +struct rpmon_qmi {
> +	struct rpmon_info		*info;
> +	struct qmi_handle		qmi;
> +	struct qmi_service		*svc;
> +	struct qmi_ops			*ops;
> +	struct qmi_msg_handler		*handlers;
> +	int (*sendmsg)(const struct rpmon_qmi_device *rdev,
> +			const void *data,
> +			u32 len);
> +};
> +
> +/* rpqmi message types currently supported. */
> +enum rpmon_qmi_msg_type {
> +	RPQMI_MSG_REGISTER = 0,
> +	RPQMI_MSG_CONNCHK_RESP,
> +	RPQMI_MSG_MAX,
> +};
> +
> +int rpmon_qmi_handle_init(struct rpmon_qmi *rqmi,
> +		void (*cb)(enum rpmon_qmi_msg_type type,
> +			struct sockaddr_qrtr *sq,
> +			const void *msg));
> +
> +#endif /* RPMON_QMI_INTERFACE_H */
> diff --git a/drivers/rpmon/rpmon_qmi_msg_v1.c b/drivers/rpmon/rpmon_qmi_msg_v1.c
> new file mode 100644
> index 000000000000..10d38d8133b0
> --- /dev/null
> +++ b/drivers/rpmon/rpmon_qmi_msg_v1.c
> @@ -0,0 +1,240 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 Vivo Communication Technology Co. Ltd.
> + * Copyright (C) 2020 Wang Wenhu <wenhu.wang@vivo.com>
> + * All rights reserved.
> + *
> + * RPMON	An implementation of remote processor monitor freamwork

typo:                                                         framework  {in all 3 source files}

> + * for platforms that multi-processors exists. RPMON is implemented

but that sentence is confusing at best.

> + * with chardev and sysfs class as interfaces to communicate with
> + * the user level. It supports different communication interfaces
> + * added modularly with remote processors. Currently QMI implementation
> + * is available, and this file implements the message type v1.
> + *
> + * RPMON could be used to detect the stabilities of remote processors,
> + * collect any kinds of information you are interested with, take

                                               interested in, take

> + * actions like connection status check, and so on. Enhancements can
> + * be made upon current implementation.
> + */
> +
> +#include <linux/soc/qcom/qmi.h>
> +#include <linux/rpmon.h>
> +#include "rpmon_qmi.h"
> +
> +#define RPMON_SVC_ID_V01	0x3c
> +#define RPMON_SVC_VER_V01	0x01
> +#define RPMON_SVC_INS_V01	0x00
> +
> +#define RPMON_CONN_REQ_MSG_ID_VO1			0x20
> +#define RPMON_CONN_RESP_MSG_ID_VO1			0x20
> +#define RPMON_CONN_IND_MSG_ID_V01			0x21
> +#define RPMON_EXEC_COMP_REQ_MSG_ID_V01		0x22
> +#define RPMON_EXEC_COMP_RESP_MSG_ID_V01		0x22
> +
> +static struct qmi_elem_info register_req_v01_ei[] = {
> +	{
> +		.data_type      = QMI_OPT_FLAG,
> +		.elem_len       = 1,
> +		.elem_size      = sizeof(uint8_t),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x10,

Can you use an enum or #define value for the tlv_type magic numbers?
(multiple places)

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
> +
> +static struct qmi_elem_info conn_indication_v01_ei[] = {
> +	{
> +		.data_type      = QMI_EOTI,
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = QMI_COMMON_TLV_TYPE,
> +	},
> +};
> +
> +static struct qmi_elem_info response_v01_ei[] = {
> +	{
> +		.data_type      = QMI_STRUCT,
> +		.elem_len       = 1,
> +		.elem_size      = sizeof(struct qmi_response_type_v01),
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = 0x02,
> +		.offset         = offsetof(
> +				struct rpmon_response,
> +				resp),

multiple lines not needed above.

> +		.ei_array      = qmi_response_type_v01_ei,
> +	},
> +	{
> +		.data_type      = QMI_EOTI,
> +		.array_type     = NO_ARRAY,
> +		.tlv_type       = QMI_COMMON_TLV_TYPE,
> +	},
> +};
> +
> +static void (*msg_callback)(enum rpmon_qmi_msg_type type,
> +			    struct sockaddr_qrtr *sq,
> +			    const void *msg);
> +
> +static int rpmon_qmi_sendmsg_v1(const struct rpmon_qmi_device *rdev,
> +				const void *data,
> +				u32 len)
> +{
> +	int ret;
> +	struct sockaddr_qrtr sq;
> +
> +	memcpy(&sq, &rdev->addr, sizeof(sq));
> +
> +	ret = qmi_send_indication(&rdev->rqmi->qmi, &sq,
> +				  RPMON_CONN_IND_MSG_ID_V01,
> +				  QMI_TLV_TL_SIZE,
> +				  conn_indication_v01_ei, NULL);
> +	if (ret < 0)
> +		pr_err("Error %d send indication failed", ret);
> +
> +	return ret;
> +}
> +
> +static void rpmon_qmi_recv_register_req_v1(struct qmi_handle *qmi,
> +			struct sockaddr_qrtr *sq,
> +			struct qmi_txn *txn,
> +			const void *msg)
> +{
> +	struct rpmon_response resp;
> +	int ret;
> +
> +	resp.resp.result = QMI_RESULT_SUCCESS_V01;
> +	resp.resp.error = QMI_ERR_NONE_V01;
> +	ret = qmi_send_response(qmi, sq, txn,
> +				RPMON_CONN_RESP_MSG_ID_VO1,
> +				sizeof(resp.resp) + QMI_TLV_TL_SIZE * 2,
> +				response_v01_ei,
> +				&resp.resp);
> +	if (ret < 0)
> +		pr_err("Error %d send respons failed", ret);
> +
> +	if (msg_callback)
> +		msg_callback(RPQMI_MSG_REGISTER, sq, msg);
> +}
> +
> +void rpmon_qmi_recv_conn_check_resp_v1(struct qmi_handle *qmi,
> +	struct sockaddr_qrtr *sq,
> +	struct qmi_txn *txn,
> +	const void *msg)
> +{
> +	struct rpmon_response resp;
> +	int ret;
> +
> +	resp.resp.result = QMI_RESULT_SUCCESS_V01;
> +	resp.resp.error = QMI_ERR_NONE_V01;
> +	ret = qmi_send_response(qmi, sq, txn,
> +				RPMON_EXEC_COMP_REQ_MSG_ID_V01,
> +				sizeof(resp.resp) + QMI_TLV_TL_SIZE * 2,
> +				response_v01_ei,
> +				&resp.resp);
> +	if (ret < 0)
> +		pr_err("Error %d send respons failed", ret);

		                      response

> +
> +	if (msg_callback)
> +		msg_callback(RPQMI_MSG_CONNCHK_RESP, sq, msg);
> +}
> +
> +static struct qmi_msg_handler rpmon_qmi_msg_handlers_v01[] = {
> +	{
> +		.type = QMI_REQUEST,
> +		.msg_id = RPMON_CONN_REQ_MSG_ID_VO1,
> +		.ei = register_req_v01_ei,
> +		.decoded_size = sizeof(struct rpmon_register_req),
> +		.fn = rpmon_qmi_recv_register_req_v1,
> +	},
> +	{
> +		.type = QMI_REQUEST,
> +		.msg_id = RPMON_EXEC_COMP_REQ_MSG_ID_V01,
> +		.ei = conn_check_resp_v01_ei,
> +		.decoded_size = sizeof(struct rpmon_conn_check_resp),
> +		.fn = rpmon_qmi_recv_conn_check_resp_v1,
> +	},
> +};
> +
> +static struct qmi_service rpmon_qmi_svc = {
> +	.service = RPMON_SVC_ID_V01,
> +	.version = RPMON_SVC_VER_V01,
> +	.instance = RPMON_SVC_INS_V01,
> +};
> +
> +int rpmon_qmi_handle_init(struct rpmon_qmi *rqmi,
> +		void (*cb)(enum rpmon_qmi_msg_type type,
> +			   struct sockaddr_qrtr *sq,
> +			   const void *msg))
> +{
> +	rqmi->svc = &rpmon_qmi_svc;
> +	rqmi->handlers = rpmon_qmi_msg_handlers_v01;
> +	rqmi->sendmsg = rpmon_qmi_sendmsg_v1;
> +
> +	if (cb)
> +		msg_callback = cb;
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(rpmon_qmi_handle_init);
> +
> +MODULE_AUTHOR("Wang Wenhu");

Please include email address in the string above.
About 3/4 of all uses of MODULE_AUTHOR() do so.

> +MODULE_LICENSE("GPL v2");
> 

thanks.
-- 
~Randy

