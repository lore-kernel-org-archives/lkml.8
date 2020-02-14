Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B246C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29289222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbgBNSdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:33:01 -0500
Received: from foss.arm.com ([217.140.110.172]:43572 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729448AbgBNSc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:32:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D83D101E;
        Fri, 14 Feb 2020 10:32:59 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D9BB3F68E;
        Fri, 14 Feb 2020 10:32:58 -0800 (PST)
From:   James Morse <james.morse@arm.com>
Subject: Re: [V2 2/3] firmware: arm_sdei: Removed multiple white lines.
To:     luanshi <zhangliguang@linux.alibaba.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1579145331-78633-1-git-send-email-zhangliguang@linux.alibaba.com>
 <1579145331-78633-2-git-send-email-zhangliguang@linux.alibaba.com>
Message-ID: <bebb759e-ff1f-e11e-be6f-589c96a338c0@arm.com>
Date:   Fri, 14 Feb 2020 18:32:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1579145331-78633-2-git-send-email-zhangliguang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luanshi,

On 16/01/2020 03:28, luanshi wrote:
> Remove one unnecessary white line.
> 
> Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
> ---
>  drivers/firmware/arm_sdei.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
> index 37e9bf0..f81c09e 100644
> --- a/drivers/firmware/arm_sdei.c
> +++ b/drivers/firmware/arm_sdei.c
> @@ -599,7 +599,6 @@ static int _sdei_event_register(struct sdei_event *event)
>  					       event->registered,
>  					       SDEI_EVENT_REGISTER_RM_ANY, 0);
>  
> -
>  	err = sdei_do_cross_call(_local_event_register, event);
>  	if (err) {
>  		spin_lock(&event->sdei_event_lock);

I'm afraid these whitespace-only patches aren't worth sending. If its not caught at
review, it gets to annoy the reader until someone can do a drive-by fix when they are
changing adjacent code.

I've merged this with the first patch in the eventual series.


Thanks,

James
