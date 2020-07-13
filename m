Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68ABC433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD14C2065E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WvP9QjqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbgGMQ0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 12:26:47 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12629 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729593AbgGMQ0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:26:47 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0c8b0d0000>; Mon, 13 Jul 2020 09:25:49 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 Jul 2020 09:26:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 Jul 2020 09:26:46 -0700
Received: from [10.26.72.101] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Jul
 2020 16:26:44 +0000
Subject: Re: [PATCH v6 1/2] remoteproc: qcom: Add per subsystem SSR
 notification
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bjorn.andersson@linaro.org>, <tsoni@codeaurora.org>,
        <psodagud@codeaurora.org>, <sidgup@codeaurora.org>,
        <elder@ieee.org>, linux-tegra <linux-tegra@vger.kernel.org>
References: <1592965408-16908-1-git-send-email-rishabhb@codeaurora.org>
 <1592965408-16908-2-git-send-email-rishabhb@codeaurora.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <98e3a18e-1491-6f20-6507-d6e6817b76fe@nvidia.com>
Date:   Mon, 13 Jul 2020 17:26:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1592965408-16908-2-git-send-email-rishabhb@codeaurora.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594657549; bh=n+W/fHPjiMLdifX49gddUCYGAELEgIBFfQAWGVbyyE8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=WvP9QjqA1apj6IdMTqNWwQW8Mv+jSmgZuhsua2WWsJluO8QGxsdYFR0P3cbkPk2ZJ
         Db9PDdGwAGhKyCtYnv0kEdeUbHIk2stgK52SzcgJoUEkjIvINh7mQM/FHi8Y981w0m
         TAP+RtpFSWn9HGhhFrirKiVErYUsHI9O3JFcMgDUApXKfnt1dtJM9dH8f7rm4FJfb1
         u4yM9+QmvpI7O9VZB550oy2yBrPYpFb2YziyZcLCELiYxznS9ZZwLCbWWDCm9uF6Jv
         Wjr1x+JZUx8U/6wRy5Xv6TQo7vUcZ7x+WWVhcx4JYfp/qsPFW9g3vlqg1HW7MY4arz
         iVBSiB9DTLXtA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/06/2020 03:23, Rishabh Bhatnagar wrote:
> Currently there is a single notification chain which is called whenever any
> remoteproc shuts down. This leads to all the listeners being notified, and
> is not an optimal design as kernel drivers might only be interested in
> listening to notifications from a particular remoteproc. Create a global
> list of remoteproc notification info data structures. This will hold the
> name and notifier_list information for a particular remoteproc. The API
> to register for notifications will use name argument to retrieve the
> notification info data structure and the notifier block will be added to
> that data structure's notification chain. Also move from blocking notifier
> to srcu notifer based implementation to support dynamic notifier head
> creation.
> 
> Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>  drivers/remoteproc/qcom_common.c      | 90 ++++++++++++++++++++++++++++++-----
>  drivers/remoteproc/qcom_common.h      |  5 +-
>  include/linux/remoteproc/qcom_rproc.h | 20 ++++++--
>  3 files changed, 95 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
> index 9028cea..7a7384c 100644
> --- a/drivers/remoteproc/qcom_common.c
> +++ b/drivers/remoteproc/qcom_common.c
> @@ -12,6 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/notifier.h>
>  #include <linux/remoteproc.h>
> +#include <linux/remoteproc/qcom_rproc.h>
>  #include <linux/rpmsg/qcom_glink.h>
>  #include <linux/rpmsg/qcom_smd.h>
>  #include <linux/soc/qcom/mdt_loader.h>
> @@ -23,7 +24,14 @@
>  #define to_smd_subdev(d) container_of(d, struct qcom_rproc_subdev, subdev)
>  #define to_ssr_subdev(d) container_of(d, struct qcom_rproc_ssr, subdev)
>  
> -static BLOCKING_NOTIFIER_HEAD(ssr_notifiers);
> +struct qcom_ssr_subsystem {
> +	const char *name;
> +	struct srcu_notifier_head notifier_list;
> +	struct list_head list;
> +};
> +
> +static LIST_HEAD(qcom_ssr_subsystem_list);
> +static DEFINE_MUTEX(qcom_ssr_subsys_lock);
>  
>  static int glink_subdev_start(struct rproc_subdev *subdev)
>  {
> @@ -189,37 +197,83 @@ void qcom_remove_smd_subdev(struct rproc *rproc, struct qcom_rproc_subdev *smd)
>  }
>  EXPORT_SYMBOL_GPL(qcom_remove_smd_subdev);
>  
> +static struct qcom_ssr_subsystem *qcom_ssr_get_subsys(const char *name)
> +{
> +	struct qcom_ssr_subsystem *info;
> +
> +	mutex_lock(&qcom_ssr_subsys_lock);
> +	/* Match in the global qcom_ssr_subsystem_list with name */
> +	list_for_each_entry(info, &qcom_ssr_subsystem_list, list)
> +		if (!strcmp(info->name, name))
> +			goto out;
> +
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info) {
> +		info = ERR_PTR(-ENOMEM);
> +		goto out;
> +	}


The above appears to be breaking the ARM64 build on the latest -next
when building the modules  ...
 
  CC [M]  drivers/remoteproc/qcom_common.o
drivers/remoteproc/qcom_common.c: In function 'qcom_ssr_get_subsys':
remoteproc/qcom_common.c:210:9: error: implicit declaration of function 'kzalloc' [-Werror=implicit-function-declaration]
  info = kzalloc(sizeof(*info), GFP_KERNEL);
         ^~~~~~~
drivers/remoteproc/qcom_common.c:210:7: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
  info = kzalloc(sizeof(*info), GFP_KERNEL);

Cheers
Jon

-- 
nvpublic
