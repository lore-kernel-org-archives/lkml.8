Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F79BC33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 03:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59DD2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 03:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOdhh4SH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbgAQDqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 22:46:42 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:37239 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729567AbgAQDql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 22:46:41 -0500
Received: by mail-wm1-f54.google.com with SMTP id f129so6095781wmf.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 19:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=nBsOi7qo2/t1sKXFYbln9CglVWat/u9OXSO1nJqHBl0=;
        b=NOdhh4SHOUVywYRor13V4tHLLL5OHQ4kbrNsUlE95poNIlt5unkiXepFqZRxi1SMqT
         bkGTxTTHHkXyCueHKzmbqZF1aEari39BIxIoMMTikfKrwVC08CrSqd+ppsduCa/0CivV
         bv0olZorUdegNj7d67BBEjFNtGgOYlHWr6RvrIwphvatjy1Z+XH2USEDmMMCNXOohVra
         9Uvt93VSb/4Ebo7MPOdO2poXvW1kDBJz3E96gYRPhV600hrOy845Gd8IajLV2P/LMOa/
         pYBR2upp+m97TsCaP7ssGNgK7ES6D2yQOecd6yjmgw9WO13b+u7t2mwAh0bw5H3yFabI
         BxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nBsOi7qo2/t1sKXFYbln9CglVWat/u9OXSO1nJqHBl0=;
        b=Dl5xTfzeVaDuu3mJrZBdZ2H1uApOLn10tZ9QqISg5arX0fJofiFoPasj0cvgFLPtDw
         YMzUzUtZpmmqfmvBtX+Z0OrxQkA7JTA5yDrWGRXrElrglqjqjgbEtB0ogUQjs+YJYXPd
         F+Fp1SFlIP14BHrJQkVREgPVRE4oe8lOc0DjgFgOlUmD+zaVv70DUYo9WHqcQZNV3S0p
         D2rv+stAA9SbzXJlQ+f0yq2KjElKnvpdueCkmymIylBgdX4mji3nfWva0fpvAKj16sNs
         ybHtyKe81/2RaqETzkzYKjALH8Bm19oJ++onlPygwuSl9cBP/OmQbmX4FeCxPdewOcFE
         HNFQ==
X-Gm-Message-State: APjAAAWMLNSie0QhrZpP3VbEvrEm5t4/WUdrWZRObRcs9AWONXps13SU
        ZDXb1qdUpOfJsAN+3LG/dNntiv4oV4MOkw9bOxHoWFAiAWA=
X-Google-Smtp-Source: APXvYqwZLJ9/rnA/t8CJHWbv6KElbhA3HMz4WY5YWak9MqEQ9QXYuEDlR5sCzwcXFFxodRrU2TZZiPhZnKQE9JQDKEc=
X-Received: by 2002:a1c:9cce:: with SMTP id f197mr2326748wme.133.1579232799576;
 Thu, 16 Jan 2020 19:46:39 -0800 (PST)
MIME-Version: 1.0
From:   Jeff Chua <jeff.chua.linux@gmail.com>
Date:   Fri, 17 Jan 2020 11:46:28 +0800
Message-ID: <CAAJw_ZsrUP54N5Ko2PrZm2BnKbxv44pXL3Ycw1Ux2onAFqrOVQ@mail.gmail.com>
Subject: No realtime clock (/dev/rtc) on new ThinkPad X1
To:     lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Got installed Linux 5.5.0-rc6 on ThinkPad X1. CPU is i7-10510U (Comet
Lake) ... and /dev/rtc is missing.

Linux is latest git pull (f4353c3e2aaf7f7d3c5a18271b368bf5292854c3)
CPU model name      : Intel(R) Core(TM) i7-10510U CPU @ 1.80GHz

Am I missing something?

My best.,
Jeff
