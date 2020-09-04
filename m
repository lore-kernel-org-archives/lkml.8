Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFE1C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 05:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECAB0206C9
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 05:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgIDFYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 01:24:04 -0400
Received: from mo-csw1516.securemx.jp ([210.130.202.155]:36476 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgIDFYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 01:24:03 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 0845Nl96029789; Fri, 4 Sep 2020 14:23:48 +0900
X-Iguazu-Qid: 34tKqQuZ1rIRQCAdQl
X-Iguazu-QSIG: v=2; s=0; t=1599197027; q=34tKqQuZ1rIRQCAdQl; m=bHQnvnj8fj43z0qYHRT5DlNboUVTf+5Eg7zcdr7Odyo=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1510) id 0845Nk86011100;
        Fri, 4 Sep 2020 14:23:46 +0900
Received: from enc03.toshiba.co.jp ([106.186.93.13])
        by imx2.toshiba.co.jp  with ESMTP id 0845NkFC025197;
        Fri, 4 Sep 2020 14:23:46 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc03.toshiba.co.jp  with ESMTP id 0845Njao027360;
        Fri, 4 Sep 2020 14:23:45 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     Ben Levinsky <ben.levinsky@xilinx.com>
Cc:     stefanos@xilinx.com, michals@xilinx.com,
        devicetree@vger.kernel.org, emooring@xilinx.com,
        michael.auchter@ni.com, mathieu.poirier@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jliang@xilinx.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v12 3/5] firmware: xilinx: Add RPU configuration APIs
References: <20200903212310.17990-1-ben.levinsky@xilinx.com>
        <20200903212310.17990-4-ben.levinsky@xilinx.com>
Date:   Fri, 04 Sep 2020 14:23:44 +0900
X-TSB-HOP: ON
Message-ID: <87imcup127.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

Thanks for addressing the comments on the previous version. One comment
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
> v12:
> - in drivers/firmware/zynqmp.c, update zynqmp_pm_set_rpu_mode so rpu_mode
>   is only set if no error
> - update args for zynqmp_pm_set_rpu_mode, zynqmp_pm_set_tcm_config fn arg's to
>   reflect what is expected in the function and the usage in
>   zynqmp_r5_remoteproc accordingly
> ---
>  drivers/firmware/xilinx/zynqmp.c     | 60 ++++++++++++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h | 18 +++++++++
>  2 files changed, 78 insertions(+)
>
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index a966ee956573..916a0b15ab33 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -846,6 +846,66 @@ int zynqmp_pm_release_node(const u32 node)
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
> +
> +	/* only set rpu_mode if no error */
> +	*rpu_mode = ret_payload[0];

The comment and the statement do not match. rpu_mode is being
un-conditionally set even if there is an error.

It's not clear which is correct - the code or the comment?

Other than that, the rest of the patch looks fine.

Thanks,
Punit

> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_get_rpu_mode);
> +
> +/**
> + * zynqmp_pm_set_rpu_mode() - Set RPU mode
> + * @node_id:	Node ID of the device
> + * @rpu_mode:	Argument 1 to requested IOCTL call. either split or lockstep
> + *
> + *		This function is used to set RPU mode to split or
> + *		lockstep
> + *
> + * Return:	Returns status, either success or error+reason
> + */
> +int zynqmp_pm_set_rpu_mode(u32 node_id, enum rpu_oper_mode rpu_mode)
> +{
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
> +				   IOCTL_SET_RPU_OPER_MODE, (u32)rpu_mode,
> +				   0, NULL);
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_set_rpu_mode);
> +
> +/**
> + * zynqmp_pm_set_tcm_config - configure TCM
> + * @tcm_mode:	Argument 1 to requested IOCTL call
> + *              either PM_RPU_TCM_COMB or PM_RPU_TCM_SPLIT
> + *
> + * This function is used to set RPU mode to split or combined
> + *
> + * Return: status: 0 for success, else failure
> + */
> +int zynqmp_pm_set_tcm_config(u32 node_id, enum rpu_tcm_comb tcm_mode)
> +{
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id,
> +				   IOCTL_TCM_COMB_CONFIG, (u32)tcm_mode, 0,
> +				   NULL);
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_set_tcm_config);
> +
>  /**
>   * zynqmp_pm_force_pwrdwn - PM call to request for another PU or subsystem to
>   *             be powered down forcefully
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 6241c5ac51b3..79aa2fcbcd54 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -385,6 +385,9 @@ int zynqmp_pm_request_wake(const u32 node,
>  			   const bool set_addr,
>  			   const u64 address,
>  			   const enum zynqmp_pm_request_ack ack);
> +int zynqmp_pm_get_rpu_mode(u32 node_id, enum rpu_oper_mode *rpu_mode);
> +int zynqmp_pm_set_rpu_mode(u32 node_id, u32 arg1);
> +int zynqmp_pm_set_tcm_config(u32 node_id, u32 arg1);
>  #else
>  static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
>  {
> @@ -549,6 +552,21 @@ static inline int zynqmp_pm_request_wake(const u32 node,
>  {
>  	return -ENODEV;
>  }
> +
> +static inline int zynqmp_pm_get_rpu_mode(u32 node_id, enum rpu_oper_mode *rpu_mode)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int zynqmp_pm_set_rpu_mode(u32 node_id, u32 arg1)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int zynqmp_pm_set_tcm_config(u32 node_id, u32 arg1)
> +{
> +	return -ENODEV;
> +}
>  #endif
>  
>  #endif /* __FIRMWARE_ZYNQMP_H__ */
