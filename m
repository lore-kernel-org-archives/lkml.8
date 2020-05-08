Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05575C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 05:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E58D1208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 05:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgEHFWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 01:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgEHFWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 01:22:41 -0400
X-Greylist: delayed 2594 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 May 2020 22:22:41 PDT
Received: from omr2.cc.vt.edu (omr2.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:33:fb76:806e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734F2C05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 22:22:41 -0700 (PDT)
Received: from mr3.cc.vt.edu (mr3.cc.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 0484dPDB003164
        for <linux-kernel@vger.kernel.org>; Fri, 8 May 2020 00:39:25 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 0484dKKV005387
        for <linux-kernel@vger.kernel.org>; Fri, 8 May 2020 00:39:25 -0400
Received: by mail-qt1-f197.google.com with SMTP id w12so476251qto.19
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 21:39:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version
         :content-transfer-encoding:date:message-id;
        bh=Dm06ZAKZYIX7YP7mgGyJ/rXR8epdEB9fSQnJcSEERv0=;
        b=ldmWnJIp/sVwDUIixbnC2XEp5a5MHtzQaLF4s/yPRG74QpjTfY9emz+v3+aTWbKvha
         IbBp2AE+uJqi/J3mSPpxKu9wmYH3Z0luNxfdjsg+fYvgq5TGKb1bz2uvWEQ5j6wdgAXf
         LpG7tM7RgnHkCN/lj8ba/Kx9p8irG+y02NQYgW9C7eAwCTGU2/m9fe5Zo1jxhn2H4kE2
         JBtyBoaGPEcYnC0rDhxU4Pmh+Zd9gz0/QAIEXFDADk3VPAqLLyYmCmIEfmtwKt+mLijz
         yXY+b0YZfVcEb95GmATGHfHbVrNh2ciFi6IpML2gplVmBOBYkfQvxOPvPtVtk8LfdZ7t
         RvZQ==
X-Gm-Message-State: AGi0PuYeQzarDiLOhCX+JnlpLX16JenyWAiv8Zrxfa/q2G/T/+0/4oMA
        Vvm++HD70y4PF89xqW9EfMR1HnHpNnyPl9hKLtQl+WvKWrnetCCk5QSHtU0Q/qZqfd6YcGSl1Z/
        ExdNSkOq0y9Pn6DlC8w8nQbNndG/GTUJUvVo=
X-Received: by 2002:ac8:4ccc:: with SMTP id l12mr971196qtv.129.1588912760479;
        Thu, 07 May 2020 21:39:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypJZvgYBYOZoJzUErxWw9UD6lNr0XHDTIdHvnfdB1sZ9pIcck8dCVstQ+Px8izYngtQhOv/vLQ==
X-Received: by 2002:ac8:4ccc:: with SMTP id l12mr971144qtv.129.1588912759384;
        Thu, 07 May 2020 21:39:19 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id h2sm358428qkh.91.2020.05.07.21.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 21:39:17 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: linux-next 20200506 - build failure with net/bpfilter/bpfilter_umh
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1588912756_228720P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Fri, 08 May 2020 00:39:16 -0400
Message-ID: <251580.1588912756@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1588912756_228720P
Content-Type: text/plain; charset=us-ascii

My kernel build came to a screeching halt with:

  CHECK   net/bpfilter/bpfilter_kern.c
  CC [M]  net/bpfilter/bpfilter_kern.o
  CC [U]  net/bpfilter/main.o
  LD [U]  net/bpfilter/bpfilter_umh
/usr/bin/ld: cannot find -lc
collect2: error: ld returned 1 exit status
make[2]: *** [scripts/Makefile.userprogs:36: net/bpfilter/bpfilter_umh] Error 1
make[1]: *** [scripts/Makefile.build:494: net/bpfilter] Error 2
make: *** [Makefile:1726: net] Error 2

The culprit is this commit:

commit 0592c3c367c4c823f2a939968e72d39360fce1f4
Author: Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed Apr 29 12:45:15 2020 +0900

    bpfilter: use 'userprogs' syntax to build bpfilter_umh

and specifically, this line:

+userldflags += -static

At least on Fedora, this dies an ugly death unless you have the glibc-static RPM
installed (which is *not* part of the glibc-devel RPM).  Not sure how to fix this, or
give a heads-up that there's a new requirement that might break the build.


--==_Exmh_1588912756_228720P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXrTicwdmEQWDXROgAQLCSA//UqzDH6Xrc8pTpaZYj6PQFrnX7JxNxPEw
7XF4cADkh8YyVLIya15u3roNmb993e8UtqpJK2E4/kjDP5MB81NN/9qA/5r3Cb1g
OaiYFTXl5wtwIyhc8vegiLqNrzs5ZV8VsHEt4o2QbY1tm/ubErebDSXbrdu1bQx9
qPIBzhk6FDBik1NnyT4ouUbkL2L5xxK/+SIxkqKF56rWpjFyg1IvOCuJgq0zziN9
RpDMjUzXqjty9AudhwTK/o/pNoJJ4VBBDpcA73+UWoiU0Rcxa8WTjf0qiLVhsF2j
y6lT49uCsfG+mfzeGPZMxxziS4Mbaglq+LqZtsD6ni3+IaUckz4FY6nRdQys1Fy6
wz7e97Yxem3qzWKuOum10cU6sF4WXbyp0mTK9STQZMN6o7lVO95GDhEZDYf6X4x3
9z6K7CgqHceQNoXAPKm32hz3Zcwnz1XajB9zda+F103mXgldccmYba+uyk8YDCct
B10n104eo3316gUz5k1/LMQtCjIOFBvj+2UQTaN6x1U514rJu2ddrQVrD+lVShvV
M3jLq73GWXU07x4xO7CgQMwwbHKf3zD28i7wAOy4FY0LxIIDwtrsx9jGQsHaX4nm
JuiPSWAGY8u7aikcoWVM5K0vk0Ea8Bjj9LlLzTHK0ZmDunKsAjTIE4/O3aQR3h6W
6PQ9qiuQN7E=
=SYBk
-----END PGP SIGNATURE-----

--==_Exmh_1588912756_228720P--
