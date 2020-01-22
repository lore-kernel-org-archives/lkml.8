Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1024BC33CAA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 01:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DADAD24677
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 01:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579657767;
	bh=9KnnXX2/OrzdO6JBb/OFQS7ivsYk0n5NvjqHRcGYyHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CjVpQq0gHEqF4Ie5cQeakko486ceKrQIg56Zyq+J1Grf/LNDwIY3ym9qdTbyFdeJo
	 EAOcZ+DqlSxX/BESGnAgULqqOkrHrPTckGZgvP3kib8WYR1lKVqsSesjBW2Umm0G85
	 fQ0VSIs/gAna/dIZx8UUXS3lQcMJHUhm3eEApBkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAVBt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 20:49:27 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46902 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgAVBt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 20:49:27 -0500
Received: by mail-ot1-f68.google.com with SMTP id r9so4827154otp.13;
        Tue, 21 Jan 2020 17:49:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0e4U3NGNiyOXEG5BTPMvy4a3ChT8Vgud6kZ1y3h76T8=;
        b=ImuCN6wTfseC10MhjhiwUEO1Ol2i+Gsa47caf140+M4gis1HZqfhg7b6KUyKNna1hV
         sRn4UJaOstYRk38oGikeVoY/tUhLrVY57OPKWoblj9/AhVVvQw+E/GXK0+U9xLjzuPFu
         iWb+oxdWkVJ4zQFTnhxR/zoHe/DB7P79rcqeSDqHJoT72+ehygtrGlP/PrHQJqjdcfc4
         VxF/9D94CYhh+cU122o1uQ0mi+ssnPCV7aIEGanjjy8xCOwJ7ZqeWEitkET2LI6pDDp5
         RixI4O8kWu059KRj+8usPRAMnC0dhba8mesH1eBCuPz5czgpeYfZEoddJsV+anw40ilb
         ofKw==
X-Gm-Message-State: APjAAAW3jFssxpKt2htRIflYLQGFIKIX7uCwXBzs0DZ8WpHAPBp/8Kgb
        0Ij7K9kBiutwRLSo232wjw==
X-Google-Smtp-Source: APXvYqyzugwvcOCdxnqZ6MUiET7xvXEGYjJRave83G82DjEs9h7Al45XqkIl1dKWyPMOnsVxk/NrNg==
X-Received: by 2002:a9d:de9:: with SMTP id 96mr5825817ots.222.1579657766225;
        Tue, 21 Jan 2020 17:49:26 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 15sm12537842oin.5.2020.01.21.17.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 17:49:25 -0800 (PST)
Received: (nullmailer pid 4806 invoked by uid 1000);
        Wed, 22 Jan 2020 01:49:24 -0000
Date:   Tue, 21 Jan 2020 19:49:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: imx8mn: add SNVS clock
Message-ID: <20200122014924.GA4746@bogus>
References: <20200116073718.4475-1-horia.geanta@nxp.com>
 <20200116073718.4475-2-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200116073718.4475-2-horia.geanta@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2020 09:37:16 +0200, =?UTF-8?q?Horia=20Geant=C4=83?= wrote:
> Add macro for the SNVS clock of the i.MX8MN.
> 
> Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
> ---
>  include/dt-bindings/clock/imx8mn-clock.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
