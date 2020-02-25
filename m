Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF350C35E0C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F1E218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582653485;
	bh=LwXKWjZfFSdGikn7p8jWRZJOGinTNMobus6UKP/+6XE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VvwbJza3leAC+eE0+i/pZdWrrQTa95EGJAypOqpXjkjINLir8fRvHOHgXAJvgfXIP
	 1yQP7lakzmlVVDN1elVn7Z9hwRdjSRDxxeYhDV3qJ8S6Wp64TlpyIDyTKJUT22SJ5J
	 jmjE1O82AVOd+tKYYU4S+uaOGv2vxdtcaagHPMjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731056AbgBYR6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:58:04 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38317 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729536AbgBYR6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:58:03 -0500
Received: by mail-ot1-f67.google.com with SMTP id z9so360582oth.5;
        Tue, 25 Feb 2020 09:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8GwTzddrLu/wUsAnxNvKRBKqXG7o72fYpPpNcXHr19E=;
        b=ajEf5W+nHQHEO30OrPLyA821vOv2CcsaxFZZBl5NxHZ0Ev/z3kVmuA+D3B/S19N55F
         hqIOj+kiRpdZ8gB9fSe6NrYEauxmffxc77LT5Au/6MqeXEpHiSfIN66HRYQYeurHhsP+
         zkKwFjSGwLLwZe9u/aRjU58SiMW+MyHnbwwfTFlrYnRpiJyHCLJ7I/6cI+gNCQ4DHMka
         TJUNFr8ZnwHJuduI+QqZL40K03u6I+pkM1fq085as7x0IKTO6Qv2umZ5grgW0vUm0nU+
         gPyqZfM0Sb9sJV3JSKn+Ax0sUNa2ZZ/um0xTmc7ERhyKs+I7Joa5/GSFDQu/t6F4KWNv
         HdPg==
X-Gm-Message-State: APjAAAVm/P9sCpbY2wK/RVEUYq64ZnyJQgkhiUg15KZNyL/TWFpnbalM
        h/tPB79YrBJIx6oyf1uW2g==
X-Google-Smtp-Source: APXvYqyqIOkEAcKJ5+8hpXXY05G/dthQhXpUBc1sdkuly+kiJaFQmDzPObHMm6N2y/PtDm8/3bQW7Q==
X-Received: by 2002:a05:6830:1149:: with SMTP id x9mr46722989otq.156.1582653483133;
        Tue, 25 Feb 2020 09:58:03 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y6sm5900513oti.44.2020.02.25.09.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 09:58:02 -0800 (PST)
Received: (nullmailer pid 7499 invoked by uid 1000);
        Tue, 25 Feb 2020 17:58:01 -0000
Date:   Tue, 25 Feb 2020 11:58:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, leonard.crestez@nxp.com,
        daniel.baluta@nxp.com, aisheng.dong@nxp.com, peng.fan@nxp.com,
        fugang.duan@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: Re: [PATCH 3/7] bindings: clock: imx8qxp: add
 "fsl,imx8qxp-lpcg-cm40" compatible string
Message-ID: <20200225175801.GA7447@bogus>
References: <1581909561-12058-1-git-send-email-qiangqing.zhang@nxp.com>
 <1581909561-12058-4-git-send-email-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581909561-12058-4-git-send-email-qiangqing.zhang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 11:19:17 +0800, Joakim Zhang wrote:
> Add "fsl,imx8qxp-lpcg-cm40" compatible string.
> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  Documentation/devicetree/bindings/clock/imx8qxp-lpcg.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
