Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBF6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 05:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8317B206BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 05:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="FF/l+9Nv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgGQFXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 01:23:04 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:24994 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725300AbgGQFXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 01:23:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594963382; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=3ZpZ6/pCNKcDZYIqNInGVw+8RVODNqnFWNjYNp94gOI=;
 b=FF/l+9NvPhrzG59nSWRmtOvEsvb6Lfd0RpX/Mdnzec8/1pNxfgcYwolVIFeI59C+EwYpSMmM
 l6C4TxXcmMAxUxrpzPiillWepfP4bD/TzTxTvzFn8cflzcqqrSZkQQPZvva4Zae4WkWjNWOn
 lIfkKHG2mEBNkcU3W4AF7jcvUT4=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f1135b5e3bee125105afc4f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 17 Jul 2020 05:23:01
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E2D9AC433CA; Fri, 17 Jul 2020 05:23:00 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F2B8EC433C6;
        Fri, 17 Jul 2020 05:22:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 17 Jul 2020 10:52:59 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        evgreen@chromium.org, ohad@wizery.com
Subject: Re: [PATCH 2/3] remoteproc: qcom_q6v5_mss: Add MBA log extraction
 support
In-Reply-To: <20200717045741.GC2922385@builder.lan>
References: <20200716123630.21892-1-sibis@codeaurora.org>
 <20200716123630.21892-3-sibis@codeaurora.org>
 <20200717045741.GC2922385@builder.lan>
Message-ID: <52afbcbc46604680064c938f54dee331@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-17 10:27, Bjorn Andersson wrote:
> On Thu 16 Jul 05:36 PDT 2020, Sibi Sankar wrote:
> 
>> On SC7180 the MBA firmware stores the bootup text logs in a 4K segment
>> at the beginning of the MBA region. Add support to extract the logs
>> which will be useful to debug mba boot/authentication issues.
>> 
>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> ---
>>  drivers/remoteproc/qcom_q6v5_mss.c | 41 
>> ++++++++++++++++++++++++++----
>>  1 file changed, 36 insertions(+), 5 deletions(-)
>> 
>> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c 
>> b/drivers/remoteproc/qcom_q6v5_mss.c
>> index 95e21ed607cb9..4ddf084b2c6fc 100644
>> --- a/drivers/remoteproc/qcom_q6v5_mss.c
>> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
>> @@ -9,6 +9,7 @@
>> 
>>  #include <linux/clk.h>
>>  #include <linux/delay.h>
>> +#include <linux/devcoredump.h>
>>  #include <linux/dma-mapping.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/kernel.h>
>> @@ -37,6 +38,8 @@
>> 
>>  #define MPSS_CRASH_REASON_SMEM		421
>> 
>> +#define MBA_LOG_SIZE			SZ_4K
>> +
>>  /* RMB Status Register Values */
>>  #define RMB_PBL_SUCCESS			0x1
>> 
>> @@ -139,6 +142,7 @@ struct rproc_hexagon_res {
>>  	int version;
>>  	bool need_mem_protection;
>>  	bool has_alt_reset;
>> +	bool has_mba_logs;
>>  	bool has_spare_reg;
>>  };
>> 
>> @@ -200,6 +204,7 @@ struct q6v5 {
>>  	struct qcom_sysmon *sysmon;
>>  	bool need_mem_protection;
>>  	bool has_alt_reset;
>> +	bool has_mba_logs;
>>  	bool has_spare_reg;
>>  	int mpss_perm;
>>  	int mba_perm;
>> @@ -518,6 +523,19 @@ static int q6v5_rmb_mba_wait(struct q6v5 *qproc, 
>> u32 status, int ms)
>>  	return val;
>>  }
>> 
>> +static void q6v5_dump_mba_logs(struct q6v5 *qproc)
>> +{
>> +	struct rproc *rproc = qproc->rproc;
>> +	void *data;
>> +
>> +	data = vmalloc(MBA_LOG_SIZE);
>> +	if (!data)
>> +		return;
>> +
>> +	memcpy(data, qproc->mba_region, MBA_LOG_SIZE);
>> +	dev_coredumpv(&rproc->dev, data, MBA_LOG_SIZE, GFP_KERNEL);
>> +}
>> +
>>  static int q6v5proc_reset(struct q6v5 *qproc)
>>  {
>>  	u32 val;
>> @@ -838,6 +856,7 @@ static int q6v5_mba_load(struct q6v5 *qproc)
>>  {
>>  	int ret;
>>  	int xfermemop_ret;
>> +	bool mba_load_err = false;
>> 
>>  	qcom_q6v5_prepare(&qproc->q6v5);
>> 
>> @@ -931,7 +950,7 @@ static int q6v5_mba_load(struct q6v5 *qproc)
>>  	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_q6);
>>  	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_modem);
>>  	q6v5proc_halt_axi_port(qproc, qproc->halt_map, qproc->halt_nc);
>> -
>> +	mba_load_err = true;
>>  reclaim_mba:
>>  	xfermemop_ret = q6v5_xfer_mem_ownership(qproc, &qproc->mba_perm, 
>> true,
>>  						false, qproc->mba_phys,
>> @@ -939,6 +958,8 @@ static int q6v5_mba_load(struct q6v5 *qproc)
>>  	if (xfermemop_ret) {
>>  		dev_err(qproc->dev,
>>  			"Failed to reclaim mba buffer, system may become unstable\n");
>> +	} else if (qproc->has_mba_logs & mba_load_err) {
>> +		q6v5_dump_mba_logs(qproc);
>>  	}
>> 
>>  disable_active_clks:
>> @@ -968,7 +989,7 @@ static int q6v5_mba_load(struct q6v5 *qproc)
>>  	return ret;
>>  }
>> 
>> -static void q6v5_mba_reclaim(struct q6v5 *qproc)
>> +static void q6v5_mba_reclaim(struct q6v5 *qproc, bool err_path)
>>  {
>>  	int ret;
>>  	u32 val;
>> @@ -1006,6 +1027,9 @@ static void q6v5_mba_reclaim(struct q6v5 *qproc)
>>  				      qproc->mba_size);
>>  	WARN_ON(ret);
>> 
>> +	if (qproc->has_mba_logs && err_path && !ret)
> 
> Wouldn't it be possible to just call q6v5_dump_mba_logs() directly 
> after
> the return from q6v5_mba_reclaim()? That way we can avoid passing the
> bool to indicate if the reclaim should also dump some stuff.
> 
> Sure we don't have a way to tell if the assign_mem failed, but we're
> going to crash shortly anyways (which is something we should change).

