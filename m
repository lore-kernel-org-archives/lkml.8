Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307A4C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 12:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B6E20578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 12:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="TrYNao6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgBQMUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 07:20:08 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:14195 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728213AbgBQMUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 07:20:08 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581942007; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Ak3LgBqGOZMnRKzcv+4G1EyGXh9VotBzC+KbdmXq/x0=;
 b=TrYNao6Jq0yqqSk9zC/akypmSzDnCg9pMrOgoiog0fyTeUT2q8fLakFiOfluPD9+QD1Y9+9y
 jX61g6Z84J+3tq473RlNp78ctLI57/+9+9J8Tsta5X1TDfuNfpv80nLepH2XHoIPfTpAv7k3
 yOgH0AWuxw7jczCIZCOTcXovPpo=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4a84f7.7faacf1dcb20-smtp-out-n01;
 Mon, 17 Feb 2020 12:20:07 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 440FFC447A3; Mon, 17 Feb 2020 12:20:07 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 756CEC43383;
        Mon, 17 Feb 2020 12:20:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 17 Feb 2020 20:20:05 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Stanley Chu <stanley.chu@mediatek.com>
Cc:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        avri.altman@wdc.com, alim.akhtar@samsung.com, jejb@linux.ibm.com,
        beanhuo@micron.com, asutoshd@codeaurora.org,
        matthias.bgg@gmail.com, bvanassche@acm.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kuohong.wang@mediatek.com, peter.wang@mediatek.com,
        chun-hung.wu@mediatek.com, andy.teng@mediatek.com
Subject: Re: [PATCH v3 1/2] scsi: ufs: pass device information to
 apply_dev_quirks
In-Reply-To: <1578726707-6596-2-git-send-email-stanley.chu@mediatek.com>
References: <1578726707-6596-1-git-send-email-stanley.chu@mediatek.com>
 <1578726707-6596-2-git-send-email-stanley.chu@mediatek.com>
Message-ID: <2a8fc44914b7ed8777a4a99ba6b8647a@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-11 15:11, Stanley Chu wrote:
> Pass UFS device information to vendor-specific variant callback
> "apply_dev_quirks" because some platform vendors need to know such
> information to apply special handlings or quirks in specific devices.
> 
> In the same time, modify existed vendor implementations according to
> the new interface for those vendor drivers which will be built-in
> or built as a module alone with UFS core driver.
> 
> Cc: Alim Akhtar <alim.akhtar@samsung.com>
> Cc: Asutosh Das <asutoshd@codeaurora.org>
> Cc: Avri Altman <avri.altman@wdc.com>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Bean Huo <beanhuo@micron.com>
> Cc: Can Guo <cang@codeaurora.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>
> Reviewed-by: Bean Huo <beanhuo@micron.com>
> Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
> ---
>  drivers/scsi/ufs/ufs-qcom.c | 3 ++-
>  drivers/scsi/ufs/ufshcd.c   | 8 ++++----
>  drivers/scsi/ufs/ufshcd.h   | 7 ++++---
>  3 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
> index c69c29a1ceb9..ebb5c66e069f 100644
> --- a/drivers/scsi/ufs/ufs-qcom.c
> +++ b/drivers/scsi/ufs/ufs-qcom.c
> @@ -949,7 +949,8 @@ static int
> ufs_qcom_quirk_host_pa_saveconfigtime(struct ufs_hba *hba)
>  	return err;
>  }
> 
> -static int ufs_qcom_apply_dev_quirks(struct ufs_hba *hba)
> +static int ufs_qcom_apply_dev_quirks(struct ufs_hba *hba,
> +				     struct ufs_dev_desc *card)
>  {
>  	int err = 0;
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 1b97f2dc0b63..7c85c890594c 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -6803,7 +6803,8 @@ static int
> ufshcd_quirk_tune_host_pa_tactivate(struct ufs_hba *hba)
>  	return ret;
>  }
> 
> -static void ufshcd_tune_unipro_params(struct ufs_hba *hba)
> +static void ufshcd_tune_unipro_params(struct ufs_hba *hba,
> +				      struct ufs_dev_desc *card)
>  {
>  	if (ufshcd_is_unipro_pa_params_tuning_req(hba)) {
>  		ufshcd_tune_pa_tactivate(hba);
> @@ -6817,7 +6818,7 @@ static void ufshcd_tune_unipro_params(struct 
> ufs_hba *hba)
>  	if (hba->dev_quirks & UFS_DEVICE_QUIRK_HOST_PA_TACTIVATE)
>  		ufshcd_quirk_tune_host_pa_tactivate(hba);
> 
> -	ufshcd_vops_apply_dev_quirks(hba);
> +	ufshcd_vops_apply_dev_quirks(hba, card);

Hi Stanley,

Is this series merged? If no, would you mind moving
ufshcd_vops_apply_dev_quirks(hba, card); a little bit? Like below.

@@ -6852,14 +6852,14 @@ static void ufshcd_tune_unipro_params(struct 
ufs_hba *hba)
                 ufshcd_tune_pa_hibern8time(hba);
         }

+       ufshcd_vops_apply_dev_quirks(hba, card);
+
         if (hba->dev_quirks & UFS_DEVICE_QUIRK_PA_TACTIVATE)
                 /* set 1ms timeout for PA_TACTIVATE */
                 ufshcd_dme_set(hba, UIC_ARG_MIB(PA_TACTIVATE), 10);

In this way, vendor codes have a chance to modify the dev_quirks
before ufshcd_tune_unipro_params() does the rest of its job.

Thanks,
Can Guo.

>  }
> 
>  static void ufshcd_clear_dbg_ufs_stats(struct ufs_hba *hba)
> @@ -6980,10 +6981,9 @@ static int ufshcd_probe_hba(struct ufs_hba *hba)
>  	}
> 
>  	ufs_fixup_device_setup(hba, &card);
> +	ufshcd_tune_unipro_params(hba, &card);
>  	ufs_put_device_desc(&card);
> 
> -	ufshcd_tune_unipro_params(hba);
> -
>  	/* UFS device is also active now */
>  	ufshcd_set_ufs_dev_active(hba);
>  	ufshcd_force_reset_auto_bkops(hba);
> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> index e05cafddc87b..4f3fa71303da 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -320,7 +320,7 @@ struct ufs_hba_variant_ops {
>  	void	(*setup_task_mgmt)(struct ufs_hba *, int, u8);
>  	void    (*hibern8_notify)(struct ufs_hba *, enum uic_cmd_dme,
>  					enum ufs_notify_change_status);
> -	int	(*apply_dev_quirks)(struct ufs_hba *);
> +	int	(*apply_dev_quirks)(struct ufs_hba *, struct ufs_dev_desc *);
>  	int     (*suspend)(struct ufs_hba *, enum ufs_pm_op);
>  	int     (*resume)(struct ufs_hba *, enum ufs_pm_op);
>  	void	(*dbg_register_dump)(struct ufs_hba *hba);
> @@ -1052,10 +1052,11 @@ static inline void
> ufshcd_vops_hibern8_notify(struct ufs_hba *hba,
>  		return hba->vops->hibern8_notify(hba, cmd, status);
>  }
> 
> -static inline int ufshcd_vops_apply_dev_quirks(struct ufs_hba *hba)
> +static inline int ufshcd_vops_apply_dev_quirks(struct ufs_hba *hba,
> +					       struct ufs_dev_desc *card)
>  {
>  	if (hba->vops && hba->vops->apply_dev_quirks)
> -		return hba->vops->apply_dev_quirks(hba);
> +		return hba->vops->apply_dev_quirks(hba, card);
>  	return 0;
>  }
