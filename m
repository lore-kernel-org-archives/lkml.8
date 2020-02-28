Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01506C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86E92469F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUeTvM/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgB1O3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:29:00 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:39652 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgB1O3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:29:00 -0500
Received: by mail-yw1-f66.google.com with SMTP id x184so3437739ywd.6;
        Fri, 28 Feb 2020 06:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1miRK1mEzWH0HleISod00fDwFSsYi7WyuiSe/ld2DLI=;
        b=lUeTvM/956qY6JCuxDkIsb+rLf4crpckakgsKjC0WUp3bu1rQQqUZ5ZsWh0WnsX7fk
         owyoGlajBnyfUiYtUyIeg0H4sDiFQT9tHt383NLV4fRbJYxg2oxVd4OYXntF6U88wKV5
         ol2e1hPDbGtmZZY/27TlmMeL2bvffxFIBBgYkAR6U7WIGo5jyQOyFi/fm/3bHEAYBtX4
         EMHKAOnICW/uH7sPH1z+vVHA0o0EFCnoV81bOtXKi5puxsyEq6sxcFedwr3hfWoqFsud
         QBL8rgKhg1Wj2K0dPDDR3wZciJhRn6YLbc6E9T8MuFoyN2+XCv5qQKQegBzSdn/4+m07
         SQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1miRK1mEzWH0HleISod00fDwFSsYi7WyuiSe/ld2DLI=;
        b=QOn2EhyqpVNWhgoB6ML1lgn+0ZQfRoDpLCFnT8xDJFFwyeoFCyMIjJwLLIDY+++xar
         +iuIx1Uxyptr2uVVkiSu73Q9g4OYflV7DaBcajdKywYiB4C3Me4wJNvtwVkuLN5F0CTp
         5PopfDffhBtHbiuQdN60s2c/Ppvb0AumfgJ4oovFGjOQPtYA1TFwA3IwHdYk12V5VVWz
         igvBHl+0PzsnUzKNQjSuJXlq62PCsr/LpXZIufNt4Xi52G8ShualPSrqWiNgIKxiQJ07
         YGWwLOUIPzT84sacxQwQsAjYKWihOOZRkp62gaIofd0sJbmrHYJoSCxvdVw8541K+h8Y
         KemA==
X-Gm-Message-State: APjAAAU5b9lynyQZe2t1Wj4ttac9YrNKGL2eRMZNj9iJYOi95oIM7GDN
        7QCIQLX6+WyvkWjF6nUGtA8=
X-Google-Smtp-Source: APXvYqyqYrbxvlzw9FZLEHH+UjYlW5TslsoD/PAZmEBH+GpBMHOOKPmN0B3RPc+ev4VICRqHACbw3A==
X-Received: by 2002:a25:4843:: with SMTP id v64mr3616892yba.315.1582900139260;
        Fri, 28 Feb 2020 06:28:59 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id d125sm2700754ywb.94.2020.02.28.06.28.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Feb 2020 06:28:58 -0800 (PST)
Subject: Re: [PATCH v3] of: overlay: log the error cause on resolver failure
To:     Luca Ceresoli <luca@lucaceresoli.net>, devicetree@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
References: <20200228084027.10797-1-luca@lucaceresoli.net>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <37e8707f-a351-7979-98f5-36c5c30a16dd@gmail.com>
Date:   Fri, 28 Feb 2020 08:28:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200228084027.10797-1-luca@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/20 2:40 AM, Luca Ceresoli wrote:
> When a DT overlay has a node label that is not present in the live
> devicetree symbols table, this error is printed:
> 
>   OF: resolver: overlay phandle fixup failed: -22
>   create_overlay: Failed to create overlay (err=-22)
> 
> which does not help much in finding the node label that caused the problem
> and fix the overlay source.
> 
> Add an error message with the name of the node label that caused the
> error. The new output is:
> 
>   OF: resolver: node label 'gpio9' not found in live devicetree symbols table
>   OF: resolver: overlay phandle fixup failed: -22
>   create_overlay: Failed to create overlay (err=-22)
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

Thanks Luca, looks good.

Reviewed-by: Frank Rowand <frank.rowand@sony.com>

-Frank


> 
> ---
> 
> Changed in v3:
>  - add only the message from v1, but as reworded by Frank
> 
> Changed in v2:
>  - add a message for each error path that does not have one yet
> ---
>  drivers/of/resolver.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/resolver.c b/drivers/of/resolver.c
> index 83c766233181..b278ab4338ce 100644
> --- a/drivers/of/resolver.c
> +++ b/drivers/of/resolver.c
> @@ -321,8 +321,11 @@ int of_resolve_phandles(struct device_node *overlay)
>  
>  		err = of_property_read_string(tree_symbols,
>  				prop->name, &refpath);
> -		if (err)
> +		if (err) {
> +			pr_err("node label '%s' not found in live devicetree symbols table\n",
> +			       prop->name);
>  			goto out;
> +		}
>  
>  		refnode = of_find_node_by_path(refpath);
>  		if (!refnode) {
> 

