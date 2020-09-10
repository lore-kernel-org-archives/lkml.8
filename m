Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22317C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC02620855
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HfnozHbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbgIJIJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgIJIJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:09:44 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A879C061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:09:43 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w5so5624672wrp.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HW5X6FWMv5/e4KSBh82l0NpUQWigGJ0PbEh/1MkAVKU=;
        b=HfnozHbWaTguajYcFNCVKxZ75ih8D/HaTbS53P9AhX6OU9DY9b7kQa5XoK9ZDPIxub
         zJe8aLjRn9bjJ5T3+tEDTbLvam1KHVi5P9mMtPf8daiKa/RSLEzjln21/fTxFXLpfTXW
         DKsaaIKEPDTGy7ODLODbWhH2nMKYMmm144Pz7c5NEuokuV+78OaRiJGNz5ljTTrv2mXi
         R4VXcAYCkdUJd3ToDY7dbZH2g1UwXOvC74FNzUZlOmnFypZz2GUMA7AXvZ01Rg+0Rh1I
         uF3+Sc6P73+SmQC1I05a9Kg17PHHd8xtExKuT9X1rujIXJRtv49pCn6nwwP0bHgqVpx0
         qDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HW5X6FWMv5/e4KSBh82l0NpUQWigGJ0PbEh/1MkAVKU=;
        b=oj/q4pfpaNppadkySznjHHMEtRFe4l/zf9X9g9vp75jI33fuAb0qL4YalvIHNcewNz
         bh0kH5IzVDbCbjw9Dj66CCEb0LV5NInybs7q1uQTSKV3t2AK+XJcEixqtz/oHmsyADjL
         AgCWQigspSC9maYw8oTjyJTMZf0mx6ua33P09dv6ZGuR0cil2Mr7UU8+a3YFGSPtQt1V
         yoAysK9ylkSpdERFJGFIoWejAvg64gnHs0o0rIzljcd9FZeicoXtOzuN94j2Cs3qBBqi
         tszJhhzsmHnpaYRMcXiT8hNJd42TmIy5ZrJ3w0Z4NimQchxv0JkYWdpzUnBkrZrUsrcz
         SvDQ==
X-Gm-Message-State: AOAM531tZzyKxAvM7Mdg4csZDDBXGQGxJk68YhVtVFvgL+Y09AlDdidL
        xefRganhvVW0MPhfCHREsHhueDqXgVr/KA==
X-Google-Smtp-Source: ABdhPJyC24439Plq0OYUSmUtWSm/IIc4tZh9ord4BIkHn4H3dQ3W41vvJq9aF+i00RtWqgOdPeQmOw==
X-Received: by 2002:adf:8544:: with SMTP id 62mr7749987wrh.262.1599725381930;
        Thu, 10 Sep 2020 01:09:41 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id 197sm2616771wme.10.2020.09.10.01.09.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Sep 2020 01:09:41 -0700 (PDT)
Subject: Re: [PATCH 2/2] soundwire: qcom: get max rows and cols info from
 compatible
To:     Vinod Koul <vkoul@kernel.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20200909160912.3656-1-srinivas.kandagatla@linaro.org>
 <20200909160912.3656-3-srinivas.kandagatla@linaro.org>
 <20200910063940.GR77521@vkoul-mobl>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <c14cf97f-5a42-95a5-d44c-bc6ac9ea35a3@linaro.org>
