Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6568C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 22:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7C562225D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 22:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="meBgXr2K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgFSWHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 18:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728906AbgFSWHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 18:07:18 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF7AC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 15:07:18 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id p18so8833866eds.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 15:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=FofYLR7vERDCGqlrwGl+40IK2EVftz+ALwz0eB3/bUI=;
        b=meBgXr2KKhTwAXn2DBEPg60WdxLEP8hcHROFDw7sHf9QzqKP+k/KNEXYX0nZ1Iyw1g
         eYtdBtGVXeEGwfbI2SwfVu6xR1vKVqiyKuF1w4pu98I0TKIut6a/5ETKB7s5oiRVdlD0
         UCF9kKsGnOsacua84JzFCEUd4SZzAIObS/Na35vus4q+btPg+crAA0HsR+h7w/GZSaGa
         4QdIzJhvU+ezSap6Cl+o6UBJr75hHNXZHh8a/9vuia39NOueoIEs7s4XiLotDwDkxUm9
         5+D3FDL7C9rm6vLae5XOPQnCiIB/+kFi+Te/5w2rKzwUo1Bjlkrl1UYw9VVlDQeuZjP/
         rjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FofYLR7vERDCGqlrwGl+40IK2EVftz+ALwz0eB3/bUI=;
        b=MDg70Rt+fJuqW6a4vnn2PVm0QNFXFOcWVqiOLufBznSimRfbHr4pDnRUUefe0W/tvG
         OKHqM4FtSVyoc05Ziszvd+61DOt7dfVP7CzccNlPi+8SmwfTO5kc2hymmC3z1VUUYurQ
         IbaiiG92XGekwcbDiIIMIuVmHl+/Bbp4YF1DzNA8hVeDXxYVpShtOA24PzPwwjMvyroD
         5ECwVY9vqcRINcezsVKKuwpa/k+Ou+e/5KG+JYL9S6iIQRcaqkUoqaHUv/EriLcu5ElP
         gMVilNomf/YGWSIHhjeYO7NX8QOkMpq+I41flznVwJCO+eXrTLME8q8RbYZFzbxNFkry
         Xbtg==
X-Gm-Message-State: AOAM530edczqp0JfrU+vD6Bkb1qsStS9jvRwBOEotb00BYhoS6zevrZX
        beGqjG6vwRTGsUKe4nbUNUhAPt4NNWKBcjS0QaADvw==
X-Google-Smtp-Source: ABdhPJwCp6dTqzKzDVUhjKyDf+BUdP0V+rF4Eef2dzh03xSHrJJYr0aEkvPS/WNz9UDYajBbITDB+uE1A7YvriLC1Y8=
X-Received: by 2002:aa7:d6c1:: with SMTP id x1mr5349272edr.154.1592604435655;
 Fri, 19 Jun 2020 15:07:15 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 19 Jun 2020 15:07:04 -0700
Message-ID: <CAPcyv4jA-_Wd4S6gM2jf_VhVsgsdR5rQTeAc3AEPr6SAvhq3eA@mail.gmail.com>
Subject: [GIT PULL] libnvdimm for v5.8-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.8-rc2

...to receive a feature (papr_scm health retrieval) and a fix (sysfs
attribute visibility) for v5.8.

Vaibhav explains in the merge commit below why missing v5.8 would be
painful and I agreed to try a -rc2 pull because only cosmetics kept
this out of -rc1 and his initial versions were posted in more than
enough time for v5.8 consideration.

===
    These patches are tied to specific features that were committed to
    customers in upcoming distros releases (RHEL and SLES) whose time-lines
    are tied to 5.8 kernel release.

    Being able to track the health of an nvdimm is critical for our
    customers that are running workloads leveraging papr-scm nvdimms.
    Missing the 5.8 kernel would mean missing the distro timelines and
    shifting forward the availability of this feature in distro kernels by
    at least 6 months.
===

I notice that these do not have an ack from Michael, but I had been
assuming that he was deferring this to a libnvdimm subsystem decision
ever since v7 back at the end of May where he said "I don't have
strong opinions about the user API, it's really up to the nvdimm
folks." [1]

This pull request includes v13 of papr_scm set, and it looks good to me.

Please consider pulling, I would not normally have broached asking for
this exception, but Vaibhav made sure to have less than 24 hour turn
around on all final review comments.

This has been in -next all week with no reported issues.

[1]: http://lore.kernel.org/r/875zcigafk.fsf@mpe.ellerman.id.au

---

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/libnvdimm-for-5.8-rc2

for you to fetch changes up to 9df24eaef86f5d5cb38c77eaa1cfa3eec09ebfe8:

  Merge branch 'for-5.8/papr_scm' into libnvdimm-for-next (2020-06-19
14:18:51 -0700)

----------------------------------------------------------------
libnvdimm for 5.8-rc2

- Fix the visibility of the region 'align' attribute. The new unit tests
  for region alignment handling caught a corner case where the alignment
  cannot be specified if the region is converted from static to dynamic
  provisioning at runtime.

- Add support for device health retrieval for the persistent memory
  supported by the papr_scm driver. This includes both the standard
  sysfs "health flags" that the nfit persistent memory driver publishes
  and a mechanism for the ndctl tool to retrieve a health-command payload.

----------------------------------------------------------------
Dan Williams (1):
      Merge branch 'for-5.8/papr_scm' into libnvdimm-for-next

Vaibhav Jain (6):
      powerpc: Document details on H_SCM_HEALTH hcall
      seq_buf: Export seq_buf_printf
      powerpc/papr_scm: Fetch nvdimm health information from PHYP
      powerpc/papr_scm: Improve error logging and handling papr_scm_ndctl()
      ndctl/papr_scm,uapi: Add support for PAPR nvdimm specific methods
      powerpc/papr_scm: Implement support for PAPR_PDSM_HEALTH

Vishal Verma (1):
      nvdimm/region: always show the 'align' attribute

 Documentation/ABI/testing/sysfs-bus-papr-pmem |  27 ++
 Documentation/powerpc/papr_hcalls.rst         |  46 ++-
 arch/powerpc/include/uapi/asm/papr_pdsm.h     | 132 ++++++++
 arch/powerpc/platforms/pseries/papr_scm.c     | 420 +++++++++++++++++++++++++-
 drivers/nvdimm/region_devs.c                  |  14 +-
 include/uapi/linux/ndctl.h                    |   1 +
 lib/seq_buf.c                                 |   1 +
 7 files changed, 618 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-papr-pmem
 create mode 100644 arch/powerpc/include/uapi/asm/papr_pdsm.h
