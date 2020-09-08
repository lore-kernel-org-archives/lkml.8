Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FE1C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60CF1206E7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CS2hv5JA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbgIHQHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730979AbgIHP5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:57:23 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B48C06135A;
        Tue,  8 Sep 2020 05:35:08 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id a12so15758670eds.13;
        Tue, 08 Sep 2020 05:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7ODE/jSoFoT1RI4D1U/3TkgwGZ8r03CJLgahQ6P96U4=;
        b=CS2hv5JAC4mpz/2lV43ML1i02t81QdOqDFvelJkUXjnVLSJPUHyQaLEcJWPTgvCSfk
         mbPH8SttCaBK30PHUvaRM4UdUgm45nO0UqolJUHsaIiCUPAqW78HBxlzDFQO+UVVzEfM
         Bn3zuXTchdcW6ei46BAgGWuKQi9nYAxzmXSUKXUvFXtiU5E9XipilzjT46ZnW4+ctiZM
         FtvjPNRQsJJ0ucvT+3LzFwwB03erUWVIsfG3nGO3JU3X2y2+Uy7WmBOzlSaPWfxhz6VM
         APCMWvt2OmHngHAQ2wesYCg7E0PtZI5+JexgWa95yDr6WzHv6zHCkRHl4f25qfVVHMZF
         XqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7ODE/jSoFoT1RI4D1U/3TkgwGZ8r03CJLgahQ6P96U4=;
        b=f49Jer/5k7izE0WTmqTiQg0+MzithQbP1BD1pZR33oJIOjYWQQK9mRmOp7rdhUoPLj
         whmtZF22rXGcCQbj+AP0WLOw1rMaK9kiMbcjsJdB7bIhUYx07Bbvm2jXGgDFVOAbE343
         8kVA1EdN06Bzik1xOhqG1pLGWJ7yDpbyEy1iWF/CojO6H7FUs5UHe4k4YmHgz7oISDnZ
         2YWM4Tl3H/4/bcZ05uDnzE4cftAjsAc1kI+sDAco3kLFzk7WDdH6kk6H0CjPGNhDE3bD
         utkDHKTApcTy3f8X7+JLfEBrw+qZdduLTcBrrJi7nqDjrbQ2Yeys4cxllOaCDuOBbVNb
         Oiiw==
X-Gm-Message-State: AOAM5315rAiZiGg5XMq0aUVobhz8CJ1VbhCOoKIVKtQiXYHsfKQlFAUO
        ae30aOQM6pYfBYSy7JfBZw0+Gfw/yMa+4w==
X-Google-Smtp-Source: ABdhPJwMiNn1XGUvLXepu/tpSDLMSP9mR3gMF74QnCG8MATQcekKKPhXTyWT/Rko/faqKJfFztxzdQ==
X-Received: by 2002:a05:6402:b1a:: with SMTP id bm26mr26953000edb.209.1599568507189;
        Tue, 08 Sep 2020 05:35:07 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d8b:1700:7cee:a9ea:bd04:6924])
        by smtp.gmail.com with ESMTPSA id x6sm9399939ejf.59.2020.09.08.05.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 05:35:06 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Igor Russkikh <irusskikh@marvell.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-spdx@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 0/5 REBASED to v5.9-rc4] Qlogic drivers: Convert to SPDX license identifiers
Date:   Tue,  8 Sep 2020 14:34:46 +0200
Message-Id: <20200908123451.7215-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Igor, dear Thomas, dear Greg,

this is the patchset:

  https://lore.kernel.org/linux-spdx/20190606205526.447558989@linutronix.de/

rebased to v5.9-rc4, hopefully ready to apply to the current spdx-tree.

