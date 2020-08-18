Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0819C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B64AE2067C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="XqZ7IzUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgHRJaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 05:30:20 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:25388 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726145AbgHRJaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 05:30:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597743019; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=AHVbPJFk+TLJWIDMizKenawUcEUUBXKZ1Yv5y2vGNuY=;
 b=XqZ7IzUL8Nw0Vn37g1M7niGEggQ8/49MRS9XUuM4aNd2+lSXDNgKgHPF6kKi3tEam5iLr3GK
 f/UyrJfF/LFkEPEYaKm0b8nqQmZg8EtrdpDhDQzcCSXtqB5XZp5LC59v6rnm80k+6BsTQIvF
 R/jTb/DX21lFVGnbMkj0+eSJRrs=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f3b9f6ef2b697637a220853 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 18 Aug 2020 09:29:18
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EB685C433A1; Tue, 18 Aug 2020 09:29:16 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: hongwus)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 19D12C433CA;
        Tue, 18 Aug 2020 09:29:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 18 Aug 2020 17:29:16 +0800
From:   hongwus@codeaurora.org
To:     Asutosh Das <asutoshd@codeaurora.org>
Cc:     Can Guo <cang@codeaurora.org>, nguyenb@codeaurora.org,
        rnayak@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-scsi-owner@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: Remove an unpaired
 ufshcd_scsi_unblock_requests() in err_handler()
In-Reply-To: <20200818054237.GA880@asutoshd-linux1.qualcomm.com>
References: <1597728047-39936-1-git-send-email-cang@codeaurora.org>
 <20200818054237.GA880@asutoshd-linux1.qualcomm.com>
Message-ID: <72617138cbb0ccd5a50a9b7048251489@codeaurora.org>
X-Sender: hongwus@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-18 13:42, Asutosh Das wrote:
> On Mon, Aug 17 2020 at 22:21 -0700, Can Guo wrote:
>> Commit 5586dd8ea250a ("scsi: ufs: Fix a race condition between error
>> handler and runtime PM ops") moves the ufshcd_scsi_block_requests() 
>> inside
>> err_handler(), but forgets to remove the 
>> ufshcd_scsi_unblock_requests() in
>> the early return path. Correct the coding mistake.
>> 
>> Signed-off-by: Can Guo <cang@codeaurora.org>
>> 
> Reviewed-by: Asutosh Das <asutoshd@codeaurora.org>
> 
>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>> index 2b55c2e..b8441ad 100644
>> --- a/drivers/scsi/ufs/ufshcd.c
>> +++ b/drivers/scsi/ufs/ufshcd.c
>> @@ -5670,7 +5670,6 @@ static void ufshcd_err_handler(struct 
>> work_struct *work)
>> 		if (hba->ufshcd_state != UFSHCD_STATE_ERROR)
>> 			hba->ufshcd_state = UFSHCD_STATE_OPERATIONAL;
>> 		spin_unlock_irqrestore(hba->host->host_lock, flags);
>> -		ufshcd_scsi_unblock_requests(hba);
>> 		return;
>> 	}
>> 	ufshcd_set_eh_in_progress(hba);
>> -- Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, 
>> a Linux Foundation Collaborative Project.
>> 

Reviewed-by: Hongwu Su<hongwus@codeaurora.org>
