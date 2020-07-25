Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A10BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 17:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5F37206D7
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 17:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmPtqyfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgGYRrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 13:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbgGYRrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 13:47:51 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195BBC08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 10:47:51 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id y22so10847936oie.8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 10:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4lhtu1K0BG/0jHhz2IEgTy/+M32YSdppT7D+/e/UP+U=;
        b=ZmPtqyfgTDS+F2G9Ns7dqDGIfPhORumtj+B5J8LnYD00rv9Su4jkc+VxuCFoZqTtL9
         Uyap2jFduODRUPm6IOglt30oMSnCrfagIPghJiPo03SWJwGZrts+cYt1w/Iwt5qROpTZ
         m7+JQEcQFM4T+nTTP+DmMspcHVPmmap38udSTXzahDyqpDz47MBMagTLxmKRJQ3M5AnX
         EeIk0kJi6FvDVoKIJUMwdxhMbitvU5IeIaXFLDE9T+JB/08QlGaEpcsdA6Nnqc+s2j++
         YLGGPU2XpZyLX+yzmP3sX5eptl3u0UoZ/ZctvJgSYEW+rPAGiet+FAWlBYv6doKx8wQ1
         lPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4lhtu1K0BG/0jHhz2IEgTy/+M32YSdppT7D+/e/UP+U=;
        b=fIl4RjfO3h6JkF4DWuBpUjpx2OTMw650DMiW32WZ25pENeu3EfJzL7wujI9e1RDb2E
         VkOgzxeB/bk+7P/CKywv4RsLL2DSqbcKTmrRnhktFnh9IQiFwpksEFbiTLLEzqcY2rbS
         YhpkY70eWdZD7svqNtQnhnHqvctzbrzitXRUMnumv5iYRkh9r13I8uCz2eQa7HpWQsP/
         ED5eUvHQdlHy1ui6SpQWiB9xZOoWUPHR5NyYNOV9/PPds+F/E81sFZ90OxD1Rgv7TUer
         mTW4z76iagMuL0ubbBz1GGpTP1XZVMLtirbA8iSNZ4diRLdSfRh95zJe2Xicqf/BsrAS
         vazg==
X-Gm-Message-State: AOAM530bgCf5acb1t3d/AQpWGaN8UdB/aP7myo+NNZmNGbeJX8s888KX
        oSxJTWy2jXgpcC+0O5EgnaXduDCd
X-Google-Smtp-Source: ABdhPJwjcJQR+vPB9GPYKs4ugc4uB1N+Xim0+x+S4vy4sqRZza1eFco4CcjKuomuRCZp0OVQ4tQ9kg==
X-Received: by 2002:aca:a814:: with SMTP id r20mr12687639oie.91.1595699269955;
        Sat, 25 Jul 2020 10:47:49 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id e203sm692119oia.17.2020.07.25.10.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jul 2020 10:47:49 -0700 (PDT)
Subject: Re: [PATCH 1/1] STAGING - REALTEK RTL8188EU DRIVERS: Fix Coding Style
 Error
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anoop S <anoop.skumar1507@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        Joe Perches <joe@perches.com>,
        Merwin Trever Ferrao <merwintf@gmail.com>,
        Rahul Gottipati <rahul.blr97@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20200725122041.5663-1-anant.thazhemadam@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <aab59eb1-baff-5de1-4e14-88ffc42db1fe@lwfinger.net>
Date:   Sat, 25 Jul 2020 12:47:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200725122041.5663-1-anant.thazhemadam@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/20 7:20 AM, Anant Thazhemadam wrote:
> Running the checkpatch.pl script on the file for which patch was created, the
> following error was found to exist.
> ERROR: space required after that ',' (ctx:VxV)
> 
> Fixed the above error which was found on line #721 by inserting a blank
> space at the appropriate position.
> 
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> ---
>   drivers/staging/rtl8188eu/core/rtw_security.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/core/rtw_security.c
> index 21f6652dd69f..57e171d3e48d 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_security.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_security.c
> @@ -718,7 +718,7 @@ u32 rtw_tkip_decrypt(struct adapter *padapter, u8 *precvframe)
>   				res = _FAIL;
>   			}
>   		} else {
> -			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo==NULL!!!\n",__func__));
> +			RT_TRACE(_module_rtl871x_security_c_, _drv_err_, ("%s: stainfo==NULL!!!\n", __func__));
>   			res = _FAIL;
>   		}
>   	}

In fixing one checkpatch.pl condition, you introduced another - the resulting 
line is too long. You should fix only one such condition, but you should fix any 
others that are introduced. You do need to document it.

Patch subjects for this driver should be written as "staging: rtl8188eu: .....".

Larry


