Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67EBC2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 15:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C3620857
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 15:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrxPr+6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgDJPiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 11:38:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43961 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgDJPiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 11:38:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id i10so2652499wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 08:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VBKczGYLsv2GTJSTGN6d+Mg13l565iovwK7tDtM0eCo=;
        b=QrxPr+6Zokq+E+HKmNBf8y79Ddlaewwn8GP1PRaMIzBz9Upg9gtVX0v8e5qSXAgslp
         HP5QTgLW81HquXtdESlyoaeThSFU0YEmpYBldvPfh0CB6q+oUI+eFyhsAjzCf1qwKLrE
         QAjRqMDNksMQfm85mfIu4ar0m8IvhAnj0oE1dcX3cfbYoOdk5Se3LK5zjXliq2JUYvA7
         HH1A2ziGB860hMbI5hU++6fDjkRXUKkodvIliFCej/nWPuoCIGx4fnzUIv7P0Nk+V9m5
         kCVV1vB3eC3JwhadPiqKt0cPjcjWTKZZcD/fTmlac66dSpBoR0rG+0tzsLoX59hPB0IM
         3r+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VBKczGYLsv2GTJSTGN6d+Mg13l565iovwK7tDtM0eCo=;
        b=YcxOYRMYqNZcOGDLubuoj62nqtdIoN1RyBXNJnk+tsSAF9T4GBgh1G+mRQ+eW2/rDf
         eWXniY30X4YQpM3Dn4Xhet+VN9F7aR84rmxRn/RMjHEFQGv1GXnjNHMCe2jMmC1XobDZ
         8BRzbcwVmm7PB1tdUEktCpV1dM2qS1TAK+KSdSuog6XXGehmJOuN0U0pVQ3TDIMlyh0A
         uFKJQUgSHLcoEAsOAJAbrRpNoOz7u4Me6q4mw89S+ln3mBHovVdngJS1ggNjrbPaHPdU
         H2syVr9fUQSPh1qMB473JZwhCCDjZnqcNJW1w+cRCoJowavnvnOVgwd36/bdhn7xtOjX
         enww==
X-Gm-Message-State: AGi0PuYsj8I6AYxs1jyvnpWtG0dkDLJQaTCiirkR03MfqgkmLzliOfNQ
        p8XMX24rAK8i79zPLO6jMyq0pppq
X-Google-Smtp-Source: APiQypKRu6/ZfCk4+n3XAujm26yEhTNUYNWNybtmWmBhGqeG9bDSQnILKiY37xpy0jq4aInGx/BmNg==
X-Received: by 2002:a5d:5230:: with SMTP id i16mr5097555wra.15.1586533081703;
        Fri, 10 Apr 2020 08:38:01 -0700 (PDT)
Received: from [192.168.43.227] (94.197.121.102.threembb.co.uk. [94.197.121.102])
        by smtp.gmail.com with ESMTPSA id c17sm3298882wrp.28.2020.04.10.08.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 08:38:01 -0700 (PDT)
Subject: Re: [PATCH 1/2] staging: vt6656: Refactor the assignment of the
 phy->signal variable
To:     Oscar Carter <oscar.carter@gmx.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20200410112834.17490-1-oscar.carter@gmx.com>
 <20200410112834.17490-2-oscar.carter@gmx.com>
From:   Malcolm Priestley <tvboxspy@gmail.com>
Message-ID: <986e8e5e-245a-cc70-2c6f-8ac3a4a485c9@gmail.com>
Date:   Fri, 10 Apr 2020 16:37:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200410112834.17490-2-oscar.carter@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/04/2020 12:28, Oscar Carter wrote:
> Create a constant array with the values of the "phy->signal" for every
> rate. Remove all "phy->signal" assignments inside the switch statement
> and replace these with a single reading from the new vnt_phy_signal
> array.
> 
> Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> ---
>   drivers/staging/vt6656/baseband.c | 101 +++++++-----------------------
>   1 file changed, 21 insertions(+), 80 deletions(-)
> 
> diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/baseband.c
> index a19a563d8bcc..47f93bf6e07b 100644
> --- a/drivers/staging/vt6656/baseband.c
> +++ b/drivers/staging/vt6656/baseband.c
> @@ -115,6 +115,21 @@ static const u16 vnt_frame_time[MAX_RATE] = {
>   	10, 20, 55, 110, 24, 36, 48, 72, 96, 144, 192, 216
>   };

Actually you don't need the second values
> 
> +static const u8 vnt_phy_signal[][2] = {
> +	{0x00, 0x00},	/* RATE_1M  */
The driver would never attempt use preamble at this rate
so it's safe to include in with the next 3 rates

> +	{0x01, 0x09},	/* RATE_2M  */
> +	{0x02, 0x0a},	/* RATE_5M  */
> +	{0x03, 0x0b},	/* RATE_11M */
just |= BIT(3) for preamble.

> +	{0x8b, 0x9b},	/* RATE_6M  */
> +	{0x8f, 0x9f},	/* RATE_9M  */
> +	{0x8a, 0x9a},	/* RATE_12M */
> +	{0x8e, 0x9e},	/* RATE_18M */
> +	{0x89, 0x99},	/* RATE_24M */
> +	{0x8d, 0x9d},	/* RATE_36M */
> +	{0x88, 0x98},	/* RATE_48M */
> +	{0x8c, 0x9c}	/* RATE_54M */

Again just |= BIT(4) for PK_TYPE_11A

Regards

Malcolm
