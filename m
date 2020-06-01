Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D02AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 22:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 578ED2073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 22:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELVkIWJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgFAWwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 18:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgFAWwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 18:52:16 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C321EC05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 15:52:15 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r9so1054209wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 15:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=XqDBJ7HNiDNNZGgyc51P8jxOS0QlkoJQOsugIayCn2o=;
        b=ELVkIWJpEFw9xOmhKTe40+CQr52T8e002hs+DErPwBDW+3iF9V8Y3ipknzBK5wMKqc
         jsfBAO5fLEEyi1qZxmSTQ40Vt+dKtInPcbU6HonGJy21VUUYwuLYI/rhl2+cpWGctMV0
         juLiRzHe6AhAFSxQ9jw6NoBehIcrC9YjcpRYRznWqYe6dhS0ncnrieHrYO9Yl6WCIKzo
         V+xtoYA1QDbS7zwMKkgKBGweIU5D0jo2JSxsMe63HY+0R7+/SinWo5W5M7Q+NIuIWpxI
         o/YUPUCz4/7gUtkt0YczKR1tPVg0xkvUawc0mgKeSHmwstIUt7w5pTw9+6ltvT3tnkKb
         L62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XqDBJ7HNiDNNZGgyc51P8jxOS0QlkoJQOsugIayCn2o=;
        b=Te15xM21o9l1/BtdlQGr9sLSGcsUNyid1caFgYcn8BdgN/H1eM/Rr00pz1iICGA2cO
         R6Nx9K8yeT456ZaU25Rzws/3fqe9jm6EjPDdnGEX91K3lYNVREGNPDNUsGDOh+E/mI+F
         ELzgoHSGir32RlYnibsMJOmWAA2hy65VtnrLoyIuKOBTJcbo3LNrNwHoUdXVt5XFwTYN
         lrGgKTFgbtqQZNh991JBvSKFJSy/uobjpfzzd8s9WHVxDIc9fxfm0soQFICuS0z3II1z
         v5A1cMo5Xh00lWfzMIFD9unY1faBo6RXORhNT5gwSkEyR0Vi0+TD+YfNbfuNwk/0Zg90
         PEiw==
X-Gm-Message-State: AOAM533B1rTyJtbSwA8CikK+LmlPm/LsiUaEsQraGFPEz0pc8+6ColBu
        Qqj/bErmrZKSfXqXhFCpNvjY4WpPtJwbTciW1sT7Tegk2KM=
X-Google-Smtp-Source: ABdhPJwqIJwmyDmwRvdGfp7P5QdvXpQEr6+3jnUxclTGB3SIHmf8J/3PeA7clHOujCF21kc/2weyF846NaDWIjGUgk0=
X-Received: by 2002:a7b:c951:: with SMTP id i17mr1303533wml.44.1591051933716;
 Mon, 01 Jun 2020 15:52:13 -0700 (PDT)
MIME-Version: 1.0
From:   Philip Schwartz <philquadra@gmail.com>
Date:   Mon, 1 Jun 2020 17:52:00 -0500
Message-ID: <CACYmiSfM00o864c5pxxWEQNZsgFMkNwJePCGvae6P7o31NXMyw@mail.gmail.com>
Subject: Bug in your kernel since version 5.2
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is my sixth attempt to send a bug report.

The first time you didn't like my email address.
The second time you didn't like that I copied the whole url.
The third time you didn't like that the part of the url that I copied
looked a bit like a url.
The fourth time you complained that "The message contains HTML
subpart,therefore we consider it SPAM"
The fifth time you didn't like ?????????.

Kernel dot org Bugzilla       I D equals  204003


I look forward to your email rejection message.
