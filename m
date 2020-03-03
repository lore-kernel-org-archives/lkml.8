Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E63C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 11:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AAA20857
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 11:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X9DQytk5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgCCLSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 06:18:01 -0500
Received: from mail-pf1-f169.google.com ([209.85.210.169]:37775 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgCCLSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 06:18:00 -0500
Received: by mail-pf1-f169.google.com with SMTP id p14so1309221pfn.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 03:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6LpPu+7mzHDbzzNZ3vNWrKJy3N6+UnYE5W0wfZ5TDvA=;
        b=X9DQytk52qZ6DQRmc5okitpNMgHqG6s8o4bhvGC/XRa0ECQDG91tyC0uTDPgvD5O1k
         AUuMxfLAJyrLqXfrAp5dKlhSuhJd+75XMDpEpOhrHrfJ3hNdoOJBM9SxQNB3jHDPbsD8
         DhiRPCC1dISZWIga0LihFWuRrO+DF9g8G3LAFp5NaoxJuVYG6DS7xohhSh+k7UWyF562
         YPqgCzzzuUmbeQKhJvCRRs0x4f4+fnOrjIpvEtN8uYJfnHqRy6MgFt55MQn41GYLpstR
         fMeTQE2yvj0EyS4Bx0uHfr0FdNMEMZDwY5XPTrtOrDQpG/auu4hOrJn2TkWWAD4aZ+Pr
         r/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6LpPu+7mzHDbzzNZ3vNWrKJy3N6+UnYE5W0wfZ5TDvA=;
        b=GR8X9p9sl6NbHzuBpta5X54Fox6Ccyly0kWxNJMg+0ZLeevIiw1++uB3Hu2KZDYAfM
         xanQ2WHB7W37chKkhJHpT+TPiK0xGuz0L6IDMIv4fLpqrhQG+LdF3HHwojOI1PUJvrNi
         n5mBnKW88nXLM1jk1lhncdpAmoOiNDuqzDkLxUWvc32tqkBnCeNDLsryuQlUh6xN4UCv
         JAGw5io/7FkdYu+KCQHyRXGOPRpSMOmaLwA0CmpyKdprTK/u6A4aCAGl5VIqws7HZDQz
         Xv815J3i07n96xQTClINrmFhOAeQ/D1vq7n22ne6OAW6zPaIGMDeRXehbE9GbkWCeKkQ
         POhA==
X-Gm-Message-State: ANhLgQ0lLjUmDM27d9+ysVWPv6H11d7cpXFIvPJrF0BMRGE9ZSlYN8q9
        QJJ0Kvc3lhnX0JyaSdoJkbwa12shkQ0=
X-Google-Smtp-Source: ADFU+vtX4ocvGPjD4lCipeCvf6Ndh/Qq0CPh8PdfYnJjc4X0n5KlKRfZpxjGrKkVvOS0v1sBH1rFJA==
X-Received: by 2002:a63:4103:: with SMTP id o3mr3271939pga.199.1583234279527;
        Tue, 03 Mar 2020 03:17:59 -0800 (PST)
Received: from localhost ([122.167.24.230])
        by smtp.gmail.com with ESMTPSA id d4sm2138730pjg.19.2020.03.03.03.17.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2020 03:17:58 -0800 (PST)
Date:   Tue, 3 Mar 2020 16:47:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 0/3] Convert i.MX6Q cpufreq to use nvmem API
Message-ID: <20200303111756.eikekt7vg2js7emw@vireshk-i7>
References: <1583201690-16068-1-git-send-email-peng.fan@nxp.com>
 <20200303054547.4wpnzmgnuo7jd2qa@vireshk-i7>
 <AM0PR04MB4481FDAD041F6476FFFC0F6788E40@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4481FDAD041F6476FFFC0F6788E40@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-03-20, 06:16, Peng Fan wrote:
> Hi Viresh,
> 
> > Subject: Re: [PATCH 0/3] Convert i.MX6Q cpufreq to use nvmem API
> > 
> > On 03-03-20, 10:14, peng.fan@nxp.com wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Use nvmem API is better compared with direclty accessing OCOTP registers.
> > > nvmem could handle OCOTP clk, defer probe.
> > >
> > > Patch 1/3 is dts changes to add nvmem related properties Patch 2/3 is
> > > a bug fix Patch 3/3 is convert to nvmem API
> > 
> > Should I apply patch 2 and 3 ? And you can take 1/3 via ARM Soc tree as this
> > shouldn't break anything.
> 
> Please take patch 2 and 3. Without patch 1, it just use legacy method,
> not break things.

Applied. Thanks.

-- 
viresh
