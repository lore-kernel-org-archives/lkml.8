Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FE0C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 06:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D31B9221ED
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 06:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuH75S8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgIKGh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 02:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgIKGh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 02:37:57 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AFBC061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 23:37:57 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id q21so8842748edv.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 23:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:user-agent:mime-version;
        bh=JYsIzWJNQ9HOskt53qaA1OI6xr+mABes6ItMjhTm61E=;
        b=GuH75S8E3FBb4ColCdULSnNfKahWmeLofLG4gf7THTUBPg/9DkOiGWy8EEzDtnilcZ
         G4yx317j7KBsfXRkcRa+91iL6trtADQpPZBToBMUWHmkQCyaIhDmCONGuOrF4EuR0Q6b
         sR/JgmUSZoarrE1uNxXwB3ylsCwfS+OxdxA4F3ego/M0MPyQIRBI8+nPqC2OVzbkCLHk
         Fb5/o7PH9OCtZuyOu+jsarajsVL2aPnwVFPWAuKAx1eP/oX6eLb1s4IEbaYf9E1PzWPX
         1xYzdtkDN1y3i5/1Y2R855rFLThh5LJdyNINRZ06vYTARop0cOVxh/f1tPd4yyfkeJM3
         5lew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=JYsIzWJNQ9HOskt53qaA1OI6xr+mABes6ItMjhTm61E=;
        b=WvLNMYP+qFLP0Vtfs0CUagHY/jsLXMyr76TOdVbH1gNSBpfaRePmwFrpd4eVQ5Y+Q2
         BhdNh4frm0O2x8Gc3QFu11kx7s8H6ZHhIxm6Z0Jy3FnG4knL2nbpU4t3RTdIi9K7xjEY
         Gt6oftKnJ14XnDVvLt/HVND37pKlUnI6nIdXrLO7Htin+zKlSUFRtee+fNdh7Nsrolyl
         bDBjy7tH8q+hTe2RS7VEfP8765Y171HSKtLMkhUOAyF3SJ6znAbyYSYGCypcugmLMHyi
         Rlc4+yGCTWdW89RMM+NHzVHumKdpYCA6R160EpxkIMQSR5q/WvIdkoVXOtc4zxQxpcMI
         ehNA==
X-Gm-Message-State: AOAM5301E2Tfe82oeXYRHZRk3fJt9hjIQsSUIStnBLtkay+1UUJAAppN
        kXCB2qqLTcLda4UTmKxjYis=
X-Google-Smtp-Source: ABdhPJwMNHZVMsTH1f2tiU2z/5HkR5tdCT0HGAc7uMbFikD7BsQmEea7xMi5fwkal+SE1TGvXGxNWQ==
X-Received: by 2002:a50:d7ca:: with SMTP id m10mr471855edj.259.1599806276224;
        Thu, 10 Sep 2020 23:37:56 -0700 (PDT)
Received: from felia ([2001:16b8:2dfa:1900:b0c3:335:87f7:d616])
        by smtp.gmail.com with ESMTPSA id j8sm886500ejj.91.2020.09.10.23.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 23:37:55 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Fri, 11 Sep 2020 08:37:54 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Joe Perches <joe@perches.com>
cc:     linux-kernel@vger.kernel.org,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Subject: MAINTAINERS: Marking internal distribution lists
Message-ID: <alpine.DEB.2.21.2009110811520.9220@felia>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

in my continued effort to clean up MAINTAINERS, I came across various 
email "lists" that are actually just some kind of internal distribution
lists, but we cannot subscribe to them (no archives available) and they 
are not affiliated to a specific person.

Some examples are:

  - bcm-kernel-feedback-list.broadcom.com
  - brcm80211-dev-list.cypress.com
  - brcm80211-dev-list.pdl.broadcom.com
  - coreteam.netfilter.org
  - esc.storagedev.microsemi.com
  - linux-imx.nxp.com
  - megaraidlinux.pdl.broadcom.com
  - MPT-FusionLinux.pdl.broadcom.com
  - ocfs2-devel.oss.oracle.com
  - oss-drivers.netronome.com
  - patches.opensource.cirrus.com
  - qat-linux.intel.com
  - rds-devel.oss.oracle.com
  - sparmaintainer.unisys.com
  - wil6210.qti.qualcomm.com
  - x86.kernel.org

One of the dots needs to be replaced by an @, of course, but let us not 
make it too easy for spammers to pick something up ;)

Some of them are mentioned in MAINTAINERS with 'L:' entry as those above, 
some others are mentioned in MAINTAINERS with an 'R:' or even a 'M:' entry.

Greg KH also called them email group aliases and does not want them to be 
valid entries for maintainer roles ('M:') because it is unclear who really 
is the maintainer for such sections (when is it orphaned, when does the 
maintainer actually change, etc.).

Would you have any recommendation for marking/handling such email 
addresses in MAINTAINERS?

I thought about the following options:

If the email address cannot be affiliated to one specific person and the 
list is not subscribable,

  A. should we then mark them as 'L: email (internal)'? (or 
     some other keyword, such as non-subscribable, restricted group...)
 
  B. should we just make them 'R:' entries?

With a bit of searching and guessing, I can probably update all those 
entries in MAINTAINERS and pass them to the according mailing lists for 
review and inclusion.


Best regards,

Lukas
