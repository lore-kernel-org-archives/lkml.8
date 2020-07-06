Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0954C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFDF0206CB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JrCEisNA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgGFOsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729304AbgGFOsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 10:48:22 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A67FC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 07:48:22 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o11so41301749wrv.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 07:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=cBZ2scPa5H+r50RUQxyW3XJ5xsh/nqsYrlxmo7w/e8w=;
        b=JrCEisNAfZ3q+hI01mukf0VgotpSmwx/3EA0lVL93a9mhJjLYMKTr+edgUYovIQUWC
         SOY7omUcDRq5G+Xjm8XrP5dCgnVehYA1I4Buebae7Mn7NzmVwqZI0UKX87V9dTORYxUB
         a9rlOdz8FbHuOYJutbG76thBXURF+ZbxXGeCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=cBZ2scPa5H+r50RUQxyW3XJ5xsh/nqsYrlxmo7w/e8w=;
        b=teR5Oo7pq/iXA5kr1+ap/hbeHTWWocvfWv6kzkQ4hIu322yYWcGg9WkZyahQCv2IhN
         WsxNnTLQT1rUt1mKVBhtKOXhotzrxyTtxVUGlde14cadioM8HY86aYiVOcBjjOIV6dWc
         PlWic2RB+r2hKx4/iQu7+ftzhZY50SCXRpyY2HABXey3GnJdjUGbTGG+oP20V7tkA/jj
         DbWoC6ndAiM0HTjHXlFf5H7UR+TYcc18yOwteDcjvxPGHWMYwiMBoaB9TAERSwVSHgVq
         LvW6uW9oXsSLdACPUo2kDrwv0HsNpLM0nwEIjfcjxLqUiTJ4MLDNvVQvlOtxhOgTDFfA
         hEsQ==
X-Gm-Message-State: AOAM533HZE8bz0xbteldykeDMggenybyqvIo4qCYl0tKSj44fpwISX8t
        5w9ARCxYKTN2jjRBYYxWPsm3etPjqGZtLxGZ0cCcpOxLKBlBGswj3opnA3Aav7yOs0ilrMdsx0Q
        5UweVdvUI3RV3NeropXGhcWbim++4Cyd8o+3dH99jc9JJ0vyzZLHo/N7n+y+bhPHqzHYyOBbjuy
        iN6zI=
X-Google-Smtp-Source: ABdhPJyDCzhSaOmHq049kLL6PXnNNhsPb7sswh46NV21Ro6z1vjnWiqyJZwkoucKnfUQ+ZjY+/JaTA==
X-Received: by 2002:a5d:55cb:: with SMTP id i11mr46581284wrw.28.1594046900665;
        Mon, 06 Jul 2020 07:48:20 -0700 (PDT)
Received: from [10.230.185.151] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c136sm19604644wmd.10.2020.07.06.07.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 07:48:20 -0700 (PDT)
Subject: Re: [PATCH][next] scsi: lpfc: fix less than zero comparison on
 unsigned int computation
To:     Colin King <colin.king@canonical.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200706130820.487271-1-colin.king@canonical.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <44692d32-d522-43ff-de74-a1faa432a911@broadcom.com>
Date:   Mon, 6 Jul 2020 07:48:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200706130820.487271-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/6/2020 6:08 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The expressions start_idx - dbg_cnt is evaluated using unsigned int
> arthithmetic (since these variables are unsigned ints) and hence can
> never be less than zero, so the less than comparison is never true.
> Re-write the expression to check for start_idx being less than dbg_cnt.
>
> Addresses-Coverity: ("Unsigned compared against 0")
> Fixes: 372c187b8a70 ("scsi: lpfc: Add an internal trace log buffer")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/scsi/lpfc/lpfc_init.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
> index 7285b0114837..ce5afe7b11d0 100644
> --- a/drivers/scsi/lpfc/lpfc_init.c
> +++ b/drivers/scsi/lpfc/lpfc_init.c
> @@ -14152,7 +14152,7 @@ void lpfc_dmp_dbg(struct lpfc_hba *phba)
>   		if ((start_idx + dbg_cnt) > (DBG_LOG_SZ - 1)) {
>   			temp_idx = (start_idx + dbg_cnt) % DBG_LOG_SZ;
>   		} else {
> -			if ((start_idx - dbg_cnt) < 0) {
> +			if (start_idx < dbg_cnt) {
>   				start_idx = DBG_LOG_SZ - (dbg_cnt - start_idx);
>   				temp_idx = 0;
>   			} else {

Thanks Colin - I was about to send a patch for this. Has this fix and 
one a couple of lines further down. I will post it shortly.

-- james

