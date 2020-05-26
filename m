Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A260C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B2F42084C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="d2apTG1a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389614AbgEZR0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 13:26:02 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:28035 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388803AbgEZR0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 13:26:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590513960; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=Im6hIGPpJqtxzbNyAwrxrzA8oUaUroHuS60646TlJzw=; b=d2apTG1am+hSxfRzHh5UFIdIWVDS9omKduDIiW5j72X4WOrHWbKiH39HbqFnr3jJLXGYBsTM
 6NtLxTkpT182o3rDBnTFMmdhqWZ7vHrhEukg7N3DBh8DnOpTSt6EoHCrp13NzwR31O1ZZHp0
 wmnDmbFa/uKBhzEzw451Oarrggk=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5ecd51185086732481df4755 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 26 May 2020 17:25:44
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5B8AEC433AD; Tue, 26 May 2020 17:25:44 +0000 (UTC)
Received: from [192.168.8.176] (cpe-70-95-149-85.san.res.rr.com [70.95.149.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: asutoshd)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 85926C433CA;
        Tue, 26 May 2020 17:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 85926C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=asutoshd@codeaurora.org
Subject: Re: [PATCH v4 0/4] scsi: ufs: Fix WriteBooster and cleanup UFS driver
To:     Stanley Chu <stanley.chu@mediatek.com>, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, avri.altman@wdc.com,
        alim.akhtar@samsung.com, jejb@linux.ibm.com
Cc:     beanhuo@micron.com, cang@codeaurora.org, matthias.bgg@gmail.com,
        bvanassche@acm.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Virtual_Global_UFS_Upstream@mediatek.com
References: <20200522083212.4008-1-stanley.chu@mediatek.com>
From:   "Asutosh Das (asd)" <asutoshd@codeaurora.org>
Message-ID: <a18ed057-e35b-b1b9-9ce2-718d7c3961fd@codeaurora.org>
Date:   Tue, 26 May 2020 10:25:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200522083212.4008-1-stanley.chu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/2020 1:32 AM, Stanley Chu wrote:
> Hi,
> 
> This patch set fixes some WriteBooster issues and do small cleanup in UFS driver
> 
> v3 -> v4
>    - Squash patch [4] and [5] (Asutosh)
>    - Fix commit message in patch [4]
> 
> v2 -> v3
>    - Introduce patch [5] to fix possible VCC power drain during runtime suspend (Asutosh)
> 
> v1 -> v2
>    - Remove dummy new line in patch [4] (Asutosh)
>    - Add more limitation to allow WriteBooster flush during Hibern8 in runtime-suspend. Now the device power mode is kept as Active power mode only if link is put in Hibern8 or Auto-Hibern8 is enabled during runtime-suspend (Asutosh)
> 
> Stanley Chu (4):
>    scsi: ufs: Remove unnecessary memset for dev_info
>    scsi: ufs: Allow WriteBooster on UFS 2.2 devices
>    scsi: ufs: Fix index of attributes query for WriteBooster feature
>    scsi: ufs: Fix WriteBooster flush during runtime suspend
> 
>   drivers/scsi/ufs/ufs-sysfs.c | 13 ++++-
>   drivers/scsi/ufs/ufs.h       |  2 +-
>   drivers/scsi/ufs/ufshcd.c    | 99 +++++++++++++++++++++++++-----------
>   drivers/scsi/ufs/ufshcd.h    |  3 +-
>   4 files changed, 82 insertions(+), 35 deletions(-)
> 

This set looks good to me.

Reviewed-by: Asutosh Das <asutoshd@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
Linux Foundation Collaborative Project
