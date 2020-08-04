Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66BCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 10:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF67020656
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 10:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbgHDKmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 06:42:44 -0400
Received: from foss.arm.com ([217.140.110.172]:42388 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728170AbgHDKmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 06:42:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 721951FB;
        Tue,  4 Aug 2020 03:42:43 -0700 (PDT)
Received: from [10.37.12.82] (unknown [10.37.12.82])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C52E3F718;
        Tue,  4 Aug 2020 03:42:41 -0700 (PDT)
Subject: Re: [PATCH] coresight: etm4x: Add Support for HiSilicon ETM device
To:     liuqi115@huawei.com, gregkh@linuxfoundation.org,
        saiprakash.ranjan@codeaurora.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
References: <1596461740-13527-1-git-send-email-liuqi115@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <d7271f87-719a-cc3b-6306-bb07f24fe070@arm.com>
Date:   Tue, 4 Aug 2020 11:47:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1596461740-13527-1-git-send-email-liuqi115@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qi

On 08/03/2020 02:35 PM, Qi Liu wrote:
> Add ETMv4 periperhal ID for HiSilicon Hip08 and Hip09 platform. Hip08
> contains ETMv4.2 device and Hip09 contains ETMv4.5 device.

Does the ETMv4.5 on your system implement system instructions to access
the ETMs ? If so, please could you give the following series on your
board ?

http://lists.infradead.org/pipermail/linux-arm-kernel/2020-July/587745.html


> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> ---
>   drivers/hwtracing/coresight/coresight-etm4x.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 0c35cd5e..4a4f0bd 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -1561,6 +1561,8 @@ static struct amba_cs_uci_id uci_id_etm4[] = {
>   };
> 
>   static const struct amba_id etm4_ids[] = {
> +	CS_AMBA_ID(0x000b6d02),			/* HiSilicon-Hip09 */
> +	CS_AMBA_ID(0x000b6d01),			/* HiSilicon-Hip08 */

Please use CS_AMBA_UCI_ID() instead.

We should stop using the CS_AMBA_ID()


Suzuki
