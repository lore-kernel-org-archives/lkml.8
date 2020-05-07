Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27946C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 021DA207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="lLTG3m+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgEGSCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:02:15 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:11413 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727771AbgEGSCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:02:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588874534; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=4yDrMYccwPReA9j2ANAELXNtg9SFRUnwpspfAHYq0jQ=;
 b=lLTG3m+TlPZ37xXJwGRZr3hm0fJ6MjJPjRWL0so/gGSoel/HjcoDKu5HTRqRQaBgr77pQ45o
 1jT/tqT1ZjzDMj/rPhxXUUaEop8TDs7+GlViPCOOEr6oDBZdpoBTB0XHkmGgLSOIwyBxMnyD
 k7pSdMheKZR7Lwrem0oaZKN0+es=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb44cf5.7fb1f1013500-smtp-out-n04;
 Thu, 07 May 2020 18:01:25 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4086AC433BA; Thu,  7 May 2020 18:01:25 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 64528C433D2;
        Thu,  7 May 2020 18:01:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 07 May 2020 11:01:24 -0700
From:   rishabhb@codeaurora.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Chris Lew <clew@codeaurora.org>, Sibi <sibis@codeaurora.org>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        linux-remoteproc-owner@vger.kernel.org
Subject: Re: [PATCH 3/4] rpmsg: glink: Integrate glink_ssr in qcom_glink
In-Reply-To: <20200423003736.2027371-4-bjorn.andersson@linaro.org>
References: <20200423003736.2027371-1-bjorn.andersson@linaro.org>
 <20200423003736.2027371-4-bjorn.andersson@linaro.org>
Message-ID: <bd5db1445c94f40c8d71504dc642d811@codeaurora.org>
X-Sender: rishabhb@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-22 17:37, Bjorn Andersson wrote:
> In all but the very special case of a system with _only_ glink_rpm,
> GLINK is dependent on glink_ssr, so move it to rpmsg and combine it 
> with
> qcom_glink_native in the new qcom_glink kernel module.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Acked-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>

