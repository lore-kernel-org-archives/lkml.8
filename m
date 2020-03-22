Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9714DC4332E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 15:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ECAE20724
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 15:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d7DJJwA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgCVPOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 11:14:04 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55728 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgCVPOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 11:14:03 -0400
Received: by mail-pj1-f66.google.com with SMTP id mj6so4892699pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 08:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jU1tZN9SvriQuTPAY9v52hKU3vRtjkoA4roKYV/o0ys=;
        b=d7DJJwA+X2FK84QrpDwYCttb8rdd2e4lT8+Q5t70Gv2OgQB48UzwilKy9HxnqIx0u6
         Pw5Oc4gmv7sKIZukyv/OadTHJirAPW4rkMqZHFbHOgACPEw7NSmh3qZcMhkhuTUlmksz
         H9RtOhwhEi0o2YorU6S02Z6fTWGneSV7k9tLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jU1tZN9SvriQuTPAY9v52hKU3vRtjkoA4roKYV/o0ys=;
        b=aoEZsKaD3o7s4OTV9b/1xidTiLR/ZxIeomVb6ySmJqwZ9SbAwzlBWzQkMXtm9reIq1
         JHpvo8+T1RFIrfo2yokPmDloyX5JoNsRBjszr+zCewD7NPglwxg9WOayJFXOzZpSw/qn
         JOtPSs1oG/ixR4ba5SzhW2xatDztZnyb973YS00yOr5d+ADEAMdF3MZxZdKM33B1HMkY
         LA42PwyI1KIKmkI7hgL4fbmTSYgBLWKEo/I9uWozXrDoeJXrQeYSYDwCP9LraUXmX7PN
         klgvDD7xQL3vHlpMTgY/xCdeAI4BAIfB9BChw738hL9MDOcvdQiv0mNkc8w1twjKeGxl
         hylg==
X-Gm-Message-State: ANhLgQ0HVvVoPrXgvZ2dKMu2FxJ+Fmje2sPhkPwi5P6NsP4jvdtQGCtj
        6C32EftT/pZ81vUwRfVHFJ0ZRg==
X-Google-Smtp-Source: ADFU+vtbmF3l7sn6QV7hQukMIYQEHoGaYcXFfhI82JP1bexvWQg3p2JE0n4ekAuPsSplVisGoCrg4A==
X-Received: by 2002:a17:90a:3589:: with SMTP id r9mr20229184pjb.196.1584890042470;
        Sun, 22 Mar 2020 08:14:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i2sm10807108pfr.151.2020.03.22.08.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 08:14:00 -0700 (PDT)
Date:   Sun, 22 Mar 2020 08:13:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 11/11] mtd: new support oops logger based on pstore/blk
Message-ID: <202003220812.5728216E0@keescook>
References: <1581078355-19647-1-git-send-email-liaoweixiong@allwinnertech.com>
 <1581078355-19647-12-git-send-email-liaoweixiong@allwinnertech.com>
 <202003181149.90B22E24@keescook>
 <69b0133c-dfa3-2680-2a2e-473033750703@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69b0133c-dfa3-2680-2a2e-473033750703@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 22, 2020 at 09:51:19PM +0800, WeiXiong Liao wrote:
> The physical features of MTD device require that the user configurations
> must meet some requirements. For example the record size must be
> multiples of page size of MTD flash. It's really different to block device.
> If we make this device driver "invisible", we should have other way to
> limit user configurations. The dmesg pstore front-end is the most easiest
> one to fix to. There are still much work to do to support other front-ends.

I finally understand this now -- I was still thinking of things like
nvme which ultimately expose a block layer. MTD appear to genuinely be a
"non-block" device. But it is still considered a "storage" device, yes?

So perhaps "block storage device" and "non-block storage device"?

-- 
Kees Cook
