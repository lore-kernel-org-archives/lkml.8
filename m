Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A642EC10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AABD20724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n9Fpd1Nu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgCRRbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:31:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44764 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbgCRRbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:31:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id b72so14245401pfb.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=0oVbpGrGaY5Fn00wldsg1aTGnPnQCIYKyx4rmQ1e970=;
        b=n9Fpd1NuTWVQu9epcV+JGD/nHGepi9Ph3ZkaXkMfpihjmZaS+QMz8V/HlkgjbLLACj
         LorPwwfzVo/KefRYCqMYchP1ZOL5nqZ/4o2aZ9miAMO1ZyUHoMsHJq3vbyOQSCVFAG5v
         7Sm2quzm5bDNKFBNtlt5kO9ipfd2Wdp2KZa2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=0oVbpGrGaY5Fn00wldsg1aTGnPnQCIYKyx4rmQ1e970=;
        b=g2H9OHvit1D6mkrdphomlZdzOcw+LWjw+cy7zhd9QhjmnHVAYmRgM13roVdPD2H2Kp
         VNwLyedYxPDjmv/FlCFMOHg13r3MEY6IRPrHyFE2GoRei91QzIo7TR7JLgg6OWdjxvxC
         BAeNLrqNkkK867j4iN9xyTUCCgsdO9CVllGWl9b00tFscFiebaHm5VPO8ybHFwcPrS8M
         uDSMzxwxtQ9XYEcd+5KHr2Msg6BkH4qWkSuawzcz5HKPExEM15ayUUcdkymSnIixWqML
         F0Shk5QP13NkvBLH0p8pG6+s0BaVCnElFYJC4YsvVTT8domNhB7+VocV7qGqJreK/H+i
         uiYQ==
X-Gm-Message-State: ANhLgQ0fNJyh4Xg0meJUbGv6Ma4fWa6PDx9iWeyAZNGdwIdRIsPQ6/cJ
        79EmQ5OvmH4gQfM7XoCJGhKkItxP+7c=
X-Google-Smtp-Source: ADFU+vuzc7K3+9m1BhQ+oGkfVeBCP83NSpJFatT09znpgGeh3rcLWxfIVkWImKTQR4sb5hCcgwyFTQ==
X-Received: by 2002:aa7:8087:: with SMTP id v7mr5297772pff.96.1584552706680;
        Wed, 18 Mar 2020 10:31:46 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k24sm7180866pgm.61.2020.03.18.10.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:31:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200318085542.081ca750@lwn.net>
References: <20200318054425.111928-1-swboyd@chromium.org> <20200318085542.081ca750@lwn.net>
Subject: Re: [PATCH] docs: locking: Add 'need' to hardirq section
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
To:     Jonathan Corbet <corbet@lwn.net>
Date:   Wed, 18 Mar 2020 10:31:45 -0700
Message-ID: <158455270522.152100.5382041841043211189@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Corbet (2020-03-18 07:55:42)
> On Tue, 17 Mar 2020 22:44:25 -0700
> Stephen Boyd <swboyd@chromium.org> wrote:
>=20
> > Add the missing word to make this sentence read properly.
> >=20
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  Documentation/kernel-hacking/locking.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/k=
ernel-hacking/locking.rst
> > index a8518ac0d31d..9850c1e52607 100644
> > --- a/Documentation/kernel-hacking/locking.rst
> > +++ b/Documentation/kernel-hacking/locking.rst
> > @@ -263,7 +263,7 @@ by a hardware interrupt on another CPU. This is whe=
re
> >  interrupts on that cpu, then grab the lock.
> >  :c:func:`spin_unlock_irq()` does the reverse.
> > =20
> > -The irq handler does not to use :c:func:`spin_lock_irq()`, because
> > +The irq handler does not need to use :c:func:`spin_lock_irq()`, because
>=20
> Please take out the :c:func: stuff while you're at it, we don't need that
> anymore.  Just spin_lock_irq() will do the right thing.
>=20

Ok. I'll make two patches then to remove func throughout this file and
you can decide to squash them or not.
