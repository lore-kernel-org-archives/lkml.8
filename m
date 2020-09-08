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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1226DC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B27EF2177B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khM1iowT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbgIHGgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 02:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbgIHGgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 02:36:12 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A1AC061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 23:36:11 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 37so13976218oto.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 23:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=FXRGk/mcZqtGVK0Pfsx/t/t3xjkBJkZX90W+LIJkKWc=;
        b=khM1iowTzcl7lEIPB9WuChKeXOvVObXNvfAYDQn1DLcwxkKR+ZgLS6SMCjfMuJynGL
         hZlUNE2ATidQ4nq40mSMdf/KRZX8XV8ONGM0UOBjjTtykUus3ZcM3Dn03gWTVQ7dKyb2
         H2a0V1mhNMqqZYvua9Nr1EdjM/NrKEa2/tbrt27Pd8R/OFH3qaT92nRMEAUXtnyif11S
         lIPZcAVmyBZNLvWDCmr4wp8FwTCYLhrbBWqVtIAa08J7InIyNurzMFOyvAeUeRvokEq+
         42vbWLC692YakX/mjeaxQ6Aq5/oCPJLHWn7tK1guTemtKanxsYd4cGhJwkHiv17yJGwh
         3ZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=FXRGk/mcZqtGVK0Pfsx/t/t3xjkBJkZX90W+LIJkKWc=;
        b=C024K7vslLOpTaQacl3b751sLEMFkDRZx6YnJS8ShqgQXmSGkIfAPOKilPCsY0Wmi8
         i78/huWt8L/Q03lf0jA+/ftxQQJ4SiBURwQ7pO1mJWEglQ0Gw27GCvTevf0xgBRyvb2x
         1f7bOJV0KmoBjIu6bpG32E44uOQHc2MeiIcp/wOTudLAOdet88IoRPdoiolXpup1pzKl
         4sgbo8jmnMfvIaJHxbSDiVASeQRLais7dmBNaUW2FGBq8jfqD7KbpOKQG4A+Zvr/7Ilf
         CNyOBNl1OTT5jeqM5rYh511KY1DTp1+C8hko7KCLi2Xj1hSXslHbdYulfY9b2s/yQRhA
         PrOA==
X-Gm-Message-State: AOAM530/AKto3Hnt++NVeLmrKJIUGbJJQvTS0BmAZ684MbptU1Hlr0dD
        JPSjdqaO9HlI66w0kKfcp3JyJbTblZI3DwoPGP8=
X-Google-Smtp-Source: ABdhPJwg9SHSpM3hrzuhuGbH/Zf2VBcEiDVfAOrQkih76xQZuKIoVD4i+Io3P6/4U620db3sTks2pm/DyaGhe1H15dI=
X-Received: by 2002:a05:6830:1d5:: with SMTP id r21mr18117971ota.244.1599546970601;
 Mon, 07 Sep 2020 23:36:10 -0700 (PDT)
MIME-Version: 1.0
From:   Grant Grundler <grantgrundler@gmail.com>
Date:   Mon, 7 Sep 2020 23:35:59 -0700
Message-ID: <CAP6odjjZAZ4fcAdoFETzbX0_e-VPsrvJ0Fh1_ZXfeAZKLppj3A@mail.gmail.com>
Subject: Apply from 2018? [V2,0/3] phy: qcom-ipq4019-usb: add new driver
To:     Alban Bedel <albeu@free.fr>, Andy Gross <andy.gross@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Crispin <john@phrozen.org>,
        Matthew McClintock <mmcclint@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alban, Andy,
Can you please apply this patch series from 2018 or please explain
what I (or John) have to do so this series can be applied?

   https://patchwork.kernel.org/cover/10552139/
   [V2,0/3] phy: qcom-ipq4019-usb: add new driver=EF=BF=BC

OpenWRT has been applying this code to all ipq4019 targets since Jul 2018:
    https://git.openwrt.org/?p=3Dopenwrt/openwrt.git;a=3Dcommitdiff;h=3D956=
72e04335ea0d7d8f468cec8f63d593cc6ede6

I expect if there were problems with it, we'd know by now.

$ find -name \*qcom-ipq4019-usb\*
./target/linux/ipq40xx/patches-5.4/076-phy-qcom-ipq4019-usb-add-driver-for-=
QCOM-IPQ4019.patch
./target/linux/ipq40xx/patches-5.4/075-dt-bindings-phy-qcom-ipq4019-usb-add=
-binding-documen.patch
./target/linux/ipq40xx/patches-4.19/076-phy-qcom-ipq4019-usb-add-driver-for=
-QCOM-IPQ4019.patch
./target/linux/ipq40xx/patches-4.19/075-dt-bindings-phy-qcom-ipq4019-usb-ad=
d-binding-documen.patch
...

In 2018, Rob Herring reviewed (and approved):
   [V2,1/3] dt-bindings: phy-qcom-ipq4019-usb: add binding document

I've just reviewed 2/3 and 3/3. You can add to those:
  Reviewed-by: Grant Grundler <grantgrundler@gmail.com>

I compared 3/3 with the DTS entries that were submitted (and I
approved) to chromeos-3.18 kernel tree in 2016:
   https://chromium-review.googlesource.com/337605
   https://chromium-review.googlesource.com/344471

While not identical, the important bits (reg values) are.

(I would reply to the original thread but I don't have it in a format
I can easily reply to.)

cheers,
grant
