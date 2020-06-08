Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBA1C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3B17206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTnOMmB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbgFHLcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 07:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729310AbgFHLcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 07:32:10 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00285C08C5C2;
        Mon,  8 Jun 2020 04:32:09 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q11so17017522wrp.3;
        Mon, 08 Jun 2020 04:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xSWNJpoj9Q+cfvAowlT8L7DGalgysWzhUfSm0eMm4Aw=;
        b=YTnOMmB4tb7Dp7ULkcGrEQ2H44bPw8oI8UxeG8wLRrUOFOX9HKqGiFjpA/+2yyikWg
         TYOAL5M7vN2hsz83LGl5LjLejxt2SDIQED5YjCaeZSRfy6ePf9Rg+2ToMG9xszGpujSr
         7hX8fQU3sC74EfkKhAk1TEt+a17drdUeJLH3eYolZX5+1X9XUSgLbZG7quo+lVq4y8yH
         zIP/6831snBBGt/NRhjDe28Nu28zeDxb4jDCoiML9lrYQAdf/4HgcuyMKjX4UxwTb2ba
         HThTClKTaH1kCL2k02fzgWTmHn9nTrwDG2JUB1l30ZRmO6xk/G+S4UIwjOjaOdChobvR
         sZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xSWNJpoj9Q+cfvAowlT8L7DGalgysWzhUfSm0eMm4Aw=;
        b=ESAqD2R7b6GAqaGQ4nYZD9tdbFpltQ2ww6f5QhQuxzWZC/MshALOlA9kRd9vqdIAKt
         9Yu1ep3DyxzyVx6XTDT+CP4oIAo7sFZ/beMZK5K+XlMS4aEcHvk5FxQHPQ9nI3WOTnDY
         6qBM4v2hudodEkwRQtq8vitZ+ACKQOOeIagquqz4oTuiPZzxS2rUta6Y8li+Oob5ylP9
         tWviA/K/1dPfXBLYMPEPxs9ML4sibpEaRRpGgrkFpTjcjRP6oC1xIgF5abZEbBGcgERd
         zjCrEBlDkymZKbyMhdoTlEYFL4YrPMV33Ymj5/HWMfWtOaq3SwVEVzUykGI2CM3OM9vt
         jL2g==
X-Gm-Message-State: AOAM532JnmTveD2Suu+ei0kNOWsAjOwWZMxXE4C/Gwwe0c0+WEV31TS9
        rzhTtbk5HA9tS6C3YwZF7C8D5LHIZec=
X-Google-Smtp-Source: ABdhPJyWGnzhV7sCJMthf69WCiVGa54Q3A42fYSaonFUzQL96QhkraYk/+8MtD6KJiYecm6g6HARww==
X-Received: by 2002:adf:ff82:: with SMTP id j2mr22242545wrr.375.1591615928639;
        Mon, 08 Jun 2020 04:32:08 -0700 (PDT)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id d17sm25584732wrg.75.2020.06.08.04.32.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2020 04:32:08 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: [PATCH] soc: amlogic: meson-gx-socinfo: Fix S905X3 ID
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <7d58e4db-2893-3675-eb93-ea14c3534b5b@baylibre.com>
Date:   Mon, 8 Jun 2020 15:32:03 +0400
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <ACA41DA3-88A4-4141-AEAD-C056C9834B6B@gmail.com>
References: <20200604044808.30995-1-christianshewitt@gmail.com>
 <7d58e4db-2893-3675-eb93-ea14c3534b5b@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
X-Mailer: Apple Mail (2.3445.104.14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 8 Jun 2020, at 12:58 pm, Neil Armstrong <narmstrong@baylibre.com> =
wrote:
>=20
>> The current value is taken from Amlogic's 4.9 bsp kernel which =
appears
>> to use the wrong ID. For comparison, here's before/after:
>>=20
>> [    0.152237] soc soc0: Amlogic Meson SM1 (Unknown) Revision 2b:c =
(10:2) Detected
>> [    0.152463] soc soc0: Amlogic Meson SM1 (S905X3) Revision 2b:c =
(10:2) Detected
>=20
> For SM1 we have weird values, here are the one we gen on KernelCI:
> SEI610 (S905D3):
> Amlogic Meson SM1 (Unknown) Revision 2b:c (50:2)
>=20
> VIM3L (S905D3)
> Amlogic Meson SM1 (Unknown) Revision 2b:c (4:2)
>=20
> And you report now:
> Odroid-C4 (S905X4)
> Amlogic Meson SM1 (Unknown) Revision 2b:c (10:2)
>=20
> And at the time you reported:
> VIM3L (S905D3)
> Amlogic Meson SM1 (S905D3) Revision 2b:c (b0:2)
>=20
> So I'm quite lost here=E2=80=A6.

In [1] you added the SM1 SoC ID and S905X3 ID { "S905X3", 0x2b, 0x5, 0xf =
}
which matches the BSP kernel source.

In [2] I added a second S905X3 ID { "S905X3", 0x2b, 0xb0, 0xf2 } for =
VIM3L, but
this was a mistake (the chip is S905D3) so [3] corrected it to { =
"S905D3", 0x2b,
0xb0, 0xf0 } which matches my VIM3L board. If the VIM3L=E2=80=99s in =
KernelCI now show
"2b:c (4:2)=E2=80=9D it looks there has been a package change (silicon =
fixes?) and we
need to add another S905D3 package ID.

In the last week I helped three different users install LE on S905X3 =
Android
box devices, all of which declare "2b:c (10:2)=E2=80=9D as the SoC ID, =
which matches
the only S905X3 device I own (Odroid C4). So I assumed the BSP is wrong =
and
sent this fix patch.

If SEI610 is S905X3 (implied by the original SM1 submission from you) =
KernelCI
output shows the current ID is wrong (=E2=80=98Unknown=E2=80=99) so we =
probably need to fix it
with { "S905X3", 0x2b, 0x50, 0xf0 } then add new S905D3 (VIM3L) and =
S905X3 (as
per this patch) IDs.

If SEI610 is S905D3 (as stated in this thread) the fix in this patch is =
still
correct, but we also need to send a second patch to add two new S905D3 =
package
IDs (SEI610 + VIM3L).

I=E2=80=99ll ping you off-list to discuss.

Christian

[1] c9cc9bec36d0 ("soc: amlogic: meson-gx-socinfo: Add SM1 and S905X3 =
ID=E2=80=9D)
[2] 1d7c541b8a5b ("soc: amlogic: meson-gx-socinfo: Add S905X3 ID for =
VIM3L=E2=80=9D)
[3] fdfc6997bd08 ("soc: amlogic: meson-gx-socinfo: Fix S905D3 ID for =
VIM3L=E2=80=9D)