We wont crash as long as we dont touch
the mba region though. Trying a mba
logs dump in such a case will ensure
that we crash lol.

> 
> 
> 
> I think you should move the has_mba_logs into q6v5_dump_mba_logs(),
> making it cause an early return.

cool sure I'll do that.

> 
> Regards,
> Bjorn
> 
>> +		q6v5_dump_mba_logs(qproc);
>> +
>>  	ret = qcom_q6v5_unprepare(&qproc->q6v5);
>>  	if (ret) {
>>  		q6v5_pds_disable(qproc, qproc->proxy_pds,
>> @@ -1255,7 +1279,7 @@ static void qcom_q6v5_dump_segment(struct rproc 
>> *rproc,
>>  						false, true,
>>  						qproc->mpss_phys,
>>  						qproc->mpss_size);
>> -			q6v5_mba_reclaim(qproc);
>> +			q6v5_mba_reclaim(qproc, false);
>>  		}
>>  	}
>>  }
>> @@ -1297,7 +1321,7 @@ static int q6v5_start(struct rproc *rproc)
>>  	return 0;
>> 
>>  reclaim_mpss:
>> -	q6v5_mba_reclaim(qproc);
>> +	q6v5_mba_reclaim(qproc, true);
>> 
>>  	return ret;
>>  }
>> @@ -1313,7 +1337,7 @@ static int q6v5_stop(struct rproc *rproc)
>>  	if (ret == -ETIMEDOUT)
>>  		dev_err(qproc->dev, "timed out on wait\n");
>> 
>> -	q6v5_mba_reclaim(qproc);
>> +	q6v5_mba_reclaim(qproc, false);
>> 
>>  	return 0;
>>  }
>> @@ -1717,6 +1741,7 @@ static int q6v5_probe(struct platform_device 
>> *pdev)
>> 
>>  	qproc->version = desc->version;
>>  	qproc->need_mem_protection = desc->need_mem_protection;
>> +	qproc->has_mba_logs = desc->has_mba_logs;
>> 
>>  	ret = qcom_q6v5_init(&qproc->q6v5, pdev, rproc, 
>> MPSS_CRASH_REASON_SMEM,
>>  			     qcom_msa_handover);
>> @@ -1808,6 +1833,7 @@ static const struct rproc_hexagon_res sc7180_mss 
>> = {
>>  	},
>>  	.need_mem_protection = true,
>>  	.has_alt_reset = false,
>> +	.has_mba_logs = true,
>>  	.has_spare_reg = true,
>>  	.version = MSS_SC7180,
>>  };
>> @@ -1843,6 +1869,7 @@ static const struct rproc_hexagon_res sdm845_mss 
>> = {
>>  	},
>>  	.need_mem_protection = true,
>>  	.has_alt_reset = true,
>> +	.has_mba_logs = true,
>>  	.has_spare_reg = false,
>>  	.version = MSS_SDM845,
>>  };
>> @@ -1870,6 +1897,7 @@ static const struct rproc_hexagon_res 
>> msm8998_mss = {
>>  	},
>>  	.need_mem_protection = true,
>>  	.has_alt_reset = false,
>> +	.has_mba_logs = false,
>>  	.has_spare_reg = false,
>>  	.version = MSS_MSM8998,
>>  };
>> @@ -1900,6 +1928,7 @@ static const struct rproc_hexagon_res 
>> msm8996_mss = {
>>  	},
>>  	.need_mem_protection = true,
>>  	.has_alt_reset = false,
>> +	.has_mba_logs = false,
>>  	.has_spare_reg = false,
>>  	.version = MSS_MSM8996,
>>  };
>> @@ -1933,6 +1962,7 @@ static const struct rproc_hexagon_res 
>> msm8916_mss = {
>>  	},
>>  	.need_mem_protection = false,
>>  	.has_alt_reset = false,
>> +	.has_mba_logs = false,
>>  	.has_spare_reg = false,
>>  	.version = MSS_MSM8916,
>>  };
>> @@ -1974,6 +2004,7 @@ static const struct rproc_hexagon_res 
>> msm8974_mss = {
>>  	},
>>  	.need_mem_protection = false,
>>  	.has_alt_reset = false,
>> +	.has_mba_logs = false,
>>  	.has_spare_reg = false,
>>  	.version = MSS_MSM8974,
>>  };
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
>> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
