Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97E3C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 20:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FC120749
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 20:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="SIk3jEAG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387456AbgCKUR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 16:17:26 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:35817 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387438AbgCKUR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 16:17:26 -0400
Received: by mail-oi1-f180.google.com with SMTP id k8so1755219oik.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 13:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=dgYAkXI3ma7Oc+dHyFkSF1DkN+fuarKTOkldg/gMqBQ=;
        b=SIk3jEAGoobST4zcCoFLiVGcnfP2rEcJY2fki+Tb8StA3B8A87tiTLKU7onvD5gOf2
         WDhlb1gKf5IAzMjtLudGF0hQV3OCg/2fzXJmsj74lUbpVHY1wzf8vCcb/nLgTWsziSIK
         1VwBohoU7CgeaKKowFZ5EDpWGV6uXf+rtc4EqHr3zdSUc8nLuEJiLri+H/x43uTkI5zt
         D2oC2Y1dJDIexxeY+uFLG3/mobhp8xfyGcjxvODk+24FMJVsXdoZexl0bt5/C2jm+DJs
         i4Dmoj4vYIhqsO9Z0g4jR5sqtVlyC4qgbP8FOGgeNAyL3VCFi06Cj29GY8isvmQCclg6
         IlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=dgYAkXI3ma7Oc+dHyFkSF1DkN+fuarKTOkldg/gMqBQ=;
        b=UnyG+pNcEpkeup2fEk1ffRLmIJ38D3W5iTGMMJFOSC9YkFHicsTj+T6PcX1JhvShSo
         mx+eOqxFUtUMTCvOnN5Zxdtd6XY1O3b0vMycKW8mlN7FGn8aVdlagBxCStgHdcq8B4sF
         5tyycRaNIsYcyNEmXXgFVwQMpBoPkbI/81bdQVwrUEfUPKZGg4lwuieqALMqZ7NhIIpQ
         +8/BpM+g0TxpQ8sTnRf9z25QnI0gY3rkgZN9Mh5AffxrppRiXdlXcGAIXTXujiLtfj7I
         ZDk4AcPsulGOr4ib85imeJHOwmdG8jal5zwCvEw64/Q/VMp8P57iLuIRzjSUnAdcgsTa
         lrGg==
X-Gm-Message-State: ANhLgQ3fuuwygU9szi5cSLqOoYTTYLYvYZ36leXWoh5h+K79mgjOjXNs
        xyI+sn4k+Ga50LHBTWys5fAgraD/Iiniw8dm+/AQ1Q==
X-Google-Smtp-Source: ADFU+vuAYlGMS4QcCId7G5LFjjM7mgfj2Av4YLv0smiA/DKEeOaqm4HPmM+Iwa/UyAz8SUv4IdkzedNnML8bV5vr978=
X-Received: by 2002:aca:1201:: with SMTP id 1mr315383ois.172.1583957843793;
 Wed, 11 Mar 2020 13:17:23 -0700 (PDT)
MIME-Version: 1.0
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 11 Mar 2020 13:17:13 -0700
Message-ID: <CAJ+vNU0qVnCkWpG_NKNQTdYf5LJpRrgOeWX0xH=GgavKJ1QNwg@mail.gmail.com>
Subject: CN80xx (octeontx/thunderx) breakage from f2d8340
To:     Marc Zyngier <maz@kernel.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        David Daney <david.daney@cavium.com>,
        Sunil Goutham <sgoutham@cavium.com>,
        Jan Glauber <jglauber@cavium.com>,
        Robert Richter <rrichter@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc,

Im seeing a failure to boot on an octeontx CN80xx (thunderx) due to
f2d8340 ("irqchip/gic-v3: Add GICv4.1 VPEID size discovery"). I'm not
sure if something is hanging, I just get no console output from the
kernel.

Is there perhaps something in the dt that requires change? The
board/dts I'm using is:
https://github.com/Gateworks/dts-newport/blob/sdk-10.1.1.0-newport/gw6404-linux.dts
https://github.com/Gateworks/dts-newport/blob/sdk-10.1.1.0-newport/gw640x-linux.dtsi
https://github.com/Gateworks/dts-newport/blob/sdk-10.1.1.0-newport/cn81xx-linux.dtsi

Any ideas? I've cc'd the Cavium/Marvell folk to see if they know
what's up or can reproduce on some of their hardware.

Best Regards,

Tim
