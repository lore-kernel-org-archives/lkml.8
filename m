Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF94C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29C9120776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="mMg1BiLh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731409AbgEZHBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 03:01:53 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:27247 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731396AbgEZHBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 03:01:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590476512; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=bxN1ySkS5OLFnpjDUyutSFYIlYJ92O/h8wsCXEUhy+Y=;
 b=mMg1BiLh67xOgOnkwdUaNzseh1ImGrtX8KKkUcSAD37z2Znoy6PE0E5nuNytRymsgR7tUvsV
 Ubo+kMijoL0J3EW/wQk0xDmDL3ft3cwaFTduhtcj302ocQWOvz+YjDdNrAfOcdgM7g1ac8l8
 V16wQ2ltOwjqsVrdT+KRG0blg4E=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5eccbedc2c54998475ff99d7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 26 May 2020 07:01:48
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 61A5AC43395; Tue, 26 May 2020 07:01:47 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E5A78C433C6;
        Tue, 26 May 2020 07:01:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 26 May 2020 12:31:46 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        devicetree-owner@vger.kernel.org
Subject: Re: [PATCHv3 0/2] Add support for replicators which loses context on
 clock removal
In-Reply-To: <20200525161553.GA31527@xps15>
References: <cover.1590171891.git.saiprakash.ranjan@codeaurora.org>
 <20200525161553.GA31527@xps15>
Message-ID: <8b3592edb443a091891d00e0fa32debc@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 2020-05-25 21:45, Mathieu Poirier wrote:
> Hi Sai,
> 
> On Sat, May 23, 2020 at 12:06:50AM +0530, Sai Prakash Ranjan wrote:
>> This series is mainly to add support for replicators
>> which lose context on removing AMBA clock like on SC7180
>> SoC where replicator in AOSS domain loses context.
>> 
> 
> I am good with this set but need a reviewed-by on the DT binding before 
> I can
> add it to my tree.  The same goes for your other set[1].
> 

Sure, let's wait for an ack from Rob and thanks for the reviews.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
