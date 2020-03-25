Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953BBC54FCF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3CF2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="vqLgD6gm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgCYQcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 12:32:31 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:10589 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727994AbgCYQca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 12:32:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585153949; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=5UvPwup7f3AuNdIm3PXIwT0XlBlphSX6/sF/XlEruEI=; b=vqLgD6gmPgXy4MvrPU89fuMTBZaY7MuOYZ7oom18PIPsWMvMM+Z9Ul7pQdoFOM3WWM2Tuf5k
 1gYf0Npj/GWQjSBD+1EkCN02m0/Qg0s1oE0SAEAp3DCYRsbT80jH6W6nUPcGErd0imtiRkTG
 37CulomPbR5zgEnO9+0k7zPsLgk=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7b879a.7f87b3858228-smtp-out-n03;
 Wed, 25 Mar 2020 16:32:26 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 786CBC43637; Wed, 25 Mar 2020 16:32:26 +0000 (UTC)
Received: from [192.168.8.111] (cpe-70-95-153-89.san.res.rr.com [70.95.153.89])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: asutoshd)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B6F2CC433BA;
        Wed, 25 Mar 2020 16:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B6F2CC433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=asutoshd@codeaurora.org
Subject: Re: [PATCH v1 1/3] scsi: ufshcd: Update the set frequency to devfreq
To:     Avri Altman <Avri.Altman@wdc.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Cc:     "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <ebd9ea7d0ebb1884b15e4fe7e3e03460c1e3c52b.1585094538.git.asutoshd@codeaurora.org>
 <SN6PR04MB4640BC23D0827886927D302AFCCE0@SN6PR04MB4640.namprd04.prod.outlook.com>
From:   "Asutosh Das (asd)" <asutoshd@codeaurora.org>
Message-ID: <3ea137ea-aade-31d8-a374-70c6f0d2dacc@codeaurora.org>
Date:   Wed, 25 Mar 2020 09:32:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <SN6PR04MB4640BC23D0827886927D302AFCCE0@SN6PR04MB4640.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/2020 6:11 AM, Avri Altman wrote:
>>
>> Currently, the frequency that devfreq provides the
>> driver to set always leads the clocks to be scaled up.
>> Hence, round the clock-rate to the nearest frequency
>> before deciding to scale.
>>
>> Also update the devfreq statistics of current frequency.
>>
>> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
>> ---
>>   drivers/scsi/ufs/ufshcd.c | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>> index 2a2a63b..4607bc6 100644
>> --- a/drivers/scsi/ufs/ufshcd.c
>> +++ b/drivers/scsi/ufs/ufshcd.c
>> @@ -1187,6 +1187,9 @@ static int ufshcd_devfreq_target(struct device
>> *dev,
>>          if (!ufshcd_is_clkscaling_supported(hba))
>>                  return -EINVAL;
>>
>> +       clki = list_first_entry(&hba->clk_list_head, struct ufs_clk_info, list);
>> +       /* Override with the closest supported frequency */
>> +       *freq = (unsigned long) clk_round_rate(clki->clk, *freq);
>>          spin_lock_irqsave(hba->host->host_lock, irq_flags);
> Please remind me what the spin lock is protecting here?

Hmmm ... Nothing comes to my mind. I blamed it but it's a part of a 
bigger change.

> 
>>          if (ufshcd_eh_in_progress(hba)) {
>>                  spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
>> @@ -1201,8 +1204,13 @@ static int ufshcd_devfreq_target(struct device
>> *dev,
>>                  goto out;
>>          }
>>
>> -       clki = list_first_entry(&hba->clk_list_head, struct ufs_clk_info, list);
>> +       /* Decide based on the rounded-off frequency and update */
>>          scale_up = (*freq == clki->max_freq) ? true : false;
>> +       if (scale_up)
>> +               *freq = clki->max_freq;
> This was already established 2 lines above ?
Good point - I'll change it.

> 
>> +       else
>> +               *freq = clki->min_freq;
>> +       /* Update the frequency */
>>          if (!ufshcd_is_devfreq_scaling_required(hba, scale_up)) {
>>                  spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
>>                  ret = 0;
>> @@ -1250,6 +1258,8 @@ static int ufshcd_devfreq_get_dev_status(struct
>> device *dev,
>>          struct ufs_hba *hba = dev_get_drvdata(dev);
>>          struct ufs_clk_scaling *scaling = &hba->clk_scaling;
>>          unsigned long flags;
>> +       struct list_head *clk_list = &hba->clk_list_head;
>> +       struct ufs_clk_info *clki;
>>
>>          if (!ufshcd_is_clkscaling_supported(hba))
>>                  return -EINVAL;
>> @@ -1260,6 +1270,8 @@ static int ufshcd_devfreq_get_dev_status(struct
>> device *dev,
>>          if (!scaling->window_start_t)
>>                  goto start_window;
>>
>> +       clki = list_first_entry(clk_list, struct ufs_clk_info, list);
>> +       stat->current_frequency = clki->curr_freq;
> Is this a bug fix? > devfreq_simple_ondemand_func is trying to establish the busy period,
> but also uses the frequency in its calculation - which I wasn't able to understand how.
> Can you add a short comment why updating current_frequency is needed?
>
Sure - I'll add a comment. If stat->current_frequency is not updated, 
the governor would always ask to set the max freq because the initial 
frequency was unknown to it. Reference - devfreq_simple_ondemand_func(...)

> 
> Thanks,
> Avri
> 

Thanks,
-asd

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
Linux Foundation Collaborative Project
