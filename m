Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26431C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 16:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02BE020787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 16:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZtVJ6k8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgGVQNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 12:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgGVQNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 12:13:20 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBE6C0619E0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 09:13:20 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id p1so1229602pls.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 09:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=sCo/inNgkLQRT12JTmJMZ3t5FYhm9G5o0OvWRhxmUYY=;
        b=ZtVJ6k8n6QgA5V0GDnL+qCelw405mI5mbymnEASb/d/sbO7p8pvMJ0pGUXqxK1diGO
         I4pxKbknYjMDPKA4YU0OmtZhMXmOrBv4tWbqZ5bKQnwtOR+WO6mtDNO7cUqIPyIL1PDJ
         5y3ltK4uqTP2+UEN/TzXmAlIda0lZ9AYfpjqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=sCo/inNgkLQRT12JTmJMZ3t5FYhm9G5o0OvWRhxmUYY=;
        b=rRDRikLxJ3IEhAccZNWCy60iEMQ+esXrDuSn/FmkWjjDQEI7CQSVlfPDBJDaG+JDP1
         txzwRO2XZ2Sw6ReDlnZRbVFcm+q7TZdqXI8Gdm7sOLq/JtkYU2uQr1gVTCkDaJXkLB0t
         fTEjwA7uMis7bPAoqyebyUs15Pe5bZpSSHO6zsro6Ru/pmy2kcXE+KFudOmIMp9YMySb
         3XeI746+7uj5gP/LcocMwC2KqEaDBhC++kkbz6bsWxKoDhXmP64KlnnKLyHy6bfS9SCK
         YXPXOsQNrjHDF0W3OFykYP/jpmznniAs9ZBylKynAA/tNI4Y3nQotWIG/O7ijt80pqEB
         /RlQ==
X-Gm-Message-State: AOAM530DAhjnr8+T6YEXU5z6OKg0FOWqU66P4w1IdktnO1wFzoK7p0ju
        1K1HDZJclr9v2j4JlK/FtacYlaXe1YbJAA==
X-Google-Smtp-Source: ABdhPJy0W1IuXt9MEXOac/YWBS3DNz4wrXiLLLVZ57+dq9dOC6LdmQY/m1fU9sjLUkbAoCAmpH/org==
X-Received: by 2002:a17:90a:1b2c:: with SMTP id q41mr115652pjq.195.1595434399571;
        Wed, 22 Jul 2020 09:13:19 -0700 (PDT)
Received: from [10.230.185.151] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id r9sm163543pje.12.2020.07.22.09.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 09:13:18 -0700 (PDT)
Subject: Re: [PATCH -next] scsi: lpfc: Add dependency on CPU_FREQ
To:     Guenter Roeck <linux@roeck-us.net>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <jsmart2021@gmail.com>
References: <20200722023027.36866-1-linux@roeck-us.net>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <0829df21-26fd-b023-4728-42025fb2dc20@broadcom.com>
Date:   Wed, 22 Jul 2020 09:13:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722023027.36866-1-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/2020 7:30 PM, Guenter Roeck wrote:
> Since commit 317aeb83c92b ("scsi: lpfc: Add blk_io_poll support for
> latency improvment"), the lpfc driver depends on CPUFREQ. Without it,
> builds fail with
>
> drivers/scsi/lpfc/lpfc_sli.c: In function 'lpfc_init_idle_stat_hb':
> drivers/scsi/lpfc/lpfc_sli.c:7329:26: error:
> 	implicit declaration of function 'get_cpu_idle_time'
>
> Add the missing dependency.
>
> Fixes: 317aeb83c92b ("scsi: lpfc: Add blk_io_poll support for latency improvment")
> Cc: Dick Kennedy <dick.kennedy@broadcom.com>
> Cc: James Smart <jsmart2021@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   drivers/scsi/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> index 571473a58f98..701b61ec76ee 100644
> --- a/drivers/scsi/Kconfig
> +++ b/drivers/scsi/Kconfig
> @@ -1154,6 +1154,7 @@ source "drivers/scsi/qedf/Kconfig"
>   config SCSI_LPFC
>   	tristate "Emulex LightPulse Fibre Channel Support"
>   	depends on PCI && SCSI
> +	depends on CPU_FREQ
>   	depends on SCSI_FC_ATTRS
>   	depends on NVME_TARGET_FC || NVME_TARGET_FC=n
>   	depends on NVME_FC || NVME_FC=n

Reviewed-by:  James Smart <james.smart@broadcom.com>

-- james

