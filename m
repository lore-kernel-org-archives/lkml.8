Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8B9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 20:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7A71206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 20:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZX/uvfC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgHRUiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 16:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgHRUiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 16:38:03 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCD4C061389;
        Tue, 18 Aug 2020 13:38:02 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id h21so16170995qtp.11;
        Tue, 18 Aug 2020 13:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qItOo82livW8QC37rDaz6rglqISGnPM5/lh3qaWaPNI=;
        b=ZX/uvfC0x3e8wOKIXLWjSOXYMp2QEmZLFDh97gzPJZCWOKYQUKn+R1lAV4ESFVh5sV
         KPPROIbWMowDLDHUCBDuZUcP39GRfHWEBh7KNllCa3KQV4WQutU22FSxTVpcR3qjxnMI
         B9lAs/uPJ64RdVrd4cNaxPVDco30koDXjcJ/Y2P3SXDNnPFVI3J6naaLyNqHA2hwX9et
         B4fo/wXbTM8LVDce0P37gr2wvLnNcjYiSSFe2uirjaAcrXeSP2max5+zS3PQG0Qz6gcu
         jokf89jonwVcuwOSwc5wg9uhwp7AH7+mlcE4EDunL9smIYKZ/FJyT0fverX04KNg//FR
         qrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qItOo82livW8QC37rDaz6rglqISGnPM5/lh3qaWaPNI=;
        b=K2/ZzaiwSYB3kvVHqSsxY2i8nl9haB1Raoa48htaAjp/E3rm1dBu2MXzMT/QKaGC/5
         eLfIdv424UaK3kk1UN1XGHtKZjvL1dNyeu7W1BW6EIE9gb+XcPoZQjLhvA7vjZLTamPx
         VF+Np/LrnCq4W9tGMp1Ocbp6kkvm9z1Uk6uyxFh2/ZrPlVADlboJcScnb7LxQCv6k+St
         ItXEzzlvhy/bDKYQjEHp8l9LIx7klVPP3yp0XkjQwF8vEM4xwqJWDn4tHPWJr1MmpXL0
         ViKdQpHJnaIENSDcWt/xZ5779ghQhnRwTqA4xzeTIzfjmL8Lhif797x4byHdtDT385Hg
         JbRw==
X-Gm-Message-State: AOAM533yKx2t9qsAE1GxbAeqg9GvZckdSvN0U02tphsqvQIAbfGig3wD
        Z6Ba5eS1MSQi3kkFTI5S27/5HCHbgxC7dw==
X-Google-Smtp-Source: ABdhPJzwhBwerDWFEP8tEmovT9GH2QM4AzKWy2B77z/LfntylA9XG8pPfxF/eR518aXYCiDQeLyQTQ==
X-Received: by 2002:ac8:4741:: with SMTP id k1mr19855889qtp.41.1597783082027;
        Tue, 18 Aug 2020 13:38:02 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id t8sm22575113qke.7.2020.08.18.13.38.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 13:38:01 -0700 (PDT)
Subject: Re: [RFC PATCH v2 0/3] mikroBUS driver for add-on boards
To:     Vaishnav M A <vaishnav@beagleboard.org>,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, johan@kernel.org,
        elder@kernel.org, Frank Rowand <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     robh@kernel.org, mchehab+huawei@kernel.org, davem@davemloft.net,
        jkridner@beagleboard.org, drew@beagleboard.org,
        robertcnelson@beagleboard.org, rajkovic@mikroe.com,
        chrisfriedt@gmail.com, zoran.stojsavljevic@gmail.com
References: <20200818124815.11029-1-vaishnav@beagleboard.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <d53f0014-db7c-902c-70c7-eacac41cc6ed@gmail.com>
Date:   Tue, 18 Aug 2020 15:38:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818124815.11029-1-vaishnav@beagleboard.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vaishnav,

+me +devicetree

Please add these two recipients to future versions.

I will comment more after reading the first version and v2.

-Frank


On 2020-08-18 07:48, Vaishnav M A wrote:
> Hi,
> 
> This Patch series is an update to the mikroBUS driver
> RFC v1 Patch : https://lkml.org/lkml/2020/7/24/518 .
> The mikrobus driver is updated to add mikrobus ports from device-tree
> overlays, the debug interfaces for adding mikrobus ports through sysFS
> is removed, and the driver considers the extended usage of mikrobus
> port pins from their standard purposes.
> 
> change log:
>         v2: support for adding mikroBUS ports from DT overlays,
>         remove debug sysFS interface for adding mikrobus ports,
>         consider extended pin usage/deviations from mikrobus standard
>         specifications,
>         use greybus CPort protocol enum instead of new protcol enums
>         Fix cases of wrong indendation, ignoring return values, freeing
>         allocated resources in case of errors and other style suggestions
>         in v1 review.
> 
> Vaishnav M A (3):
>   add mikrobus descriptors to greybus_manifest
>   mikroBUS driver for add-on boards on mikrobus ports
>   Add Device Tree Bindings for mikroBUS port
> 
>  .../bindings/misc/linux,mikrobus.txt          |  81 ++
>  MAINTAINERS                                   |   6 +
>  drivers/misc/Kconfig                          |   1 +
>  drivers/misc/Makefile                         |   1 +
>  drivers/misc/mikrobus/Kconfig                 |  16 +
>  drivers/misc/mikrobus/Makefile                |   7 +
>  drivers/misc/mikrobus/mikrobus_core.c         | 692 ++++++++++++++++++
>  drivers/misc/mikrobus/mikrobus_core.h         | 191 +++++
>  drivers/misc/mikrobus/mikrobus_manifest.c     | 444 +++++++++++
>  drivers/misc/mikrobus/mikrobus_manifest.h     |  21 +
>  drivers/misc/mikrobus/mikrobus_port.c         | 171 +++++
>  include/linux/greybus/greybus_manifest.h      |  47 ++
>  12 files changed, 1678 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/linux,mikrobus.txt
>  create mode 100644 drivers/misc/mikrobus/Kconfig
>  create mode 100644 drivers/misc/mikrobus/Makefile
>  create mode 100644 drivers/misc/mikrobus/mikrobus_core.c
>  create mode 100644 drivers/misc/mikrobus/mikrobus_core.h
>  create mode 100644 drivers/misc/mikrobus/mikrobus_manifest.c
>  create mode 100644 drivers/misc/mikrobus/mikrobus_manifest.h
>  create mode 100644 drivers/misc/mikrobus/mikrobus_port.c
> 

