Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E91C7619D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 02:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207BC24656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 02:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hp///StS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgBTCaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 21:30:52 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40217 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbgBTCaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 21:30:52 -0500
Received: by mail-pg1-f193.google.com with SMTP id z7so1127072pgk.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 18:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=2xhrwQviTomzj/0fU6jHXjC8RaazAr+9nr9rIvva37U=;
        b=Hp///StSFNDmabhiBJZofs78699fSOAHSNe6zLrXA7M2hyLOxa3a0Ygi6HVn5lETmu
         /HoY2FjCYrlBjYcn9uvUP+uC43wI9zgb67Hknh2mVyjfTr5GGw3llqw8UNeOQhQhOMKS
         3//sWtboNU2F5iAQLTkzRMmiRTvJ3k/F9YU3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=2xhrwQviTomzj/0fU6jHXjC8RaazAr+9nr9rIvva37U=;
        b=H9P47/ZQYRbcDdBHnxNLdSrqRflZideUPtiMSVg1Hq7PqZnJUzxmiWmvKBtn8n7T63
         xYwSVH6EG61JZhntQk8FRFBIevGNs/z2YWmzdftQdbTzPSsgdsTLoRwDz9CvmZBWMviM
         vSRGkeMeeY+O4elHDPz9RCLuGHDGR/0vgnpSJ6g7ex0eTtUJeptSXF4RcA9Ia6Hp7ias
         Nmngfy7+vcFerLRzTJ8nXcnEAYYwBE0BL8rd+1DQq1QJY5P6UjNVpV1hh2pvZyVy2VaZ
         rU+N2ZP1SPQ2XruQ4iCDn3tFS5l3hqX0ooErP1Q9ezbkD9alPUGYlo03TPZcR2w8B1QK
         g3qw==
X-Gm-Message-State: APjAAAXVrhcpAvQXGrN4MK2Z5sIUl93pSg5+SZTjUKiSXLM/PuoybZ4I
        Rv5qXCZtIhj1YK+xUUe7/QnFQw==
X-Google-Smtp-Source: APXvYqyqR/j5YTlyk7mPPllz5VnOKlmRZem93IGnshNp2h/Zrxs8wbPD10c413ZLvO8K7rxkd709fg==
X-Received: by 2002:a63:e218:: with SMTP id q24mr4515412pgh.244.1582165851831;
        Wed, 19 Feb 2020 18:30:51 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b186sm389624pgc.46.2020.02.19.18.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 18:30:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1581932974-21654-3-git-send-email-akashast@codeaurora.org>
References: <1581932974-21654-1-git-send-email-akashast@codeaurora.org> <1581932974-21654-3-git-send-email-akashast@codeaurora.org>
Subject: Re: [PATCH 2/2] dt-bindings: spi: Add interconnect binding for QSPI
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgautam@codeaurora.org,
        rojay@codeaurora.org, skakit@codeaurora.org,
        Akash Asthana <akashast@codeaurora.org>
To:     Akash Asthana <akashast@codeaurora.org>, agross@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org
Date:   Wed, 19 Feb 2020 18:30:50 -0800
Message-ID: <158216585051.184098.12834695664812457422@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Akash Asthana (2020-02-17 01:49:34)
> Add documentation for the interconnect and interconnect-names
> properties for QSPI.
>=20
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
