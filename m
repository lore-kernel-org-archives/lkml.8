Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9813FC55191
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 23:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 672E620704
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 23:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587858178;
	bh=Wa9pRor+FZOPY2ND7QNZBk7br1p7RSGFmR3CvEbaUMk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=1IejIhTrODnkui9UfYJS4DjDBKjkLI8hFB7af++tDjtFxk+MUuFfOcW3Ji0kscY5j
	 bDIsxUsBjKpn8TBb89YMnk70sYIad7VppzBFXiBF9yoNvS+9k4J+AkPRlju9LCwBQj
	 mjvJuLAKtJApbjS/6b5osXW764K9NNyKo6WSFi/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgDYXm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 19:42:58 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:43293 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgDYXm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 19:42:57 -0400
Received: by mail-oo1-f67.google.com with SMTP id h23so419743oos.10;
        Sat, 25 Apr 2020 16:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+HEWMzeY2Z+R1cn0KYsKeAg1YeSXi0Mg+04sBBJlfTc=;
        b=tz/r5aaOuflm27DzF/ChBRPar3U51v+FA1eEjgWX5hf8XxkIkGFFSqpq1T1bGHzecr
         /xnK8JDjFYDpWJEMTbVuUPE5XBJxj5dusMun4C7Ol7NLGodLYZ2gM2ygU+G9w5UaMJ4w
         LeqIg+/lpbdH4qnD3YdyNzKJm5yMExMe7ENtA9ADjdpumSzplUToyIpOTHmLvOFO5+0P
         wG09BIqp0E0BCJek1hmVps4I4Nitk2ftRap3Ur0TWYldtEDInmXZK1bu02fLwUHHyvfK
         os1qnTV0qPU+mfv+j71DNWNwT+nMLOEtnaOuAluIRkZ8COdPyGQtRLKeFi1pPNN/SxOI
         a4lg==
X-Gm-Message-State: AGi0PuYUcC0n86kXcJOgLI7gKxKa8/SFJy/D72ZkBC6uyTwjvl74SawK
        4o7RlBBIhKyFG85AS3meZw==
X-Google-Smtp-Source: APiQypKkjbBTjqSUlR6x0aO3oupijTopSqVOPLVvsIWAyUpGQQf5McdNoXkpwHf8bLuV01Jz9zO9YA==
X-Received: by 2002:a4a:9c8d:: with SMTP id z13mr13279565ooj.50.1587858175193;
        Sat, 25 Apr 2020 16:42:55 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r67sm2818967oie.19.2020.04.25.16.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 16:42:54 -0700 (PDT)
Received: (nullmailer pid 1923 invoked by uid 1000);
        Sat, 25 Apr 2020 23:42:54 -0000
Date:   Sat, 25 Apr 2020 18:42:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree fixes for v5.7, take 2
Message-ID: <20200425234253.GA32365@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull a couple more DT fixes for v5.7-rc.

Rob


The following changes since commit 0903060fe590105b7d31901c1ed67614c08cee08:

  kbuild: check libyaml installation for 'make dt_binding_check' (2020-04-17 10:45:23 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.7-2

for you to fetch changes up to 4bc77b2d211e107fa54b1f39cd0d7dac5537b8cb:

  dt-bindings: phy: qcom-qusb2: Fix defaults (2020-04-24 17:53:57 -0500)

----------------------------------------------------------------
Devicetree fixes for v5.7-rc, take 2:

A couple of schema and kbuild fixes.

----------------------------------------------------------------
Douglas Anderson (1):
      dt-bindings: phy: qcom-qusb2: Fix defaults

Rob Herring (3):
      dt-bindings: Re-enable core schemas for dtbs_check
      dt-bindings: Fix command line length limit calling dt-mk-schema
      dt-bindings: Fix erroneous 'additionalProperties'

 Documentation/devicetree/bindings/Makefile          | 21 ++++++++++++---------
 .../devicetree/bindings/mfd/st,stpmic1.yaml         |  2 --
 .../devicetree/bindings/phy/qcom,qusb2-phy.yaml     |  6 +++---
 .../devicetree/bindings/regulator/mps,mp5416.yaml   |  1 -
 .../devicetree/bindings/regulator/mps,mpq7920.yaml  |  3 ++-
 .../bindings/regulator/rohm,bd71828-regulator.yaml  |  6 +++++-
 .../bindings/regulator/rohm,bd71837-regulator.yaml  |  6 +++++-
 .../bindings/regulator/rohm,bd71847-regulator.yaml  |  6 +++++-
 8 files changed, 32 insertions(+), 19 deletions(-)
