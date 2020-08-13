Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58A7C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 13:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C94BF2078D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 13:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgHMNj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 09:39:57 -0400
Received: from foss.arm.com ([217.140.110.172]:54718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgHMNj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 09:39:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81F211063;
        Thu, 13 Aug 2020 06:39:55 -0700 (PDT)
Received: from [10.37.8.11] (unknown [10.37.8.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA7B63F6CF;
        Thu, 13 Aug 2020 06:39:53 -0700 (PDT)
Subject: Re: [PATCH v2] coresight: etm4x: Add Support for HiSilicon ETM device
To:     liuqi115@huawei.com, gregkh@linuxfoundation.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
References: <1597323562-3706-1-git-send-email-liuqi115@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <aa4ac117-c378-5b2c-c685-6ed3d1c6ffb9@arm.com>
Date:   Thu, 13 Aug 2020 14:44:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1597323562-3706-1-git-send-email-liuqi115@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/13/2020 01:59 PM, Qi Liu wrote:
> Add ETMv4 periperhal ID for HiSilicon Hip08 and Hip09 platform. Hip08
> contains ETMv4.2 device and Hip09 contains ETMv4.5 device.
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm4x.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 6d7d216..7797a57 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -1587,6 +1587,8 @@ static const struct amba_id etm4_ids[] = {
>   	CS_AMBA_UCI_ID(0x000bb805, uci_id_etm4),/* Qualcomm Kryo 4XX Cortex-A55 */
>   	CS_AMBA_UCI_ID(0x000bb804, uci_id_etm4),/* Qualcomm Kryo 4XX Cortex-A76 */
>   	CS_AMBA_UCI_ID(0x000cc0af, uci_id_etm4),/* Marvell ThunderX2 */
> +	CS_AMBA_UCI_ID(0x000b6d01, uci_id_etm4),/* HiSilicon-Hip08 */
> +	CS_AMBA_UCI_ID(0x000b6d02, uci_id_etm4),/* HiSilicon-Hip09 */

Acked-by: Suzuki K Poulose <suzuki.oulose@arm.com>
