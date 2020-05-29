Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3151C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFEF42074B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqGJS3FK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgE2Js1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 05:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgE2JsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 05:48:25 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68ECCC03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 02:48:24 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y18so1046375pfl.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 02:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mPpjYDtVNFbOV3twkT62l0LyftrjpV9lJs5FQ+hBUJY=;
        b=RqGJS3FKuMyWpu1m3Hzc6I4POBM8lESMPYNIYKWdGRlvA8Kh4IUyw7F0hympeVZpd1
         yXWiFtzPY6j5UXa/C+hrN8clyWYIa55Iia4MqyCMWOIAKyuA8D7fPpKzOnHCb9wTJo+K
         wuYYrIN+1Uebl+YzdTKfCzPq2JRfKJAztns+u5u6kveazJvE361p23B2baTzk8oLw4rV
         O4eJ2mXLljPox04H1Jle4G9dzklK687lj4qCHFllOTt06dkwa7EWVHPslOjSUmJwpZFv
         JcegsnotpcOIrh168sH42B+nib3cjDhdNcgap8Abs7up2U86YnRPYnWc4twOvdKA2ZgT
         bJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mPpjYDtVNFbOV3twkT62l0LyftrjpV9lJs5FQ+hBUJY=;
        b=setobAYHhLKqyFOciBTq4JSJ+/eY1GmSKkiuL1RkuXrCQhRQlLgvhHZvtX+pLZ9NqA
         eBZAK5e5Sll6YlBmwG3jAiKZXXkBSrNgsgy+YdIqPbYjDgfoBuX7oL42BDIYVkdjqjTo
         p6dHCsiaPhgWch1WEdDyQ7s/KhY6vr5LpoXGiHNJSlpM7q+fxgNteGQnreEfcyg3S6J7
         17NtZ8nHO2XsusPGzjiO3tbdJ4zEnNTlAd2qO17wrofi/sy6OqZ562VaPvIcx8W8+8W6
         Fzk9vzXNrNe/7AqYj4ivxBA9HmCZDRN8OKtCZhV2OUBZSgettSV5gv3DAI5jvlpujXWC
         ncHA==
X-Gm-Message-State: AOAM531aDY6sPL/yw7iHqXdLvSE2FiLXDy+MAtCK8pWjB2hOEtxOHXed
        idJJQOdP0TZfQ4mvFSFKH515XREyato=
X-Google-Smtp-Source: ABdhPJwWITnuWJvg76c3WAVB8NAsrXfY/9PtnbOchm4AlaChuKqAL/wfFo3hfttRROrUzG84B3Dqgw==
X-Received: by 2002:a62:7610:: with SMTP id r16mr1467560pfc.70.1590745703981;
        Fri, 29 May 2020 02:48:23 -0700 (PDT)
Received: from cnn ([2401:4900:2654:9f89:a888:ed6a:9872:b822])
        by smtp.gmail.com with ESMTPSA id i22sm3987421pfo.92.2020.05.29.02.48.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 May 2020 02:48:23 -0700 (PDT)
Date:   Fri, 29 May 2020 15:18:13 +0530
From:   Manikandan <manikandan.hcl.ers.epl@gmail.com>
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, sdasari@fb.com, patrickw3@fb.com,
        vijaykhemka@fb.com, manikandan.e@hcl.com
Subject: Re: [PATCH] hwmon:(adm1275) Enable adm1278 ADM1278_TEMP1_EN
Message-ID: <20200529094813.GA29323@cnn>
References: <20200528141523.GA8810@cnn>
 <76D2694A-C80C-49F8-B51D-8A74341CA4ED@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76D2694A-C80C-49F8-B51D-8A74341CA4ED@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 05:34:22PM +0000, Vijay Khemka wrote:
> 
> 
> ﻿On 5/28/20, 7:15 AM, "Manikandan Elumalai" <manikandan.hcl.ers.epl@gmail.com> wrote:
> 
>     
>     The adm1278 temperature sysfs attribute need it for one of the our openbmc platform . 
>     This functionality is not enabled by default, so PMON_CONFIG needs to be modified in order to enable it.
> 
> There is no Signed-off-by.
>     
>     ---
>      drivers/hwmon/pmbus/adm1275.c | 15 +++++++++++++++
>      1 file changed, 15 insertions(+)
>     
>     diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
>     index 5caa37fb..47b293d 100644
>     --- a/drivers/hwmon/pmbus/adm1275.c
>     +++ b/drivers/hwmon/pmbus/adm1275.c
>     @@ -681,6 +681,21 @@ static int adm1275_probe(struct i2c_client *client,
>      			}
>      		}
>      
>     +		config = i2c_smbus_read_byte_data(client, ADM1275_PMON_CONFIG);
>     +		if (config < 0)
>     +			return config;
>     +
>     +		/* Enable TEMP1 by defult */
>     +		config |= ADM1278_TEMP1_EN;
>     +		ret = i2c_smbus_write_byte_data(client,
>     +					ADM1275_PMON_CONFIG,
>     +					config);
>     +		if (ret < 0) {
>     +		dev_err(&client->dev,
>     +			"Failed to enable temperature config\n");
>     +		return -ENODEV;
>     +		}
>     +
>      		if (config & ADM1278_TEMP1_EN)
> 
> This check becomes irrelevant as you are enabling it above then rather than
> enabling it just remove this check.
     Thanks for review Vijay. I will submit changes in v2.
> 
>      			info->func[0] |=
>      				PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP;
>     -- 
>     2.7.4
>     
>     
> 
