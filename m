Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DC3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CA3820814
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590720525;
	bh=lTs9pvq7l065S1A5oy9Mu+/D2VOo7F6HWtxdl7x2110=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iCA8EAMAX2C+/F45sETbttxNZtlongC6FENuhBi4o2KcM+OGBSiPzZw9RjHyrF/f5
	 YTm4n2y0adtKQrxMau/lv69S+ztXyUzRXfaiCHaa9wMXyowD1yOmeyjt/BtQ4mCynn
	 PEdqtHKk9MePtoJSl42MZBihwqrGj0JRKt2xs/4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406860AbgE2Csn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 22:48:43 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43920 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406751AbgE2Csl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 22:48:41 -0400
Received: by mail-io1-f65.google.com with SMTP id h10so749404iob.10;
        Thu, 28 May 2020 19:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2wOEByp6gUNrdU4BNTFl/gH2hxnA8FPWu2vBLdfhtz0=;
        b=GMg0Xsg5Il3Pb/gXIR+Y/FBt7eKQB1fZj0VfurI89bQ8uWTDVNYqorGCzNmqqULNgF
         SwgjazO1jKhc9EMx1YMnIRINuBbMy+G7mEjkk5syC/QnHX3SaNDAA4nkUlhnifzdgpaA
         4KrCCqs46QU2Zhoza6Bzbc/7R9xRrVXKFL7kKXZ3KH9S0MfuQV8RFTXYKSMj9t1gBmwY
         crG0NAf0/i3W0kZn8fCm9etqtrE7dunR87tXrKM3OVs/VtW6md8ILrKWt1N4q4mD8iI7
         H1cT6qzJQvPQ/4r89MxpUkuR815DhMSvX7MTNMwTxrlhLpdx+uVTYaNCzrYDJh+PYHwH
         A6wQ==
X-Gm-Message-State: AOAM5305t7Q5TLsTjaerliEbuVkTJllmUC0BT3y0PL+vNQsRRsAWQ/RK
        SSo27U+2s8aFCakly8XF0w==
X-Google-Smtp-Source: ABdhPJwaVZjnnoKp02/s1snipVdrssvc2EzQh9OAl8zSZDlr1KNefyoQMWawpPD/c9VL/HI8n3SvZA==
X-Received: by 2002:a02:a80f:: with SMTP id f15mr5497366jaj.90.1590720520911;
        Thu, 28 May 2020 19:48:40 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id o15sm4084317ilg.46.2020.05.28.19.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 19:48:40 -0700 (PDT)
Received: (nullmailer pid 1171117 invoked by uid 1000);
        Fri, 29 May 2020 02:48:39 -0000
Date:   Thu, 28 May 2020 20:48:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shc_work@mail.ru, s.hauer@pengutronix.de, shawnguo@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, festevam@gmail.com,
        linux-clk@vger.kernel.org, kernel@pengutronix.de,
        Linux-imx@nxp.com, s.trumtrar@pengutronix.de,
        mturquette@baylibre.com, sboyd@kernel.org
Subject: Re: [PATCH 3/9] dt-bindings: clock: Convert i.MX31 clock to
 json-schema
Message-ID: <20200529024839.GA1170982@bogus>
References: <1590650879-18288-1-git-send-email-Anson.Huang@nxp.com>
 <1590650879-18288-4-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590650879-18288-4-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 15:27:53 +0800, Anson Huang wrote:
> Convert the i.MX31 clock binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/clock/imx31-clock.txt      |  90 ----------------
>  .../devicetree/bindings/clock/imx31-clock.yaml     | 118 +++++++++++++++++++++
>  2 files changed, 118 insertions(+), 90 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/imx31-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/imx31-clock.yaml
> 

Applied, thanks!
