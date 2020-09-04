Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8308CC2BC11
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E12B20665
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgIDUOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 16:14:08 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34806 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgIDUOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 16:14:03 -0400
Received: by mail-lj1-f196.google.com with SMTP id v23so9451481ljd.1;
        Fri, 04 Sep 2020 13:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=At+S5JZyc9Zm+52GjsVD6sS7Q92PnPRfNew2jlCBSY4=;
        b=CYh51hfOSGSU1k025B/yyx52c1q1eDqhCjILVvznk8+axwX7sVyOQ1GADMKccuzylr
         w8CNdNqzIm56sUrPy38XJxviuaWyZqLGNpng/v5cyStt28vEYI4EJoID2cYDEEl3eSQx
         cUsxgxLpl/GyQbSulAVwJdT0oafSFZYvEiKAJGGtlgB/Wbshp7EdlvCgikzAJ5BdH1Yu
         xR0VzctUqpd22pWq7T4BpIGE0lfldaVXz/IUX+g3S0crPnRdPLz/zHFCADxa7ePadBeT
         HiZ2j4zKwyJ2Z176gpvJzWSNUIQPDgj8/LlzrhsQEdtb5rxZCSZKpVJtmXzl+Jgq1bQ+
         ONRA==
X-Gm-Message-State: AOAM531RZd0lLgdIqEBDqb3kSJgACK6HovFia8FfrGdTUeqOCJzn2Weg
        2c8HiQWafjd87l4m+CtcmTA=
X-Google-Smtp-Source: ABdhPJyOWTIqrtXqErOx88+91MdhEusWqnJHGxKq/QirYJUhbK/MdJOSOdDLCajmGAobK2J007RA8w==
X-Received: by 2002:a2e:9047:: with SMTP id n7mr4954800ljg.125.1599250440040;
        Fri, 04 Sep 2020 13:14:00 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id a16sm1468533ljj.108.2020.09.04.13.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 13:13:59 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Guo Ren <guoren@kernel.org>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: [PATCH 0/2] drop GZFLAGS definition
Date:   Fri,  4 Sep 2020 23:12:56 +0300
Message-Id: <20200904201258.795438-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GZFLAGS is not used. KGZIP env var can be used to pass
additional flags to gzip instead.

Denis Efremov (2):
  ARM: makefile: Drop GZFLAGS definition and export
  csky: Drop GZFLAGS definition

 arch/arm/Makefile  | 3 +--
 arch/csky/Makefile | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

-- 
2.26.2

