Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA27C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EA2421973
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtAp4yLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbgDQOFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 10:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730774AbgDQOFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 10:05:06 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586BCC061A0C;
        Fri, 17 Apr 2020 07:05:06 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u9so1095460pfm.10;
        Fri, 17 Apr 2020 07:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5LL6XGfAXdgthOmL4pwvCtOYPIlMnPGTD2c4+Vvf394=;
        b=NtAp4yLqragNc0O8AnLye1YbWGmtvoCvOCliZqarlR8IdzDL2aqUrpslBaPDW04CHQ
         P5bNUkEPZ4LxfSJE80kwC9TJLTgTthAMoMpd7Z9wRi9ra5kGszzGkuHsPrCYnOXCCDH+
         1QhODwTW1EktQ0gOP/4UJnBaEcaYCn+Bhq6bjY0m0e11UeUmPZIeAQcDaI2X1zu/O3w3
         t947hbqB9PrfAJW9xS1BkPDYE/8tYGycELDe3lA8TDxZQgPvYJsh7VMaWUDCqpoVOd8v
         aqsHMecpxPrMEnH8V4D6mxRmxSQegN19faA3d3azPTWD0IM0mLOgB58E1gWZv4cmNoWZ
         hKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5LL6XGfAXdgthOmL4pwvCtOYPIlMnPGTD2c4+Vvf394=;
        b=YlH/K09JrpZt+YeDNAnX4TYvtN7QkSr7E9ZX/XnVsI9L1SkX4dhsHmMb1uVbLa1dym
         51UfyPQakkcOp7o17eoPDpi041HRqeMKLLvZnJw9BkTyN2HVXacoq38Il9Ag476YDn1W
         4i1srFrBRhub7/sChcDAn+v9OkYE1TCDKhY/fhL8MQ91ZXnEnFv3cHNgH3RNxcrIuxJn
         nRdvn66ZFB4fYn8uQ+HFdI+AjICN+Cf8WLTibEjnaDVWsGHYs0FKaoANQTT9hJkM+fSw
         kClGiseNps5AA6XXWw57eqadvpBzy21hw2VIRNkklg/lsUwS7FuByBWvql4n1JKU8liz
         jjHQ==
X-Gm-Message-State: AGi0PuZwERNe7J+Q+4jGVRUSU4Pc44Ol5W4yJtge2ifO6beDLpkxyDXg
        XbDgQjN7CdYCRoKlRGhmOXk=
X-Google-Smtp-Source: APiQypKJ7IQ5HuBONljX9r+Hv7vT+IGOL07C35LShN8GAmTgnNpFG/ESC5bQtQMaH+JeOEVZzyzZ3w==
X-Received: by 2002:a63:4650:: with SMTP id v16mr2785901pgk.99.1587132305901;
        Fri, 17 Apr 2020 07:05:05 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a9sm18298165pgv.18.2020.04.17.07.05.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Apr 2020 07:05:05 -0700 (PDT)
Date:   Fri, 17 Apr 2020 07:05:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kbuild test robot <lkp@intel.com>,
        Lina Iyer <ilina@codeaurora.org>
Subject: Re: [PATCH] soc: qcom: cmd-db: Properly endian swap the slv_id for
 debugfs
Message-ID: <20200417140504.GA98984@roeck-us.net>
References: <20200417000645.234693-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417000645.234693-1-swboyd@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 05:06:45PM -0700, Stephen Boyd wrote:
> Read the slv_id properly by making sure the 16-bit number is endian
> swapped from little endian to CPU native before we read it to figure out
> what to print for the human readable name. Otherwise we may just show
> that all the elements in the cmd-db are "Unknown" which isn't right.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Cc: Lina Iyer <ilina@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/soc/qcom/cmd-db.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> base-commit: d6815c5c43d4f9d18e557d27fd27ae8d9cfd450c
> prerequisite-patch-id: fc235b174200bb1b24876628a89a841d1c2e4aad
> prerequisite-patch-id: df579afb4eaea4200733d9dffb1d75eef8d8360b
> 
> diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> index 4f8b739c6485..fc5610603b17 100644
> --- a/drivers/soc/qcom/cmd-db.c
> +++ b/drivers/soc/qcom/cmd-db.c
> @@ -254,7 +254,7 @@ static int cmd_db_debugfs_dump(struct seq_file *seq, void *p)
>  		if (!rsc->slv_id)
>  			break;
>  
> -		switch (rsc->slv_id) {
> +		switch (le16_to_cpu(rsc->slv_id)) {
>  		case CMD_DB_HW_ARC:
>  			name = "ARC";
>  			break;
