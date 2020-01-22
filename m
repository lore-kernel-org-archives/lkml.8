Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0178BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDBAA2087E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgAVNxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:53:43 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41138 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgAVNxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:53:42 -0500
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1iuGRx-0002s9-2p
        for linux-kernel@vger.kernel.org; Wed, 22 Jan 2020 13:53:41 +0000
Received: by mail-wr1-f71.google.com with SMTP id z15so3102620wrw.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 05:53:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y5yptEkyrRbLvaccFMnqXZIPixdorHXoMP06yHQ05yU=;
        b=JQ6u3NfijHOzOzq+COuYX9QDNhK1AY44nGw5bDtsVCo+otoYpM6bOYud9lKDXqCXKt
         Y5yzexrRqX8S9pDNJl0JGm6yXJ6xEFYEjSwjZobzQ0yQQynCZPVTP0I5maAAq5vb9r51
         A5iiy8YnAflAq3Jym6I9KcXHLeMEVG6yyd46vLA9CNd51UXFwAAU1un06dR9C4pXSqaC
         /Tjaa6fg29Gjnxn5dnJ39VExLK51/eXbUJjsT0iCVbYfCEnRRLt7e55uDpJNcH4GGbIQ
         47e20eXNuWdWiITD7umTqZyw3KbUtOZqeQrEpaUY/bgGhuYZpRtstZKaVqhF+MBTDQvc
         vmwQ==
X-Gm-Message-State: APjAAAXCQrUeNupFMaV1kvsG5JDnRiqPE4kGFSoQR773GsmrNGyFcTLN
        TBR/z5Oh08AL0TZSGaaPMu/8fPAIsIf/pkaI8gqj9Bwxzbcu4otEjuiofE0p9Nlrj/WtUhrCMH8
        dMUH0Mv9IJLZGpr8+NKl8IMWJvOo4w5xL+Nztm3eYG0KqWNqc/znSEp5o1A==
X-Received: by 2002:adf:dd52:: with SMTP id u18mr11211159wrm.131.1579701220684;
        Wed, 22 Jan 2020 05:53:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqxUz0jEsW9sXwSOEu5jc3NKfKm1f1tvIJ9U/ntW4xNZK1uUAUiFRkDLwRNPZVtygguuP3RUeVsEGMygtLGzUH8=
X-Received: by 2002:adf:dd52:: with SMTP id u18mr11211144wrm.131.1579701220513;
 Wed, 22 Jan 2020 05:53:40 -0800 (PST)
MIME-Version: 1.0
References: <20200117175626.56358-1-andriy.shevchenko@linux.intel.com>
 <a4a30d2e-b7eb-0f2e-933d-97f5bb006428@canonical.com> <20200122133850.GK32742@smile.fi.intel.com>
In-Reply-To: <20200122133850.GK32742@smile.fi.intel.com>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Wed, 22 Jan 2020 10:53:04 -0300
Message-ID: <CAHD1Q_z73kxvBM_Es7NJj+5j6DMYbh-tr6PJRv6Z7DDAzd7g8w@mail.gmail.com>
Subject: Re: [PATCH v1 1/8] rtc: cmos: Use shared IRQ only for Microsoft
 Surface 3
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-rtc@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 10:39 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> [...]
> Thank you for testing!
>
> (Un)fortunately I dug a bit into the history of the patches and into the ACPI
> tables of MS Surface 3. I have another (better) solution which I will send
> separately from this series.
>

OK, if possible, loop me in and I can test that too.
Appreciate your effort on this!
Thanks,


Guilherme
