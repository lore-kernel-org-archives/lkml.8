Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E864C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 05:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A8E24677
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 05:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AUKoQ2qI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgCBFzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 00:55:19 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33430 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCBFzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 00:55:19 -0500
Received: by mail-pg1-f194.google.com with SMTP id m5so1036259pgg.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 21:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/rugZxpdMgFuggpknIjg9upbTqeu96rVvKelMnBJ9UA=;
        b=AUKoQ2qIej++uMhL6Cg9bs9r0hCEdWT28c5rZpygXGbAUxGgH6pqibzWYMpM6cc7/T
         Hhu3Jn7w73pVCQZWpU0wBqzMfTezwvpaOvnbE/5bVsZoEml3Wo2JbYgkn3NaZB30zSqy
         fzoLCy4Beb8LUmmrcpVkPayAEYqs8zNb3ZMrimukA9XfsiZ9yiZU08Ww7Vl3w3yVuLse
         doj2aTd77l8pXdi6IXiROq+tghT/WVtVfz+M4+hqy9Ivwt8T8ry/cbrHfgSUOLkhA3i8
         lN/Wxw0A41YK7IkLkgnGBFmuH20k2rF+D0p5Ej/4MS5phnLcZKDYo/Nc1e8CzZhHe78w
         ifhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/rugZxpdMgFuggpknIjg9upbTqeu96rVvKelMnBJ9UA=;
        b=kAH/DRiHeDtEkbk5uga7xkb455lbTc5HX+OumKlJmKmFQDR2ZeNoIHUlF9A7ytzB/6
         aEMcG3PwH7ZnlmI4f3FLg41n/GRIpCjef2f9dFLvc2UrLcMAUhrzXLnF8WdAA0f1blXx
         JOEEWtbAIPwLMLf/3D52/UUC1n0PkYTe7Z+FvyB6O+DUgErxXVpxK9ueSHG+V8tYKSvL
         LqZe4/N4gF5c62RKMspifxfKS2ECsxWxhITTVXpviiOZKlexLySQbzk5F65tSRF3RV5O
         S63h2grw7/sLrm0nxp6w/xdaPEscu5S1/XvTaYs0Acsz6iu+a9gO41vi/6YkcYZQQVe9
         3uNA==
X-Gm-Message-State: APjAAAUH7JDNANfVl1GndOD0wbtVSmlZWk40+jaJRrPMMeQgPoCkV91p
        G0ZZZ/I+JuCOwyd4XQEhtz5z
X-Google-Smtp-Source: APXvYqxY0x55nq3fyRV03uQtfT196Q9JIOy5IBWGxH31mgiNHSafdj+D6Pob7Gp23ZUNY1EY8VbmHw==
X-Received: by 2002:a65:668c:: with SMTP id b12mr17983339pgw.14.1583128518463;
        Sun, 01 Mar 2020 21:55:18 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:683:b69c:15d:29bf:12ee:d853])
        by smtp.gmail.com with ESMTPSA id i15sm278975pfk.115.2020.03.01.21.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Mar 2020 21:55:17 -0800 (PST)
Date:   Mon, 2 Mar 2020 11:25:10 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] net: qrtr: Fix FIXME related to qrtr_ns_init()
Message-ID: <20200302055510.GB23607@Mani-XPS-13-9360>
References: <20200302032527.552916-1-bjorn.andersson@linaro.org>
 <20200302032527.552916-3-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302032527.552916-3-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 01, 2020 at 07:25:27PM -0800, Bjorn Andersson wrote:
> The 2 second delay before calling qrtr_ns_init() meant that the remote
> processors would register as endpoints in qrtr and the say_hello() call
> would therefor broadcast the outgoing HELLO to them. With the HELLO
> handshake corrected this delay is no longer needed.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  net/qrtr/ns.c   | 2 +-
>  net/qrtr/qrtr.c | 6 +-----
>  net/qrtr/qrtr.h | 2 +-
>  3 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
> index e3f11052b5f6..cfd4bd07a62b 100644
> --- a/net/qrtr/ns.c
> +++ b/net/qrtr/ns.c
> @@ -693,7 +693,7 @@ static void qrtr_ns_data_ready(struct sock *sk)
>  	queue_work(qrtr_ns.workqueue, &qrtr_ns.work);
>  }
>  
> -void qrtr_ns_init(struct work_struct *work)
> +void qrtr_ns_init(void)
>  {
>  	struct sockaddr_qrtr sq;
>  	int ret;
> diff --git a/net/qrtr/qrtr.c b/net/qrtr/qrtr.c
> index 423310896285..313d3194018a 100644
> --- a/net/qrtr/qrtr.c
> +++ b/net/qrtr/qrtr.c
> @@ -1263,11 +1263,7 @@ static int __init qrtr_proto_init(void)
>  		return rc;
>  	}
>  
> -	/* FIXME: Currently, this 2s delay is required to catch the NEW_SERVER
> -	 * messages from routers. But the fix could be somewhere else.
> -	 */
> -	INIT_DELAYED_WORK(&qrtr_ns_work, qrtr_ns_init);
> -	schedule_delayed_work(&qrtr_ns_work, msecs_to_jiffies(2000));
> +	qrtr_ns_init();
>  

You forgot to remove the below instances of delayed_work:

#include <linux/workqueue.h>
struct delayed_work qrtr_ns_work;
cancel_delayed_work_sync(&qrtr_ns_work);

Other than that,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

>  	return rc;
>  }
> diff --git a/net/qrtr/qrtr.h b/net/qrtr/qrtr.h
> index 53a237a28971..dc2b67f17927 100644
> --- a/net/qrtr/qrtr.h
> +++ b/net/qrtr/qrtr.h
> @@ -29,7 +29,7 @@ void qrtr_endpoint_unregister(struct qrtr_endpoint *ep);
>  
>  int qrtr_endpoint_post(struct qrtr_endpoint *ep, const void *data, size_t len);
>  
> -void qrtr_ns_init(struct work_struct *work);
> +void qrtr_ns_init(void);
>  
>  void qrtr_ns_remove(void);
>  
> -- 
> 2.24.0
> 
