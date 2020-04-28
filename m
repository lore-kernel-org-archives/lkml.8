Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B2FC83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C15FD208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Y4JojaNB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgD1Qiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:38:54 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:47834 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728037AbgD1Qix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:38:53 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03SGcWQr007658;
        Tue, 28 Apr 2020 18:38:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=ho062TRS0YdQ6wUnxTpdhRHNh/WM5Lgej+B4b4n+1WU=;
 b=Y4JojaNBtGP9CoyX+sKdfiEZeYVNiE9SsaFXBE4sApdQ179oDInnlsJfgIXrRuYmOkuq
 PpLyX1racB7DlJrMZ55V4evElOtb9DjKjwj99Jed3EPuNJWxWiHxZbAJ7GTfqWSfkuGX
 sAYKpOfqtCJxYrSz91Oj+jGyv9o7sy5UgYrIzibaiKunR9TMB4tm+n7IRTya7TEs0l4f
 TX6ZD9mrw+Pb2l7/zuoM/NhG9PJkf6yobA7mUMfoq2vA5KBItp+OZibVbQv/WZw9GfSA
 bG9+FPzeHXZNj/6XWPERS5fqs4VuRFeHQ1QQ5T7ZwRODPgJDfME3ZMF+X/fcPjAFYSTQ LQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30mhjws5jb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Apr 2020 18:38:44 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A9B9310002A;
        Tue, 28 Apr 2020 18:38:43 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 95B912B5F4B;
        Tue, 28 Apr 2020 18:38:43 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.44) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 28 Apr
 2020 18:38:42 +0200
Subject: Re: [PATCH v3 03/14] remoteproc: Add new operation and flags for
 synchronistation
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <loic.pallardy@st.com>, <s-anna@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200424200135.28825-1-mathieu.poirier@linaro.org>
 <20200424200135.28825-4-mathieu.poirier@linaro.org>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <7c5c8d5e-feb7-74ad-a2eb-1ccb8192b0ae@st.com>
Date:   Tue, 28 Apr 2020 18:38:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424200135.28825-4-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-28_11:2020-04-28,2020-04-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/20 10:01 PM, Mathieu Poirier wrote:
> Add a new sync_ops to support use cases where the remoteproc
> core is synchronising with the remote processor.  Exactly when to use
> the synchronisation operations is directed by the flags in structure
> rproc_sync_flags.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  include/linux/remoteproc.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index ac4082f12e8b..ceb3b2bba824 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -353,6 +353,23 @@ enum rsc_handling_status {
>  	RSC_IGNORED	= 1,
>  };
>  
> +/**
> + * struct rproc_sync_flags - platform specific flags indicating which
> + *			      rproc_ops to use at specific times during
> + *			      the rproc lifecycle.
> + * @on_init: true if synchronising with the remote processor at
> + *	     initialisation time
> + * @after_stop: true if synchronising with the remote processor after it was
> + *		stopped from the cmmand line
typo command
> + * @after_crash: true if synchronising with the remote processor after
> + *		 it has crashed
> + */
> +struct rproc_sync_flags {
> +	bool on_init;
> +	bool after_stop;
> +	bool after_crash;
> +};
> +
how about a bit field instead (just a proposition)?
Platform driver would set the sync flag and rproc_set_sync_flag could be a 
simple mask instead of a switch case.

Is it possible to split this patch in a different ways because difficult to understand as
rproc_sync_flags seems not used before 
[PATCH v3 09/14] remoteproc: Deal with synchronisation when crashing

Thanks
Arnaud  

>  /**
>   * struct rproc_ops - platform-specific device handlers
>   * @start:	power on the device and boot it
> @@ -459,6 +476,9 @@ struct rproc_dump_segment {
>   * @firmware: name of firmware file to be loaded
>   * @priv: private data which belongs to the platform-specific rproc module
>   * @ops: platform-specific start/stop rproc handlers
> + * @sync_ops: platform-specific start/stop rproc handlers when
> + *	      synchronising with a remote processor.
> + * @sync_flags: Determine the rproc_ops to choose in specific states.
>   * @dev: virtual device for refcounting and common remoteproc behavior
>   * @power: refcount of users who need this rproc powered up
>   * @state: state of the device
> @@ -482,6 +502,7 @@ struct rproc_dump_segment {
>   * @table_sz: size of @cached_table
>   * @has_iommu: flag to indicate if remote processor is behind an MMU
>   * @auto_boot: flag to indicate if remote processor should be auto-started
> + * @sync_with_rproc: true if currently synchronising with the rproc
>   * @dump_segments: list of segments in the firmware
>   * @nb_vdev: number of vdev currently handled by rproc
>   */
> @@ -492,6 +513,8 @@ struct rproc {
>  	const char *firmware;
>  	void *priv;
>  	struct rproc_ops *ops;
> +	struct rproc_ops *sync_ops;
> +	struct rproc_sync_flags sync_flags;
>  	struct device dev;
>  	atomic_t power;
>  	unsigned int state;
> @@ -515,6 +538,7 @@ struct rproc {
>  	size_t table_sz;
>  	bool has_iommu;
>  	bool auto_boot;
> +	bool sync_with_rproc;
>  	struct list_head dump_segments;
>  	int nb_vdev;
>  	u8 elf_class;
> 
