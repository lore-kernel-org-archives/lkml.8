Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3E7C3404B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034D62067D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQ/FPSt5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgBRUPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:15:08 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:51971 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgBRUPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:15:07 -0500
Received: by mail-wm1-f49.google.com with SMTP id t23so4096632wmi.1;
        Tue, 18 Feb 2020 12:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=0x0/HJiEHIniNToQWMEKzmP1pNeyrj9mArFmMB3/6oE=;
        b=cQ/FPSt5OIRzl1p9b3GlWHZLZF3ES6cfsrm+xOf8SoJjHGH4TWiN/h6mdpR+y492h0
         f/MUwDUSpVtDzXeZwwMOEKO8UrrR0pTIY1CHnL6j20GNRsM2JvOF3371F/OmXNrIptn3
         CiHlLJUYwuCpSwyJq/jSi499b4/V37S1I5ydkRiLEUWQSbU5Z68aCcD4+9nDTCVxBxKJ
         UOcTxcejqStBTxt+Lwze3KmqkYGmpOilVJP4OuozkAvgSgCRhplfwQcyf4/oiw1ZxLOu
         zCBYeE5HNED5Nenn0EL8S6YrJ54SKUjtozg12xrLhgdfaI5kWDiw0tVWH1niZ9jk0SHC
         Jx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=0x0/HJiEHIniNToQWMEKzmP1pNeyrj9mArFmMB3/6oE=;
        b=PNauAWQbaxcGp7slQseJDSuC0DZphSTlIERXD5sPI+05NBzQmPRslsBWbtEjCBt1Ao
         Oa2UzXHOcVcXY8FfymB+j+4e6PUemaQ9I2kNr4NstIayLzpT5gDUzLGqogDrHOThJE5V
         TGCk/kbNBgvCs669aq1qcood3nhehjSHvgUP7DzWFZjxel+BGCOqzT7OyCOkPzIdRlOc
         m8kwMAzd4CIFdlImb6Gnqkd37I4FoaIdlG/e3dA4dcwpSL6EEoDKgNBeVjX30onauIuF
         R28Rw9Fsrd8VY6hXd4orMacr2QlB3gp+60SOA38hvNl18d0TtCLEL4oQXM68LrPn1ald
         9Okw==
X-Gm-Message-State: APjAAAWNUlLZMJtL7DlJkJrDxcErqF0FyYbzd9wIRCDjawPbNppVccnz
        Yng8KbAr+wB+Ar/KRBmVVNk=
X-Google-Smtp-Source: APXvYqxaKM2I2yMNbfTnkgC7Ma2W+KQe6RNJr+dtwL3UO48sj8LWbrvhSS1fDhoq9yK7xMRlItjpyA==
X-Received: by 2002:a1c:66d6:: with SMTP id a205mr4898203wmc.10.1582056905203;
        Tue, 18 Feb 2020 12:15:05 -0800 (PST)
Received: from felia ([2001:16b8:38a9:1a00:819d:444c:ffbc:5dca])
        by smtp.gmail.com with ESMTPSA id v5sm8114572wrv.86.2020.02.18.12.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 12:15:04 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Tue, 18 Feb 2020 21:14:53 +0100 (CET)
X-X-Sender: lukas@felia
To:     "Luck, Tony" <tony.luck@intel.com>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Anatoly Pugachev <matorola@gmail.com>, Pat Gefre <pfg@sgi.com>,
        Christoph Hellwig <hch@lst.de>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tty/serial: cleanup after ioc*_serial driver removal
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F57B7D6@ORSMSX115.amr.corp.intel.com>
Message-ID: <alpine.DEB.2.21.2002182112520.3368@felia>
References: <20200217081558.10266-1-lukas.bulwahn@gmail.com> <CADxRZqwGBi=4A224mG0cPgONdNitnvi3LFD_KQckxdYSXzgBGg@mail.gmail.com> <alpine.DEB.2.21.2002170950390.11007@felia> <3908561D78D1C84285E8C5FCA982C28F7F57B7D6@ORSMSX115.amr.corp.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Feb 2020, Luck, Tony wrote:

> > I do not know if there are more ia64 serial drivers, but the MAINTAINERS 
> > entry and commit message suggested there is not another serial driver.
> 
> Lukas,
> 
> There aren't any other ia64 specific serial drivers. But ia64 does use generic
> serial drivers (e.g. my test machine has a couple of serial ports attached to 16550A
> devices)
> 
> I think some notes in that documentation file still apply. Please don't delete.
> 

I provided a PATCH v2 that does not delete the documentation, which 
already was reviewed by Christoph Hellwig.

Please pick and apply that PATCH v2.

Lukas 
