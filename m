Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA69DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBC992075A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="tVt8fAIT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731711AbgFWCoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:44:01 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:27462 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731647AbgFWCoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:44:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592880240; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=WfFCzgOO13CqCxPazC8JqcGDUy+ilIoTv/tjzdvEEtg=;
 b=tVt8fAITW3Mif0qIJIs3AKY1DD/BW8lZ+NVZOQQCID+WPjukqQfRfcewxV9+WjTxjVQf630K
 /LZG5wQ4dC4t/u1GvvIfEaJFR7GXIh2P6bx2apZPfnCFX7xnvtwOadq31ggabW+qYxtIPhXK
 G6ebd5z6311kQZuud/MKDB6Tbx0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5ef16c5a356bcc26aba8d024 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Jun 2020 02:43:38
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CDD37C433CA; Tue, 23 Jun 2020 02:43:37 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5009FC433C6;
        Tue, 23 Jun 2020 02:43:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 22 Jun 2020 19:43:37 -0700
From:   rishabhb@codeaurora.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, mathieu.poirier@linaro.org
Subject: Re: [v4 PATCH 0/3] Extend coredump functionality
In-Reply-To: <20200622222330.GN149351@builder.lan>
References: <1590611177-15826-1-git-send-email-rishabhb@codeaurora.org>
 <20200622222330.GN149351@builder.lan>
Message-ID: <d1eb275a572ac3e2979c6997daf5acf6@codeaurora.org>
X-Sender: rishabhb@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-22 15:23, Bjorn Andersson wrote:
> On Wed 27 May 13:26 PDT 2020, Rishabh Bhatnagar wrote:
> 
>> This patch series moves the coredump functionality to a separate
>> file and adds "inline" coredump feature. Inline coredump directly
>> copies segments from device memory during coredump to userspace.
>> This avoids extra memory usage at the cost of speed. Recovery is
>> stalled until all data is read by userspace.
>> 
>> Changelog:
>> 
> 
> Hi Rishabh,
> 
> This looks good to me, but it doesn't apply cleanly on linux-next. Can
> you please take a look?
> 
> Regards,
> Bjorn
> 
Yes some more gerrits have been merged in the meantime. I'll rebase on 
top
of Linux-next and send out another patchset.
>> v4 -> v3:
>> - Write a helper function to copy segment memory for every dump format
>> - Change segment dump fn to add offset and size adn covert mss driver
>> 
>> v3 -> v2:
>> - Move entire coredump functionality to remoteproc_coredump.c
>> - Modify rproc_coredump to perform dump according to conf. set by 
>> userspace
>> - Move the userspace configuration to debugfs from sysfs.
>> - Keep the default coredump implementation as is
>> 
>> v2 -> v1:
>> - Introduce new file for coredump.
>> - Add userspace sysfs configuration for dump type.
>> 
>> Rishabh Bhatnagar (3):
>>   remoteproc: Move coredump functionality to a new file
>>   remoteproc: Add inline coredump functionality
>>   remoteproc: Add coredump debugfs entry
>> 
>>  drivers/remoteproc/Makefile              |   1 +
>>  drivers/remoteproc/qcom_q6v5_mss.c       |   9 +-
>>  drivers/remoteproc/remoteproc_core.c     | 191 ------------------
>>  drivers/remoteproc/remoteproc_coredump.c | 328 
>> +++++++++++++++++++++++++++++++
>>  drivers/remoteproc/remoteproc_debugfs.c  |  86 ++++++++
>>  drivers/remoteproc/remoteproc_internal.h |   4 +
>>  include/linux/remoteproc.h               |  21 +-
>>  7 files changed, 443 insertions(+), 197 deletions(-)
>>  create mode 100644 drivers/remoteproc/remoteproc_coredump.c
>> 
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>> a Linux Foundation Collaborative Project
>> 
