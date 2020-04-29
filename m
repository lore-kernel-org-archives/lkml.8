Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4E3C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 21:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 642FC2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 21:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588195713;
	bh=oxBMqJyj8yMfGgCq0Djn4Gf9/JD/uFFlvQgBzSZb/pU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V8UzM4ufE4DTsCWh66/zhimAofcu1RElaCGGx9/pEAAH4NkZzYDJVqXwMl1it9sxn
	 EnjnqtDg63YcxIqaauQ8x3E/aix/CGt2il6IGGziYIgl5gMXbMPjloNTLjrKo9fTjh
	 4BUwjprR8gQzw0zypnj88LPKJ5d4b+2IMNmH5vBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgD2V2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 17:28:32 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:45438 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgD2V2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 17:28:31 -0400
Received: by mail-oo1-f66.google.com with SMTP id 190so772721ooa.12;
        Wed, 29 Apr 2020 14:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HTRWOj0KdaKd2TGYE7Fq7HlZd+8gEmeN4MPCIvIIZtM=;
        b=QRhyanSBjfuyWZ2qSWIOYDAzzUWfqE7pS6iRFptRYuW4b0iwcY9YwRCBo5qTyEnYsI
         MGISnnX4rjKtDaAT5sWp8BC3hRJ7FMlTd6qO5vbTHWcA38RB5dqzLDjnll6pxf1/u7Ug
         eL6O1jQiyVfwCwp4d5iyCP7hAY34c5KS0XZkpWYe7zAng9uAqOZkZevsj0Re8F31RU4R
         q7aB/L0dhwiKnYiTdhLH4liwJncIFwJ3iLgZTjnc9+3XnFwWWlRlA53v3R/o+cJFb1wV
         GByxk59z9cGgBaZ2bmnfYvN5TRg4WNEDZQd1XXaSJ0Okl4rrEI1Y181veiSK2YB2pGN1
         QnJg==
X-Gm-Message-State: AGi0PuZGNfwC/g7TZdbVaZeBshyvB2+iTUQUGeLSYJySnm0zFbPOkfgB
        nahb9QQ3OJuEi0/5dsSHyw==
X-Google-Smtp-Source: APiQypJyegtm8yIG1VEh3Jf2qqLfj1DhUVFSbT8aPGwmC9oX3vWOIOoFvfsiT7wmfOLODUTkdJ9lwQ==
X-Received: by 2002:a4a:7346:: with SMTP id e6mr36162oof.89.1588195710445;
        Wed, 29 Apr 2020 14:28:30 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b6sm678593otp.31.2020.04.29.14.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 14:28:29 -0700 (PDT)
Received: (nullmailer pid 28791 invoked by uid 1000);
        Wed, 29 Apr 2020 21:28:29 -0000
Date:   Wed, 29 Apr 2020 16:28:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V3 1/5] dt-bindings: clock: Convert i.MX6Q clock to
 json-schema
Message-ID: <20200429212829.GB23326@bogus>
References: <1587084091-5941-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587084091-5941-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 08:41:27AM +0800, Anson Huang wrote:
> Convert the i.MX6Q clock binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V2:
> 	- Force 'interrupts' minItem/maxItem to 2.
> ---
>  .../devicetree/bindings/clock/imx6q-clock.txt      | 41 -------------
>  .../devicetree/bindings/clock/imx6q-clock.yaml     | 67 ++++++++++++++++++++++
>  2 files changed, 67 insertions(+), 41 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/imx6q-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/imx6q-clock.yaml


> diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.yaml b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> new file mode 100644
> index 0000000..0daf789
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: GPL-2.0

If NXP is the only author on these, please dual license:

(GPL-2.0-only OR BSD-2-Clause)
