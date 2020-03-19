Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173B8C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 22:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48F0206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 22:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oVefZhPG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbgCSWsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 18:48:19 -0400
Received: from mail-pj1-f73.google.com ([209.85.216.73]:56112 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgCSWsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 18:48:19 -0400
Received: by mail-pj1-f73.google.com with SMTP id gv4so2742058pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 15:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5WtAORZ7SLKlJMzImdvIvZ4TLDWK4cV3hlxUTvVcgm0=;
        b=oVefZhPGfE8C2nh3FoVLrMo+ZnJ4ufUSS+wfUmo2CPPOaVotexymf6xloK75yv6miQ
         T4QDN5TI+S6L45Bsr3doVIDDkFHoZr1TyywiKeJhQceW2OFgaISr/5lCc1SCfl5v1qQ2
         D4VjKzNlH5R0GZ6ze/p9xLyPfFMlw80MGZM+AJvj3LR6rymVoBCQ/hUlDN3sPlnmyTmU
         39P3y/KWjYRGBhCbyBegy236FPg92GUMGeBJgUM+xiuOwyotD8oJpv8Hc2oqCLLuGfsi
         vY44qdg+EtEfEWyD09+I/GrtP2eMc5xgFcObEsAG8/w/fJuePiys41jnWqOJScvaAOmy
         r1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5WtAORZ7SLKlJMzImdvIvZ4TLDWK4cV3hlxUTvVcgm0=;
        b=B2HPZeaDq9pzid+YVXF4DtaN3JPzJDObgh2dpiyKPam287XjyvCP6c+7q4ztqpTG2o
         0lIGvx16HaX3uzff6aK667l3lzkQesRyxDknBlqkUIONrgE99r4KEQPfIpVT1Qg+ct8D
         3dkpye7GA4G4YMRXw8hbJGDPFTDC+AInSpcU7qXXkWZFlvYH5AqaxFDP8jw8pvV1meB9
         FDiQdlHQAbizTOobylTftNpQ4yLPNdNuZUqITqC0lGOyI6ZU8/4i1lIdf8xmwWjeerv8
         y+0PGDlS2kTlzqTub0QichXNNPFw37jlEmrbGzyPZ8vhFUAAJUNVjpe8DxJRCPi+n+Bp
         FxcA==
X-Gm-Message-State: ANhLgQ0hQiLkguIb+FyeZi2+nheLDpey/1zehNBTTtH9u3TeLr8/B1PX
        jX+MHOIS2HSOa9bES6Gf4i+PsGnmgg==
X-Google-Smtp-Source: ADFU+vv4ppWOXgl7BA5LMYVaLuMmRS7QvvyfGGP9o9MIRW+9mrUpZ7dEgMdw+2umUBVT1P11GBDgo7Qq/Q==
X-Received: by 2002:a17:90b:19ca:: with SMTP id nm10mr5930332pjb.161.1584658097568;
 Thu, 19 Mar 2020 15:48:17 -0700 (PDT)
Date:   Thu, 19 Mar 2020 15:48:09 -0700
Message-Id: <20200319224812.202013-1-kunyi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH linux hwmon-next v1 0/3] Add SB-TSI hwmon driver
From:   Kun Yi <kunyi@google.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     Kun Yi <kunyi@google.com>, openbmc@lists.ozlabs.org,
        joel@jms.id.au, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*** BLURB HERE ***
This patchset adds hwmon support for AMD SoC SB-TSI emulated temperature
sensor and related documentation.

Kun Yi (3):
  hwmon: (sbtsi) Add basic support for SB-TSI sensors
  hwmon: (sbtsi) Add documentation
  dt-bindings: (hwmon/sbtsi_tmep) Add SB-TSI hwmon driver bindings

 .../devicetree/bindings/hwmon/sbtsi_temp.txt  |  14 ++
 Documentation/hwmon/sbtsi_temp.rst            |  33 +++
 drivers/hwmon/Kconfig                         |  10 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/sbtsi_temp.c                    | 218 ++++++++++++++++++
 5 files changed, 276 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/sbtsi_temp.txt
 create mode 100644 Documentation/hwmon/sbtsi_temp.rst
 create mode 100644 drivers/hwmon/sbtsi_temp.c

-- 
2.25.1.696.g5e7596f4ac-goog

