Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CE7C2BB54
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 09:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8076C2074B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 09:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="OMf1NOEN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgDGJ40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 05:56:26 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:37996 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbgDGJ40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 05:56:26 -0400
Received: by mail-lj1-f181.google.com with SMTP id v16so3013845ljg.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 02:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Hr+mHdDvTFoRIT/CRSZS1TyQa2gyop6xAKiNSv38ra0=;
        b=OMf1NOENNZQYb1s0ekZSWScx1UIQEOmNdE6Ci7fyg9t2GHZpfvUdgCqWsFsSXaQkmw
         bDqH/7BaZhRZTkRnpMJkZvB5k9LcqAbtwXPSdfzD+2YX40dHWTVoRHLr8wVYIbxS2Bb3
         mXyxGdW1qC7NGWEAq+CvM7tWUDyWVSnt0j8BeyyJJAfVHuX+aE62pwzxovyqobGDR9FM
         zyHBmYFFqG+pxr1BnAzS3mrXXebO2M5LiTdlQK/bqcdvy6YRYpEn6eslzQxCVwVkR/ma
         vkiTObVAl9rLBAfb6yt6DmYk/mIRPc/vOE6GHcRyQly5xXihidnjZR08KyR9al0a6oD6
         8VeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Hr+mHdDvTFoRIT/CRSZS1TyQa2gyop6xAKiNSv38ra0=;
        b=PdmNGtz1nkVz9wEp32iHFgrQiASiMNgFNkUyuTdawVIYu0NiH368F4a3nzWwhQy95b
         aCVsEsFkXK5j4pEevtIizEeV7pByAqzggiRv4512XocUU2OysnkckgxxNS1J1B2Tk0Kx
         rU5SuBrVWJ2R37q7dsbArTHZWE91Z3Y16PubZKK040a3YYlFnm1R9/O56irnWkd0TVco
         GKlXuWwKgm/wtUMuyCx7JdnE3w8kyC20Lcu6CFaflMji1kHl3F/2D+/npXuXGDEBoh9z
         K0Xxvu6JWfp78/TZH+Xez5yNTIczJ0yGocktdRsP3YwsPXZCmuNIWOYEcFg+cCCey9fM
         2UzA==
X-Gm-Message-State: AGi0Puatityq8cS7BPaj2k6UpzpsmJEStWoYj5+P5XerbL1wBobbdIlt
        Bdq53471DvzPnWYtA+D0oF14QA==
X-Google-Smtp-Source: APiQypLzbcBXaC7SPGZjabCqZDwjsTQUaJcJmC9dGQcLyjzMIEUJJViDWI7gPma8gc5q1NE53lxhhQ==
X-Received: by 2002:a2e:888e:: with SMTP id k14mr1266812lji.4.1586253383383;
        Tue, 07 Apr 2020 02:56:23 -0700 (PDT)
Received: from localhost (h-200-138.A463.priv.bahnhof.se. [176.10.200.138])
        by smtp.gmail.com with ESMTPSA id t24sm10710162lfk.90.2020.04.07.02.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 02:56:22 -0700 (PDT)
Date:   Tue, 7 Apr 2020 11:56:20 +0200
From:   Niklas <niklas.soderlund@ragnatech.se>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] media: rcar-vin: Add support for
 MEDIA_BUS_FMT_SRGGB8_1X8 format
Message-ID: <20200407095620.GA1716317@oden.dyn.berto.se>
References: <1583838364-12932-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1583838364-12932-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200310124605.GO2975348@oden.dyn.berto.se>
 <OSBPR01MB35905FFB621C2F4222692832AAFF0@OSBPR01MB3590.jpnprd01.prod.outlook.com>
 <20200310140625.GA88560@oden.dyn.berto.se>
 <CA+V-a8vsYGdx6AtgqwS0LXREn4hu-EjVh2D5Dp_rHmpazBYG5A@mail.gmail.com>
 <20200319150329.GB3192108@oden.dyn.berto.se>
 <CA+V-a8u8=H-6WfaYMLWH73zo5ehP8cu9D-tdGULk=Hkvq4KuAQ@mail.gmail.com>
 <20200330120745.GA3213219@oden.dyn.berto.se>
 <CA+V-a8vbTc0DZ15y0zZ97PH6khwQVxz=M-8_kgx1AiKkdg5QaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+V-a8vbTc0DZ15y0zZ97PH6khwQVxz=M-8_kgx1AiKkdg5QaA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lad,

On 2020-04-06 18:20:33 +0100, Lad, Prabhakar wrote:
> Did you manage to get the required information on this ?

I'm still working on it, sorry for not completing it last week. I will 
let you know as soon as I can.

-- 
Regards,
Niklas Söderlund
