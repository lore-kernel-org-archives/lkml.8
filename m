Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D221C5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47BDB2076C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584528883;
	bh=FDYLowK+05GnppB+zN6Px1rdHtm0JLwtsdZXuDh28hg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k1mMoma4UbheKVrTOPBr8LE4c0SZB5ZRu//8oiIxT/phzL3ZmAbBpmiiPCzywsMj6
	 w+hTIO4wK0mM2uAngHGQ6zLWHl/EzJjfl2TMQTCQR9TSKJk6GFLepyIuC6m4Q5XCXt
	 UfHC1yxbVTA8QvEJGicFd0tn+b6TF5IMlSIKUrvw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgCRKym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:54:42 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44275 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgCRKyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 06:54:41 -0400
Received: by mail-lj1-f193.google.com with SMTP id w4so11741317lji.11;
        Wed, 18 Mar 2020 03:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T97O9Vqu+LMQpVYQNFGe+EhBOmlbTf9zlZZvS0bG7A0=;
        b=bqGbAgylY1H2hVTamMQWUpf7ufomDfqBiAXXguioHXdW1rPm9Y6sw/cGHQNg6I+LCI
         tvQuEoy8ArI2VRKBsX3tNcDH6ZjjcDr4yXk9rL0Fukryr9Ez/c/O811Ndi+5MEwARmqP
         ZA11Xgj6wOZVGBIvs/djh8SxhKEJa0nvCxNPWM2p/3EiOxzySg9dQglpgmO2AdHVz3v4
         6gFF+hMJNUsb6adfyoYDmCEaFpr0EgN6CLq7i5LTDaPqu0xvDddifB1inzw4Fn66y7iz
         h3/FhJhDVpQoC/uuU/oQXHVOmtmbYOovRE6m7Gm39EnUe1cdpdmN4Lq3ob44B/2iahcm
         hk8A==
X-Gm-Message-State: ANhLgQ0bp+keWnKcl0NHi1IMl5YMkiD+NPY9G4MUX8ZbQFlUmlkgCAIT
        2WPjgK79klS+aDM2gH34t4HcFw5A
X-Google-Smtp-Source: ADFU+vt2B5iZWPf7Zuy33TvJyEKsrN5xS1exSGMr7mDLaY3R4e9VeMku1oq5uA8xSEINCv204LQJ4w==
X-Received: by 2002:a2e:7401:: with SMTP id p1mr2031473ljc.279.1584528879281;
        Wed, 18 Mar 2020 03:54:39 -0700 (PDT)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id a13sm4061368ljp.4.2020.03.18.03.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 03:54:38 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1jEWL6-0000bB-De; Wed, 18 Mar 2020 11:54:20 +0100
Date:   Wed, 18 Mar 2020 11:54:20 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH V5 1/1] USB: serial: f81232: Add generator for F81534A
Message-ID: <20200318105420.GA4905@localhost>
References: <20200312034431.21407-1-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312034431.21407-1-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 11:44:31AM +0800, Ji-Ze Hong (Peter Hong) wrote:
> The Fintek F81534A series is contains 1 HUB / 1 GPIO device / n UARTs,
> but the UART is default disable and need enabled by GPIO device(2c42/16F8).
> 
> When F81534A plug to host, we can only see 1 HUB & 1 GPIO device and we
> write 0x8fff to GPIO device register F81534A_CTRL_CMD_ENABLE_PORT(116h)
> to enable all available serial ports.
> 
> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>

Thanks, Ji-Ze. Now applied.

Johan
