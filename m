Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0B2C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 11:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD4F9206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 11:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgEPLTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 07:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726191AbgEPLTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 07:19:21 -0400
Received: from omr2.cc.vt.edu (omr2.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:33:fb76:806e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B6EC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 04:19:21 -0700 (PDT)
Received: from mr5.cc.vt.edu (mail.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 04GBJKZ2012049
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 07:19:20 -0400
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 04GBJFla014759
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 07:19:20 -0400
Received: by mail-qv1-f69.google.com with SMTP id q4so5373701qve.19
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 04:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version
         :content-transfer-encoding:date:message-id;
        bh=7nzjeA11iHruS820XTb1Yr4HhsdAtwCzcWD9bNKBytE=;
        b=fw1CksfLMBFynxQOWQ9I0nb8bjWS5sNG38buXCFw5L8AjIW8/uDi5dklsmRPIQ8Vz8
         RCagW9W2nzSamIiM4L8x4x0Sd/gAppWn3p3aQELbEXXGCNZJHdHVONwHMmiMa2puVxs9
         DQf+fJUl4jjaHXDwNErwcSH5Ry1c7mHk6cmlewYse/Z2V1R2ZeODGWMzC/96C1Hs2fxV
         sJkwKXr1OvD8kapp24DgNExTIgtzrPAzyl13EJuE67y+2KF7nwzmPL2/VzR/oYbdoE1q
         U+MA4kZueCaXCttGRLXz+7C4Kznm1X++U5KQ+O58nBV/kzvMNgnHZsHqQjTcXSIjMTQM
         pdqg==
X-Gm-Message-State: AOAM531ismOi/tDWhDeAesFjErs4XqzLD4rC7jH3oa7hxL3Cou87YJCx
        0hiGg6//knn9xj1FEXJpnU1AEB+3AwZhrt20nU73GRfS4uJYYKfrRLqPMGflEyNB3+4owmeHtVL
        4K9WAceCIqjtDnN5JX/JgUGQ0XGmsWnkNwFg=
X-Received: by 2002:ac8:361b:: with SMTP id m27mr7849356qtb.60.1589627955589;
        Sat, 16 May 2020 04:19:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzu/VgBeAalVkQ2AoXUd1YZ5quJJpKb3lrAyS34gggihg4EW4vEhNzxDCfoUii8huxWiaMoqw==
X-Received: by 2002:ac8:361b:: with SMTP id m27mr7849338qtb.60.1589627955267;
        Sat, 16 May 2020 04:19:15 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id g5sm3567148qkl.114.2020.05.16.04.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 04:19:14 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Hannes Reinecke <hare@suse.de>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: next-20200514 - build issue in drivers/md/dm-zoned-target.c
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1589627953_23225P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sat, 16 May 2020 07:19:13 -0400
Message-ID: <367320.1589627953@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1589627953_23225P
Content-Type: text/plain; charset=us-ascii

Am seeing a build error in next-0514.  -0420 built OK.
building a 'make allmodconfig' on a RPi4 in 32-bit mode.

  MODPOST 7575 modules
ERROR: modpost: "__aeabi_uldivmod" [drivers/md/dm-zoned.ko] undefined!

objdump and 'make drivers/md/dm-zoned-target.s' tells
me that the problem is in function dmz_fixup_devices(), near here:

@ drivers/md/dm-zoned-target.c:806:             reg_dev->nr_zones = DIV_ROUND_UP(reg_dev->capacity,
        ldr     r0, [r6, #56]   @ reg_dev_166->capacity, reg_dev_166->capacity
        adds    r1, r3, r1      @ tmp316, _227, reg_dev_166->capacity
        adc     r0, r2, r0      @ tmp315, _227, reg_dev_166->capacity
        subs    r1, r1, #1      @, tmp316,
@ drivers/md/dm-zoned-target.c:805:             reg_dev->zone_nr_sectors = zoned_dev->zone_nr_sectors;
        strd    r2, [r6, #80]   @, reg_dev,
@ drivers/md/dm-zoned-target.c:806:             reg_dev->nr_zones = DIV_ROUND_UP(reg_dev->capacity,
        sbc     r0, r0, #0      @, tmp315,
        bl      __aeabi_uldivmod                @
@ drivers/md/dm-zoned-target.c:806:             reg_dev->nr_zones = DIV_ROUND_UP(reg_dev->capacity,
        str     r1, [r6, #64]   @ tmp306, reg_dev_166->nr_zones

git blame points at this commit:

commit 70978208ec91d798066f4c291bc98ff914bea222
Author: Hannes Reinecke <hare@suse.de>
Date:   Mon May 11 10:24:30 2020 +0200

    dm zoned: metadata version 2

Reverting that commit lets the build complete.



--==_Exmh_1589627953_23225P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXr/MMAdmEQWDXROgAQLTXQ/+OU15bnjwmP85lolwTjIv5S1rqgFkYmu/
57mmfcH6/P0JC/BvSfrQbaV7HdVx6xBYoywU4N24/huMaYLebX4gUd1ZVaF5QIVc
XYndVZmi5cJb91q1SfzkV6Z6pcYdscMiyv+ViMuHR81G/4vBq4/CVYzyxKaGJBK3
tj6mCALx/qvTN7EokTX+RQY3WHv75vKbS+RmgSwVNcQVuLT+PR6rJqYCIhKcpNIh
54vj3sXGkkzHmhoKRck0qQ/h0yXLugHQtqpufLcAkoWwIIqRkcDKoJMqq15dZ8S3
tA9wQ665Su47SbiUe6hjq7vJGcNAU0KsexfnRdKxGKElr8XYiHd2X2c5N9kCVh7i
cLljCXsewU0tByCTo2KvzT9m5iEqQepjHcYJWhrDtrl3PkOnoVKeUoJD0G53ayoN
mbyNxFm0IVY/+V6+FfuDuSVJ7lQK4jv6upibc+WUsA8LVi+sM+GeSCJx4Qx3Sfxd
iFKJWW6e7rlpTy+eQp3ipIzR2rXgasfCaXTJXzIDkQiQKmUpeRTiMttInpyyFmwL
mJRgcxq6HfXmREcy6yTRZf/IaTtxV2j3A6YZzoSFfg/pj52nX6dPbuaYPlhPDlaO
6tWHzUk5DqIdh8ydmeK3KUrsCdvNPt/ksUuMkEi/vFQPOyQ1qFYC+9sdDltY4bXL
AbbIXSkzR0A=
=LIvL
-----END PGP SIGNATURE-----

--==_Exmh_1589627953_23225P--
