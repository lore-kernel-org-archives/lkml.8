Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0641EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBB392068F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBPzWph8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbgGMJEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 05:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgGMJEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 05:04:33 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C04C061755;
        Mon, 13 Jul 2020 02:04:32 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id dm19so12524681edb.13;
        Mon, 13 Jul 2020 02:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=500CoOdzf5q9Fcdg+W/g6TzNdn+PpBuDz3AznE+D28c=;
        b=PBPzWph8pFtudHo5crZ5ekdllU1lkd/26D1a+9EVNOBbZmxnoTyJsQUJIq+14nPBDu
         5C2TpVpjCvb+CtewWOtjkkPbIl/xDZkViX4SJaTsJ3EMUNhUd+9WRTg0l8bzPZgVF26U
         pQcnci5wbiZESK8/6kUwuk0mI1mSpi0X99Vxlb1lpcfhozI+lvHIGxUb9egHBJfa0qxw
         eh+5Mh+XZirsYTlTju6hwNkqUY0j6Ri/WUl7acHIo1QmqgYsnNzOGWG0lJZ/1nhm7mnb
         sCHPvKRQ4yrPYV8mF/Gv7kiAa4OUoGCeOakALFi+zKPBKfTYvJbk58/anNqWQmNH6OWr
         KQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=500CoOdzf5q9Fcdg+W/g6TzNdn+PpBuDz3AznE+D28c=;
        b=mgG3XfdlGViJyr9lLA1SecMRSHePgPyjksGA4kWrinFJUP6eKa1/UqEqc8iNxUvYKk
         52wbvjy1RoW/882a152ceFx/DQZzd7MYnE5YmkR++ThGSNrPT7jER9c/O0FBAtH54ySs
         iIoz5Wm2RFEaBLp+yGL+DM/XhhhNCFypyGn/8VJ2hVDjhFXlfysphcv8XIyHZzapc6+s
         bZfcZDwNIEbf9ikigXg221X84qbW13aAK9nvOPnV2O550yWP5NS/yhj/4udhDaa1P8v9
         s83agci+l3UqL2rbJOGSadyfMb+us7xgP78RgzyeVXp/41++UhYhaZ+3je3W0RCVmDxy
         dR7w==
X-Gm-Message-State: AOAM530os+7lBh9ef3WIY5YE6KQTAxq+REJ0TYX4KZYXJkTwhB0k59f+
        Wb2MsFGyDVE40u56iUHvWN896G8UWFZMKiDwt9Q=
X-Google-Smtp-Source: ABdhPJzDoDhZGs/aa1inXlKCb8r4Ppi37w7DSuUY1EZ1shMvbTh0J0BonrstntjtS2KU3vBszYsyDDC+rJyM8oI81QU=
X-Received: by 2002:a05:6402:c82:: with SMTP id cm2mr81544390edb.293.1594631071367;
 Mon, 13 Jul 2020 02:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
 <1593701576-28580-11-git-send-email-amittomer25@gmail.com>
 <20200712173044.GL6110@Mani-XPS-13-9360> <CABHD4K8+cZMwA=pQx4Gvv5Z4xLof8Ln6fUNrB0=-SS2M_0_3aw@mail.gmail.com>
 <5e2eb92e-eada-9b14-3f15-38717284bc92@arm.com>
In-Reply-To: <5e2eb92e-eada-9b14-3f15-38717284bc92@arm.com>
From:   Amit Tomer <amittomer25@gmail.com>
Date:   Mon, 13 Jul 2020 14:33:54 +0530
Message-ID: <CABHD4K-4c8DvaW1zt4TsCRHU5YNaWKEgXdT-DK59MT9CgjB87Q@mail.gmail.com>
Subject: Re: [PATCH v5 10/10] arm64: dts: actions: Add uSD support for Cubieboard7
To:     =?UTF-8?Q?Andr=C3=A9_Przywara?= <andre.przywara@arm.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>, cristian.ciocaltea@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> But this regulator is only used for the eMMC there, which we apparently
> don't have on the Cubieboard 7?

We do have eMMC present on Cubieboard 7 (both the versions of Cubieboard7), and
the regulator name is similar to what is used in
"s900-bubblegum-96.dts" .i.e. "vcc_3v1".

But Since this patch doesn't enable eMMC, it does make sense to remove this
"vcc_3v1" regulator and keep the other one.

> > Also, another day tested it without having these regulators in , and
> > still it seems to
> > work.  So should these be removed ?
>
> If there are not even referenced in the .dts, then fixed regulators are
> rather pointless. So yes, please remove this vcc-3v1 one.

Sure, I would do this.

> What is the story with the other regulator? Is there a PMIC or a power
> switch for the SD card? Or is the power supply actually hardwired?

SD_VCC is connected to SWITCH/LDO which gets input from ATM2603C PMIC.
This seems to be enabled by default ( in early bootloaders I guess).

Thanks
-Amit.
