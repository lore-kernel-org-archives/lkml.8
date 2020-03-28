Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACE3C2D0E7
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 02:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5D4206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 02:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIYixAiA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgC1CuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 22:50:01 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:33915 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgC1CuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 22:50:00 -0400
Received: by mail-il1-f196.google.com with SMTP id t11so10715676ils.1;
        Fri, 27 Mar 2020 19:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=2T7espawJMH0SyrBBNkM4sZK6EGCQt+cUAnkbw8X+q8=;
        b=UIYixAiAO44c3MPcDqJ+yFWSoFESPl38VStvTMjsrJOy0IsBwRiHeMEbR5nA/3TkAg
         j5FovwdcFdK/ogckuQB6gKawnyfESHbFW6VGUGyCT+Jm/N/Ja40F9iCjMfnlWvkhh8sc
         UPhr+945c8/GdnIHfxCEboQPtjRttgswyyivqG2/rw64ZPTqZRGxUuu8j1MR/Llz98E9
         CEZUD6JHiiSYUlLoMTn2q2GOb6VIwlnQ6Wvyq2Ha7h0u3v5PH4Vbbh7sNjjU5mPSkCt4
         ii9lTJ71OByT/yOGVXXJ1c1ElQ9V+IezHQOhkWQv7JrSKaVcpZKmqR9zbE7VSUMtzPhl
         9EnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2T7espawJMH0SyrBBNkM4sZK6EGCQt+cUAnkbw8X+q8=;
        b=GYrLOdTl48m4z08KOczrLouJ95+YiS3wY/ZY7RevYajELbRGyqdXxuKxSt/lPhox0C
         h2VD8/eaEMGRiUvS5VaySI/kECOcM+skKMl5jczYdoLK6dd0eCwBDF0esKF/1/BlODhU
         Ke9mzoEthxvXKuhCFGAW5Ibf8hmmfI8RN2MN+5LI+72/B7WWqrlEHCTNa3L+TULw9+Bb
         RGOc9lTBj4XnbH8JcqgBjRGrkNKwwtN83LAr3I3tSP6D7GPftNtluUqyqFp452YOglk3
         EakqeVawJ23nzvliK/pLPL/+ViKcoHxLNT4rDZvbaox+RLmY65qH2L4vRbHfLnSFqSyY
         gaYQ==
X-Gm-Message-State: ANhLgQ0FY36TM+mQ6VkPjiGrxg0jX+hDQSUKYBPWgU0Ce9YA6rOsvEbV
        VYABp/7sPa2g1B8+m/g43mtayTQjQUV4P1FEHiw=
X-Google-Smtp-Source: ADFU+vu8brBOHjvUSXAejafUKJHfvGYcC5rvGqgefCeljGY9rSiNBTTc1qwA3lZCs0Mmew94vFBCEXJbPO00Gh/fpLA=
X-Received: by 2002:a92:4896:: with SMTP id j22mr2016718ilg.158.1585363799665;
 Fri, 27 Mar 2020 19:49:59 -0700 (PDT)
MIME-Version: 1.0
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 27 Mar 2020 21:49:48 -0500
Message-ID: <CAHCN7xJSKH-gXA5ncFS3h6_2R28rn70O3HfT=ActS1XVgCFSeg@mail.gmail.com>
Subject: i.MX8MN Errors on 5.6-RC7
To:     arm-soc <linux-arm-kernel@lists.infradead.org>
Cc:     Adam Ford-BE <aford@beaconembedded.com>,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting a few errors on the i.MX8MN:

[    0.000368] Failed to get clock for /timer@306a0000
[    0.000380] Failed to initialize '/timer@306a0000': -22
[    7.203447] caam 30900000.caam: Failed to get clk 'ipg': -2
[    7.334741] caam 30900000.caam: Failed to request all necessary clocks
[    7.438651] caam: probe of 30900000.caam failed with error -2
[    7.854193] imx-cpufreq-dt: probe of imx-cpufreq-dt failed with error -2

I was curious to know if anyone else is seeing similar errors.  I
already submitted a proposed fix for a DMA timeout (not shown here)
which matched work already done on i.MX8MQ and i.MX8MM.

I am not seeing huge differences between 8MM and 8MN in the nodes
which address the timer, caam or imx-cpufreq-dt.

If anyone has any suggestions, I'd love to try them.

adam
