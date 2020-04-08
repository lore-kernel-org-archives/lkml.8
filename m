Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A819BC2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F712082F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKGKiSuR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbgDHQAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 12:00:05 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45229 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729755AbgDHQAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 12:00:04 -0400
Received: by mail-qk1-f195.google.com with SMTP id m67so619985qke.12;
        Wed, 08 Apr 2020 09:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aRe2LUZ6th1URyp3FHFKMF3md2te8S/MCUnxkUCOAJM=;
        b=EKGKiSuRAwpaR5KSV6azvx0CJk9B6N+3O8L0o6RCsmsZsnV/8SEZeGSTVGM7ycSRzu
         bfNQo0kJ6IPzgBMk26jN14ISooZz+y5lUvv8X1JToguDZIF2bmWSQXP5UrPjxy1NOYqR
         O40Xym2bar84IcTU+DOguc6ig9ufu04KoDiW9laNk8VyDMWNPEE9fPTKRBtrqLOHNwxo
         zpHjHVhFEA+mye6b5NVuw6251J/jRZcZwi196jEyd4wpOR/3JZRebAGlqL+8PpPMmVKJ
         LpVsWggwkWPImJggudamhEXDakbELWE2rGyOJmbxmlso2iCdhI/3/YQx8c5qLbUnQm6+
         CGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aRe2LUZ6th1URyp3FHFKMF3md2te8S/MCUnxkUCOAJM=;
        b=tw4iHB8v62LeGFbPg4zSC78MfM2pBXqqQGKC5lUZG0AnfDw1OqXQcSQEqx9I8izPpK
         e09u8Q4Mpo9b3c7887HM7Gsrj/a4sswVL4HDCPkphLUMRPekUQdJp0+Mena7teRG7/i7
         5/A60YRQo15CKlg8sx7JpDX2RA4a/yMlHXtCpigYtW26vrbahE1wcxfv9Tzy5EhAmnFP
         qIxp1qeb3Vg/B2PnmRdtemvbxCzk24L0GXh91MpdLtq2h8YThZahUTZSVM+lyKDa52eR
         AfcwgdILIWIOrIaaa89pcUw3yY1P5oci9E3YlKZ34oug1KNESIh6ioQUTrzPDCdkFgnf
         b+BA==
X-Gm-Message-State: AGi0PuZ/M3e/ocFdt+cwjgU1sCtk50LHe5O7EgvTPiCMolnH0MCR2eek
        6lMYp5GJXVD1QlD5E5EuZII=
X-Google-Smtp-Source: APiQypKEYc/okCZmPC9ScbxhDZtYpLn1KKpByvTqnV75zi20PiEz27HaxIjHrZ1pv227jwLjwU/h3Q==
X-Received: by 2002:a05:620a:1189:: with SMTP id b9mr7975639qkk.236.1586361603428;
        Wed, 08 Apr 2020 09:00:03 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id a62sm18131916qkb.134.2020.04.08.09.00.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 09:00:02 -0700 (PDT)
Subject: Re: [PATCH] of: remove unneeded variable
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1585562702-360-1-git-send-email-dingxiang@cmss.chinamobile.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <92c6b7e9-4d55-a5c3-8c7f-5611edeb55c9@gmail.com>
Date:   Wed, 8 Apr 2020 11:00:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1585562702-360-1-git-send-email-dingxiang@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/20 5:05 AM, Ding Xiang wrote:
> rc is unneeded, just return 0.

of: of_detach_node() remove unneeded local return variable

> 
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> ---
>  drivers/of/dynamic.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index 08fd823..fe64430 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -286,7 +286,6 @@ int of_detach_node(struct device_node *np)
>  {
>  	struct of_reconfig_data rd;
>  	unsigned long flags;
> -	int rc = 0;
>  
>  	memset(&rd, 0, sizeof(rd));
>  	rd.dn = np;
> @@ -301,7 +300,7 @@ int of_detach_node(struct device_node *np)
>  
>  	of_reconfig_notify(OF_RECONFIG_DETACH_NODE, &rd);
>  
> -	return rc;
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_detach_node);
>  
> 


Reviewed-by: Frank Rowand <frank.rowand@sony.com>
