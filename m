Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4BFC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BDC121532
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRYjRdKK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgIHGl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 02:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbgIHGl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 02:41:58 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF7FC061573;
        Mon,  7 Sep 2020 23:41:57 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id u28so3700974ooe.12;
        Mon, 07 Sep 2020 23:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z4woB6C8Tv6F/Z/MvCwCzucOF/m1MsrTyEtPgxnRS4k=;
        b=cRYjRdKKvdQhonEZL4Ha0EgTiq1jGo8Cay+/b9o00euZBc0KmnBhPvP33oO8kItJlD
         m5gkUUTVppXImLuasS0nE4b5VV4ex5lw9AdJsaPpA9BVktnuQGpJQ4TwVlDeAKPGw9e0
         h5a4CkJwojSGPPMu58xK4iR2xBq6+DU/0y5bZBq/M7X7aJFh79NqhMLU8mMjHgZpRQZL
         lxjVXzXmr0WYmFgm3PR9O0t+6tMSl57zKL7knMAocj9M7d7YKj7IsvBawu9FZZ2y62+V
         urqaFZyRQpeHwecLFznjYyvLfrTTv6Ql0q7lgrvga5wjsZ7aPqpWdMQLKMvZ+HIaNU08
         vdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z4woB6C8Tv6F/Z/MvCwCzucOF/m1MsrTyEtPgxnRS4k=;
        b=gEsVd2W7ZfCnbW+dpkeRVdBcKFCliefoIiYaX4+yYH2DbrpqHRc6pOl8Sox3//APZc
         Q/2u1J8kG1jAQ9Cic3rU4OidX9goRyH6+nV6wchyVPMh+fm+HO9z17fp6rLvwcSGP39d
         l9Q6+QI/I8StvP8Fq7sinhV9YtBW3Tz6RVnXykvq/Ef4InGS7J5aOioBtJwpWc1SJdFC
         a+XXqMB+OdOfPobgsoQps0/lsxINJlKBjReyOyENoubniiCbW7FLYP6iqXX3ypFdgvF4
         8lZ5FOVTRcSM8esexw/loERq+NRRq1fjWzaJFeAJ8VznEq4m5bc+UO0LotNLgtQvbo+G
         3Pgw==
X-Gm-Message-State: AOAM530v0doe/ghJqKCP4WnuM8Clw0vQtiM5SVpqKUYv5E2gvPzoY+4Q
        nqBLTV82//6HHTr0IgmWO0eARfZY3yBpA8AU+ug=
X-Google-Smtp-Source: ABdhPJyyo86yjdnfYeJdb2lbLD7KXA4jOdvTgpqKfAGrDtRhvcjvgLVVPdzbGLOZDTeO8wykvnQKnCVmo02w8jVXUKU=
X-Received: by 2002:a4a:3e13:: with SMTP id t19mr17278220oot.49.1599547317033;
 Mon, 07 Sep 2020 23:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAP6odjjZAZ4fcAdoFETzbX0_e-VPsrvJ0Fh1_ZXfeAZKLppj3A@mail.gmail.com>
In-Reply-To: <CAP6odjjZAZ4fcAdoFETzbX0_e-VPsrvJ0Fh1_ZXfeAZKLppj3A@mail.gmail.com>
From:   Grant Grundler <grantgrundler@gmail.com>
Date:   Mon, 7 Sep 2020 23:41:46 -0700
Message-ID: <CAP6odjibYc6gMeSHqsjeZyA0YDpD_teeix8_RFkY=8UfV-xq-g@mail.gmail.com>
Subject: Re: Apply from 2018? [V2,0/3] phy: qcom-ipq4019-usb: add new driver
To:     Alban Bedel <albeu@free.fr>, linux-soc <linux-soc@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Crispin <john@phrozen.org>,
        Matthew McClintock <matthew@mcclintock.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding linux-soc@vger.kernel.org since Andy's email in MAINTAINERs bounced.
Using Matthew's personal email since his codeaurora email bounced.

On Mon, Sep 7, 2020 at 11:35 PM Grant Grundler <grantgrundler@gmail.com> wr=
ote:
>
> Alban, Andy,
> Can you please apply this patch series from 2018 or please explain
> what I (or John) have to do so this series can be applied?
>
>    https://patchwork.kernel.org/cover/10552139/
>    [V2,0/3] phy: qcom-ipq4019-usb: add new driver=EF=BF=BC
>
> OpenWRT has been applying this code to all ipq4019 targets since Jul 2018=
:
>     https://git.openwrt.org/?p=3Dopenwrt/openwrt.git;a=3Dcommitdiff;h=3D9=
5672e04335ea0d7d8f468cec8f63d593cc6ede6
>
> I expect if there were problems with it, we'd know by now.
>
> $ find -name \*qcom-ipq4019-usb\*
> ./target/linux/ipq40xx/patches-5.4/076-phy-qcom-ipq4019-usb-add-driver-fo=
r-QCOM-IPQ4019.patch
> ./target/linux/ipq40xx/patches-5.4/075-dt-bindings-phy-qcom-ipq4019-usb-a=
dd-binding-documen.patch
> ./target/linux/ipq40xx/patches-4.19/076-phy-qcom-ipq4019-usb-add-driver-f=
or-QCOM-IPQ4019.patch
> ./target/linux/ipq40xx/patches-4.19/075-dt-bindings-phy-qcom-ipq4019-usb-=
add-binding-documen.patch
> ...
>
> In 2018, Rob Herring reviewed (and approved):
>    [V2,1/3] dt-bindings: phy-qcom-ipq4019-usb: add binding document
>
> I've just reviewed 2/3 and 3/3. You can add to those:
>   Reviewed-by: Grant Grundler <grantgrundler@gmail.com>
>
> I compared 3/3 with the DTS entries that were submitted (and I
> approved) to chromeos-3.18 kernel tree in 2016:
>    https://chromium-review.googlesource.com/337605
>    https://chromium-review.googlesource.com/344471
>
> While not identical, the important bits (reg values) are.
>
> (I would reply to the original thread but I don't have it in a format
> I can easily reply to.)
>
> cheers,
> grant
