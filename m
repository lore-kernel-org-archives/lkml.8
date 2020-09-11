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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6920DC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 10:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34E422220D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 10:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4GUOCPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgIKKYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 06:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgIKKXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 06:23:42 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1280BC061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 03:23:40 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gr14so13133328ejb.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 03:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=tNRvmiWJDOMDh3dqwVbpsBb44/nhs1as4bap35suZ50=;
        b=a4GUOCPQE6EUAr3RBrvmEvINIdf/s2dKgexnw2WEUKz6UoTBXba9hrGX5txb6p97ZZ
         O47EGnLjYpnpIeepOht/l8RV/vgAUt4CzzVZqydRRWrPQnsA/+CGr4XT5WNzNJvye0Q0
         NnfYNWc9NYvR60YMax7FF8G1hvBO6XNiWzYYewaR5hzz9CDmbN+u62vug9r9dNT7id3q
         9WQQSm8jzR9RsJczGuMhMa37EcJaZ2uXxMP96rrRwWDpFeGRUkf0EcWPmX/nqLnh3HmF
         hD5MifSYmoEg066q17JfapCgkRzy42jPsc7YKUM/0V8JFTrnXnJD/ctRBAmlhrvKjSmq
         hAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=tNRvmiWJDOMDh3dqwVbpsBb44/nhs1as4bap35suZ50=;
        b=tI95C1sXbkN2VdxQ7Da07RSCKHGct80Q/8cQTu9APDH7HLmmFruuZGmBxpRk2OUaaW
         Ly6RcTVDiN80VhwEzqcqQegxLyYd97hc4xZVBWhE+N9PEGnGOTWccAJ1xGU+p5+524Mg
         pzqPWcE9wpqC6pHubrO3rGeQZq7oEGJoQMqAK/vEt42am017hGxBMtut7rNpUoHKYudr
         4BRn8MGv4BSNnUjZ6Z4Li5m92G6TONT1WeO3EUmx2y2A5qtIMIEhvMkbmNDLabdwsuVx
         KOZyREmPWlyY4WW1GrVKUREgtm/ZH3wM7WAVO03AT36noiHg/SE1Qz3l62wsKtJQXCtf
         3uYw==
X-Gm-Message-State: AOAM530bmAShxAboSb5tmfsRV+9UcUwqOPRUso7jGoACsrTRzkZ20TFP
        utib9wxpPjFqngY55da4hgc=
X-Google-Smtp-Source: ABdhPJzpbt2MYr6njG/K1pwqamHMNOmIfGVnyqAq+AayO2SojyxuQ0L+Q+qRrz/FhfSO8kISHpHGCQ==
X-Received: by 2002:a17:906:4754:: with SMTP id j20mr1399927ejs.293.1599819818775;
        Fri, 11 Sep 2020 03:23:38 -0700 (PDT)
Received: from felia ([2001:16b8:2dfa:1900:b0c3:335:87f7:d616])
        by smtp.gmail.com with ESMTPSA id d7sm1248315ejk.99.2020.09.11.03.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 03:23:38 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Fri, 11 Sep 2020 12:23:36 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Joe Perches <joe@perches.com>
cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Subject: Re: MAINTAINERS: Marking internal distribution lists
In-Reply-To: <7e513eea8ecf7ff1379d7a87245915469784121c.camel@perches.com>
Message-ID: <alpine.DEB.2.21.2009111219340.16254@felia>
References: <alpine.DEB.2.21.2009110811520.9220@felia> <7e513eea8ecf7ff1379d7a87245915469784121c.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 11 Sep 2020, Joe Perches wrote:

> On Fri, 2020-09-11 at 08:37 +0200, Lukas Bulwahn wrote:
> > Hi Joe,
> > 
> > in my continued effort to clean up MAINTAINERS, I came across various 
> > email "lists" that are actually just some kind of internal distribution
> > lists, but we cannot subscribe to them (no archives available) and they 
> > are not affiliated to a specific person.
> > 
> > Some examples are:
> > 
> >   - bcm-kernel-feedback-list.broadcom.com
> >   - brcm80211-dev-list.cypress.com
> >   - brcm80211-dev-list.pdl.broadcom.com
> >   - coreteam.netfilter.org
> >   - esc.storagedev.microsemi.com
> >   - linux-imx.nxp.com
> >   - megaraidlinux.pdl.broadcom.com
> >   - MPT-FusionLinux.pdl.broadcom.com
> >   - ocfs2-devel.oss.oracle.com
> >   - oss-drivers.netronome.com
> >   - patches.opensource.cirrus.com
> >   - qat-linux.intel.com
> >   - rds-devel.oss.oracle.com
> >   - sparmaintainer.unisys.com
> >   - wil6210.qti.qualcomm.com
> >   - x86.kernel.org
> 
> At one time, those sorts of email addresses were called "exploders"
> 
> Perhaps mark them as such?
> Maybe like:
> 
> L:	megaraidlinux.pdl@broadcom.com (exploder for non-subscribers)
> 

It is a bit long, but sounds good to me.

If that is still the terminology to settle for, I will send out patches to 
update the description and data in MAINTAINERS.

Lukas
