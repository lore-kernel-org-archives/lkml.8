Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51E4C2BA83
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 11:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A805220857
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 11:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="lClVNzu+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgBPLyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 06:54:14 -0500
Received: from mail-pg1-f174.google.com ([209.85.215.174]:46886 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBPLyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 06:54:14 -0500
Received: by mail-pg1-f174.google.com with SMTP id b35so7416689pgm.13
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 03:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=GZIc7P0G1/JUkwKtzLRD2+1b1DnogPOt/ACkqfOwTSw=;
        b=lClVNzu+n0Nk/nXJrhxPh37NHZ7KlJyyFWI5EPszPrJtn13NN/eZ6y3pOK3fyOiiKP
         T2uZjPMXsJp1MckFaih2zJxn0XkDRl0JIe34q4vkZhd2flEkh+zvafYb5ZBPyJNQ4Hha
         9v/fFn/LpydMMOYvz8wabqeNF8o7tTa21gxkwxUWO/JMDRACeURK16kyviAODcEHOc1i
         kzo9Kjze0uFtys6nElipPfeR/8Z+cliqlVjerWXcTaDtycWxNDcJdbQDqgTFST0YEFtc
         YWjICsJinL4ngMH8LUaYdwkbodx4XJcLwGzI72gEed+JDginE0LcaMdvZurk6gVNkMd5
         M4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=GZIc7P0G1/JUkwKtzLRD2+1b1DnogPOt/ACkqfOwTSw=;
        b=oBzjL9gfuWWQQcQLqC+XozuaN6b4GeS7uVd5rpx1OoXTaUI5NDYFD7TqK5gM112FTg
         v0ABoFnP3xGeHv9Ez0gzJ9fEAOGWRhK942Gatq8Hv7HIME1nH7Uf0h1c+rNUeekTclE4
         4LxPvsrf5MTSrNnXDzeXAxEz915reSo7XDjjUsdJp6FxR0dcan5DC96c1jb2QYZ6WZk7
         chJdORp/w82EANeZaFI2P7chkaRCEDj4Pm/kMm9wKYyRV8oKNpAUynHCW39tuhM6tIYi
         oXLCryMqhJBNnCH4z7SRsaIg/tSbLhNc7FYUMW3dyufdtR5Dj0vCbIkRPNwlny9fUh0m
         FGYQ==
X-Gm-Message-State: APjAAAXwcuMKHrxMaWTiosIPTMHWtLp87iWLSPDlTM/H/UpAKeBsC9du
        sRvSX/3GsIrGmzN8ZZkgafXc4T7zd0k=
X-Google-Smtp-Source: APXvYqx86gZiGVi0MZgyiI8KDbUcqdNnXNXz9okc0PVGpnvfUeVQ8TpZpnmyh2ObA4WIoag4KNU9jw==
X-Received: by 2002:aa7:8695:: with SMTP id d21mr12189311pfo.199.1581854053410;
        Sun, 16 Feb 2020 03:54:13 -0800 (PST)
Received: from [192.168.11.4] (softbank126112255110.biz.bbtec.net. [126.112.255.110])
        by smtp.googlemail.com with ESMTPSA id w128sm13239379pgb.53.2020.02.16.03.54.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2020 03:54:12 -0800 (PST)
To:     linux-kernel@vger.kernel.org
From:   Rob Landley <rob@landley.net>
Subject: [BUG] distclean gets confused by cp -sfR
Message-ID: <bd2b5d32-1cba-78c0-f702-5aaddbcd5b33@landley.net>
Date:   Sun, 16 Feb 2020 05:59:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you copy a dirty linux dir as a tree of symlinks and then "make distclean" in
the copy, most of the .o files get skipped.

  $ cd linux; make defconfig; make -j $(nproc); cd ..
  $ cp -sfR $PWD/linux boing
  $ cd boing
  $ make distclean
  $ find . -name '*.o' | wc
    892     892   20017

Reproduced in commit gb19e8c684703 on x86-64 (devuan ascii).
