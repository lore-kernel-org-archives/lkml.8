Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C25C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 10:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC54A20716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 10:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgICKhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 06:37:21 -0400
Received: from mo-csw1516.securemx.jp ([210.130.202.155]:34272 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgICKhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 06:37:11 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 083AanZf025005; Thu, 3 Sep 2020 19:36:50 +0900
X-Iguazu-Qid: 34tMd2lTh3bNiiFngA
X-Iguazu-QSIG: v=2; s=0; t=1599129409; q=34tMd2lTh3bNiiFngA; m=yfx5tZuaGPpIcb54aw33BqY59ofmVGV8uHIvgpiLVes=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1513) id 083AampL037729;
        Thu, 3 Sep 2020 19:36:48 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id 083AamnJ018789;
        Thu, 3 Sep 2020 19:36:48 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 083AaltQ027249;
        Thu, 3 Sep 2020 19:36:47 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     Ben Levinsky <ben.levinsky@xilinx.com>
Cc:     stefanos@xilinx.com, michals@xilinx.com, michael.auchter@ni.com,
        devicetree@vger.kernel.org, emooring@xilinx.com,
        mathieu.poirier@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jliang@xilinx.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v11 3/5] firmware: xilinx: Add RPU configuration APIs
References: <20200902165846.3366-1-ben.levinsky@xilinx.com>
        <20200902165846.3366-4-ben.levinsky@xilinx.com>
Date:   Thu, 03 Sep 2020 19:36:46 +0900
In-Reply-To: <20200902165846.3366-4-ben.levinsky@xilinx.com> (Ben Levinsky's
        message of "Wed, 2 Sep 2020 09:58:44 -0700")
X-TSB-HOP: ON
Message-ID: <87zh67p2o1.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

Noticed some issues while going through the code. A couple of queries
below.

Ben Levinsky <ben.levinsky@xilinx.com> writes:

> This patch adds APIs to access to configure RPU and its
> processor-specific memory.
>
> That is query the run-time mode of RPU as either split or lockstep as well
> as API to set this mode. In addition add APIs to access configuration of
> the RPUs' tightly coupled memory (TCM).
>
> Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
> ---
> v3:
> - add xilinx-related platform mgmt fn's instead of wrapping around
>   function pointer in xilinx eemi ops struct
> v4:
> - add default values for enums
> v9:
> - update commit message
> - for zynqmp_pm_set_tcm_config and zynqmp_pm_get_rpu_mode update docs for
>   expected output, arguments as well removing unused args
> - remove unused fn zynqmp_pm_get_node_status
> v11:
> - update usage of zynqmp_pm_get_rpu_mode to return rpu mode in enum
> - update zynqmp_pm_set_tcm_config and zynqmp_pm_set_rpu_mode arguments to remove unused args
> ---
>  drivers/firmware/xilinx/zynqmp.c     | 59 ++++++++++++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h | 18 +++++++++
>  2 files changed, 77 insertions(+)
>
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index a966ee956573..807e404589f8 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -846,6 +846,65 @@ int zynqmp_pm_release_node(const u32 node)
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_release_node);
>  
> +/**
> + * zynqmp_pm_get_rpu_mode() - Get RPU mode
> + * @node_id:	Node ID of the device
> + * @rpu_mode:	return by reference value
> + *		either split or lockstep
> + *
> + * Return:	return 0 on success or error+reason.
> + *		if success, then  rpu_mode will be set
> + *		to current rpu mode.
> + */
> +int zynqmp_pm_get_rpu_mode(u32 node_id, enum rpu_oper_mode *rpu_mode)
> +{
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +	int ret;
> +
> +	ret = zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
> +				  IOCTL_GET_RPU_OPER_MODE, 0, 0, ret_payload);
> +	if (ret < 0)
> +		(void)rpu_mode;

There seems to be something missing from this statement. What is
expected from "(void)rpu_mode" here.

> +	else
> +		*rpu_mode = ret_payload[0];
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_get_rpu_mode);
> +
> +/**
> + * zynqmp_pm_set_rpu_mode() - Set RPU mode
> + * @node_id:	Node ID of the device
> + * @arg1:	Argument 1 to requested IOCTL call. This is expeted to
> + *              to be value from enum rpu_oper_mode
> + *
> + * This function is used to set RPU mode to split or lockstep
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +int zynqmp_pm_set_rpu_mode(u32 node_id, u32 arg1)

If arg1 is expected to be "enum rpu_oper_mode" please have the function
argument reflect that and do any conversion needed inside the function.

> +{
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
> +				   IOCTL_SET_RPU_OPER_MODE, arg1, 0, NULL);
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_set_rpu_mode);
> +
> +/**
> + * zynqmp_pm_set_tcm_config - configure TCM
> + * @arg1:	Argument 1 to requested IOCTL call
> + *              either PM_RPU_TCM_COMB or PM_RPU_TCM_SPLIT
> + *
> + * This function is used to set RPU mode to split or combined
> + *
> + * Return: status: 0 for success, else failure
> + */
> +int zynqmp_pm_set_tcm_config(u32 node_id, u32 arg1)

Same comment as above - with the appropriate enum ofcourse.

Thanks,
Punit

> +{
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
> +				   IOCTL_TCM_COMB_CONFIG, arg1, 0, NULL);
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_set_tcm_config);
> +
>  /**
>   * zynqmp_pm_force_pwrdwn - PM call to request for another PU or subsystem to
>   *             be powered down forcefully

[...]

