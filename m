Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8187CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FBBD207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fYzn15gZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgFRTqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 15:46:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56242 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727978AbgFRTqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 15:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592509599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vAJJkV1IQ09o/T5NpQxIqWNeq9rz8g5RYhknLPVSVoA=;
        b=fYzn15gZgRg8nB8jQUpnTa2fUOiBfOX52xDdzx/9HEMX7y7O3UBlbXNTvtvDjOH0Q6RJei
        SRK19wvJ91531whOPxyALb30RVnIKG7ip0VnjjmvrtksvUqk0zkzH9yKXhMwpK9dF9bV2P
        GTqIZ98iB5PHd3wZHrwtPpBUBOJ+sIA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-gU6d5uNEMHmJe5jQc5Iy0Q-1; Thu, 18 Jun 2020 15:46:37 -0400
X-MC-Unique: gU6d5uNEMHmJe5jQc5Iy0Q-1
Received: by mail-qv1-f69.google.com with SMTP id 59so4906722qvb.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 12:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vAJJkV1IQ09o/T5NpQxIqWNeq9rz8g5RYhknLPVSVoA=;
        b=JeQ6rV/VizRTCSfGN0f/EbcNMQW6OwCdQhzbqzfj/YPBoDg6+q90ItwHAVKElCv2OK
         MIJJHVQYMUeienbwHX0sL2EA8/18wte2ppsgwj+Ig9epc7y3TqGsxY/N2cxaP++RQgwf
         nebt72nL+1Ke+A0Q4NBJcgkA2wu9/8fxx1W+zry12B1YDC5rT5pYO4Jn0XtuYoYv3Jr2
         kBv3p0HfTpwHNIFgkcAU2K5JnN9C/xd/Nya5t9R48tZWcaTkVQ5M1BCsba0XapA7Wwzf
         FrqpJ8wwuk0sXW0dBex1e/g2RISFPrV+M8RMYcGf1vnRGwgFkIPh65vFymGmRs8Z/9TD
         +c4w==
X-Gm-Message-State: AOAM5310bocaDHhBwKadjTtm2pvyNhXFbDAaW5f2QGS2Sm/ShG16u1m6
        tJ77OnCIqxT8T5PmYefmxbFgqjM6pDoL7f/84367i3J1zOBSfVp+AN9JmuOd164xpfRseRs3yjh
        eQOP+ASMossJSdqpY5vOa4j45
X-Received: by 2002:a05:6214:10cb:: with SMTP id r11mr5368151qvs.203.1592509597359;
        Thu, 18 Jun 2020 12:46:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywrhpNMyyljoqo7iW7mbIgk7aOwkBo1Yv2CLk4QFD+fxF07OsuL8qL4aJVuxLYbOl5aNqUVw==
X-Received: by 2002:a05:6214:10cb:: with SMTP id r11mr5368140qvs.203.1592509597113;
        Thu, 18 Jun 2020 12:46:37 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l188sm3605655qke.127.2020.06.18.12.46.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 12:46:36 -0700 (PDT)
Subject: Re: [PATCH v2 0/6] add regmap & indirect access support
To:     Xu Yilun <yilun.xu@intel.com>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     hao.wu@intel.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com
References: <1592493910-30473-1-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <1f684924-44a3-ca47-5f69-3401a6389e38@redhat.com>
Date:   Thu, 18 Jun 2020 12:46:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1592493910-30473-1-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set looks good to me.

Reviewed-by : Tom Rix <trix@redhat.com>

Tom

On 6/18/20 8:25 AM, Xu Yilun wrote:
> Updated the regmap & indirect access support for spi-altera.
>
> Patch #1, #2, #3 is already applied.
> Patch #4 is an 1:1 replacement of of readl/writel with regmap_read/write
> Patch #5 introduced a new platform_device_id to support indirect access as
>          a sub device.
> Patch #6 is a minor fix.
>
> Main changes from v1: 
>  - Split the v1 Patch #4 to v2 Patch #4 & #5. 
>  - Add a new platform_device_id to support indirect access.
>  - Removed the v1 Patch #5. Now we use driver name string directly.
>  - Add Yilun's Signed-off-by for Patch #6
>
>
> Matthew Gerlach (1):
>   spi: altera: fix size mismatch on 64 bit processors
>
> Xu Yilun (5):
>   spi: altera: add 32bit data width transfer support.
>   spi: altera: add SPI core parameters support via platform data.
>   spi: altera: add platform data for slave information.
>   spi: altera: use regmap-mmio instead of direct mmio register access
>   spi: altera: support indirect access to the registers
>
>  drivers/spi/Kconfig        |   1 +
>  drivers/spi/spi-altera.c   | 177 +++++++++++++++++++++++++++++++++++++++------
>  include/linux/spi/altera.h |  29 ++++++++
>  3 files changed, 183 insertions(+), 24 deletions(-)
>  create mode 100644 include/linux/spi/altera.h
>

