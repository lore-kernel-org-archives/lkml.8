Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8006C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 20:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8703821556
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 20:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgCBUFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 15:05:19 -0500
Received: from ms.lwn.net ([45.79.88.28]:58470 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgCBUFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 15:05:18 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 03FC8823;
        Mon,  2 Mar 2020 20:05:17 +0000 (UTC)
Date:   Mon, 2 Mar 2020 13:05:17 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     <linux-doc@vger.kernel.org>, <paulmck@kernel.org>, <tj@kernel.org>,
        <jiangshanlai@gmail.com>, <wanghaibin.wang@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: kthread: Fix WQ_SYSFS workqueues path
 name
Message-ID: <20200302130517.075f97ee@lwn.net>
In-Reply-To: <20200225124052.1506-1-yuzenghui@huawei.com>
References: <20200225124052.1506-1-yuzenghui@huawei.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2020 20:40:52 +0800
Zenghui Yu <yuzenghui@huawei.com> wrote:

> The set of WQ_SYSFS workqueues should be displayed using
> "ls /sys/devices/virtual/workqueue", add the missing '/'.
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  Documentation/admin-guide/kernel-per-CPU-kthreads.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-per-CPU-kthreads.rst b/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
> index baeeba8762ae..21818aca4708 100644
> --- a/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
> +++ b/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
> @@ -234,7 +234,7 @@ To reduce its OS jitter, do any of the following:
>  	Such a workqueue can be confined to a given subset of the
>  	CPUs using the ``/sys/devices/virtual/workqueue/*/cpumask`` sysfs
>  	files.	The set of WQ_SYSFS workqueues can be displayed using
> -	"ls sys/devices/virtual/workqueue".  That said, the workqueues
> +	"ls /sys/devices/virtual/workqueue".  That said, the workqueues
>  	maintainer would like to caution people against indiscriminately
>  	sprinkling WQ_SYSFS across all the workqueues.	The reason for
>  	caution is that it is easy to add WQ_SYSFS, but because sysfs is

Applied, thanks.

jon
