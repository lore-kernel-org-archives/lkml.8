Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E724DC2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 19:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5E720709
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 19:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jj7e/Bqk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgDKTXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 15:23:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40134 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgDKTXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 15:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=SgqKM3spE6mtY9h8mMydKIrhlpWx8n0IUZfulRaiV30=; b=Jj7e/BqkuhcMA8to44KkTi06Bs
        iXA+IjaMPRjuLERXPMsbyq0FXHFc0f6sFJ/TfoMo+Gt75LzYmJc76uxWd9OPPsPN5BGm15ajFl1BI
        9KJLz64yJunAtGtOGlAVDmo3oMnov8YCt3gCcCGWuYMAQdIVWc/+zxgDiEF8j3ExkQ1A/OSOkBKni
        V71HuxiJWJq3N3ZVq4LUXmHLY+z3MnpQ9bNj9PubkTZ1aJqT5U+1nfbJIWYpbnKHibhjpqzkJYhqx
        UxUc5AM7GRNbEh//ZK6irIuJlE8xQFiJachnHbr2IweynoM5rtUYmM7i+bjG05Pa/xAS/Ivzku1+y
        a8LgKaVQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jNLiZ-00009v-C6; Sat, 11 Apr 2020 19:23:03 +0000
Subject: Re: [PATCH 3/3] driver: rpmon: add rpmon_qmi driver
To:     Wang Wenhu <wenhu.wang@vivo.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20200411095301.18780-1-wenhu.wang@vivo.com>
 <20200411095301.18780-4-wenhu.wang@vivo.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4aea2dc0-3378-9da0-9123-115a5c3e9893@infradead.org>
Date:   Sat, 11 Apr 2020 12:23:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200411095301.18780-4-wenhu.wang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 4/11/20 2:53 AM, Wang Wenhu wrote:
> RPMON_QMI is used by RPMON to communicate with remote processors
> with QMI APIs if enabled. RPMON_QMI itself is designed as a modular
> framework that would introduce different kinds of message sets
> which may be updated for versions.
> 
> RPMON_QMI creates a device of rpmon_device type for each remote
> processor endpoint. All the endpoint devices shares an unique set
> of QMI suite.
> 
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
> ---
>  drivers/rpmon/Kconfig     |  15 ++
>  drivers/rpmon/Makefile    |   1 +
>  drivers/rpmon/rpmon_qmi.c | 434 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 450 insertions(+)
>  create mode 100644 drivers/rpmon/rpmon_qmi.c
> 

> diff --git a/drivers/rpmon/rpmon_qmi.c b/drivers/rpmon/rpmon_qmi.c
> new file mode 100644
> index 000000000000..ae49510cbb83
> --- /dev/null
> +++ b/drivers/rpmon/rpmon_qmi.c
> @@ -0,0 +1,434 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2020 Vivo Communication Technology Co. Ltd.
> + * Copyright (C) 2020 Wang Wenhu <wenhu.wang@vivo.com>
> + * All rights reserved.
> + *
> + * RPMON: An implementation of remote processor monitor freamwork

                                                           framework

> + * for platforms that multi-processors exists. RPMON is implemented

      confusing sentence above.

> + * with chardev and sysfs class as interfaces to communicate with
> + * the user level. It supports different communication interfaces
> + * added modularly with remote processors. Currently QMI implementation
> + * is available.
> + *
> + * RPMON could be used to detect the stabilities of remote processors,
> + * collect any kinds of information you are interested with, take

                                               interested in, take

> + * actions like connection status check, and so on. Enhancements can
> + * be made upon current implementation.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/rpmon.h>
> +#include <linux/soc/qcom/qmi.h>
> +#include <linux/of_platform.h>
> +#include "rpmon_qmi.h"
> +
> +#define DRIVER_NAME "rpmon_qmi_drv"
> +
> +/*
> + * Remote processor registered.
> + */
> +#define RP_REGISTERED		0x0001
> +
> +/*
> + * work struct for message processing.
> + */
> +struct recv_work {
> +	struct work_struct work;
> +	struct sockaddr_qrtr sq;
> +	void *msg;
> +};
> +
> +/*
> + * Delayed work to take a reset action when a failure is detected.
> + */
> +struct exec_cb_work {
> +	struct delayed_work		dwk;
> +	struct rpmon_qmi_device *rdev;
> +	u32			checks;
> +};
> +
> +struct rpmon_qmi_exec_fn {
> +	int (*exec_call)(struct rpmon_qmi_device *rdev);
> +};
> +
> +struct rpmon_qmi_cb_fn {
> +	void (*callback)(struct work_struct *work);
> +	u32 msg_len;
> +};
> +
> +static DEFINE_MUTEX(rdev_list_lock);
> +static LIST_HEAD(rdev_list);
> +static struct rpmon_qmi *rpqmi;
> +static struct workqueue_struct *rpqmi_wq;

[snip]

