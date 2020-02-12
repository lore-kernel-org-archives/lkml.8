Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8454AC35242
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 00:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50232206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 00:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="hAaKEW5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgBLAMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 19:12:22 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37314 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbgBLAMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 19:12:22 -0500
Received: by mail-pj1-f66.google.com with SMTP id m13so68569pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 16:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Pr1WOT/2gw7Ui+bqMEREVDpwEXR+a792WriIpzt4B7s=;
        b=hAaKEW5qHGtMe9K0r+9i4uWI4R3ZoMh+/psZvnhtmZTk8JOlUtnKNNqWB1Mirb283u
         tG7MUfH6JiABF4KWtCFqWV73gNqKtPEQKLHogaYe8okqGHgb41jbwJFPJwr3nCY+7Uu0
         T/koDrUYm446tI/FyX3ntJioWz/ASvkIV9/Aqins4Pg65CroAuLWyUqnU0z4/e+lzOGd
         H+tNqNK+H3oELg6622w0cA/vLZHwFQP4DADvL9QeLgEmFSa7g7ujy4w0ZORVsA3W9wdC
         1PX32M5zF1910+L6+bdy1KG8CFVS1lnzY4+mG1qBmljFTOZ+Xdg0gqx4CqnDL8Y7kDGy
         uoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Pr1WOT/2gw7Ui+bqMEREVDpwEXR+a792WriIpzt4B7s=;
        b=RdCRX+TnXvYishzVwV6VgxgArkHccPA1fyL0XRktkxpvVR8LlfJ5mUlD4dNNHtlcuy
         PrlmleZHw7B2l+F7LMgMHSlOrr+61aPM/KfJHNjxBAbhL4GIPiouohHzgbvJCX/ut5lC
         PAfN+nMsm2RnmmwYMDzJXAeRySS0Nm83/e/FPB0wnsIH6yUZrHgoExfbFj+s5FN4KJfR
         gzXm+x8j+WUsxHdUTEPb1Hh+yJ0+opPXzIMqWuUt2O+tjEYdXmGPeIugZAe3WRRLMidl
         jhtiQbV8GPS0O3GJGlpJj7+/cFEbRB6hlYWSSsB1UhVaJkZwfeWLHz0HHjQY+jLX/GaQ
         GwKw==
X-Gm-Message-State: APjAAAV0BAzWlk5vHJCl1E3XoXoLZp1qkJOlULh2Td7hKT/IcrGqI+Re
        1e3XT3MWJ5Q5v/U/HKBgOf45d2daTlE=
X-Google-Smtp-Source: APXvYqzfWf+52u5ptCvMmUlokh+ZnxotB+Jwjj8OIwwQjng66p5yI7RzfTPGOOK/x7Jm4L9EdIIjEQ==
X-Received: by 2002:a17:90a:db48:: with SMTP id u8mr6623427pjx.54.1581466341415;
        Tue, 11 Feb 2020 16:12:21 -0800 (PST)
Received: from ?IPv6:2600:1010:b06b:b0e7:939:1384:befb:d8c9? ([2600:1010:b06b:b0e7:939:1384:befb:d8c9])
        by smtp.gmail.com with ESMTPSA id r9sm5705115pfl.136.2020.02.11.16.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2020 16:12:20 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 46/62] x86/sev-es: Handle INVD Events
Date:   Tue, 11 Feb 2020 16:12:19 -0800
Message-Id: <EA510462-A43C-4F7E-BFE8-B212003B3627@amacapital.net>
References: <20200211135256.24617-47-joro@8bytes.org>
Cc:     x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Juergen Gross <JGross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Joerg Roedel <jroedel@suse.de>
In-Reply-To: <20200211135256.24617-47-joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 11, 2020, at 5:53 AM, Joerg Roedel <joro@8bytes.org> wrote:
>=20
> =EF=BB=BFFrom: Tom Lendacky <thomas.lendacky@amd.com>
>=20
> Implement a handler for #VC exceptions caused by INVD instructions.

Uh, what?  Surely the #VC code can have a catch-all OOPS path for things lik=
e this. Linux should never ever do INVD.=
