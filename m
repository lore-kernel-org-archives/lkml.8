Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64101C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CA0B20738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UeXA81lY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390913AbgFWVUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390283AbgFWUXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:23:20 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F491C061795
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 13:23:20 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id j4so9612243plk.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 13:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=8GtuMGPUaS390TqO5z4ppfXD7rQJ/F037h9evN14ygA=;
        b=UeXA81lY2Dk/K6Xv/2qrjX76DJuWeAmT6jNVUMl2qas0bB4/Xq2A+K5qs7yXGrQ+XO
         mwxD2EAVmkxFTRya/JYVHKi1xwtP25wHgkoYM4HMrUhXW7GS9mEQqjFAZyBl/iHLinb5
         NBhuRbQiglGun9uYgKwuidd8G5uUNfRAKlWE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8GtuMGPUaS390TqO5z4ppfXD7rQJ/F037h9evN14ygA=;
        b=bHEMY1BZTNNIN2Zk4d8c2uyYm825swqBm0JldgML9W9FJ5fEcMECnsAUC/Oy0BFIEq
         uHvBFHHiKorOg2LhB8F6sYd0wgqne8XpLIeeeYDz/a5AZGiiL68qT+z0cHmqY7zRTZm4
         WZKJLp/MkJelTGzxEjrjyyoVnVeGLqdP78vq+g8s42+fVG0EuiLYi+k0qgNYTc/gdRfN
         2RBkkkkfwFQVePI7oLFoQTJdhWvEhxwFG4GVfWU9Vf3gLCBAb0FWi5GRKN9lNOqkr4Cn
         QZYBfz60JENv3qgDqtRWH+R72GcX9xImxhCKvDHRNsBOXF8tx5MmRzI22xE4c6Vc/eub
         BIxw==
X-Gm-Message-State: AOAM532i9UjQ2qqJG082CnOyiAZ6UWGnZthgGr+swWP4C2TsN5TI8FOm
        pfhQJRjdfUAhEyaxpYjxK1I3JctsDHs=
X-Google-Smtp-Source: ABdhPJwaESgPCB1gfNvhANi+Yq++rrbVU7XmZhQA2VoJG+/oGv5jRcVJWUsh89tmByaVWl75PYdDHQ==
X-Received: by 2002:a17:902:b60e:: with SMTP id b14mr25563736pls.81.1592943799964;
        Tue, 23 Jun 2020 13:23:19 -0700 (PDT)
Received: from [10.69.45.46] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id ev20sm3141936pjb.8.2020.06.23.13.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 13:23:19 -0700 (PDT)
Subject: Re: [PATCH] scsi: lpfc: Avoid another null dereference in
 lpfc_sli4_hba_unset()
To:     SeongJae Park <sjpark@amazon.com>, jsmart2021@gmail.com,
        dick.kennedy@broadcom.com
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
References: <20200623084122.30633-1-sjpark@amazon.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <470678bf-2e08-c75f-db14-7569cc4fe4c7@broadcom.com>
Date:   Tue, 23 Jun 2020 13:23:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623084122.30633-1-sjpark@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/23/2020 1:41 AM, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
>
> Commit cdb42becdd40 ("scsi: lpfc: Replace io_channels for nvme and fcp
> with general hdw_queues per cpu") has introduced static checker warnings
> for potential null dereferences in 'lpfc_sli4_hba_unset()' and
> commit 1ffdd2c0440d ("scsi: lpfc: resolve static checker warning in
> lpfc_sli4_hba_unset") has tried to fix it.  However, yet another
> potential null dereference is remaining.  This commit fixes it.
>
> This bug was discovered and resolved using Coverity Static Analysis
> Security Testing (SAST) by Synopsys, Inc.
>
> Fixes: 1ffdd2c0440d ("scsi: lpfc: resolve static checker warning inlpfc_sli4_hba_unset")
> Fixes: cdb42becdd40 ("scsi: lpfc: Replace io_channels for nvme and fcp with general hdw_queues per cpu")
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>   drivers/scsi/lpfc/lpfc_init.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
> index 69a5249e007a..6637f84a3d1b 100644
> --- a/drivers/scsi/lpfc/lpfc_init.c
> +++ b/drivers/scsi/lpfc/lpfc_init.c
> @@ -11878,7 +11878,8 @@ lpfc_sli4_hba_unset(struct lpfc_hba *phba)
>   	lpfc_sli4_xri_exchange_busy_wait(phba);
>   
>   	/* per-phba callback de-registration for hotplug event */
> -	lpfc_cpuhp_remove(phba);
> +	if (phba->pport)
> +		lpfc_cpuhp_remove(phba);
>   
>   	/* Disable PCI subsystem interrupt */
>   	lpfc_sli4_disable_intr(phba);

Reviewed-by: James Smart <james.smart@broadcom.com>

-- james

