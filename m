Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4E5C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24D79208E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tF3Vfaj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgD2SzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 14:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2SzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 14:55:00 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4723EC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 11:54:59 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e26so3218261wmk.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 11:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=6YnbwWiKQ4Iao946t7dKTYYwMaT6iBCQ8RAc8IdgDxQ=;
        b=tF3Vfaj1HFl7qz5JJnZNlQQE0SjQ2PHHoZ2ssai5WnKiSXAWErxybdq60FuDs58EAe
         G5U5L5dIia+6TiCvPFmZp8dbxJBomRK78ZClIuWHuftf52F/SRz2mYQN6nGwJM/q3xtJ
         lHd5F2VXnl4eRtUdbpfsYjwGDJrblP+iLmkvb8QuYubddfNy970WhYgERnuwy/dfQS52
         TfbSLUsf8NDXrn5xjgvfrn9rNKDEysBo1fQrXCR/RdhzLcozDHeR9efgpoQKZO4MQJce
         LWQAEvmNO1tVxCqzY3DHaPV4ABgeoJWfXJePfWvJeNOYTx158NISh+hdLKN34kT9cakV
         +pVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6YnbwWiKQ4Iao946t7dKTYYwMaT6iBCQ8RAc8IdgDxQ=;
        b=cn7u/UONTneNal21tIjsExCNQylWvljHn22QN2aDOhsg0WJpnfW+psPbrvwaHrxnmC
         ugiNxmnvt0kqG9UhdGcqzQXfmJfGNpwVGNz0DsHWYve/yQHSOW2QbaT5+UX591EsyRN9
         LU/q+Cs5QMoIMcL1NOqtNnLMgZEcg6p/hv3EVsQ/HVeLVPf8hdQSqddriXf2R9BuH4XR
         pwe9A5QzxLgZ92U3aMTa8VBBhjXVO/bZ0YIU/ybOhtuiTdSOkGoc32/FB1av9RbeMKgQ
         USBmSqABaD1lQccUm8wNtKmQ8NAv+lr0qetrs767sa8QShgqjylrCC+QVEfokZfP7+h3
         7Y2w==
X-Gm-Message-State: AGi0PuYfp+3S1u/wN+bwfOd7Vg2CyMmr64RUl45yr+OkDp//S8ZrsNFc
        pjRIRuDrGOlpxYkiC58o2cc48g==
X-Google-Smtp-Source: APiQypLtXfk/wATMJxqBb2Qp5z3oODZe/lOdUgqR3v5FpRdEcmAOBgKUT58slykEAG9h6bg83V3fZw==
X-Received: by 2002:a05:600c:2f88:: with SMTP id t8mr4665841wmn.46.1588186496920;
        Wed, 29 Apr 2020 11:54:56 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id f18sm276841wrq.29.2020.04.29.11.54.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Apr 2020 11:54:56 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     Tim Lewis <elatllat@gmail.com>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, joy.cho@hardkernel.com,
        narmstrong@baylibre.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, tobetter@gmail.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4] arm64: dts: meson: S922X: extend cpu opp-points
In-Reply-To: <2A9D3FBA-917A-42C7-9757-4316D6B3D284@gmail.com>
References: <20200426162119.GA23268@imac> <1ja72x2t7w.fsf@starbuckisacylon.baylibre.com> <2A9D3FBA-917A-42C7-9757-4316D6B3D284@gmail.com>
Date:   Wed, 29 Apr 2020 11:54:53 -0700
Message-ID: <7hd07qktqa.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Hewitt <christianshewitt@gmail.com> writes:

>> On 27 Apr 2020, at 1:06 pm, Jerome Brunet <jbrunet@baylibre.com> wrote:
>>=20
>> On Sun 26 Apr 2020 at 18:21, Tim Lewis <elatllat@gmail.com> wrote:
>>=20
>>> Add extra cpu pop points to allow mild overclock on S922X. The opp
>>> points are found in Hardkernel N2 sources [1] and testing shows no
>>> obvious issues on other S922X devices. Thermal throttling should
>>> keep things in-check if needed.
>>=20
>> The Odroid-N2 has a massive heatsink mounted.
>> Do we have any idea if this applies (is safe) on any other S922x
>> device ?
>
> I=E2=80=99ve tested it on several S922X box devices that I have, and also=
 the
> original S922X version of the VIM3 - all have similar sized passive
> heatsinks about 20% the size of the N2 one. No obvious issues with
> Kodi software decoding to increase CPU usage. NB: The original patch
> submission was N2 specific and then reworked to apply to all S922X
> devices at Neil=E2=80=99s suggestion (after my TB and earlier comments).

Yes, we also have OPP lowering enabled by default (which I think Neil
mentioned earlier) so this should be safe (enough) to apply.

Queuing for v5.8,

Kevin