>  drivers/rpmsg/Kconfig                                    | 6 +++---
>  drivers/rpmsg/Makefile                                   | 3 ++-
>  drivers/{soc/qcom/glink_ssr.c => rpmsg/qcom_glink_ssr.c} | 4 ----
>  drivers/soc/qcom/Kconfig                                 | 9 ---------
>  drivers/soc/qcom/Makefile                                | 1 -
>  include/linux/rpmsg/qcom_glink.h                         | 7 +------
>  6 files changed, 6 insertions(+), 24 deletions(-)
>  rename drivers/{soc/qcom/glink_ssr.c => rpmsg/qcom_glink_ssr.c} (97%)
> 
> diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
> index a9108ff563dc..f96716893c2a 100644
> --- a/drivers/rpmsg/Kconfig
> +++ b/drivers/rpmsg/Kconfig
> @@ -24,13 +24,13 @@ config RPMSG_MTK_SCP
>  	  remote processors in MediaTek platforms.
>  	  This use IPI and IPC to communicate with remote processors.
> 
> -config RPMSG_QCOM_GLINK_NATIVE
> +config RPMSG_QCOM_GLINK
>  	tristate
>  	select RPMSG
> 
>  config RPMSG_QCOM_GLINK_RPM
>  	tristate "Qualcomm RPM Glink driver"
> -	select RPMSG_QCOM_GLINK_NATIVE
> +	select RPMSG_QCOM_GLINK
>  	depends on HAS_IOMEM
>  	depends on MAILBOX
>  	help
> @@ -40,7 +40,7 @@ config RPMSG_QCOM_GLINK_RPM
> 
>  config RPMSG_QCOM_GLINK_SMEM
>  	tristate "Qualcomm SMEM Glink driver"
> -	select RPMSG_QCOM_GLINK_NATIVE
> +	select RPMSG_QCOM_GLINK
>  	depends on MAILBOX
>  	depends on QCOM_SMEM
>  	help
> diff --git a/drivers/rpmsg/Makefile b/drivers/rpmsg/Makefile
> index ae92a7fb08f6..ffe932ef6050 100644
> --- a/drivers/rpmsg/Makefile
> +++ b/drivers/rpmsg/Makefile
> @@ -2,8 +2,9 @@
>  obj-$(CONFIG_RPMSG)		+= rpmsg_core.o
>  obj-$(CONFIG_RPMSG_CHAR)	+= rpmsg_char.o
>  obj-$(CONFIG_RPMSG_MTK_SCP)	+= mtk_rpmsg.o
> +qcom_glink-objs			:= qcom_glink_native.o qcom_glink_ssr.o
> +obj-$(CONFIG_RPMSG_QCOM_GLINK) += qcom_glink.o
>  obj-$(CONFIG_RPMSG_QCOM_GLINK_RPM) += qcom_glink_rpm.o
> -obj-$(CONFIG_RPMSG_QCOM_GLINK_NATIVE) += qcom_glink_native.o
>  obj-$(CONFIG_RPMSG_QCOM_GLINK_SMEM) += qcom_glink_smem.o
>  obj-$(CONFIG_RPMSG_QCOM_SMD)	+= qcom_smd.o
>  obj-$(CONFIG_RPMSG_VIRTIO)	+= virtio_rpmsg_bus.o
> diff --git a/drivers/soc/qcom/glink_ssr.c 
> b/drivers/rpmsg/qcom_glink_ssr.c
> similarity index 97%
> rename from drivers/soc/qcom/glink_ssr.c
> rename to drivers/rpmsg/qcom_glink_ssr.c
> index 847d79c935f1..dcd1ce616974 100644
> --- a/drivers/soc/qcom/glink_ssr.c
> +++ b/drivers/rpmsg/qcom_glink_ssr.c
> @@ -164,7 +164,3 @@ static struct rpmsg_driver qcom_glink_ssr_driver = 
> {
>  	},
>  };
>  module_rpmsg_driver(qcom_glink_ssr_driver);
> -
> -MODULE_ALIAS("rpmsg:glink_ssr");
> -MODULE_DESCRIPTION("Qualcomm GLINK SSR notifier");
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 19332ea40234..5140bd82f1be 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -35,15 +35,6 @@ config QCOM_GENI_SE
>  	  driver is also used to manage the common aspects of multiple Serial
>  	  Engines present in the QUP.
> 
> -config QCOM_GLINK_SSR
> -	tristate "Qualcomm Glink SSR driver"
> -	depends on RPMSG
> -	depends on QCOM_RPROC_COMMON
> -	help
> -	  Say y here to enable GLINK SSR support. The GLINK SSR driver
> -	  implements the SSR protocol for notifying the remote processor 
> about
> -	  neighboring subsystems going up or down.
> -
>  config QCOM_GSBI
>  	tristate "QCOM General Serial Bus Interface"
>  	depends on ARCH_QCOM || COMPILE_TEST
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 5d6b83dc58e8..e9cacc9ad401 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -3,7 +3,6 @@ CFLAGS_rpmh-rsc.o := -I$(src)
>  obj-$(CONFIG_QCOM_AOSS_QMP) +=	qcom_aoss.o
>  obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
>  obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
> -obj-$(CONFIG_QCOM_GLINK_SSR) +=	glink_ssr.o
>  obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
>  obj-$(CONFIG_QCOM_MDT_LOADER)	+= mdt_loader.o
>  obj-$(CONFIG_QCOM_OCMEM)	+= ocmem.o
> diff --git a/include/linux/rpmsg/qcom_glink.h 
> b/include/linux/rpmsg/qcom_glink.h
> index 09daa0acde2c..daded9fddf36 100644
> --- a/include/linux/rpmsg/qcom_glink.h
> +++ b/include/linux/rpmsg/qcom_glink.h
> @@ -12,6 +12,7 @@ struct qcom_glink;
>  struct qcom_glink *qcom_glink_smem_register(struct device *parent,
>  					    struct device_node *node);
>  void qcom_glink_smem_unregister(struct qcom_glink *glink);
> +void qcom_glink_ssr_notify(const char *ssr_name);
> 
>  #else
> 
> @@ -23,12 +24,6 @@ qcom_glink_smem_register(struct device *parent,
>  }
> 
>  static inline void qcom_glink_smem_unregister(struct qcom_glink 
> *glink) {}
> -
> -#endif
> -
> -#if IS_ENABLED(CONFIG_RPMSG_QCOM_GLINK_SSR)
> -void qcom_glink_ssr_notify(const char *ssr_name);
> -#else
>  static inline void qcom_glink_ssr_notify(const char *ssr_name) {}
>  #endif
