Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF585C35670
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 08:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925E7206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 08:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdG6a5mH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgBWIIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 03:08:15 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40942 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgBWIIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 03:08:15 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so2702856plp.7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 00:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yQk1zoKwLwWh37FUIzsv76O7XQbXKjoLP/vDR2rhq5Q=;
        b=qdG6a5mHwcoXs7RTbNh6kmru0Q2NPXRRviemSasiC2o4e01Hef3Y3Me1I5bBzz1/uO
         56D5yukc3T4KdRu9TgG5a+36a7OugpCRC8yaRLHrThJeDdfQ4rZhUvHfOKlo2SPRQ84F
         JWa885rbJ3z6h5PodG2mj4Kr9ZehV5e0X8fufvVJUyuiY2xNfrTnM/kQS086qlseDDlD
         jvk+qTi3wR7HpW9u8nNCE7EUhsQgVXElj0GG2TvQ3e1AdNp+rpXnq3q7pGx8/CxBEVyW
         AgMqJ6YTI6x4EhJ3yWiyAjGbrChD6TiAFG8XrawPeskkAEcUp/HkXJr5S1YSbA0ti1f1
         1j0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yQk1zoKwLwWh37FUIzsv76O7XQbXKjoLP/vDR2rhq5Q=;
        b=SEOrf2EkNtIx+qo4O78smV6JmOkraURLlCha5KUirhY9PVglyckr+7fzeQuWy11ZTJ
         L6F3xZSuQc+5Lm82FGNJDOltnAxPdhvafyHr7i3EBMXu912WEs5JqtzkALLrPmxjg5W6
         uEzJ51l0hQ5siTJmEuGccth9bqmjlnmFRiTXBQjjz+F/DrEFGAzQdqxFnnZMsHCm80SC
         sQ7NGPvEjHE6c3EXLHnuFDNZ23ym5mm5EU2KqT0a1ROs5ivvIt/Hm3lraKJOzwj2C3d3
         2hS61AT5Gx/88HMiB5xF8z3R2+Rx3AERUL7cijteY3LdbAVqOK0/XCby55XFucu4AB3O
         T62Q==
X-Gm-Message-State: APjAAAVCzwlPwdBniwLGlsGRoi9N0+m44soPojW4YFcV/nPyTJRJxs5L
        RIu9j7hIfIcZegSJS0ybFI0=
X-Google-Smtp-Source: APXvYqwiTY7/62F2gOlXwYs8R/dmD9HUIJ8WtLe7LvqVjiyj6uzrb8cWFT7iegdF6/n7O6JgYId+mw==
X-Received: by 2002:a17:902:426:: with SMTP id 35mr44071795ple.176.1582445294652;
        Sun, 23 Feb 2020 00:08:14 -0800 (PST)
Received: from gmail.com ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id t8sm7876146pjy.20.2020.02.23.00.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 00:08:13 -0800 (PST)
Date:   Sun, 23 Feb 2020 00:08:11 -0800
From:   Andrei Vagin <avagin@gmail.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH 0/5] arm64: add the time namespace support
Message-ID: <20200223080811.GA349924@gmail.com>
References: <20200204175913.74901-1-avagin@gmail.com>
 <2d982452-12e5-5c0b-6e4c-adadb7a34616@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <2d982452-12e5-5c0b-6e4c-adadb7a34616@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 12:40:47PM +0000, Vincenzo Frascino wrote:
> Hi Andrei,
> 
> On 04/02/2020 17:59, Andrei Vagin wrote:
> > Allocate the time namespace page among VVAR pages and add the logic
> > to handle faults on VVAR properly.
> > 
> > If a task belongs to a time namespace then the VVAR page which contains
> > the system wide VDSO data is replaced with a namespace specific page
> > which has the same layout as the VVAR page. That page has vdso_data->seq
> > set to 1 to enforce the slow path and vdso_data->clock_mode set to
> > VCLOCK_TIMENS to enforce the time namespace handling path.
> > 
> > The extra check in the case that vdso_data->seq is odd, e.g. a concurrent
> > update of the VDSO data is in progress, is not really affecting regular
> > tasks which are not part of a time namespace as the task is spin waiting
> > for the update to finish and vdso_data->seq to become even again.
> > 
> > If a time namespace task hits that code path, it invokes the corresponding
> > time getter function which retrieves the real VVAR page, reads host time
> > and then adds the offset for the requested clock which is stored in the
> > special VVAR page.
> > 
> 
> Thank you for adding the arm64 support of time namespaces. Overall it looks fine
> to me even if I have few comments. I will test it in the coming days just to
> make sure I did not miss something major. I will keep you updated on the results.

Thank you for the review. All comments look reasonable and I will
address them and post a second version.

Thanks,
Andrei
