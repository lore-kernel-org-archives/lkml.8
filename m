Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C0AC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC44121D81
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599720657;
	bh=t2SyhHS+Ohd0sGWn6FEslrgMgIs2UDqjysK6cgXfMYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XYEyXGFGEDkiYmENs2IVmTVyum1lyIU8xofkvi+ThkUR1f0A0GYYaQrid2dhS8kRv
	 c1DeyBZIqugHnpMmbbYmCK8em33oUdxnoBErKB1NTWOoCQWLLvaKcO6nooLYMrtfPv
	 f8tW4GjU7PDyOPZlcb66xHtPsHUkqS2VP7NHfpRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbgIJGuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 02:50:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbgIJGua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 02:50:30 -0400
Received: from localhost (unknown [122.179.50.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 188872222B;
        Thu, 10 Sep 2020 06:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599719987;
        bh=t2SyhHS+Ohd0sGWn6FEslrgMgIs2UDqjysK6cgXfMYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aIihw9nyRXIuI9jthRt+2eE6WGIfqmusB3vrU2veny44vxhfhVC2pSM5ZmTsc+Rbs
         5FP0KkQoBVKABmPSh8J/9OwTryW8LSPwQsg88lZzt5xhdfDD0bb395EeT5IZazR03d
         jFJJEm/FfswnnqykbLW4awC/XzA+b/Ie1ksDumKQ=
Date:   Thu, 10 Sep 2020 12:09:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] soundwire: qcom: get max rows and cols info from
 compatible
Message-ID: <20200910063940.GR77521@vkoul-mobl>
References: <20200909160912.3656-1-srinivas.kandagatla@linaro.org>
 <20200909160912.3656-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909160912.3656-3-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-09-20, 17:09, Srinivas Kandagatla wrote:
> currently the max rows and cols values are hardcoded. In reality
> these values depend on the IP version. So get these based on
> device tree compatible strings.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/soundwire/qcom.c | 46 +++++++++++++++++++++++++++-------------
>  1 file changed, 31 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 1ec0ee931f5b..03c5bc05fc6e 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -69,11 +69,6 @@
>  #define SWRM_REG_VAL_PACK(data, dev, id, reg)	\
>  			((reg) | ((id) << 16) | ((dev) << 20) | ((data) << 24))
>  
> -#define SWRM_MAX_ROW_VAL	0 /* Rows = 48 */
> -#define SWRM_DEFAULT_ROWS	48
> -#define SWRM_MIN_COL_VAL	0 /* Cols = 2 */
> -#define SWRM_DEFAULT_COL	16
> -#define SWRM_MAX_COL_VAL	7
>  #define SWRM_SPECIAL_CMD_ID	0xF
>  #define MAX_FREQ_NUM		1
>  #define TIMEOUT_MS		(2 * HZ)
> @@ -107,6 +102,8 @@ struct qcom_swrm_ctrl {
>  	unsigned int version;
>  	int num_din_ports;
>  	int num_dout_ports;
> +	int cols_index;
> +	int rows_index;
>  	unsigned long dout_port_mask;
>  	unsigned long din_port_mask;
>  	struct qcom_swrm_port_config pconfig[QCOM_SDW_MAX_PORTS];
> @@ -116,6 +113,21 @@ struct qcom_swrm_ctrl {
>  	int (*reg_write)(struct qcom_swrm_ctrl *ctrl, int reg, int val);
>  };
>  
> +struct qcom_swrm_data {
> +	int default_cols;
> +	int default_rows;

unsigned int for these?

> +};
> +
> +static struct qcom_swrm_data swrm_v1_3_data = {
> +	.default_rows = 48,
> +	.default_cols = 16,
> +};
> +
> +static struct qcom_swrm_data swrm_v1_5_data = {
> +	.default_rows = 50,
> +	.default_cols = 16,
> +};
> +
>  #define to_qcom_sdw(b)	container_of(b, struct qcom_swrm_ctrl, bus)
>  
>  static int qcom_swrm_ahb_reg_read(struct qcom_swrm_ctrl *ctrl, int reg,
> @@ -302,8 +314,8 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
>  	u32 val;
>  
>  	/* Clear Rows and Cols */
> -	val = (SWRM_MAX_ROW_VAL << SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_SHFT |
> -	       SWRM_MIN_COL_VAL << SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_SHFT);
> +	val = ctrl->rows_index << SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_SHFT |
> +		ctrl->cols_index << SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_SHFT;

use FIELD_{GET|SET} / u32_encode_bits for these

Please rebase on sdw-next, this has already been updated in next

>  
>  	ctrl->reg_write(ctrl, SWRM_MCP_FRAME_CTRL_BANK_ADDR(0), val);
>  
> @@ -382,8 +394,8 @@ static int qcom_swrm_pre_bank_switch(struct sdw_bus *bus)
>  	val &= ~SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK;
>  	val &= ~SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK;
>  
> -	val |= (SWRM_MAX_ROW_VAL << SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_SHFT |
> -		SWRM_MAX_COL_VAL << SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_SHFT);
> +	val |= ctrl->rows_index << SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_SHFT |
> +	       ctrl->cols_index << SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_SHFT;
>  
>  	return ctrl->reg_write(ctrl, reg, val);
>  }
> @@ -784,6 +796,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>  	struct sdw_master_prop *prop;
>  	struct sdw_bus_params *params;
>  	struct qcom_swrm_ctrl *ctrl;
> +	const struct qcom_swrm_data *data;
>  	struct resource *res;
>  	int ret;
>  	u32 val;
> @@ -792,6 +805,9 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>  	if (!ctrl)
>  		return -ENOMEM;
>  
> +	data = of_device_get_match_data(dev);

how about checking data is valid?

> +	ctrl->rows_index = sdw_find_row_index(data->default_rows);
> +	ctrl->cols_index = sdw_find_col_index(data->default_cols);
>  #ifdef CONFIG_SLIMBUS
>  	if (dev->parent->bus == &slimbus_bus) {
>  #else
> @@ -844,8 +860,8 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>  	params = &ctrl->bus.params;
>  	params->max_dr_freq = DEFAULT_CLK_FREQ;
>  	params->curr_dr_freq = DEFAULT_CLK_FREQ;
> -	params->col = SWRM_DEFAULT_COL;
> -	params->row = SWRM_DEFAULT_ROWS;
> +	params->col = data->default_cols;
> +	params->row = data->default_rows;
>  	ctrl->reg_read(ctrl, SWRM_MCP_STATUS, &val);
>  	params->curr_bank = val & SWRM_MCP_STATUS_BANK_NUM_MASK;
>  	params->next_bank = !params->curr_bank;
> @@ -855,8 +871,8 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>  	prop->num_clk_gears = 0;
>  	prop->num_clk_freq = MAX_FREQ_NUM;
>  	prop->clk_freq = &qcom_swrm_freq_tbl[0];
> -	prop->default_col = SWRM_DEFAULT_COL;
> -	prop->default_row = SWRM_DEFAULT_ROWS;
> +	prop->default_col = data->default_cols;
> +	prop->default_row = data->default_rows;
>  
>  	ctrl->reg_read(ctrl, SWRM_COMP_HW_VERSION, &ctrl->version);
>  
> @@ -907,8 +923,8 @@ static int qcom_swrm_remove(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id qcom_swrm_of_match[] = {
> -	{ .compatible = "qcom,soundwire-v1.3.0", },
> -	{ .compatible = "qcom,soundwire-v1.5.1", },
> +	{ .compatible = "qcom,soundwire-v1.3.0", .data = &swrm_v1_3_data },
> +	{ .compatible = "qcom,soundwire-v1.5.1", .data = &swrm_v1_5_data },
>  	{/* sentinel */},
>  };
>  
> -- 
> 2.21.0

-- 
~Vinod
