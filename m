Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466CBC47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 206702076D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="txKcDb32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbgEFPFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbgEFPFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:05:02 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1707C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 08:05:01 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y3so2632412wrt.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 08:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=IuVcDPvx/ramQ3zgx5WYrUfz2fWdPILVO++V7pmfrS8=;
        b=txKcDb32BBdVGQiu/JSUT4iXWdPuDxSBJVjxDRf3vU4+HoPDbeWhhoo+oJFxtOemOD
         UZj4tggxE6K9/fd9SXk9yTySnXLwAnQkHCS6BjbgJ4aTW7kFC8qHc0QY6qCBqbXt9hAd
         zY0P6u9KYkb9GWGT2bQdT8HEVhx6tHPVgaYwyUy4GcZCMEku2/7tSWpQdeqMHWRRt7zj
         Co5kFG54iSUfz5FdbaHqoAbOD7hy5oljSsaHKiu3mJVOfpHg4o6vEk5n99Kq4mZG0Oa2
         z7i32QdI6B9Ogu1m1RSLDcuTFxp+XR6DV0DK27zZMtkekdQXjFnAuCGW3gTBBqxMPuok
         WhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=IuVcDPvx/ramQ3zgx5WYrUfz2fWdPILVO++V7pmfrS8=;
        b=eTCCIxEas6zHgbgi9ncD5jKl/cGEIjm9UJKMdD/iikySRAUiFvUbMnayFv1dw0Gmnh
         XW83NCcGlpH/jfMD3oFMbWMAM51/t2Zlq11pRKOnNF4fdwwvbVQVjeqXZo4iC3y2ySP3
         Ok7siXdgbNHmN3YpA+cazHUIm/xZ2TLMGpibAjYWHRdiBtEuw0xOGKgYS4utPJq6jI+g
         YkjEkdILD1WMA0rfohlCz5napIMJX1hPEVePeknv83Af1Z8oHgvLGzzxPpJGPSa8ybtJ
         pYrolRsUxc/Drnl+ojwVidPt22GvgY5gGQXU8B3W1u7BiQiU5y7UKqOOCjdYpdHrwOIl
         dZsA==
X-Gm-Message-State: AGi0PuZS11fSQFxLTTJdJaXQO9Ca9eQ16Tj+g/Mupj9funrIwdT51IhF
        vdnaRKJwnpMFcANAyo2K1evLLQ==
X-Google-Smtp-Source: APiQypKJ78dHmdgL4QTF8E5sQrqBVtdAFbIvwh1I0kw41IMKqMhStQAsPmRkliHyLMs/wye/16BEVg==
X-Received: by 2002:a5d:4801:: with SMTP id l1mr9559567wrq.235.1588777499375;
        Wed, 06 May 2020 08:04:59 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id a12sm3191550wro.68.2020.05.06.08.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 08:04:58 -0700 (PDT)
References: <20200122092526.2436421-1-jbrunet@baylibre.com> <6f661498f58c6a519095d0657413f4b89d3ef21e.camel@pengutronix.de> <1jimi2tqsn.fsf@starbuckisacylon.baylibre.com> <1jy2q5f9zc.fsf@starbuckisacylon.baylibre.com> <05e51534c3d6284f555fd262b666c94d12cbd010.camel@pengutronix.de>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: reset: meson: add gxl internal dac reset
In-reply-to: <05e51534c3d6284f555fd262b666c94d12cbd010.camel@pengutronix.de>
Date:   Wed, 06 May 2020 17:04:57 +0200
Message-ID: <1jv9l9f6jq.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 06 May 2020 at 16:54, Philipp Zabel <p.zabel@pengutronix.de> wrote:

> Hi Jerome,
>
> On Wed, 2020-05-06 at 15:50 +0200, Jerome Brunet wrote:
>> On Tue 14 Apr 2020 at 10:28, Jerome Brunet <jbrunet@baylibre.com> wrote:
>> 
>> > On Thu 23 Jan 2020 at 11:13, Philipp Zabel <p.zabel@pengutronix.de> wrote:
>> > 
>> > > On Wed, 2020-01-22 at 10:25 +0100, Jerome Brunet wrote:
>> > > > Add the reset line of the internal DAC found on the amlogic gxl SoC family
>> > > > 
>> > > > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> > > > ---
>> > > >  include/dt-bindings/reset/amlogic,meson-gxbb-reset.h | 2 +-
>> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > > > 
>> > > > diff --git a/include/dt-bindings/reset/amlogic,meson-gxbb-reset.h b/include/dt-bindings/reset/amlogic,meson-gxbb-reset.h
>> > > > index ea5058618863..883bfd3bcbad 100644
>> > > > --- a/include/dt-bindings/reset/amlogic,meson-gxbb-reset.h
>> > > > +++ b/include/dt-bindings/reset/amlogic,meson-gxbb-reset.h
>> > > > @@ -69,7 +69,7 @@
>> > > >  #define RESET_SYS_CPU_L2		58
>> > > >  #define RESET_SYS_CPU_P			59
>> > > >  #define RESET_SYS_CPU_MBIST		60
>> > > > -/*					61	*/
>> > > > +#define RESET_ACODEC			61
>> > > >  /*					62	*/
>> > > >  /*					63	*/
>> > > >  /*	RESET2					*/
>> > > 
>> > > Thank you, applied to reset/next.
>> > 
>> > Hi Philip,
>> > 
>> > It seems reset/next has not made it to v5.7-rc1
>> > 
>> > Would it be possible to provide an immutable branch with this change, or
>> > maybe let Kevin apply this change through the amlogic tree ?
>> > 
>> > It would allow us to progress on some DT changes during this new cycle.
>> > 
>> > Thanks
>> > Jerome
>> 
>> Hi Philip, how can we move forward on this ?
>
> Sorry for the delay, I have missed the last window. I've now created an
> immutable branch:
>
>   git://git.pengutronix.de/pza/linux.git reset/meson-gxl-dac

Thx !

>
> which I will be included in the next reset pull request.
>
> regards
> Philipp

