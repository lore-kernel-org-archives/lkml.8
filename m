Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35931C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 00:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05B70206F5
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 00:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rd4hjHQV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgFMA51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 20:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgFMA50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 20:57:26 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A75C03E96F;
        Fri, 12 Jun 2020 17:57:23 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u8so4324504pje.4;
        Fri, 12 Jun 2020 17:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Kak9RTcXH+4k1Bq+r0Eico4rnB7HcnY6/d7GwzMpklg=;
        b=rd4hjHQV7QMHyFZSCuw6qnTVjFEi4NMQfAXUViJNyZr2qVVFvU5rx/QheZaE7t7oCI
         p7XTUkhlgVH3CCuJYuOEsUK7nwxXDQ+M/n+CzOvqgL+sd9iTJyDPP9Vq5mEuoqPYDTHJ
         A0euPh0FVRMc6vupo6H4GAOo9cy0Xy3/9vt3/yjPI6Ffn4QRtpaBf1HKtgnlA9SOcsYk
         VWiO/eXj1CR5sIsVqcp8dXsqhiU5bDuom1jB1pR4IFxZVqESeYDQ5s7ik6qY8zjl1XIU
         uTEOP3SD29RctBs1CPzuY6cSPSU9bP0gXOETl8F/5MypIQblyAqbRHXnJQWOlcIeJl7Z
         O5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Kak9RTcXH+4k1Bq+r0Eico4rnB7HcnY6/d7GwzMpklg=;
        b=DGqxKQ/NU8hnq1SgZJpkQ8I4T8wEMRijtbpoIn8GKHH1RcTDWA7oJFsPJlAkNwdYpC
         2EazztjfayqvO/bpeLWbvfWKMYi0VMXfwaDqtnmODO4N/ttd7yxOLpzEXSckFh7771YV
         /hzAciYn3XHjW8fgP4MSevecw97cSIEum+TX4JflmArWIr05y9kTwVTiPkH4NUc/Y4Ee
         yTJ61QJ9NwTOcruMovXAoJZllKnPPXCH4yPlwdi2fH6XtqyrZoFnrsguFq1lrS3FsIwE
         1KxNEs8f1IIbgZqIidlckE6lakumoisCDt/7hCH6NxWP2HlzLEYXG4ha63986aJaFKCN
         qVEA==
X-Gm-Message-State: AOAM5317mNz2QeWUFIKEimK/dtjGyJku+DKd4K23BoOXO6y3enJw/Od3
        F+SreUdf++a3ULRNtVZ+i14=
X-Google-Smtp-Source: ABdhPJzn4chJKvY8H19lo81yC/ZZSddLtUkK4nadfv44VK/oP/SnqXfK53twcvlno359o8FqklogjQ==
X-Received: by 2002:a17:90a:46ce:: with SMTP id x14mr1429754pjg.121.1592009843084;
        Fri, 12 Jun 2020 17:57:23 -0700 (PDT)
Received: from localhost ([108.161.26.224])
        by smtp.gmail.com with ESMTPSA id gm11sm6232274pjb.9.2020.06.12.17.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 17:57:22 -0700 (PDT)
Date:   Fri, 12 Jun 2020 17:57:19 -0700
From:   Matt Turner <mattst88@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>, Xu Wang <vulab@iscas.ac.cn>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Jason Yan <yanaijie@huawei.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        Enrico Weigelt <info@metux.net>
Subject: [PULL] alpha.git
Message-ID: <20200613005719.GA344350@p50-ethernet.mattst88.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull a few changes for alpha. They're mostly small janitorial fixes but
there's also a build fix and most notably a patch from Mikulas that fixes a
hang on boot on the Avanti platform, which required quite a bit of work and
review.

Thanks,
Matt

The following changes since commit 79ca035d2d941839f55f3b8b69f8e81c66946ed8:

  Merge branch 'proc-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace (2020-06-10 15:00:11 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mattst88/alpha.git for-linus

for you to fetch changes up to 777747f634ba765085373f851e9c48dccb12ad52:

  alpha: Fix build around srm_sysrq_reboot_op (2020-06-12 17:43:18 -0700)

----------------------------------------------------------------
Chuhong Yuan (1):
      alpha: Replace strncmp with str_has_prefix

Enrico Weigelt, metux IT consult (1):
      alpha: Kconfig: pedantic formatting

Jason Yan (2):
      alpha: remove unneeded semicolon in osf_sys.c
      alpha: remove unneeded semicolon in sys_eiger.c

Joerg Roedel (1):
      alpha: Fix build around srm_sysrq_reboot_op

Matt Turner (1):
      alpha: c_next should increase position index

Mikulas Patocka (2):
      alpha: fix rtc port ranges
      alpha: fix memory barriers so that they conform to the specification

Xu Wang (1):
      alpha: Replace sg++ with sg = sg_next(sg)

 arch/alpha/Kconfig               |  4 +--
 arch/alpha/boot/tools/objstrip.c |  2 +-
 arch/alpha/include/asm/io.h      | 74 ++++++++++++++++++++++++++++++++--------
 arch/alpha/kernel/io.c           | 60 ++++++++++++++++++++++++++++----
 arch/alpha/kernel/osf_sys.c      |  2 +-
 arch/alpha/kernel/pci_iommu.c    |  2 +-
 arch/alpha/kernel/setup.c        | 12 +++++--
 arch/alpha/kernel/sys_eiger.c    |  2 +-
 8 files changed, 127 insertions(+), 31 deletions(-)

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iNUEABYKAH0WIQSzlptPDvl9ch5jjr2cglpmBdQLvgUCXuQkbF8UgAAAAAAuAChp
c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjM5
NjlCNEYwRUY5N0Q3MjFFNjM4RUJEOUM4MjVBNjYwNUQ0MEJCRQAKCRCcglpmBdQL
vmJ0AQDEUQ90XFumMJqmNHYXWHAVKD0Lnq9shA/JcBHGXEnVtAEA7QMibeXRD4Y1
3PHd/H9JH6EmXGmnheCPU0k/Xy/LEAA=
=KLX8
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
