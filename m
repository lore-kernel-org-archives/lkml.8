Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295C7C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 04:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8BB321883
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 04:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="feIbzblS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgGNEMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 00:12:33 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:32884 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725497AbgGNEMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 00:12:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594699952; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=XBcjJwlLi5e8UJxwpFLfDWxhorCwwJpmtJ41g/1puLk=;
 b=feIbzblSDq8/CX392uiqXd2eQpyWwt8u7Thd81mKBf2Fxf9OL9DdYao0sUjeqvHCbI3Qmlah
 e9oGptnrjgk3SHbvXMYea/25g0m/FKfNH76aZgAIZXrf42gRVClHMEoVnIn4FXnsxgPtsil4
 jUUO3r26r9Z7RO1Z2opzSWuRcro=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5f0d308b1012768490038564 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 14 Jul 2020 04:11:55
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B7FCEC433CB; Tue, 14 Jul 2020 04:11:54 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F30ECC433CA;
        Tue, 14 Jul 2020 04:11:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 14 Jul 2020 12:11:53 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Bart Van Assche <bvanassche@acm.org>
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
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] scsi: ufs: Add checks before setting clk-gating
 states
In-Reply-To: <31ef233b-2562-2f61-d899-587092b5c033@acm.org>
References: <1594693693-22466-1-git-send-email-cang@codeaurora.org>
 <1594693693-22466-2-git-send-email-cang@codeaurora.org>
 <31ef233b-2562-2f61-d899-587092b5c033@acm.org>
Message-ID: <f598fd46a548d86b7dd363351920341e@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

On 2020-07-14 11:38, Bart Van Assche wrote:
> On 2020-07-13 19:28, Can Guo wrote:
>> @@ -2538,7 +2540,8 @@ static int ufshcd_queuecommand(struct Scsi_Host 
>> *host, struct scsi_cmnd *cmd)
>>  		err = SCSI_MLQUEUE_HOST_BUSY;
>>  		goto out;
>>  	}
>> -	WARN_ON(hba->clk_gating.state != CLKS_ON);
>> +	if (ufshcd_is_clkgating_allowed(hba))
>> +		WARN_ON(hba->clk_gating.state != CLKS_ON);
> 
> A minor comment: has it been considered to change this into the
> following?
> 
> 	WARN_ON(ufshcd_is_clkgating_allowed(hba) &&
> 		hba->clk_gating.state != CLKS_ON);
> 
> Thanks,
> 
> Bart.

Sure, will do that.

Thanks,

Can Guo.
