Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2CBC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E3352076D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="TBtXXmWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgHaBUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 21:20:41 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:12767 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726573AbgHaBUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 21:20:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598836836; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=ttvdUTKiWDYnqwoVEcoNwY37B3FivNnyiDBj0vSZ7fc=;
 b=TBtXXmWtcy4eDOUqPUpIp+3Morr+0b8oePHLlm4J8zBibTXMEo3YcEBFU5rVA8dCXXt/xKd2
 1NytVLObqxVDfQ4iPUsMgX2n2GW6DKMcTob+9z7y8YHmHVDJdN7w3GqdqcsNNmrKCc0pJ/G+
 wAodTBlRHPAGVjY3kWfkkcVn6wg=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f4c504808e77d893c42f235 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 31 Aug 2020 01:20:08
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C2FCFC433A0; Mon, 31 Aug 2020 01:20:07 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E64EBC433CA;
        Mon, 31 Aug 2020 01:20:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 31 Aug 2020 09:20:05 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Bean Huo <huobean@gmail.com>
Cc:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, rnayak@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        saravanak@google.com, salyzyn@google.com,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Bart Van Assche <bvanassche@acm.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] scsi: ufs: Abort tasks before clear them from
 doorbell
In-Reply-To: <26bfbdf4e5c5802cce6b0ddf5eddbd75bd306d0f.camel@gmail.com>
References: <1598321228-21093-1-git-send-email-cang@codeaurora.org>
 <1598321228-21093-2-git-send-email-cang@codeaurora.org>
 <26bfbdf4e5c5802cce6b0ddf5eddbd75bd306d0f.camel@gmail.com>
Message-ID: <ca7a01a24c8189646b5e7bb6bc8899bb@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bean,

On 2020-08-31 02:11, Bean Huo wrote:
> Hi Can
> This patch conflicts and be not in line with this series patches : h
> ttps://patchwork.kernel.org/cover/11709279/, which has been applied
> into 5.9/scsi-fixes. But they are not apppiled in the 5.9/scsi-queue.
> 
> Maybe you should rebase your patch from scsi-fixes branch. or do you
> have another better option?
> 
> Thanks,
> Bean
> 

I am pushing this change due to LINERSET handling needs it and LINERESET
handling is added based on my previous changes to err_handler, which are
picked by 5.10/scsi-queue. So the two are applied for 5.10/scsi-queue 
only.
Any conflicts you see on 5.10/scsi-queue?

Thanks,

Can Guo.

