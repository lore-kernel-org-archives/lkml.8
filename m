Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972D2C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653272071A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cPYiWF/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731979AbgDAHK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 03:10:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38993 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731765AbgDAHK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 03:10:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id k15so6539415pfh.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 00:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q3YpiEN9c0q7gtTc0xgNqKBZ8J1CYe0h5Njvo6qLBqc=;
        b=cPYiWF/6kIM7c7xd0hz8A3KchAwfdZf/WBjYHWlm/sRzmaapKKkhvB+xM+o9ExkBwu
         uI+vYZU+DEYJA+34/MvfpCsiHGXfetTpnUhEWprqfuBG6LkAHbm54C4O8FnDf43h0M1k
         3al6T2FOJA+agQa3CKSPh/T+VrSktO5sni+COXnkfh8oAlcxH3EYD7awYMjmiLX0KR7B
         NahVO1n9PiR928wCk+0u1GW2/qXX102bzWpS64sACXk3Am6+dgJd1YiU6CkX+2VzABYn
         D/nK2Wo0ASQJtn6jIZadn8VM7MefKiUkJEWk+jVDIxm1V84vY+t3I6FS5gKv4uTmKKra
         h2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q3YpiEN9c0q7gtTc0xgNqKBZ8J1CYe0h5Njvo6qLBqc=;
        b=K3mh2L24YH490PObjWhgwC6rs8h7d9D+KxzRqPHu7Ge8+U2klH5G6gf0N5Olvph+zU
         V2U6GidfEHPrWqXaJ1L8OYDXwCXlz8/yDTFy4BUL5PnG4DZsidmZu115Gmc608e1k5yd
         NaCZQya1jPDeIvGUKN+uXTvD8rtyjmCoqqMJOLJovavrRoY/YcbUyFz/QBvSbeUzfbrr
         rtpGdo2OmDYUbyyuG+bDFrcauOuJHkGM12tFL+6AATi2LZ7EV8XYzpJ9TEYjqISj/D5s
         wEf4SXlq7YHYqaIO4HDaziXiWOwRD6zpukz2Kv+F17HIiooDkjwmy7IiXn5x7FVTM+DN
         JRCg==
X-Gm-Message-State: ANhLgQ1Hw5w/zlYDT9SI4oCnxg024eSaoTFf2CWVZsisstco3mK1rZ5G
        c4MY0Pc4f5YppXFVPVbxXOdCZw==
X-Google-Smtp-Source: ADFU+vv0GaG87lZWdspiXpoeNM3S1HoJf278awHnmC0uQGmwJkgdIPHnBFsC5+Ddmr7OhhkCGjWpeQ==
X-Received: by 2002:aa7:9ec7:: with SMTP id r7mr22171606pfq.191.1585725026717;
        Wed, 01 Apr 2020 00:10:26 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 144sm870769pfx.184.2020.04.01.00.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 00:10:25 -0700 (PDT)
Date:   Wed, 1 Apr 2020 00:10:23 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     gregkh@linuxfoundation.org, davem@davemloft.net,
        smohanad@codeaurora.org, jhugo@codeaurora.org,
        kvalo@codeaurora.org, hemantk@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] net: qrtr: Add MHI transport layer
Message-ID: <20200401071023.GD663905@yoga>
References: <20200401064435.12676-1-manivannan.sadhasivam@linaro.org>
 <20200401064435.12676-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401064435.12676-3-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 31 Mar 23:44 PDT 2020, Manivannan Sadhasivam wrote:
> diff --git a/net/qrtr/mhi.c b/net/qrtr/mhi.c
[..]
> +static void qcom_mhi_qrtr_ul_callback(struct mhi_device *mhi_dev,
> +				      struct mhi_result *mhi_res)
> +{
> +	struct sk_buff *skb = (struct sk_buff *)mhi_res->buf_addr;
> +
> +	consume_skb(skb);
> +	if (skb->sk)
> +		sock_put(skb->sk);

Don't you need to do this in opposite order, to avoid a use after free?

Regards,
Bjorn
