Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7627EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E855207D3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389795AbgE2EQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 00:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbgE2EQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 00:16:43 -0400
Received: from omr2.cc.vt.edu (omr2.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:33:fb76:806e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB39C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 21:16:41 -0700 (PDT)
Received: from mr4.cc.vt.edu (mr4.cc.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 04T4GdAv008792
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 00:16:39 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 04T4GY7v004134
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 00:16:39 -0400
Received: by mail-qt1-f199.google.com with SMTP id e8so1404650qtq.22
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 21:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version
         :content-transfer-encoding:date:message-id;
        bh=AxImIuZw0Xc1fI893sOoM6bfzHzhBthxYqedLKLYczs=;
        b=pprgOWSKHyyAon+gG2pJv+I2d/l6vVqT+yyKU2+N/ysSXZeFhWnB6UZU8Wrj6+KHAw
         PvzOl9Bd3LYhDoedFiHp8e+bXMUx3GbVGZEsC8WNVgRJOl4IGJSuuLaRKEVmlpOpXiDm
         KRatNpuQ/RK0j0U0EQQyviHaTlx6K1bTkuLQqB9G9ZxE02UFJfPErDDpSKfxrRJQsGMp
         kcFzqRmDE9iAUSE6suj47sdv0Scg3GzwHotbWJGd9nY0Lgh5zXn7YE7FbgD/zZ/2ZZuG
         p4lfMU9+UPLVoGkXdM+pzQaAuZrcrGHZv7gzdr/oUBT8oCYnp4fxObACYmAeIlPPeFwx
         Ei3w==
X-Gm-Message-State: AOAM533Q+/PGaTsBDyC2CFLjP/CYEj0vl9tGGkRL/+aQx2v/ihTugl3k
        /toJQ6rShmo3nZ9QOxEw10fxr0CYbew2LYCoE1AyRo8ElkmBafFeARZcBdE2iZf5M8b5OBk/WbL
        /y+4a41K6DawsKiupwruOqBkTyPLqnU+Zs28=
X-Received: by 2002:a05:620a:204d:: with SMTP id d13mr3961137qka.440.1590725794054;
        Thu, 28 May 2020 21:16:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwylGkbQkpKBwN9Hxm3hLi1y+Q2nzoPFTPJC4/EVqadyW3+hHXvOBEpDFCcJn4ujzN4BW+Z6g==
X-Received: by 2002:a05:620a:204d:: with SMTP id d13mr3961123qka.440.1590725793669;
        Thu, 28 May 2020 21:16:33 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id n85sm6608670qkn.31.2020.05.28.21.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 21:16:32 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: next-20200528 - build error in kernel/rcu/refperf.c
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1590725791_16657P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Fri, 29 May 2020 00:16:31 -0400
Message-ID: <538911.1590725791@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1590725791_16657P
Content-Type: text/plain; charset=us-ascii

commit 9088b449814f788d24f35a5840b6b2c2a23cd32a
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Mon May 25 17:22:24 2020 -0700

    refperf: Provide module parameter to specify number of experiments

changes this line of code (line 389)

-               reader_tasks[exp].result_avg = 1000 * process_durations(exp) / ((exp + 1) * loops);
+               result_avg[exp] = 1000 * process_durations(nreaders) / (nreaders * loops);

On a 32-bit ARM make allmodconfig with gcc 8.3, this results in:

ERROR: modpost: "__aeabi_uldivmod" [kernel/rcu/refperf.ko] undefined!
make[1]: *** [scripts/Makefile.modpost:103: __modpost] Error 1

I admit not understanding why the original line of code worked and the new one doesn't.
Maybe gcc is smarter/dumber about the ranges of 'exp' and 'nreaders' than we thought?

--==_Exmh_1590725791_16657P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXtCMngdmEQWDXROgAQI7MA/+PaUvCN+J+yGgfNRmfThCGdLitHgMT/pM
3l8r1S3bKK+IO2sB/SAGJg2VfEXDfpsNqMnQ3xq/qzXIVhz398DoUQsbXFVJlXxd
Z/weNlo014uQI6zQ/lmZgM8lPJbGf7gKbQdubVYEjopITztw7+wZ44v+lcup9Ju5
15KdCT5dsUlR8osTEVheW778uZNcEAuJDXhmiHT+Rf8+4ae/MIVEllen/nZ7lE4w
NUCO5IvFSM6bEt4WiVobZCUeapvirIJ16b0djsq9zT8FJOKQVFuodSXUVws9+TzG
fbYnsS7QRQsOAwcDP/FctWtlth1o1oxQ+j/xnv4DmWj2CCX1ssLRpUvEisYNUA4y
4VrSOgIuAZej5vSVchKAVzuVmC724fTA+pEWQjfbr26a537hgG6C8qnHVsqHuhMV
iN+E8Eof5QFhxRW+pQpEA0l09CZGCCFJt1O07d40pWKzlA0lW1/BKfpxikebrVUW
yhcDOWVI96vSi2Sg/6bO1M3PaLMS9smXMxAeLwf5JTJ0+KbSjlEYuAZyD2FKGcFy
W7P0gsaKj3d7wXCEIJTKq6EidnmVGwGym2J6Ceex1cocf1izxgajF6UDxRhAqoaD
NYjhWFgZUvT9Yo8IHzY7peaolq1csokzlYDUDKGFQQJ+s8IOsDc03OsMW3+O7li/
D0aWKEiEAaE=
=o/84
-----END PGP SIGNATURE-----

--==_Exmh_1590725791_16657P--
