Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3373C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C49207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkx8vWMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbgAMON4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 09:13:56 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45357 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgAMONz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 09:13:55 -0500
Received: by mail-pg1-f195.google.com with SMTP id b9so4750920pgk.12;
        Mon, 13 Jan 2020 06:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ooESu2KqswDRqhNGZc0aoUVn4IzIIWFGmVQ0kvWO+jw=;
        b=hkx8vWMRlro4Ki5q3YwW6PB+OaNyEzwgR66eyk492de6U5Z0SQrS8wi274M62He5Xd
         /rzZSL1EOvZt18JqoFsRTGT9XXT2enP0uH4S/MPdzCEah4AQ29qfdJ5Wx9ftpW/UVd4w
         ftFQo6cCv8Sxo3DVxItSZQjXf0Ew81fbAHvlnk4VQnTeN5AaSFuuykPbf5qhsAwA7aGJ
         jTNQ6d0WBnxFDONSRiIr5OGvbg9ha5AOwtVsdLblOILP/y6RhEIxex7JJYiCsZdi2ZWR
         HGHkTkC4OmKeB2NSj2md65of8uBIoq34GphcHUXNWOoP/UYpQsmAKP6gupBsEMlo58aB
         P88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ooESu2KqswDRqhNGZc0aoUVn4IzIIWFGmVQ0kvWO+jw=;
        b=YNhGu/ntYOlgqCjiseP35Oum1HLtbRmKZwVDa4mrZi3XDSx+fFlsHjwym32QqLEGoU
         B7Yn9OGv72TxSdYI5bGHVi0m9Xt5tmBjIAfQo/fJ1sHr+P4ORz0zY96XUDqvvMh9w74u
         KEtLhiobvIuKyh9j/90oWyA58TS+dXoC3F1NSLeJAtX1XPAXsxCO6ZkZ2LNaGg6FQm/t
         gwdCuPMQKv3n9pyiioJf31JPMwKDyPRcxG54YIbjAHk6Info/zqgck4qtlyGDwNDizKU
         g8KFX04QJS0OUeJKzNz0fN/iY588h6bv3M9ZFXOWHJwbE5Vbj6zj3fIln7Cur4icgUB0
         U6Lg==
X-Gm-Message-State: APjAAAUv5j9dVmtfLKmIn9rn6ePK5sz0QzAtm3q4UasApNi9MLFw0GWs
        NQLCrCI78Xv//kCCApXeayOEPalAGsL66G1RrmA=
X-Google-Smtp-Source: APXvYqzjq/UL2Gsb+iJDoh4NHQbGxkdFVfAxm66SGFl00o/UfspyC4st0WU2mo6xH1Gh1qF6T2p2ZS2kMLPAZO6yQLg=
X-Received: by 2002:a63:3d8e:: with SMTP id k136mr20754113pga.4.1578924834953;
 Mon, 13 Jan 2020 06:13:54 -0800 (PST)
MIME-Version: 1.0
References: <20200112121849.7056-1-vadimp@mellanox.com> <20200112121849.7056-6-vadimp@mellanox.com>
In-Reply-To: <20200112121849.7056-6-vadimp@mellanox.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 13 Jan 2020 16:13:46 +0200
Message-ID: <CAHp75VdTfZHFNrMq4pAVFY6OZWHDXMnEwa4pqWcG2v05MWVzvA@mail.gmail.com>
Subject: Re: [PATCH platform-next v2 05/10] Documentation/ABI: Add new
 attribute for mlxreg-io sysfs interfaces
To:     Vadim Pasternak <vadimp@mellanox.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2020 at 2:19 PM Vadim Pasternak <vadimp@mellanox.com> wrote:
>
> Add documentation for the new attributes for:
> - Exposing reset causes types asserted by: platform reset, SoC reset,
>   AC power failure, software power off request.
> - Setting and removing system VPD (EEPROM) hardware write protection.
> - Voltage regulator devices configuration update status and firmware
>   version.
> - Setting PCIe ASIC reset to disable or enable state during PCIe root
>   complex reset.
> - System static topology identification, like system's static I2C
>   topology, number and type of FPGA devices within the system and so on.
>

Same comments as per previous patch (style related)

-- 
With Best Regards,
Andy Shevchenko
