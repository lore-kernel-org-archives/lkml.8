Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68FCC352A4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE88021775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UDJWWrKm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgBFTWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:22:46 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46472 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgBFTWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 14:22:45 -0500
Received: by mail-pg1-f194.google.com with SMTP id z124so3212725pgb.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 11:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:cc:to:from:user-agent:date;
        bh=77zEgP4+kvjzTDiKwzePB4Pg1qZYvQ9rh1jBzop1Cfo=;
        b=UDJWWrKmyAku8utbdUF/Ir+N8v/ND76ypMceKgDu7fS4zXsNrq+sw4xiy6otRjvqNn
         +ttDwYybEZg2A7GqfJwbjc3aV4UiF67/sYc9c/93Oy3JDYmIE5yKua4ATLykNnIjQh4k
         81KgxcGBkJ3hKV6ws5TtT7IUmIpU437MTbHJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:cc:to:from
         :user-agent:date;
        bh=77zEgP4+kvjzTDiKwzePB4Pg1qZYvQ9rh1jBzop1Cfo=;
        b=D8XBLAe1298Uca9attNvfIuWMQM6k/dNT3Zusy5+hPwy8/d1r+/w/anosNwm0KGiEA
         I7lIq8cMWsfHqQzUd0kb46hyOouYfEkFeprilihQVKOhKXNKko+YG584MYnvzQEi9jRC
         Wg1jiwetpd9bD+XyyNEYu+OM2ManLuD2kye2TDnfORqYIburGZZLKWz+5jmXIadBu/Gr
         d1qSLlPWI/2gjjwc92nGnYmfOJE1k0mdseiJkr8/baenmfMrt0IlWcurAcfGrsQ0Xgt2
         YHDLAgZDs0w4TXnbUwWUi0px9sCUl/dJgU/5w1jF7Nnxn9vuo7p90nqqsHboNODs2gEo
         dy3w==
X-Gm-Message-State: APjAAAX89Ppwo40U5xVMLIFTy812xu6ve8+0YWvQOCVGiamIjNM2YR0P
        a2wVudR+1VKTGgW/etAjMfSV8Q==
X-Google-Smtp-Source: APXvYqx15GV6iXPlg6VEgBbt5XLtoCLhj9G1kgJ4mJJ+PUEVWX9tF8+ZXmb7/HjMq5ZD3BXw5H8Yng==
X-Received: by 2002:a63:1f54:: with SMTP id q20mr5053928pgm.400.1581016965253;
        Thu, 06 Feb 2020 11:22:45 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id e1sm171231pfl.98.2020.02.06.11.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 11:22:44 -0800 (PST)
Message-ID: <5e3c6784.1c69fb81.34ded.0a42@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200205203818.4679-1-jarkko.sakkinen@linux.intel.com>
References: <20200205203818.4679-1-jarkko.sakkinen@linux.intel.com>
Subject: Re: [PATCH] tpm: Revert tpm_tis_spi_mod.ko to tpm_tis_spi.ko.
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andrey Pronin <apronin@chromium.org>, stable@vger.kernel.org,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Thu, 06 Feb 2020 11:22:44 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jarkko Sakkinen (2020-02-05 12:38:18)
> Revert tpm_tis_spi_mod.ko back to tpm_tis_spi.ko as the rename could break
> the build script. This can be achieved by renaming tpm_tis_spi.c as

Do you mean userspace scripts?

> tpm_tis_spi_main.c. Then tpm_tis_spi-y can be used inside the makefile.
>=20
> Cc: Andrey Pronin <apronin@chromium.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: stable@vger.kernel.org
> Fixes: 797c0113c9a4 ("tpm: tpm_tis_spi: Support cr50 devices")
> Reported-by: Alexander Steffen <Alexander.Steffen@infineon.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

