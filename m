Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8F2C4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 03:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5A02075E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 03:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3qa7GWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgCTDFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 23:05:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45199 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCTDFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 23:05:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id m15so2331403pgv.12;
        Thu, 19 Mar 2020 20:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AetbBZq6fH3L1TSV0zp8Vgu0DgkKl6UrkrvBBlKDDog=;
        b=X3qa7GWP7/MLQDcD0kMqRXOybiYDYjsblYHrK1ylLZByadrIGnRFFSW/ZaGPPWrPp4
         5XelvX8qMVz6c8zezkaMmhsaM/boJmXDTrTsXDGBcycGq68qoCgC2G1qgyyho3xGNkGp
         +kULm9o47KLudBUhr/7jRf95RCBgWGrgMA9xqDtw6OhNYRpdqiGoODTVHCPlMRwHhRTG
         X1GQJVnxnIUEt92OwumZojxSKLwFyfssFUbqXLJEjY5ulweas8l8cEwH2IQT8IBHjH41
         pVMtkz/5DRiSuwFqc8G8CnHkU7fh/eT4gmco3WKFONZUwmvWFeVAhA3xY+zfHKO0zqnt
         8TCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AetbBZq6fH3L1TSV0zp8Vgu0DgkKl6UrkrvBBlKDDog=;
        b=q8tShp05SjoeGpWUzPozVZ2aOFCCEAV+A59gBhqrd2uYJdbZfOur5VJwB3VOmuxBpB
         5voiWv6cm+NrEIMBn8o/efKIbRQPtZEYrtelVSb9rlGIpHY0hPOCTNfC3SG3qGiZg5+3
         d7w/6hCY3Ao8OFbc2m04u11zYlx5V/uv2YfUbRMVfVUfPDV20ufG+tSD3tXeEXKqErca
         GStPieEFc9h7c9/qmkFJ9GfI67t+xLN9QxRsB8+MpmUdHNBOCm+Y69d38igqm7jkBilE
         0MY1GNGFwDy6vqO2gPlV8okJT6r7JvSoH7edvEhH7uuT+pDoNXUYJ31YtDgd4okW5l2C
         bsCQ==
X-Gm-Message-State: ANhLgQ2dVwPrD8cADtDA8Hbbhs7U0cYQRRGNuee8rShhOh8vsLAJ14hp
        MhF5De3tYnsliCdG6qXT8XU=
X-Google-Smtp-Source: ADFU+vtx5K5X6TOjjrU/pgCvP2+Rz06GRkgR3bOHnCWbJjIq77NHdpFMDTQzO7GETDz0S9Xj1qxKKw==
X-Received: by 2002:aa7:8f03:: with SMTP id x3mr7538783pfr.40.1584673547029;
        Thu, 19 Mar 2020 20:05:47 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d23sm3726170pfq.210.2020.03.19.20.05.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Mar 2020 20:05:46 -0700 (PDT)
Date:   Thu, 19 Mar 2020 20:05:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Grant Peltier <grantpeltier93@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        adam.vaughn.xh@renesas.com
Subject: Re: [PATCH v2 2/2] docs: hwmon: Update documentation for isl68137
 pmbus driver
Message-ID: <20200320030545.GA3260@roeck-us.net>
References: <cover.1584568073.git.grantpeltier93@gmail.com>
 <619d5d430b80fbf33a7e19e9910a0cf049203f59.1584568073.git.grantpeltier93@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <619d5d430b80fbf33a7e19e9910a0cf049203f59.1584568073.git.grantpeltier93@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 10:50:18AM -0500, Grant Peltier wrote:
> Update documentation to include reference information for newly
> supported 2nd generation Renesas digital multiphase voltage regulators.
> Also update branding from Intersil to Renesas.
> 
> Signed-off-by: Grant Peltier <grantpeltier93@gmail.com>

Generating htmldocs results in:

/home/groeck/src/linux-staging/Documentation/hwmon/isl68137.rst:499: WARNING: Malformed table.
Text in column margin in table line 25.

Please fix and resubmit.

Thanks,
Guenter
