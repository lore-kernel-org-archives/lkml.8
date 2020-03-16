Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634D4C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 20:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3909920663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 20:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ho5A8cWk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732579AbgCPUbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 16:31:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43393 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732538AbgCPUbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 16:31:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id u12so10369412pgb.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 13:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jSCfrC5MVAMPvsu9dcDXiK9/v75uuFCpGC851+yHoL4=;
        b=Ho5A8cWkUYfvTKQPdBbUqDGnZNatk8dR3geecakaiYgWgs2iB75NRwMFkXjpF9UfyI
         44iHGvholdldIETNBdpz5nllteDz78DwJHlzrxGA6jCy8tfzoXPpc3ns1Kw/W12voUyV
         R1cMf81FQGaE0dbbXHdtAc4Ht3UOPMSiY9MhLNVHDMXhbmeg3aizad2/fQwBO0iXQruF
         icofb2Oaxa+srP2vHozKm3e2boqYtvfLuFWr4SybFNTOFJfytt+PUe4jFZrY/8cNNpB/
         RMoag02LTf+ogJ7Lr2RCvjpKdd8Z1Fls3xZzPO5SVt3OTDAhqrSrx6nLNFo2mmX0tZcf
         jyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jSCfrC5MVAMPvsu9dcDXiK9/v75uuFCpGC851+yHoL4=;
        b=sUNvsP1LvZsuNC4o6VNM3s7o+XZ+s+sDl+NRNM0BZZtQQRSJp/m2c7OT5J1UTMmi9Z
         ypHTGSg+IhdkvOFz6A+pWj6DqH8qyWob+K/WMNbtiCOGHEmRDGCNjW7tDFAPfbB+1WMX
         TcRoFAU7iWmS2I6AJXRyXgPXZZfkyuI+KgFrf+UZW2lgQVdOLtkusyA1PDivaWqR+YLa
         TQEG78UbBNpYeSEwFzoW0BN/EwTkc51dYl7L8Mb/w96k3ehHIGSURphXT3ebFDO0+bkl
         CqNsLdmBDU07+0UwlNWuvrV/pJ0UD9ir5rQfIHDPNS7cWHZQPlaNjiY0nLC1ETpDZUnP
         YH0Q==
X-Gm-Message-State: ANhLgQ2PldNPi2v5IVaOXVlYTwVkXF/aqLAxy06WXkK4tirydRqP3pJT
        E9JvmDe492LNU9f3G3dlPis9GQDcaOI62Px8llujLw==
X-Google-Smtp-Source: ADFU+vvdH3hGZiNHfp5iBR00/N+6sETjH64ZPyloW2OjEXctpOITNNnPDqaRsU+jDGfek6xVGRXod7j6HF3TvbF0BZY=
X-Received: by 2002:a63:dd06:: with SMTP id t6mr1491334pgg.384.1584390668326;
 Mon, 16 Mar 2020 13:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200316202125.15852-1-heidifahim@google.com> <20200316202125.15852-2-heidifahim@google.com>
In-Reply-To: <20200316202125.15852-2-heidifahim@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 16 Mar 2020 13:30:57 -0700
Message-ID: <CAFd5g478+t3b2rVOUJmD_wGH=cLYMYfbWeWogMB8C6LK7DotRA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] kunit: Run all KUnit tests through allyesconfig
To:     Heidi Fahim <heidifahim@google.com>
Cc:     shuah <shuah@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 1:21 PM Heidi Fahim <heidifahim@google.com> wrote:
>
> Implemented the functionality to run all KUnit tests through kunit_tool
> by specifying an --alltests flag, which builds UML with allyesconfig
> enabled, and consequently runs every KUnit test. A new function was
> added to kunit_kernel: make_allyesconfig.
> Firstly, if --alltests is specified, kunit.py triggers build_um_kernel
> which call make_allyesconfig. This function calls the make command,
> disables the broken configs that would otherwise prevent UML from
> building, then starts the kernel with all possible configurations
> enabled. All stdout and stderr is sent to test.log and read from there
> then fed through kunit_parser to parse the tests to the user. Also added
> a signal_handler in case kunit is interrupted while running.
> Tested: Run under different conditions such as testing with
> --raw_output, testing program interrupt then immediately running kunit
> again without --alltests and making sure to clean the console.
>
> Signed-off-by: Heidi Fahim <heidifahim@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
