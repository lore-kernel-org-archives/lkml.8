Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	SUBJ_ALL_CAPS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BA4C33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9DF2067C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MczfDG7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgBASjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 13:39:55 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34963 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgBASjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 13:39:55 -0500
Received: by mail-ed1-f65.google.com with SMTP id f8so11535103edv.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 10:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=shZxHXCo/+rAmckA7J/Ey6QP2+YhGLEgDLAHvjT5u+A=;
        b=MczfDG7JR4EZ5tNwWmFzxH8xkT4Gxol7teLMaJZBjDXkMZ22TrZg/CdntLukCNNy32
         DxgkA3frPptmwHiSzKyYU+E1/CrKn01ipeKApiKUxV6X9ezBLIUaL1TvychncP+REW0M
         2sDHVNV7TSzxTqXPpOtWtB2Cpjf8WkPRUJqB9r2w3J1NteXuO6EFf2vCRR0b72mMEHuv
         3bvk1oNCf884BZnaykHI+n1+LOe08unkCW6vfuQe74/vuzob0C2lM3NwilwI7ee0BpeV
         ZElt7z3x1G5/rvxAifeXrmW2dbgOFjFzOj29m/YOL+qpajbaBcRKzT5LHPNyw6ZO/j4z
         g0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=shZxHXCo/+rAmckA7J/Ey6QP2+YhGLEgDLAHvjT5u+A=;
        b=DcZSma3QmbxAcIuD6UlFMFPCU5rSitKbo1e8JvHmObCjkk0c0kYbF5qjpoDB0rq7N8
         LlcP5QawgokRxhfe5IBCBU9KJ2cLGWVTZKD3Cu8tq5hWdUVNZvLlkDaBhtGTkFlOEvpu
         mDxl0v+kBNjTviDwrdpxQcgeeExci2VJfLOt9Zv5pp72pdwWsmV/P88mK9xC3MaKPgEh
         VuehrcsRMic486FB72/wJaFvR817w/p2RI+1eVARjCU9kGoVsPu+JH2Yhbmav5RgL0UN
         GWt+J52AuPr/Sow2sqT019Ai3J1SkhJG1h3GPQuQxsyYkT0leqaPq4GwsrBNFvZ7MOIP
         yj0g==
X-Gm-Message-State: APjAAAXbKpHdqqheZEV5KTtfZVkldFcaipuIFtuj116mQA3zOlmChBbj
        3kdwAiVzidIYoSS7XsFgzx5tk7ubM52b0lPcLh1lZw==
X-Google-Smtp-Source: APXvYqzr9k9sUjPdZzk/xBSVJvi9VcDZ4qnahqEsix6GlyhKhMN/tScOMmctqyz69QrUV/NRqlY/y5lKcm9+NcASIEs=
X-Received: by 2002:aa7:db4d:: with SMTP id n13mr5756914edt.25.1580582391224;
 Sat, 01 Feb 2020 10:39:51 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6402:1d06:0:0:0:0 with HTTP; Sat, 1 Feb 2020 10:39:50
 -0800 (PST)
Reply-To: mayacinemballo@gmail.com
From:   TERANGA GOLD CORPORATION <goldcorporationteranga@gmail.com>
Date:   Sat, 1 Feb 2020 19:39:50 +0100
Message-ID: <CADQt5TzmWSMj4R2Bz8EPP3JMuegpJ5Y0LsT3odQvzV_ZUw8ivw@mail.gmail.com>
Subject: TERANGA GOLD CORPORATION
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 TERANGA GOLD CORPORATION OUAGADOUGOU
 Burkina Faso Ouagadougou is One of the largest gold producing regions
in Africa.
 (A Symbol of Africa).



We are group of miners producing unrefined Gold in the form of dust,
Bars and Nuggets as well as raw uncut diamonds. We will like to use
this medium to inform you all, that we control the mines from which
these precious commodities are gotten. We are based in Monrovia,
Burkina Faso, Liberia and Freetown, Sierra Leone. Mino River Miners
Association is a Gold and Diamond-mining and exploration group. This
group has operations in Bu Liberia and Sierra Leone.


We deem it necessary to sell our products to genuine buyers and also
solicit the interest of international investors, who we can work with
continuously, in improving our mines and increasing our production
capacity, In this vain, we have asked our representative to secure us
the chance of meeting a very good and reliable buyer or investor, who
will be willing to meet us and discuss possible opportunity of buying
our products constantly and also help to improve our mines, as you
know that Liberia has a high quality gold of 22+ and even 24 carats in
quality, Also Burkina Faso have 92% pure gold (22k, the average
quality extracted by artisanal miners look forward to enter into a
long term business with buyers.


Burkina Faso represents a significant portion of the West African
Birimian greenstone belt exposure (approximately 22%).
https://www.terangagold.com/exploration/burkina-faso/default.aspx


Richard S. Young
President, CEO & Non-Independent Director
TERANGA GOLD CORPORATION.


CONTACT PERSON

Mayacine MBALLO
Senior Procurement Officer chez Teranga Gold Corporation (Ouagadougou)
EMAIL ADDRESS: mayacinemballo@gmail.com
Tel: +226 79 10 78 95


Jacob Ou=C3=A9draogo
Cost Accountant at Teranga Gold Corporation (Ouagadougou)


_____________________________________________________________________
           Teranga Gold Corporation. All rights reserved.