> +/**
> + * rpmon_qmi_exec_cb_worker - callback worker for execution
> + * @work: work to been done
> + *
> + * Called as worker handler by the signle worker thread of rpmon_wq.

                                      single

> + * The worker is scheduled after timeout ms duration since the execution.
> + */
> +static void rpmon_qmi_exec_cb_worker(struct work_struct *work)
> +{
> +	struct delayed_work *dwk = to_delayed_work(work);
> +	struct exec_cb_work *ewk =
> +			container_of(dwk, struct exec_cb_work, dwk);
> +	struct rpmon_qmi_device *rdev = ewk->rdev;
> +
> +	mutex_lock(&rdev_list_lock);
> +	if (ewk->checks <= atomic_read(&rdev->reports)) {
> +		pr_debug("%s health check success", rdev->info->name);
> +		goto out;
> +	}
> +
> +	pr_err("subsystem %s failed to respond in time", rdev->info->name);
> +
> +	rpmon_event_notify(rdev->info, RPMON_EVENT_CHKCONN_FAIL);
> +
> +out:
> +	mutex_unlock(&rdev_list_lock);
> +	kfree(ewk);
> +}
> +
> +static struct rpmon_qmi_cb_fn rpmon_qmi_event_callbacks[] = {
> +	{
> +		.callback = rpmon_qmi_register_req_cb,
> +		.msg_len = sizeof(struct rpmon_register_req),
> +	},
> +	{
> +		.callback = rpmon_qmi_conn_check_resp_cb,
> +		.msg_len = sizeof(struct rpmon_conn_check_resp),
> +	},
> +};
> +
> +/**
> + * rpmon_qmi_conn_check - send indication, initiate and queue callback work
> + * @rdev: device interface of specific remote processor to be checked
> + */
> +static int rpmon_qmi_conn_check(struct rpmon_qmi_device *rdev)
> +{
> +	struct exec_cb_work *ewk;
> +
> +	mutex_lock(&rdev_list_lock);
> +	if (!(rdev->flag & RP_REGISTERED)) {
> +		pr_err("%s has not registered", rdev->info->name);
> +		return -ENOANO;

Why ENOANO?

> +	}
> +
> +	if (!__ratelimit(&rdev->ratelimit)) {
> +		pr_err("%s rate-limited", rdev->info->name);
> +		return 0;
> +	}
> +	mutex_unlock(&rdev_list_lock);
> +
> +	rdev->rqmi->sendmsg(rdev, NULL, 0);
> +
> +	ewk = kzalloc(sizeof(*ewk), GFP_KERNEL);
> +	if (!ewk)
> +		return -ENOANO;

ditto.

> +	ewk->rdev = rdev;
> +	ewk->checks = atomic_inc_return(&rdev->checks);
> +	INIT_DELAYED_WORK(&ewk->dwk, rpmon_qmi_exec_cb_worker);
> +	queue_delayed_work(rpqmi_wq,
> +			   &ewk->dwk, msecs_to_jiffies(rdev->timeout));
> +
> +	return 0;
> +}
> +
> +static struct rpmon_qmi_exec_fn rpmon_qmi_exec_calls[] = {
> +	{.exec_call = rpmon_qmi_conn_check},
> +};
> +
> +static int rpmon_qmi_monitor(struct rpmon_info *info, u32 event)
> +{
> +	struct rpmon_qmi_device *rdev = (struct rpmon_qmi_device *)info->priv;
> +	int i;
> +
> +	for (i = 0; i < RPMON_EXEC_MAX; i++) {
> +		if (event & RPMON_ACTION(i)) {
> +			if (i >= (sizeof(rpmon_qmi_exec_calls) /
> +				  sizeof(struct rpmon_qmi_exec_fn)))
> +				return -ENOTSUPP;
> +

I'm not totally up about speculative fetches, but is any of
<linux/nospec.h> needed here?

> +			if (rpmon_qmi_exec_calls[i].exec_call)
> +				return rpmon_qmi_exec_calls[i].exec_call(rdev);
> +			else
> +				return -ENOTSUPP;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}

[snip]

> +static void rpmon_qmi_msg_callback(enum rpmon_qmi_msg_type type,
> +			struct sockaddr_qrtr *sq,
> +			const void *msg)
> +{
> +	struct recv_work *rwk;
> +
> +	if (type >= (sizeof(rpmon_qmi_event_callbacks) /
> +		     sizeof(struct rpmon_qmi_cb_fn))) {
> +		pr_err("Error none supported message type.\n");

		              non-supported

> +		return;
> +	}
> +
> +	if (rpmon_qmi_event_callbacks[type].callback) {
> +		rwk = kzalloc(sizeof(*rwk), GFP_KERNEL);
> +		if (!rwk) {
> +			pr_err("Error to alloc recv_work");
> +			return;
> +		}
> +
> +		INIT_WORK(&rwk->work, rpmon_qmi_event_callbacks[type].callback);
> +		memcpy(&rwk->sq, sq, sizeof(*sq));
> +
> +		rwk->msg = kzalloc(rpmon_qmi_event_callbacks[type].msg_len,
> +				   GFP_KERNEL);
> +		if (!rwk->msg) {
> +			pr_err("Error to alloc message of recv_work");
> +			kfree(rwk);
> +			return;
> +		}
> +
> +		memcpy(rwk->msg, msg, rpmon_qmi_event_callbacks[type].msg_len);
> +		queue_work(rpqmi_wq, &rwk->work);
> +	}
> +}

[snip]

> +static void __exit rpmon_qmi_drv_exit(void)
> +{
> +	rpmon_qmi_del_server();
> +
> +	qmi_handle_release(&rpqmi->qmi);
> +
> +	platform_driver_unregister(&rpmon_qmi_drv);
> +}
> +module_exit(rpmon_qmi_drv_exit);
> +
> +MODULE_AUTHOR("Wang Wenhu");

Please add email address above.

> +MODULE_DESCRIPTION("Subsystem Monitor via QMI platform driver");
> +MODULE_ALIAS("platform:" DRIVER_NAME);
> +MODULE_LICENSE("GPL v2");
> 

thanks.
-- 
~Randy