> On Mon, 2020-08-24 at 19:07 -0700, Can Guo wrote:
>> To recovery non-fatal errors, no full reset is required, err_handler
>> only
>> clears those pending TRs/TMRs so that scsi layer can re-issue them.
>> In
>> current err_handler, TRs are directly cleared from UFS host's
>> doorbell but
>> not aborted from device side. However, according to the UFSHCI JEDEC
>> spec,
>> the host software shall use UTP Transfer Request List CLear Register
>> to
>> clear a task from UFS host's doorbell only when a UTP Transfer
>> Request is
>> expected to not be completed, e.g. when the host software receives a
>> “FUNCTION COMPLETE” Task Management response which means a Transfer
>> Request
>> was aborted. To follow the UFSHCI JEDEC spec, in err_handler, aborts
>> one TR
>> before clearing it from doorbell.
>> 
>> Signed-off-by: Can Guo <cang@codeaurora.org>
>> ---
>>  drivers/scsi/ufs/ufshcd.c | 143 ++++++++++++++++++++++++++--------
>> ------------
>>  1 file changed, 81 insertions(+), 62 deletions(-)
>> 
>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>> index b8441ad..000895f 100644
>> --- a/drivers/scsi/ufs/ufshcd.c
>> +++ b/drivers/scsi/ufs/ufshcd.c
>> @@ -235,6 +235,7 @@ static int ufshcd_setup_hba_vreg(struct ufs_hba
>> *hba, bool on);
>>  static int ufshcd_setup_vreg(struct ufs_hba *hba, bool on);
>>  static inline int ufshcd_config_vreg_hpm(struct ufs_hba *hba,
>>  					 struct ufs_vreg *vreg);
>> +static int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag);
>>  static int ufshcd_wb_buf_flush_enable(struct ufs_hba *hba);
>>  static int ufshcd_wb_buf_flush_disable(struct ufs_hba *hba);
>>  static int ufshcd_wb_ctrl(struct ufs_hba *hba, bool enable);
>> @@ -5657,8 +5658,8 @@ static void ufshcd_err_handler(struct
>> work_struct *work)
>>  {
>>  	struct ufs_hba *hba;
>>  	unsigned long flags;
>> -	u32 err_xfer = 0;
>> -	u32 err_tm = 0;
>> +	bool err_xfer = false;
>> +	bool err_tm = false;
>>  	int err = 0;
>>  	int tag;
>>  	bool needs_reset = false;
>> @@ -5734,7 +5735,7 @@ static void ufshcd_err_handler(struct
>> work_struct *work)
>>  	spin_unlock_irqrestore(hba->host->host_lock, flags);
>>  	/* Clear pending transfer requests */
>>  	for_each_set_bit(tag, &hba->outstanding_reqs, hba->nutrs) {
>> -		if (ufshcd_clear_cmd(hba, tag)) {
>> +		if (ufshcd_try_to_abort_task(hba, tag)) {
>>  			err_xfer = true;
>>  			goto lock_skip_pending_xfer_clear;
>>  		}
>> @@ -6486,7 +6487,7 @@ static void ufshcd_set_req_abort_skip(struct
>> ufs_hba *hba, unsigned long bitmap)
>>  }
>> 
>>  /**
>> - * ufshcd_abort - abort a specific command
>> + * ufshcd_try_to_abort_task - abort a specific task
>>   * @cmd: SCSI command pointer
>>   *
>>   * Abort the pending command in device by sending UFS_ABORT_TASK
>> task management
>> @@ -6495,6 +6496,80 @@ static void ufshcd_set_req_abort_skip(struct
>> ufs_hba *hba, unsigned long bitmap)
>>   * issued. To avoid that, first issue UFS_QUERY_TASK to check if the
>> command is
>>   * really issued and then try to abort it.
>>   *
>> + * Returns zero on success, non-zero on failure
>> + */
>> +static int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
>> +{
>> +	struct ufshcd_lrb *lrbp = &hba->lrb[tag];
>> +	int err = 0;
>> +	int poll_cnt;
>> +	u8 resp = 0xF;
>> +	u32 reg;
>> +
>> +	for (poll_cnt = 100; poll_cnt; poll_cnt--) {
>> +		err = ufshcd_issue_tm_cmd(hba, lrbp->lun, lrbp-
>> >task_tag,
>> +				UFS_QUERY_TASK, &resp);
>> +		if (!err && resp ==
>> UPIU_TASK_MANAGEMENT_FUNC_SUCCEEDED) {
>> +			/* cmd pending in the device */
>> +			dev_err(hba->dev, "%s: cmd pending in the
>> device. tag = %d\n",
>> +				__func__, tag);
>> +			break;
>> +		} else if (!err && resp ==
>> UPIU_TASK_MANAGEMENT_FUNC_COMPL) {
>> +			/*
>> +			 * cmd not pending in the device, check if it
>> is
>> +			 * in transition.
>> +			 */
>> +			dev_err(hba->dev, "%s: cmd at tag %d not
>> pending in the device.\n",
>> +				__func__, tag);
>> +			reg = ufshcd_readl(hba,
>> REG_UTP_TRANSFER_REQ_DOOR_BELL);
>> +			if (reg & (1 << tag)) {
>> +				/* sleep for max. 200us to stabilize */
>> +				usleep_range(100, 200);
>> +				continue;
>> +			}
>> +			/* command completed already */
>> +			dev_err(hba->dev, "%s: cmd at tag %d
>> successfully cleared from DB.\n",
>> +				__func__, tag);
>> +			goto out;
>> +		} else {
>> +			dev_err(hba->dev,
>> +				"%s: no response from device. tag = %d,
>> err %d\n",
>> +				__func__, tag, err);
>> +			if (!err)
>> +				err = resp; /* service response error
>> */
>> +			goto out;
>> +		}
>> +	}
>> +
>> +	if (!poll_cnt) {
>> +		err = -EBUSY;
>> +		goto out;
>> +	}
>> +
>> +	err = ufshcd_issue_tm_cmd(hba, lrbp->lun, lrbp->task_tag,
>> +			UFS_ABORT_TASK, &resp);
>> +	if (err || resp != UPIU_TASK_MANAGEMENT_FUNC_COMPL) {
>> +		if (!err) {
>> +			err = resp; /* service response error */
>> +			dev_err(hba->dev, "%s: issued. tag = %d, err
>> %d\n",
>> +				__func__, tag, err);
>> +		}
>> +		goto out;
>> +	}
>> +
>> +	err = ufshcd_clear_cmd(hba, tag);
>> +	if (err)
>> +		dev_err(hba->dev, "%s: Failed clearing cmd at tag %d,
>> err %d\n",
>> +			__func__, tag, err);
>> +
>> +out:
>> +	return err;
>> +}
>> +
>> +/**
>> + * ufshcd_abort - scsi host template eh_abort_handler callback
>> + * @cmd: SCSI command pointer
>> + *
>>   * Returns SUCCESS/FAILED
>>   */
>>  static int ufshcd_abort(struct scsi_cmnd *cmd)
>> @@ -6504,8 +6579,6 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
>>  	unsigned long flags;
>>  	unsigned int tag;
>>  	int err = 0;
>> -	int poll_cnt;
>> -	u8 resp = 0xF;
>>  	struct ufshcd_lrb *lrbp;
>>  	u32 reg;
>> 
>> @@ -6574,63 +6647,9 @@ static int ufshcd_abort(struct scsi_cmnd *cmd)
>>  		goto out;
>>  	}
>> 
>> -	for (poll_cnt = 100; poll_cnt; poll_cnt--) {
>> -		err = ufshcd_issue_tm_cmd(hba, lrbp->lun, lrbp-
>> >task_tag,
>> -				UFS_QUERY_TASK, &resp);
>> -		if (!err && resp ==
>> UPIU_TASK_MANAGEMENT_FUNC_SUCCEEDED) {
>> -			/* cmd pending in the device */
>> -			dev_err(hba->dev, "%s: cmd pending in the
>> device. tag = %d\n",
>> -				__func__, tag);
>> -			break;
>> -		} else if (!err && resp ==
>> UPIU_TASK_MANAGEMENT_FUNC_COMPL) {
>> -			/*
>> -			 * cmd not pending in the device, check if it
>> is
>> -			 * in transition.
>> -			 */
>> -			dev_err(hba->dev, "%s: cmd at tag %d not
>> pending in the device.\n",
>> -				__func__, tag);
>> -			reg = ufshcd_readl(hba,
>> REG_UTP_TRANSFER_REQ_DOOR_BELL);
>> -			if (reg & (1 << tag)) {
>> -				/* sleep for max. 200us to stabilize */
>> -				usleep_range(100, 200);
>> -				continue;
>> -			}
>> -			/* command completed already */
>> -			dev_err(hba->dev, "%s: cmd at tag %d
>> successfully cleared from DB.\n",
>> -				__func__, tag);
>> -			goto out;
>> -		} else {
>> -			dev_err(hba->dev,
>> -				"%s: no response from device. tag = %d,
>> err %d\n",
>> -				__func__, tag, err);
>> -			if (!err)
>> -				err = resp; /* service response error
>> */
>> -			goto out;
>> -		}
>> -	}
>> -
>> -	if (!poll_cnt) {
>> -		err = -EBUSY;
>> -		goto out;
>> -	}
>> -
>> -	err = ufshcd_issue_tm_cmd(hba, lrbp->lun, lrbp->task_tag,
>> -			UFS_ABORT_TASK, &resp);
>> -	if (err || resp != UPIU_TASK_MANAGEMENT_FUNC_COMPL) {
>> -		if (!err) {
>> -			err = resp; /* service response error */
>> -			dev_err(hba->dev, "%s: issued. tag = %d, err
>> %d\n",
>> -				__func__, tag, err);
>> -		}
>> -		goto out;
>> -	}
>> -
>> -	err = ufshcd_clear_cmd(hba, tag);
>> -	if (err) {
>> -		dev_err(hba->dev, "%s: Failed clearing cmd at tag %d,
>> err %d\n",
>> -			__func__, tag, err);
>> +	err = ufshcd_try_to_abort_task(hba, tag);
>> +	if (err)
>>  		goto out;
>> -	}
>> 
>>  	spin_lock_irqsave(host->host_lock, flags);
>>  	__ufshcd_transfer_req_compl(hba, (1UL << tag));