Date:   Thu, 10 Sep 2020 09:09:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200910063940.GR77521@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/09/2020 07:39, Vinod Koul wrote:
> On 09-09-20, 17:09, Srinivas Kandagatla wrote:
>> currently the max rows and cols values are hardcoded. In reality
>> these values depend on the IP version. So get these based on
>> device tree compatible strings.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/soundwire/qcom.c | 46 +++++++++++++++++++++++++++-------------
>>   1 file changed, 31 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
>> index 1ec0ee931f5b..03c5bc05fc6e 100644
>> --- a/drivers/soundwire/qcom.c
>> +++ b/drivers/soundwire/qcom.c
>> @@ -69,11 +69,6 @@
>>   #define SWRM_REG_VAL_PACK(data, dev, id, reg)	\
>>   			((reg) | ((id) << 16) | ((dev) << 20) | ((data) << 24))
>>   
>> -#define SWRM_MAX_ROW_VAL	0 /* Rows = 48 */
>> -#define SWRM_DEFAULT_ROWS	48
>> -#define SWRM_MIN_COL_VAL	0 /* Cols = 2 */
>> -#define SWRM_DEFAULT_COL	16
>> -#define SWRM_MAX_COL_VAL	7
>>   #define SWRM_SPECIAL_CMD_ID	0xF
>>   #define MAX_FREQ_NUM		1
>>   #define TIMEOUT_MS		(2 * HZ)
>> @@ -107,6 +102,8 @@ struct qcom_swrm_ctrl {
>>   	unsigned int version;
>>   	int num_din_ports;
>>   	int num_dout_ports;
>> +	int cols_index;
>> +	int rows_index;
>>   	unsigned long dout_port_mask;
>>   	unsigned long din_port_mask;
>>   	struct qcom_swrm_port_config pconfig[QCOM_SDW_MAX_PORTS];
>> @@ -116,6 +113,21 @@ struct qcom_swrm_ctrl {
>>   	int (*reg_write)(struct qcom_swrm_ctrl *ctrl, int reg, int val);
>>   };
>>   
>> +struct qcom_swrm_data {
>> +	int default_cols;
>> +	int default_rows;
> 
> unsigned int for these?
Yes, we could do that but does it really add anything, given the range 
is up to 256.

> 
>> +};
>> +
>> +static struct qcom_swrm_data swrm_v1_3_data = {
>> +	.default_rows = 48,
>> +	.default_cols = 16,
>> +};
>> +
>> +static struct qcom_swrm_data swrm_v1_5_data = {
>> +	.default_rows = 50,
>> +	.default_cols = 16,
>> +};
>> +
>>   #define to_qcom_sdw(b)	container_of(b, struct qcom_swrm_ctrl, bus)
>>   
>>   static int qcom_swrm_ahb_reg_read(struct qcom_swrm_ctrl *ctrl, int reg,
>> @@ -302,8 +314,8 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
>>   	u32 val;
>>   
>>   	/* Clear Rows and Cols */
>> -	val = (SWRM_MAX_ROW_VAL << SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_SHFT |
>> -	       SWRM_MIN_COL_VAL << SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_SHFT);
>> +	val = ctrl->rows_index << SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_SHFT |
>> +		ctrl->cols_index << SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_SHFT;
> 
> use FIELD_{GET|SET} / u32_encode_bits for these
> 
> Please rebase on sdw-next, this has already been updated in next

Yes, I will do that!
> 
>>   
>>   	ctrl->reg_write(ctrl, SWRM_MCP_FRAME_CTRL_BANK_ADDR(0), val);
>>   
>> @@ -382,8 +394,8 @@ static int qcom_swrm_pre_bank_switch(struct sdw_bus *bus)
>>   	val &= ~SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_BMSK;
>>   	val &= ~SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_BMSK;
>>   
>> -	val |= (SWRM_MAX_ROW_VAL << SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_SHFT |
>> -		SWRM_MAX_COL_VAL << SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_SHFT);
>> +	val |= ctrl->rows_index << SWRM_MCP_FRAME_CTRL_BANK_ROW_CTRL_SHFT |
>> +	       ctrl->cols_index << SWRM_MCP_FRAME_CTRL_BANK_COL_CTRL_SHFT;
>>   
>>   	return ctrl->reg_write(ctrl, reg, val);
>>   }
>> @@ -784,6 +796,7 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>>   	struct sdw_master_prop *prop;
>>   	struct sdw_bus_params *params;
>>   	struct qcom_swrm_ctrl *ctrl;
>> +	const struct qcom_swrm_data *data;
>>   	struct resource *res;
>>   	int ret;
>>   	u32 val;
>> @@ -792,6 +805,9 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>>   	if (!ctrl)
>>   		return -ENOMEM;
>>   
>> +	data = of_device_get_match_data(dev);
> 
> how about checking data is valid?
I think the check would be unnecessary here, as we would not endup here 
without a matching compatible!

--srini
> 
>> +	ctrl->rows_index = sdw_find_row_index(data->default_rows);
>> +	ctrl->cols_index = sdw_find_col_index(data->default_cols);
>>   #ifdef CONFIG_SLIMBUS
>>   	if (dev->parent->bus == &slimbus_bus) {
>>   #else
>> @@ -844,8 +860,8 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>>   	params = &ctrl->bus.params;
>>   	params->max_dr_freq = DEFAULT_CLK_FREQ;
>>   	params->curr_dr_freq = DEFAULT_CLK_FREQ;
>> -	params->col = SWRM_DEFAULT_COL;
>> -	params->row = SWRM_DEFAULT_ROWS;
>> +	params->col = data->default_cols;
>> +	params->row = data->default_rows;
>>   	ctrl->reg_read(ctrl, SWRM_MCP_STATUS, &val);
>>   	params->curr_bank = val & SWRM_MCP_STATUS_BANK_NUM_MASK;
>>   	params->next_bank = !params->curr_bank;
>> @@ -855,8 +871,8 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>>   	prop->num_clk_gears = 0;
>>   	prop->num_clk_freq = MAX_FREQ_NUM;
>>   	prop->clk_freq = &qcom_swrm_freq_tbl[0];
>> -	prop->default_col = SWRM_DEFAULT_COL;
>> -	prop->default_row = SWRM_DEFAULT_ROWS;
>> +	prop->default_col = data->default_cols;
>> +	prop->default_row = data->default_rows;
>>   
>>   	ctrl->reg_read(ctrl, SWRM_COMP_HW_VERSION, &ctrl->version);
>>   
>> @@ -907,8 +923,8 @@ static int qcom_swrm_remove(struct platform_device *pdev)
>>   }
>>   
>>   static const struct of_device_id qcom_swrm_of_match[] = {
>> -	{ .compatible = "qcom,soundwire-v1.3.0", },
>> -	{ .compatible = "qcom,soundwire-v1.5.1", },
>> +	{ .compatible = "qcom,soundwire-v1.3.0", .data = &swrm_v1_3_data },
>> +	{ .compatible = "qcom,soundwire-v1.5.1", .data = &swrm_v1_5_data },
>>   	{/* sentinel */},
>>   };
>>   
>> -- 
>> 2.21.0
> 
