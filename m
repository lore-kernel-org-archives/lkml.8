Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5775C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A9B24650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CVafjZJf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgBURmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 12:42:07 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45952 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgBURmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:42:06 -0500
Received: by mail-pg1-f194.google.com with SMTP id b9so1307115pgk.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 09:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Z0ajQmgxeuIEJg1R79ODn1BBQ+XGOzhA6+1MZaQFdLw=;
        b=CVafjZJfMia4GiT4T6spBIy59aFiEKScjaEtP6tGUJV1gDCFZIHOSr51ooSw/97kKO
         U0wG6HHfV8eOvk0pU0xXMJ/3G8nlCZo//f7fNeXsQTcM9tDuFLvLNXqg3QrVFCNefbyE
         Xr329kobXBeK751Lg7pSt0z+p4yq6/BfxPnmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Z0ajQmgxeuIEJg1R79ODn1BBQ+XGOzhA6+1MZaQFdLw=;
        b=UvjkOzcp9kkwQ1VAB7meW2RLy0LLE/1tMxfCS4Z4zdgX1X1LlsvubWZlMh8e8TiPNe
         bswja7Z+KRLx7wijb0v6v6x0Bd3zYYl2mgtdwA6dJbApQGbxbBIjSEUF6/ElVBNfYI8O
         5h3KWyumszdOAqyHVUTMnKJGIyOyTjrEohuETydY2kOppoWUyIklCkOiaHX9ZmuS3K85
         9sj88J/9dbtVXu9/BrN2Kp77tRC+UU4+ZkdEmefuQ3FHzpIRWboNQjpvpjEMPsLndX1Z
         MuywYUJdvV0Bd4X4rjH7CyCsekTYfjDSrUT57Jb2cyEXn4/j817A08ygnL5l1h8bpKt4
         +hfw==
X-Gm-Message-State: APjAAAVatjTbc4A7nVPFf+ZphW4FGm5qeeCp0gSNiVJs+UYHf+p1eYI3
        QvH8yE9Z0ZgVhX7VWZ22lKTAtRtWQvY4Iyi0bXmVbX/YxDlY9kywT17mJBxumjW2HanbDobxLfH
        7h3izcVGI26/HeFLAvR/OXMXV5336jPzn3tesnPxIjAOpbE7yBS9ErZWrZAhR/kAaWL9JmM2f5i
        5C5WM=
X-Google-Smtp-Source: APXvYqyHZu3+WU9AU2VLD7KGoNayml0yrujlDGRLPLRP/66aarTY8M79Q50NfYcg+rGmy4Qq53ke3Q==
X-Received: by 2002:a62:f842:: with SMTP id c2mr38901891pfm.104.1582306925501;
        Fri, 21 Feb 2020 09:42:05 -0800 (PST)
Received: from [10.69.45.46] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 13sm3400667pfj.68.2020.02.21.09.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 09:42:04 -0800 (PST)
Subject: Re: [PATCH][next] scsi: lpfc: fix spelling mistake "Notication" ->
 "Notification"
To:     Colin King <colin.king@canonical.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200221154841.77791-1-colin.king@canonical.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <db8a57f5-53e3-08ea-048f-8b5dca08b16e@broadcom.com>
Date:   Fri, 21 Feb 2020 09:42:03 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200221154841.77791-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/21/2020 7:48 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a lpfc_printf_vlog info messgae. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/scsi/lpfc/lpfc_els.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
> index a712f15bc88c..80d1e661b0d4 100644
> --- a/drivers/scsi/lpfc/lpfc_els.c
> +++ b/drivers/scsi/lpfc/lpfc_els.c
> @@ -3128,7 +3128,7 @@ lpfc_cmpl_els_disc_cmd(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
>   		for (i = 0; i < ELS_RDF_REG_TAG_CNT &&
>   			    i < be32_to_cpu(prdf->reg_d1.reg_desc.count); i++)
>   			lpfc_printf_vlog(vport, KERN_INFO, LOG_ELS,
> -				 "4677 Fabric RDF Notication Grant Data: "
> +				 "4677 Fabric RDF Notification Grant Data: "
>   				 "0x%08x\n",
>   				 be32_to_cpu(
>   					prdf->reg_d1.desc_tags[i]));

Reviewed-by: James Smart <james.smart@broadcom.com>

Thanks!

-- james

