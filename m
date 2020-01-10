Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2554CC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C102082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgAJPmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 10:42:53 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:56017 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbgAJPmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 10:42:52 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MEVJq-1ishJP1Vz0-00FxYC; Fri, 10 Jan 2020 16:42:45 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH 0/3] y2038: remove unused interfaces
Date:   Fri, 10 Jan 2020 16:42:29 +0100
Message-Id: <20200110154232.4104492-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5xm2JkhorhKDqr/qgHuLyxFqSTz4N7RQfAuP693+0IN2KrM/aj8
 GeoaxuRnXA5BHP0JpPlyPMK7ecRlFcIqleJV2BplTHzRll2YRL5HEdOwg0a5PBeTFGrvUHw
 IHVloROxdZXYGW3DBGadeD03zPocgzwPshIcfyqWPBCyZL1QLEZqRGBMkcoyCiIw5nxiS6K
 FFfeoHtv9qw8mK+VWirlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FlkCF2dvsS0=:3r0nxqRTNBz3xWqmpddubL
 0z48Uffa3+S5qZka6hw03rBDqoJYU21oSgD/ZQ5ptrH9BP0WIF4ui79v3JlvN+HHCpZkOEuKC
 JBx2gj/U+U4z8e9vXTtxa2hdHVq2WGJOf93ZOtEK19tM7Il8uAAWSx4lL3RAETyVtrOx6O1ZJ
 UR+67kE//8dSeVF2w1lbv60dLGbF5ukbeSNXwJ679potl7+WlGgYKiDc5KZhdZHKFYC1lJZx7
 ZWXF6mRMV4IfomBjZ7nyVeZyTZc/OXuJ21N86qMo+n4ds+UrmZf50mL7/7YvAaRvxqEPj4G7R
 BOYkcN7wEZAIEeyX3bGCzbYzyGQ9Km2dG4jcv4rvWoReNWbYxmbta3yU1SrNEk5A3cRnUNBhB
 dRAAC5DX5A88KdTGR0S2ZZkrn9ofLR4cX1cps0EGteMf2ihmjsIcZhm0pXshrB/kYeTpSPOJ9
 zRi9h9vHqUtF92HfFo2RvI9kqW6u2KQuIfrl7RSHeHimYtCzpk7UWxtUshTBMIvZtHg0M3ZNx
 V38cMe4ObHzDihAF5b46sA3EijWS2VT2BPkZMDt/KV/tKzDT6ttcxnvpb9YBsJwrEKGPLhUIJ
 F1CR7UFs23ZVwrMvSavnvHKQFocAr0gLB1mdUvIxGUX6TkSMzmAFJDYb7VhUylwMcfHXDq8zV
 ODFwtv3b1FIzg5ccnQpGCN38XZWFXeyLaJkhkrDvwvJ2JTOTp2NFQco5s8y0rmYb4WIaxbNw8
 NxoAMRpquzYOrzqeGQyb10t/pWIa9r3lNlzkITRPhFVzatzvL+I3a20+leMQSg9xwHYAm0xiZ
 YkTpDi6PSX1vppkFXiBigVTgZBV9v9KfzTIganYHl0sm76e8PglbuA462NcCv3dI2GcWrbH29
 1zJ7+/v+Vh1VmxKZe7rQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Can you add these to your patches for linux-5.6?

I have y2038 cleanups for sound, v4l, nfsd, scsi and xfs that are
merged in the respective subsystem trees, as well as another
series of individual patches queued up in my own y2038 tree.

With all that work merged, most of include/linux/time32.h
and some other related code can be removed from the kernel,
so it would be good to send these at the end of the coming
merge window, and to give them some more testing in linux-next
to make sure we don't gain any new users.

      Arnd

Arnd Bergmann (3):
  y2038: remove ktime to/from timespec/timeval conversion
  y2038: remove unused time32 interfaces
  y2038: hide timeval/timespec/itimerval/itimerspec types

 include/linux/compat.h                 |  29 -----
 include/linux/ktime.h                  |  37 ------
 include/linux/time32.h                 | 154 +------------------------
 include/linux/timekeeping32.h          |  32 -----
 include/linux/types.h                  |   5 -
 include/uapi/asm-generic/posix_types.h |   2 +
 include/uapi/linux/time.h              |  22 ++--
 kernel/compat.c                        |  64 ----------
 kernel/time/time.c                     |  43 -------
 9 files changed, 15 insertions(+), 373 deletions(-)

-- 

Cc: y2038@lists.linaro.org
Cc: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>
2.20.0

