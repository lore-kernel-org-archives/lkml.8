Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297E6C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 20:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F21EB217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 20:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rubrik.com header.i=@rubrik.com header.b="XDaBLmaG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgAUUBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 15:01:38 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35379 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbgAUUBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 15:01:38 -0500
Received: by mail-pg1-f196.google.com with SMTP id l24so2094505pgk.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 12:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qfjJsIdbdeYfyoWYZI/v+xL9rsxmnFotagk/efJxZeQ=;
        b=XDaBLmaGKsvEWcDjGHgeVwG57SWuGhclAo6G2PUcE/5Zi8tJOPIcpFOalPhI2YjcIz
         ErPPyTkWJN5jZA2W4o6xO0KAyc986aY9CLTLXDnzUq38kfIwOpJ+nbpQ6vrUoD5qsNmH
         MXy+/DUOOrBFVv7w63wFCl4WZ2mLcqcJSMtjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qfjJsIdbdeYfyoWYZI/v+xL9rsxmnFotagk/efJxZeQ=;
        b=V5YyQEFzpcQSG20s2RkPaf4wpw9LfJGpcD33h8/tDi6sXHT7BMF8+zHiP8rxlniXgz
         AzMPdLAnOQe5B6x6435aHCoX31clsSeUhSRC7IriRD/XEw1A7+1KVRGRDEw1KpDOcFpU
         e1ROZw7u9UKSj+xzGpFxDF19O4r6UWQLGdEa+crpWcO96eC7vSff7UM7jZuJ/tgszbCy
         zjqRbE/AX/Wr37HbBTgNb3z4a9WQwTOJWEb/UdxqrUv0q9m+qK0RB0N7mJG2y6/0MvEf
         Fwz0aKWbo1yEZTOkPkhfI3F6yoZjV06fKrngHiGbmesZQOlJ6Vvfjxd6bjbYJG59ZBeh
         9ffw==
X-Gm-Message-State: APjAAAUzf06fcTcDwtE8M5lzSsj1kGlkzZZ7uPHbG7Pt+HpY1sBHyFG5
        FW3SXzHjNfPAKlakx2eZ4xBm
X-Google-Smtp-Source: APXvYqx6+px4l0XmU+9V7IVWwJwCbBzMl171NAwatnATO+rYrz+LfLVcaRFQF3IahVgYFFZvBIWQJA==
X-Received: by 2002:a63:6c86:: with SMTP id h128mr6631935pgc.200.1579636897415;
        Tue, 21 Jan 2020 12:01:37 -0800 (PST)
Received: from fa2cb4acc48b.colo.rubrik.com ([4.7.92.14])
        by smtp.gmail.com with ESMTPSA id p28sm42443677pgb.93.2020.01.21.12.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 12:01:36 -0800 (PST)
From:   "muraliraja.muniraju" <muraliraja.muniraju@rubrik.com>
Cc:     axboe@kernel.dk,
        "muraliraja.muniraju" <muraliraja.muniraju@rubrik.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Adding multiple workers to the loop device.
Date:   Tue, 21 Jan 2020 20:01:08 +0000
Message-Id: <20200121200110.52231-1-muraliraja.muniraju@rubrik.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <DM6PR04MB5754D8E261B4200AA62D442D860D0@DM6PR04MB5754.namprd04.prod.outlook.com>
References: <DM6PR04MB5754D8E261B4200AA62D442D860D0@DM6PR04MB5754.namprd04.prod.outlook.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the dd results that I ran with the worker and without the worker changes. 
Enhanced Loop has the changes and ran with 1,2,3,4 workers with 4 dds running on the same loop device.
Normal Loop is 1 worker(the existing code) with 4 dd's running on the same loop device.
Enhanced loop
1 - READ: io=21981MB, aggrb=187558KB/s, minb=187558KB/s, maxb=187558KB/s, mint=120008msec, maxt=120008msec
2 - READ: io=41109MB, aggrb=350785KB/s, minb=350785KB/s, maxb=350785KB/s, mint=120004msec, maxt=120004msec
3 - READ: io=45927MB, aggrb=391802KB/s, minb=391802KB/s, maxb=391802KB/s, mint=120033msec, maxt=120033msec
4 - READ: io=45771MB, aggrb=390543KB/s, minb=390543KB/s, maxb=390543KB/s, mint=120011msec, maxt=120011msec
Normal loop
1 - READ: io=18432MB, aggrb=157201KB/s, minb=157201KB/s, maxb=157201KB/s, mint=120065msec, maxt=120065msec
2 - READ: io=18762MB, aggrb=160035KB/s, minb=160035KB/s, maxb=160035KB/s, mint=120050msec, maxt=120050msec
3 - READ: io=18174MB, aggrb=155058KB/s, minb=155058KB/s, maxb=155058KB/s, mint=120020msec, maxt=120020msec
4 - READ: io=20559MB, aggrb=175407KB/s, minb=175407KB/s, maxb=175407KB/s, mint=120020msec, maxt=120020msec

The Enhanced loop is the current patch with number of workers to be 4. Beyond 4 workers I did not see a significant changes.
