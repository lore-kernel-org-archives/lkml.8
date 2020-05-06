Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82819C4724C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 05:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 632BC20735
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 05:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qa4Zt0hu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgEFFvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 01:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727032AbgEFFvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 01:51:39 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF51C061A0F;
        Tue,  5 May 2020 22:51:39 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j5so642502wrq.2;
        Tue, 05 May 2020 22:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:user-agent:mime-version;
        bh=nSVb3PkS7tlyf+3taQPnEP1Eff6rnFW28O+T1NDOdcE=;
        b=qa4Zt0huxFz8HpA5bELEktHKTEcCLxRITJXkka3TjD3K1oRws7lktDVasgfGR4c6cD
         +CHvBYT+Q+63XzWERo73HdLbHj7x3th2TMr7DRDEXumaSousDTqztkM62ykqNIvhfN0J
         H8wWipCphUgsmTqQlfiYPJpOF8uemyUm/nBYZ+NXhSYYak+bPsSGuFEb5TAsl/cyWOPf
         x6k1sUpB+ulnhF8LliWQ+he8rpSRM1Hz/0gmuWo9WK21eoQgQrsWQ5EpxfHfjvbOdnrz
         VB+J8XOvAukaxJZ6Z9D9wMefVSZ04z3MMMUkShIo+GPnDLIPs5IyOVhVDZl2HRn2ObdB
         a52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=nSVb3PkS7tlyf+3taQPnEP1Eff6rnFW28O+T1NDOdcE=;
        b=UvO28+ZCcjjoW0ji17h5W0MNYeMAw/Zen5C68ql0sXh3BMGz2vzuF98AGgbTJYND7E
         K4Cxj0uYbaGmz2OtQtKj80Q+Z7xuZ2HmPjwEDWBNCSXCmBqtqdrf8f8Hw21WvEWfXDxf
         T8rugGBEn40Nr0QHE+BlyzcUXGIpP8Yr5y0L+atyNIq/EjNZktc7Cl/yPi1+mocoeYwt
         TzECvReRguBSYeOdcrkbIByUdXoeYeVcemT8JEBmpR0DbqydOLu3fzW+vM7/i5acV14N
         h8jcFyfXv1TuNQF6QuFIQtOnnSdSRhM+tzkSNUKUUqpY7BtvE9dvw8H0nhDGrWFWZ092
         vSkg==
X-Gm-Message-State: AGi0PuZkbeJbPytRTFPSr7UVBdzjF8E/Hf9r1VR07cMz7ON1B0kl5vhi
        qEvrpZDWbElJhQwTTa4l7FVkG3lB9jQ=
X-Google-Smtp-Source: APiQypIPZvMmeMC+/3D0zdDLWUsgmfJ8bkt0AnAOeqk3D/5PB61wRUAIAa541ltCRSrdQDdyQ0jfVw==
X-Received: by 2002:a5d:6b85:: with SMTP id n5mr7673266wrx.370.1588744298190;
        Tue, 05 May 2020 22:51:38 -0700 (PDT)
Received: from felia ([2001:16b8:2df1:2500:bc2e:80a7:2be5:2fcf])
        by smtp.gmail.com with ESMTPSA id 185sm1340363wmc.32.2020.05.05.22.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 22:51:37 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Wed, 6 May 2020 07:51:36 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Jakub Kicinski <kuba@kernel.org>
cc:     Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: MAINTAINERS: Wrong ordering in DYNAMIC INTERRUPT MODERATION
Message-ID: <alpine.DEB.2.21.2005060749590.7719@felia>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub,

with your commit 9b038086f06b ("docs: networking: convert DIM to RST"), 
visible on next-20200505, ./scripts/checkpatch.pl -f MAINTAINERS 
complains:

WARNING: Misordered MAINTAINERS entry - list file patterns in alphabetic order
#5966: FILE: MAINTAINERS:5966:
+F:	lib/dim/
+F:	Documentation/networking/net_dim.rst

This is due to wrong ordering of the entries in your submission. If you 
would like me to send you a patch fixing that, please just let me know.

It is a recent addition to checkpatch.pl to report ordering problems in 
MAINTAINERS, so you might have not seen that at submission time.


Best regards,

Lukas
