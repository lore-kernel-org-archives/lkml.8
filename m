Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7E9C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8792071B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Ebvn6/ID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgCLR1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:27:42 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:19010 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726371AbgCLR1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:27:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584034061; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=sEACIl73HriXGhDAU2H2q10BwiBheQrnYjwTuFhyhEA=; b=Ebvn6/IDqHmId8IDn+Da2mQ3NPDCz6ObACB31ujTxcimYorPL+9lgZRRYfsuzgvf0mjYD2Hr
 YT6QB20fhTuK2tDC6hT5kZi7wrQVE1tRjk91g8UGOgD+Si3rGbIj5be6xpO41yVPd529bvpj
 HlFwNXhX5tfspounQhWS7n3XY/Y=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6a7104.7fe347be70d8-smtp-out-n04;
 Thu, 12 Mar 2020 17:27:32 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6A02CC44792; Thu, 12 Mar 2020 17:27:30 +0000 (UTC)
Received: from [10.46.161.159] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: asutoshd)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3E66EC43637;
        Thu, 12 Mar 2020 17:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3E66EC43637
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=asutoshd@codeaurora.org
Subject: Re: [PATCH v2 1/8] scsi: ufs: fix uninitialized tx_lanes in
 ufshcd_disable_tx_lcc()
To:     Stanley Chu <stanley.chu@mediatek.com>, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, avri.altman@wdc.com,
        alim.akhtar@samsung.com, jejb@linux.ibm.com
Cc:     beanhuo@micron.com, cang@codeaurora.org, matthias.bgg@gmail.com,
        bvanassche@acm.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kuohong.wang@mediatek.com, peter.wang@mediatek.com,
        chun-hung.wu@mediatek.com, andy.teng@mediatek.com
References: <20200312110908.14895-1-stanley.chu@mediatek.com>
 <20200312110908.14895-2-stanley.chu@mediatek.com>
From:   "Asutosh Das (asd)" <asutoshd@codeaurora.org>
Message-ID: <cadc9e14-f990-6103-ee73-578d4a28ba1a@codeaurora.org>
Date:   Thu, 12 Mar 2020 10:27:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312110908.14895-2-stanley.chu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/12/2020 4:09 AM, Stanley Chu wrote:
> In ufshcd_disable_tx_lcc(), if ufshcd_dme_get() or ufshcd_dme_peer_get()
> get fail, uninitialized variable "tx_lanes" may be used as unexpected lane
> ID for DME configuration.
> 
> Fix this issue by initializing "tx_lanes".
> 
> Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
> ---
Reviewed-by: Asutosh Das <asutoshd@codeaurora.org>

>   drivers/scsi/ufs/ufshcd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 5698f1164a5e..314e808b0d4e 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -4315,7 +4315,7 @@ EXPORT_SYMBOL_GPL(ufshcd_hba_enable);
>   
>   static int ufshcd_disable_tx_lcc(struct ufs_hba *hba, bool peer)
>   {
> -	int tx_lanes, i, err = 0;
> +	int tx_lanes = 0, i, err = 0;
>   
>   	if (!peer)
>   		ufshcd_dme_get(hba, UIC_ARG_MIB(PA_CONNECTEDTXDATALANES),
> 


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
Linux Foundation Collaborative Project
