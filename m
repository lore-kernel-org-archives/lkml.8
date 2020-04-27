Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE66C5519A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 09:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C68C20656
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 09:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcfjzbQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgD0JTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 05:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgD0JTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 05:19:16 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AA3C0610D5;
        Mon, 27 Apr 2020 02:19:16 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a21so16773944ljb.9;
        Mon, 27 Apr 2020 02:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zyuVBjsIdXGQVFMeD0f1H4bcoGzMBUz/1lgvMwBIesE=;
        b=ZcfjzbQ287TzP0v7Ah3Qa2k4sl+wT8u1fI5J3pzj09Y5kBp8mQXmVu6yoKuefxeu7/
         8s4ICvjxj8inmFVeK4MwVqI7MNHmuHI3P7pk6ePpBK2QUm5wfVHMfRRjhPa9nZpXJ9tI
         MNjSmDq6clfxrjem4wqjUFt2zFk+Mn+aXPue5w+gR2HKXeP1+RxVVlJ9x+pxEwDwwXuF
         USljfBXancQjWeV0p/Nxaau22YUbVkmGSQqNZnB413FP2mrTnmbYwMu3RtOSzHbMs4bL
         LqD3MNSIoOYlNIXKbrgG1Fay/fmXrh3j5OEHRjyXzejsGfz8IIW40n98KxOhRa6ejltq
         dFJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zyuVBjsIdXGQVFMeD0f1H4bcoGzMBUz/1lgvMwBIesE=;
        b=jnNpjwi1WBNtVwsza8W1ygl/vJ0Gum6AjmzVyDxF05pBMBNGpf2flz40uiSSsXqgpQ
         nG5TgdiShxNwPsMHWCKMiK7IR1Fe5oyZ9MbYNBT5kss/nYPaowNVUYCP0bIRX2+eoRxd
         fojWLILuWelIm+5iHDA9IA2XA3CSFrq9PCL5bC40dLU0//pDUDFjVIVn9uOTB4FDEj8E
         FQok239KsCK36s5fBj1kWfMPwBvwY4dJo+OXWGnoRx708zLPzWJoFjI12E463V6IZu5e
         XenFZJy7wSl87khRjM1upMYZck6ldYAELtdDI459wI4voVmxuDN03YxwWg6v9dxMUq+l
         vDfg==
X-Gm-Message-State: AGi0PuaamUhR7irZplshchSkWrIlVnsMo/yMxni+KxMN3YjWJuEC25qd
        FLj+Z0iwhjasQT2y1PbjqC4=
X-Google-Smtp-Source: APiQypK7KCI35pS++4J0SIqHJD7dr5g2l7+08iQ5RiCR71+iMFlR/jYNxzQBPDEHu+qT/Sz5AOLSQg==
X-Received: by 2002:a2e:96c2:: with SMTP id d2mr14198354ljj.214.1587979154856;
        Mon, 27 Apr 2020 02:19:14 -0700 (PDT)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id g6sm9538704ljj.78.2020.04.27.02.19.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2020 02:19:14 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: [PATCH v4] arm64: dts: meson: S922X: extend cpu opp-points
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <1ja72x2t7w.fsf@starbuckisacylon.baylibre.com>
Date:   Mon, 27 Apr 2020 13:19:09 +0400
Cc:     Tim Lewis <elatllat@gmail.com>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, joy.cho@hardkernel.com,
        narmstrong@baylibre.com, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        tobetter@gmail.com, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2A9D3FBA-917A-42C7-9757-4316D6B3D284@gmail.com>
References: <20200426162119.GA23268@imac>
 <1ja72x2t7w.fsf@starbuckisacylon.baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: Apple Mail (2.3445.104.14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 27 Apr 2020, at 1:06 pm, Jerome Brunet <jbrunet@baylibre.com> =
wrote:
>=20
> On Sun 26 Apr 2020 at 18:21, Tim Lewis <elatllat@gmail.com> wrote:
>=20
>> Add extra cpu pop points to allow mild overclock on S922X. The opp
>> points are found in Hardkernel N2 sources [1] and testing shows no
>> obvious issues on other S922X devices. Thermal throttling should
>> keep things in-check if needed.
>=20
> The Odroid-N2 has a massive heatsink mounted.
> Do we have any idea if this applies (is safe) on any other S922x
> device ?

I=E2=80=99ve tested it on several S922X box devices that I have, and =
also the
original S922X version of the VIM3 - all have similar sized passive
heatsinks about 20% the size of the N2 one. No obvious issues with
Kodi software decoding to increase CPU usage. NB: The original patch
submission was N2 specific and then reworked to apply to all S922X
devices at Neil=E2=80=99s suggestion (after my TB and earlier comments).

CH.

[snip]=
