Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E269CA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ED8C206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvPtXVce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbgELSY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 14:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELSY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 14:24:27 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411B9C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 11:24:27 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id fu13so9793661pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 11:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=961n+c1GNdKybW/LN1o/gY81PgosmFKarrYkVTELyz0=;
        b=XvPtXVce9hWrdI43Y+WE6kKwegYPpDhAB0TYUjytWtQ8H+40ZBKNeQEIdrzxDHXgp2
         BmdelckH9+B03Q4A+NvgRndasYMC2h7QmvR/SaiK376HEqNIu0eaYn/BsBMHHkBzjM4E
         R1ycwYbprnORRAsSLgHVXXemFRaK+WtUOFPKQuOqxBiXENqLPcms1DqyNnpTAHM1Srz1
         P3vRgl5AHfpT6w4iQIgG2KI09jGQB58WbYwoT5vKz5HUiQnD0Tj0v/QJLnUR4bpZMU3g
         X2iau688t2P/YQHp9psbIFnBGJ0qZETpnALxkB//MaPfW2PC1Sgk9PQfzNArlahdQaok
         VApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=961n+c1GNdKybW/LN1o/gY81PgosmFKarrYkVTELyz0=;
        b=avf8jGzYmu6y3sWeg1/oCOM9qWfnXe+xo6+YpJEpothMEtkcHAvhCDe8jv3wUtrT/0
         8gcsP+gudeQLBWoesCA8gr9FC3XtIoA/9wN47JTD8ybjvFMpxIcRvgTzveHw4OTABApC
         IJWSnBeCaUXjYl8RXwVfA8KBjXXYda8O0CRQgysDIgHMM7HwDsNUnc/X1Ww+veEeLohT
         JuQbTgAJ31qoADbp4s+zi0g85Bhy/B/opQyVY3nAITtaDEznsillPKPWYqmDP55HbvMZ
         j/2HR7aXulTBsDKcY7iL/nmeBQU8AUgFbCXwSrhd9qpBxayx61FiKePE9C9jTmjcZyIx
         y+Qg==
X-Gm-Message-State: AOAM531hDKYetpAuby9i/bpFdm0qZjx7NahHJRhmT6P8SG57iDuT9aUg
        eR85uk0V0PdbvP7JODc9AvgcrTupUZ0=
X-Google-Smtp-Source: ABdhPJzBV66wJQuITxkCc0XHcDkJ+MrmmpVsrb+3Ib9E19QAyemN5majwIA4wxSM3ToNXfpT8vN5mg==
X-Received: by 2002:a17:90a:1983:: with SMTP id 3mr1518296pji.48.1589307865780;
        Tue, 12 May 2020 11:24:25 -0700 (PDT)
Received: from [10.0.0.131] (c-73-252-187-149.hsd1.ca.comcast.net. [73.252.187.149])
        by smtp.gmail.com with ESMTPSA id d20sm13062704pjs.12.2020.05.12.11.24.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 11:24:25 -0700 (PDT)
From:   "Raj J Putari (unidef)" <jmaharaj2013@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: request: get the linux compiler to compile using the c++ compiler
Message-Id: <A3FC49BE-ECB6-4087-B51B-9E751BA5DBCC@gmail.com>
Date:   Tue, 12 May 2020 11:24:12 -0700
To:     LKML <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I tried changing the make file to compile with c++, it compiled (this =
was freebsd though), but wouldn=E2=80=99t boot. Couldn=E2=80=99t figure =
out how to debug, but I estimated the bzimage was corrupt

Anyone want to volunteer and figure it out? Maybe get it working so we =
can have smart pointers, classes, and templates, along with the c++ =
feature set? Just for those who want it, maybe we can fork linux (cinx?)=
