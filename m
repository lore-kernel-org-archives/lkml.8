Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1889C4332E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 09:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7523B2076A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 09:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgCWJuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 05:50:54 -0400
Received: from foss.arm.com ([217.140.110.172]:46794 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727738AbgCWJuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 05:50:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8ED131B;
        Mon, 23 Mar 2020 02:50:53 -0700 (PDT)
Received: from [10.37.12.136] (unknown [10.37.12.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 118DF3F68E;
        Mon, 23 Mar 2020 02:50:50 -0700 (PDT)
Subject: Re: [PATCH 1/2] coresight: etm4x: Add support for Qualcomm SC7180 SoC
To:     saiprakash.ranjan@codeaurora.org, mathieu.poirier@linaro.org,
        bjorn.andersson@linaro.org, leo.yan@linaro.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, agross@kernel.org,
        david.brown@linaro.org, mark.rutland@arm.com
Cc:     swboyd@chromium.org, rnayak@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <cover.1584689229.git.saiprakash.ranjan@codeaurora.org>
 <07a6b272c6e71e0e480f0dd0bffaf3138c0ab4c2.1584689229.git.saiprakash.ranjan@codeaurora.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <edf1bab3-411a-ff7a-b4ca-78a8ab00c72b@arm.com>
Date:   Mon, 23 Mar 2020 09:55:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <07a6b272c6e71e0e480f0dd0bffaf3138c0ab4c2.1584689229.git.saiprakash.ranjan@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/20/2020 07:44 AM, Sai Prakash Ranjan wrote:
> Add ETM Peripheral IDs for Qualcomm SC7180 SoC. It has
> 2 big CPU cores based on Cortex-A76 and 6 LITTLE CPU
> cores based on Cortex-A55.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>   drivers/hwtracing/coresight/coresight-etm4x.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index a90d757f7043..a153a65c4c5b 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -1556,6 +1556,8 @@ static const struct amba_id etm4_ids[] = {
>   	CS_AMBA_UCI_ID(0x000f0211, uci_id_etm4),/* Qualcomm Kryo */
>   	CS_AMBA_ID(0x000bb802),			/* Qualcomm Kryo 385 Cortex-A55 */
>   	CS_AMBA_ID(0x000bb803),			/* Qualcomm Kryo 385 Cortex-A75 */
> +	CS_AMBA_ID(0x000bb805),			/* Qualcomm Kryo 4XX Cortex-A55 */
> +	CS_AMBA_ID(0x000bb804),			/* Qualcomm Kryo 4XX Cortex-A76 */

Does the DEVARCH indicate that it is an ETMv4 ? (It should !) Please
could we enforce the UCI_ID check for these components ? The
moment you add CTI components to your board this could conflict with
them unless we check the UCI_ID for ETMv4.

Suzuki
