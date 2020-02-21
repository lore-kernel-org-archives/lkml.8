Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A011BC35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 18:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727AE20722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 18:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582308152;
	bh=2iqlsfCU2xzdvKiMFOxsJfrFK/WCC507GMR5NHeQJ/g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=W7f5qqgv5xxyPd38ywip3srdKgjbxWAJlxNkRSTaVr/mEHs7Nk4YNZVxVoHiJubex
	 lbgMwtoYYOtM4Z0GegZuZT5btSO358wqiEle5CVUnQRjFn5JqJxb57Ej/PvhF9m0X5
	 WoiimD7rcc15+zSjQUOiPkWoIXAJOUooVYnEdRzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgBUSCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 13:02:31 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34572 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729438AbgBUSC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 13:02:29 -0500
Received: by mail-lj1-f196.google.com with SMTP id x7so3128475ljc.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 10:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AG9TJKXnTeZzyHlgjHVGK5jDlYOlKtakbHNOYDpKW9E=;
        b=LtuqrNdxX93Kes55M7/V1nmMoOY/Am5rxlDligc40iz1+GEbCmeM7TuGyB0tTEcegn
         UDZiT2MxYZWEAGTE0LovTMS1jqfnFBkPD3xPTU2e30E6da/H/mQbYfgawXH18yg2Guvv
         l3o1EYHUu3z2m8B4mLtmpaElvsWWhBoRfpDBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AG9TJKXnTeZzyHlgjHVGK5jDlYOlKtakbHNOYDpKW9E=;
        b=ujGNF4QJHiWRm2VfZoIMoQg4z3ekG2R59Pjy7Q8SqVhOr7SBIDG0EZuO1xtrGHpfaO
         BOX+LrourEToDlbtz46p21ZbdMaMBUQcYt8bihkMTtvcloYNrDE+Nd4XO7kJ5r6gwOck
         U4uVoDaZyTatO7/n3bEzsYZkuVq7lWz7PPhjLrb0VcpjWVxIIyH5Lt/SocF7P7BCjN7z
         a1yl4nEHfpyhRE36vW9FpW3dRxnY+vp/iJq75Ele0+xZeEo/CXUE5f2S4w3UrsgcmweT
         wVkrL8a79hP+dy1/HKhXrvgBzO8ri7YPTvKbyZ/7dzJFiYsJ99xYQr8ldCV/zn9CMF0u
         Qkcg==
X-Gm-Message-State: APjAAAUtBtwxLV1pinLWFCRCXVcJnh2dm6kqADLsiKWcHVjFIpsn1KJB
        xTHoyeaVlIzY49o205MTLKrkPgCq52o=
X-Google-Smtp-Source: APXvYqzpSWDn5exKyPOp/4CXthYCIyrEXEUF6B3wvC08LHu1eh9vnuwEywfLOLbPbIyC7d4bM8ePeg==
X-Received: by 2002:a2e:5056:: with SMTP id v22mr22759110ljd.164.1582308146152;
        Fri, 21 Feb 2020 10:02:26 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id w1sm2009937lfe.96.2020.02.21.10.02.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 10:02:24 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id r19so3113941ljg.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 10:02:24 -0800 (PST)
X-Received: by 2002:a2e:580c:: with SMTP id m12mr22906965ljb.150.1582308144004;
 Fri, 21 Feb 2020 10:02:24 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgqwiBLGvwTqU2kJEPNmafPpPe_K0XgBU-A58M+mkwpgQ@mail.gmail.com>
 <158197497594.2449.9692451182044632969@skylake-alporthouse-com>
 <10791544.HYfhKnFLvn@kreacher> <4974198.mf5Me8BlfX@kreacher>
 <158227678951.3099.15076882205129643027@skylake-alporthouse-com> <CAJZ5v0h07em8y5bXcnUTBcjie8pCttADK9QX9W_cB0WQRcDfGQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0h07em8y5bXcnUTBcjie8pCttADK9QX9W_cB0WQRcDfGQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Feb 2020 10:02:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wihfx015Rr-nrMmBtN--357cFRbS4rjXeKXvEfB=GYT5g@mail.gmail.com>
Message-ID: <CAHk-=wihfx015Rr-nrMmBtN--357cFRbS4rjXeKXvEfB=GYT5g@mail.gmail.com>
Subject: Re: Linux 5.6-rc2
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 2:54 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> Please pick up this patch directly if you can.

Done. Added Chris' tested-by too.

            Linus
