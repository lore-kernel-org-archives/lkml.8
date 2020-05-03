Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E8CC4724C
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 11:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35CC1205ED
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 11:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/VeyKDZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgECLmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 07:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727023AbgECLmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 07:42:47 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AD5C061A0C;
        Sun,  3 May 2020 04:42:45 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id z2so9378273iol.11;
        Sun, 03 May 2020 04:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CswbDbzRoY7hOaMpKGQ7lTgkmEKRA2Ia8858GzcpRyQ=;
        b=B/VeyKDZ4SLuIY7xHuxpXOzOskfvZKU+A5FK81ESN3wNpQDFeg5YMMn10lN8K1HlzU
         ucNQI44nZ0RuaN9V467tsqNfMHZxbuNPptiUAsaVg3KYYzH75VV4unRSTt+NsACNb4lc
         dmcvbKyaOxB31ly2JwulyTgFbdifyHm56KvXnfOHErfj5UVE7YK2+skEdePVFu+BR44B
         uhVpDPvmnRDtBvfnAqrbUU5KLt9w1767QhJPPXsDn7tZknjhE++fAPu4TrDilwXBU/d1
         P2CRaRavJOqCiQE5DwlZs5i9VhlFSnNBdt72/1BGc2EAlaYKKm0a8lAz8UeYwOT07Ide
         HpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CswbDbzRoY7hOaMpKGQ7lTgkmEKRA2Ia8858GzcpRyQ=;
        b=K/uw8rUY+N83SIkT07MPONYaQwtZBj+85zUdcQdEsRI5L2awo8bjdfDfzwdh7hB6cW
         hXmW88s3Gq2nmnGPOXbXkUZmxsb6esBR1j9M7VSNZRyL2XUboQ8LM4S2HX/jpj/yHXcO
         pKqJp8IkjDpbGWZ3D51RQ7vQMhuFYJ3FlLNFxaka6VHCYwLl8IbT+Rdxswyb1+08FRtf
         zJNVgM+0FHXm1xWNGZhumc+9XBsg5I1ICeG6+gNihofRPuXCwGavFAEcp2Nrw5Gbeumr
         jdAiibmx7HrkKo9RP3LJmnPSZox/BdZGRpbC8vPcny3HqhzutUEhh2kOz8vjcuZ2Kn/b
         FQhQ==
X-Gm-Message-State: AGi0PuZr9BtjY1vHab9rxEH8uicuFjXCNx3jmv0hJm3goQsEL/upDYIp
        fPZtshDjHp6sn7cFY3KwArtqOAvRMWKu13OJpnc=
X-Google-Smtp-Source: APiQypK7bQYFFm90yVaM++6A1mWUH1dHV3MQb0qbIp+ohH4OaxgHO6pX+nd1tdial7Rn5XJUxQbfqsSdn1DrT9htlVU=
X-Received: by 2002:a02:3f44:: with SMTP id c4mr10593844jaf.144.1588506164909;
 Sun, 03 May 2020 04:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200426104115.22630-1-peron.clem@gmail.com> <20200426104115.22630-7-peron.clem@gmail.com>
 <CAGb2v66TFzpEmzdqxmjqGvVONkPEhaDMHNA4tRUvrX_Mg8w=tA@mail.gmail.com>
In-Reply-To: <CAGb2v66TFzpEmzdqxmjqGvVONkPEhaDMHNA4tRUvrX_Mg8w=tA@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sun, 3 May 2020 13:42:33 +0200
Message-ID: <CAJiuCcfpk=9E2dQnE+QeZrDHG7EqCBWqbEbnpBvhn-uvWuRV2w@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] ASoC: sun4i-i2s: Adjust regmap settings
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marcus Cooper <codekipper@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 27 Apr 2020 at 13:03, Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Sun, Apr 26, 2020 at 6:41 PM Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail=
.com> wrote:
> >
> > From: Marcus Cooper <codekipper@gmail.com>
> >
> > Bypass the regmap cache when flushing or reading the i2s FIFOs.
> >
> > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
>
> Acked-by: Chen-Yu Tsai <wens@csie.org>

The  SUN4I_I2S_FIFO_CTRL_REG is also missing.
As some bits can self-clear by themselves.

I will fix this in v4.

Regards,
Clement