The rebase required manual work for adjusting the diff for MAINTAINERS on
PATCH 2/5 and 5/5, and PATCH 4/5 was adjusted to the file moving in commit
955315b0dc8c ("qlge: Move drivers/net/ethernet/qlogic/qlge/ to
drivers/staging/qlge/").

The rest was rebased automatically and I compared the patches afterwards
against the original patchset to make sure nothing disturbing slipped in.

As I did not make any changes in my rebase other than adjusting the
location the diffs apply to, I also added the Reviewed-by tags from Richard
Fontana, Jilayne Lovejoy and Alexios Zavras from the original patchset,
and finally added my Sign-off to those patches.

Igor, can you please ack these patches?

Igor, please also let us know:
  A. if you will pick them up and let them travel through your tree, or
  B. if the spdx maintainers shall pick them up and they shall route them
     directly to Linus.

Thomas, I hope it is fine for you to pick up your commits, rebase them
and add the according tags from the previous patchset.

For reference, in his original cover letter, Thomas Gleixner wrote:

In our effort to clean up the license situation of the Linux kernel [1]
we've identified five Qlogic specific license files which reside in the
Documentation directory. Four of them contain a full copy of the GPLv2
license text and one (LICENSE.qla3xxx) contains a proprietary license for a
firmware binary which is not distributed with the Linux kernel. The latter
is a leftover from the old out of tree tarball which contained the firmware
binary along with the driver source. The same notice was in the qla2/4xxx
license files, but got cleaned up quite some time ago. Seems the qla3xxx
one was missed.

The following patch series replaces the license files with a proper SPDX
license identifier in the source files which today reference the license
files. There is no information lost because the copyright notices are in
the source files already and the GPLv2 license text is in the kernels
LICENSES directory. The qla3xxx cleanup removes the firmware license notice
as well because it is pointless in context of the kernel. See the
individual changelogs for detailed information about each driver/license
file.

Please support our efforts to make the Linux kernels licensing clean and
compliance friendly. If you have questions feel free to ask or contact your
legal departement. In case your legal departement has questions or issues,
please direct them to the linux-spdx mailing list where these issues are
discussed.

If you (and/or your legal departement) agree with these changes, then
please either reply with a Reviewed-by and we route them directly to Linus
or pick them up individually through your trees and let as know that they
are en route.


For your conveniance the patches are also available from git:

   git.kernel.org/pub/scm/linux/kernel/git/tglx/linux-spdx.git qlogic

Thanks,

	tglx

[1] https://lkml.kernel.org/r/alpine.DEB.2.21.1905062040530.3334@nanos.tec.linutronix.de


Thomas Gleixner (5):
  scsi/qla4xxx: Convert to SPDX license identifiers
  scsi/qla2xxx: Convert to SPDX license identifiers
  net/qlcnic: Convert to SPDX license identifiers
  net/qlge: Convert to SPDX license identifiers
  net/qla3xxx: Convert to SPDX license identifiers

 .../device_drivers/qlogic/LICENSE.qla3xxx     |  46 ---
 .../device_drivers/qlogic/LICENSE.qlcnic      | 288 -----------------
 .../device_drivers/qlogic/LICENSE.qlge        | 288 -----------------
 Documentation/scsi/LICENSE.qla2xxx            | 290 ------------------
 Documentation/scsi/LICENSE.qla4xxx            | 289 -----------------
 MAINTAINERS                                   |   3 -
 drivers/net/ethernet/qlogic/qla3xxx.c         |   3 +-
 drivers/net/ethernet/qlogic/qla3xxx.h         |   3 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic.h   |   3 +-
 .../ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c   |   3 +-
 .../ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h   |   3 +-
 .../ethernet/qlogic/qlcnic/qlcnic_83xx_init.c |   3 +-
 .../ethernet/qlogic/qlcnic/qlcnic_83xx_vnic.c |   3 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_ctx.c   |   3 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_dcb.c   |   3 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_dcb.h   |   3 +-
 .../ethernet/qlogic/qlcnic/qlcnic_ethtool.c   |   3 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_hdr.h   |   3 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_hw.c    |   3 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_hw.h    |   3 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_init.c  |   3 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_io.c    |   3 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_main.c  |   3 +-
 .../ethernet/qlogic/qlcnic/qlcnic_minidump.c  |   3 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_sriov.h |   3 +-
 .../qlogic/qlcnic/qlcnic_sriov_common.c       |   3 +-
 .../ethernet/qlogic/qlcnic/qlcnic_sriov_pf.c  |   3 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_sysfs.c |   3 +-
 drivers/scsi/qla2xxx/qla_attr.c               |   3 +-
 drivers/scsi/qla2xxx/qla_bsg.c                |   3 +-
 drivers/scsi/qla2xxx/qla_bsg.h                |   3 +-
 drivers/scsi/qla2xxx/qla_dbg.c                |   3 +-
 drivers/scsi/qla2xxx/qla_dbg.h                |   3 +-
 drivers/scsi/qla2xxx/qla_def.h                |   3 +-
 drivers/scsi/qla2xxx/qla_dfs.c                |   3 +-
 drivers/scsi/qla2xxx/qla_fw.h                 |   3 +-
 drivers/scsi/qla2xxx/qla_gbl.h                |   3 +-
 drivers/scsi/qla2xxx/qla_gs.c                 |   3 +-
 drivers/scsi/qla2xxx/qla_init.c               |   3 +-
 drivers/scsi/qla2xxx/qla_inline.h             |   3 +-
 drivers/scsi/qla2xxx/qla_iocb.c               |   3 +-
 drivers/scsi/qla2xxx/qla_isr.c                |   3 +-
 drivers/scsi/qla2xxx/qla_mbx.c                |   3 +-
 drivers/scsi/qla2xxx/qla_mid.c                |   3 +-
 drivers/scsi/qla2xxx/qla_mr.c                 |   3 +-
 drivers/scsi/qla2xxx/qla_mr.h                 |   3 +-
 drivers/scsi/qla2xxx/qla_nvme.c               |   3 +-
 drivers/scsi/qla2xxx/qla_nvme.h               |   3 +-
 drivers/scsi/qla2xxx/qla_nx.c                 |   3 +-
 drivers/scsi/qla2xxx/qla_nx.h                 |   3 +-
 drivers/scsi/qla2xxx/qla_nx2.c                |   3 +-
 drivers/scsi/qla2xxx/qla_nx2.h                |   3 +-
 drivers/scsi/qla2xxx/qla_os.c                 |   3 +-
 drivers/scsi/qla2xxx/qla_settings.h           |   3 +-
 drivers/scsi/qla2xxx/qla_sup.c                |   3 +-
 drivers/scsi/qla2xxx/qla_tmpl.c               |   3 +-
 drivers/scsi/qla2xxx/qla_tmpl.h               |   3 +-
 drivers/scsi/qla2xxx/qla_version.h            |   3 +-
 drivers/scsi/qla4xxx/ql4_83xx.c               |   3 +-
 drivers/scsi/qla4xxx/ql4_83xx.h               |   3 +-
 drivers/scsi/qla4xxx/ql4_attr.c               |   3 +-
 drivers/scsi/qla4xxx/ql4_bsg.c                |   3 +-
 drivers/scsi/qla4xxx/ql4_bsg.h                |   3 +-
 drivers/scsi/qla4xxx/ql4_dbg.c                |   3 +-
 drivers/scsi/qla4xxx/ql4_dbg.h                |   3 +-
 drivers/scsi/qla4xxx/ql4_def.h                |   3 +-
 drivers/scsi/qla4xxx/ql4_fw.h                 |   3 +-
 drivers/scsi/qla4xxx/ql4_glbl.h               |   3 +-
 drivers/scsi/qla4xxx/ql4_init.c               |   3 +-
 drivers/scsi/qla4xxx/ql4_inline.h             |   3 +-
 drivers/scsi/qla4xxx/ql4_iocb.c               |   3 +-
 drivers/scsi/qla4xxx/ql4_isr.c                |   3 +-
 drivers/scsi/qla4xxx/ql4_mbx.c                |   3 +-
 drivers/scsi/qla4xxx/ql4_nvram.c              |   3 +-
 drivers/scsi/qla4xxx/ql4_nvram.h              |   3 +-
 drivers/scsi/qla4xxx/ql4_nx.c                 |   3 +-
 drivers/scsi/qla4xxx/ql4_nx.h                 |   3 +-
 drivers/scsi/qla4xxx/ql4_os.c                 |   3 +-
 drivers/scsi/qla4xxx/ql4_version.h            |   3 +-
 drivers/staging/qlge/qlge.h                   |   3 +-
 drivers/staging/qlge/qlge_main.c              |   2 +-
 81 files changed, 75 insertions(+), 1353 deletions(-)
 delete mode 100644 Documentation/networking/device_drivers/qlogic/LICENSE.qla3xxx
 delete mode 100644 Documentation/networking/device_drivers/qlogic/LICENSE.qlcnic
 delete mode 100644 Documentation/networking/device_drivers/qlogic/LICENSE.qlge
 delete mode 100644 Documentation/scsi/LICENSE.qla2xxx
 delete mode 100644 Documentation/scsi/LICENSE.qla4xxx

-- 
2.17.1

