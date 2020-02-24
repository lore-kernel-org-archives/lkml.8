Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFE7C3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D329B20828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p3UPv9wX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgBXK2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 05:28:51 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34597 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgBXK2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 05:28:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id z15so1389067wrl.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 02:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=KMPnkJHWUfv64LFSfP4fyt8cJYWqnbRpg/kfAvL/C/M=;
        b=p3UPv9wXDKa/zvJmaLOgm2r0iGwbiZactXaGFM2+rZFueN9GJy/lKofjB9is6SeqVd
         0OOcIULiRdCCH2SZgaSCXksmRMejxV84fLNKKNxywnQQhBu21wuDMGsXr5Kf5y8AcyxC
         vQZ+VsnF00UZ/dq2b9uucbl2mH5FwDOTz/p233b92CZnE2oN38JS9wPDa//GCvQmGeX0
         m7IHn5sadf440TR6pwLkxOJfgvfJywYyooEbCieN1iuXLNiQj4rrdNZzDOIiVFSIueWy
         6i2mGacRB5xdsALMXq3e+23AscHkQculqsKvwutCPxOqdfDjdBI0g0hF0vnY7hnEyGz7
         OIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KMPnkJHWUfv64LFSfP4fyt8cJYWqnbRpg/kfAvL/C/M=;
        b=mPntaeB2lxm3a7b5lRMUOY7h+Nx442bJa6d+bXIgJsC58EZsvw2gkDZqlIU9Umgrfa
         G1SuHvoOpWpyxfnUdPdXNnOq7T2jQ6PVpLH7S31b3ARGczXBerNBYA0/2SipyUI5aIHw
         zvCQZ067j/kGdO5mwCU//r8RYSXEunNOUwPIXC+Pz5LFIosYBp8hJOhKrDxNdgsvZcn1
         tnIM69V/4pBn3ENwzDyYh4Cjnb668jXxNtiglhKSKYrIVmrYqjpTA0ITPKQEHa/zIdLq
         M6lq12qZpwmqz04kEMxIVzY6OFMdbhy7vK+HKYPoOSadOdWx3Sej3Zej6WARtcTZ78i7
         +kCw==
X-Gm-Message-State: APjAAAWj2cWvGkeMvsjx1OxQN/csKPczFRncGPTMCXaG7iF+OnHbHCf/
        hO9spKHqqYLo8QgZm74QDifBfTGgtPk=
X-Google-Smtp-Source: APXvYqzyXxvkxAFV1/I3Loj+ifSBd7pMSXCWdhZ5ZxVo9LutuFailMKd2HG80leMKei52My3s21jQQ==
X-Received: by 2002:adf:ed8c:: with SMTP id c12mr63626369wro.231.1582540128816;
        Mon, 24 Feb 2020 02:28:48 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id z14sm1066680wru.31.2020.02.24.02.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 02:28:48 -0800 (PST)
Date:   Mon, 24 Feb 2020 10:29:19 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH RESEND] mfd: cros_ec: Check DT node for usbpd-notify add
Message-ID: <20200224102919.GO3494@dell>
References: <20200210190623.18543-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200210190623.18543-1-pmalani@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2020, Prashant Malani wrote:

> Add a check to ensure there is indeed an EC device tree entry before
> adding the cros-usbpd-notify device. This covers configs where both
> CONFIG_ACPI and CONFIG_OF are defined, but the EC device is defined
> using device tree and not in ACPI.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Fixes: 4602dce0361e ("mfd: cros_ec: Add cros-usbpd-notify subdevice")
> ---
> 
> This patch was originally part 3/4 of a series for the Chrome OS EC
> USBPD notify driver:
>  https://patchwork.kernel.org/patch/11351271/
> 
> Resending this patch since the dependent components have been merged
> into the upstream master tree or an immutable staging branch:
> - Patches 1/4 and 4/4 of the original series have been included in
>   the platform/chrome maintainer's immutable staging branch:
>       https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git/log/?h=ib-chrome-platform-power-supply-cros-usbpd-notify
> - Patch 2/4 has been merged to the mainline kernel as
>   commit 4602dce0361ebc67b9bfbed9338eee588e3c7e7e.
> 
> Changes in RESEND:
> - No changes.
> 
> Changes in v8:
> - Patch first introduced in v8 of the series.
> 
>  drivers/mfd/cros_ec_dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
