Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37FBC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 19:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 943F12087E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 19:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i8my4THG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbgBCT4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 14:56:38 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42478 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgBCT4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 14:56:37 -0500
Received: by mail-pl1-f195.google.com with SMTP id e8so3652635plt.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 11:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I9M9LmaClASV810rGLEc15NYOwGjgzBVPDmw7qIokss=;
        b=i8my4THGhNGBApfbRpArFdahLO9sBtkHhFpuR70QqVUpG+FWx6DjxhgZFgtqUjPq66
         0WjH3gKJsCUoMQ7ipT4Q6vIUrwvHLMZegZ57wQNOVbfSJw10ePd/SDUsGr8EfwLgdLes
         O1I5F4wUR6GK7SPeit5DL2B1y2AggMl1HENdWpde9tuqtecoVfBt8So/j2u0G7u8EZfR
         WYQYc36PsFqwUCzYk02g3sEuETt3YnBJz//qWShRmOEl+XNkJSTTaMuyvrqaQ9VzdhG4
         G4T5lN2PKz67M00tNgzdZDVf/jY5dCXi1XUxh9mJ4TXXDeM4IET4KW97tkT7EWyzm5Xj
         ceqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I9M9LmaClASV810rGLEc15NYOwGjgzBVPDmw7qIokss=;
        b=tMZ54/FV5KIDXNbDLzmO15wb9BjcvHQq6bh6MXkrEA6ZJarfJJyRzJPL941FUtrqbb
         eBtb7NzpX21IV3nri0XMYRsik2Np7r7VUcsaPvJQFIQeH+A9gD6kPw5eYccvwJ7g+OxR
         K2ifFtWPEe/YzPlBXiEg6MDxQjjv3D5gxG3qgrIKwnCN6z0HK6VVKY9p4iLkd1useZNM
         U7rhbR73R4HYVNv04ZluE6pWFMHQKsXOiBLjOWGit8zydbDKOdrxFwrbJu9nkKcszcTh
         nvdH+Ulm3Ml1nhzYBQqFdJ7OMeUZuiLmKJZD09IXwpEArrcw8QlgIqYYzTKHVVNWWqhP
         JMJw==
X-Gm-Message-State: APjAAAXoU05ll44PNi/xmdVPtoJ6RYiM9TU4bVE2aoiHqjzS71U2cnCh
        rM+ljf+hGA7gJVAoRNyIpkz7Dg==
X-Google-Smtp-Source: APXvYqz5H17S9JQ02+kNOTj+0Wz6oywPwLIaMN2k+bOpSmvpM87PMUZNYn/QrD1GELPMKLvJrVCm/Q==
X-Received: by 2002:a17:90b:941:: with SMTP id dw1mr784516pjb.21.1580759795145;
        Mon, 03 Feb 2020 11:56:35 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id o29sm21978029pfp.124.2020.02.03.11.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 11:56:34 -0800 (PST)
Date:   Mon, 3 Feb 2020 11:56:32 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        robh@kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        tientzu@chromium.org, seanpaul@chromium.org, rjliao@codeaurora.org,
        yshavit@google.com
Subject: Re: [PATCH v2 1/2] Bluetooth: hci_qca: Enable clocks required for BT
 SOC
Message-ID: <20200203195632.GM3948@builder>
References: <1580456335-7317-1-git-send-email-gubbaven@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580456335-7317-1-git-send-email-gubbaven@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 30 Jan 23:38 PST 2020, Venkata Lakshmi Narayana Gubba wrote:

> Instead of relying on other subsytem to turn ON clocks
> required for BT SoC to operate, voting them from the driver.
> 
> Signed-off-by: Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
> ---
> v2:
>    * addressed forward declarations
>    * updated with devm_clk_get_optional()
>  
> ---
>  drivers/bluetooth/hci_qca.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index d6e0c99..73706f3 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1738,6 +1738,15 @@ static int qca_power_off(struct hci_dev *hdev)
>  	return 0;
>  }
>  
> +static int qca_setup_clock(struct clk *clk, bool enable)
> +{
> +	if (enable)
> +		return clk_prepare_enable(clk);
> +
> +	clk_disable_unprepare(clk);
> +	return 0;
> +}

As Marcel requested, inline these.

> +
>  static int qca_regulator_enable(struct qca_serdev *qcadev)
>  {
>  	struct qca_power *power = qcadev->bt_power;
> @@ -1755,6 +1764,13 @@ static int qca_regulator_enable(struct qca_serdev *qcadev)
>  
>  	power->vregs_on = true;
>  
> +	ret = qca_setup_clock(qcadev->susclk, true);
> +	if (ret) {
> +		/* Turn off regulators to overcome power leakage */

You can omit this comment as well, as the name of the function you call
is aptly named.

> +		qca_regulator_disable(qcadev);
> +		return ret;

Just return ret below instead.

> +	}
> +
>  	return 0;
>  }
>  
> @@ -1773,6 +1789,9 @@ static void qca_regulator_disable(struct qca_serdev *qcadev)
>  
>  	regulator_bulk_disable(power->num_vregs, power->vreg_bulk);
>  	power->vregs_on = false;
> +
> +	if (qcadev->susclk)

In the enable path you (correctly) rely on passing NULL to the clock
code, so do the same here.

Regards,
Bjorn
