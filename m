Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCA7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8DF32088E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Ibf9qUvz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgGCOeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 10:34:13 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:40015 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726631AbgGCOeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 10:34:13 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593786852; h=Message-ID: Subject: Cc: To: From: Date:
 Content-Transfer-Encoding: Content-Type: MIME-Version: Sender;
 bh=FRH1WL7dNGYlUrzjhSeDlO2/E0xxcXcZoxCJBRIgKXY=; b=Ibf9qUvzqg8c9DUFKanLs9OYXxLmYfPn7kZuLssU5CPCGraY1DJ0ThQUPZp+KsXrX+iGiUC0
 lwkjQ18/zJCgJYVWmrIJiIdZ2qLtLIv0nWAk6uokYRt8pmp0+0mw+99qevVApB1ZVDvVaXSy
 RErV/tM70QdI0o28mq4qMa9rlDw=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5eff41dd6f2ee827da3f6db3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 03 Jul 2020 14:34:05
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3C038C433CB; Fri,  3 Jul 2020 14:34:05 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B1ABBC433CA;
        Fri,  3 Jul 2020 14:34:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 03 Jul 2020 20:04:04 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Przywara <andre.przywara@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>
Subject: Re: [PATCH 3/3] arm64: Add KRYO4XX silver CPU cores to erratum list
 1530923 and 1024718
Message-ID: <7335e7fa1303a56a5e60339ed0c5d619@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2020-07-03 19:25, Will Deacon wrote:
> On Tue, Jun 30, 2020 at 11:30:55PM +0530, Sai Prakash Ranjan wrote:
>> KRYO4XX silver/LITTLE CPU cores with revision r1p0 are affected by
>> erratum 1530923 and 1024718, so add them to the respective list.
>> The variant and revision bits are implementation defined and are
>> different from the their Cortex CPU counterparts on which they are
>> based on, i.e., r1p0 is equivalent to rdpe.
> 
> So just to confirm, revisions prior to rdpe are unaffected, or do those
> parts simply not exist?
> 

There is one revision prior to this r0p1(r7pc) which has a different 
part
number and are used in v1 of SoCs which are limited to only internal 
test
platforms in the early stages of bringup and not used in actual devices 
out
there, so I did not add it to the list but they are affected. Plus we 
would
need to add another MIDR_QCOM_KRYO_4XX_SILVER_V1 if we are supporting 
them
which I thought was not worth it when devices with those CPUs are not 
available.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
