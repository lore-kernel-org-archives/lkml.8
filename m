Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EB1C33CB7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 10:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6D320CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 10:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580464957;
	bh=f/tet4r6lxFf+QUl6auDW1kESB757bxmeNtZ6H2x+1I=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=OwKiWWyQ2tcgjIluHIWOKj1jCgwsOBMy0cYaQ5+ye6g5++SodyITcnuEAZAlZy62x
	 qYt9adRoJcsxW5YtGoACBsujA7qO9ZcrUoa99JJ4NXzY5w0tm4YYhJumuQG1GGCHVE
	 a0dnbBe8zHnA8VDBZni5fBVvbOq1PyuvEA1Ihk+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgAaKCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 05:02:36 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44993 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbgAaKCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 05:02:36 -0500
Received: by mail-oi1-f193.google.com with SMTP id d62so6647331oia.11;
        Fri, 31 Jan 2020 02:02:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=J1109l5zNZg7r3nNwdWFJwDzztLNtO7CHAw67sTO1hw=;
        b=DgM1VNjlF0zMjquMD469+ZpOfLZ2zvx3nM1w7BBXidEPLfkydPuShzT5cg4nHxnlKa
         ta+dBCeDRGE45trzHSXekUdH+afN6orjI+4lqwzoBfXnSEIt9mZBk+3G4Cz4UYY1gdsw
         pD9mIMXv5JSJnKx5IJ+lZgaUSMsb/GhqwgvohePeGIff7C+KiOxos4TCYLFV3zXGM1Uh
         Daqscqr/na9r4/zI1rTRVvqTSYiFiP8xn0JNvel5JQZZs9hrkdO8BBA9frIeioEFKYvt
         r+4Wt2teD+geGIkLRk7ETH7FiGYl3G97rZBlaSWAPkYoxqcVUZShFaeDv5J/AkOs3b3w
         0csg==
X-Gm-Message-State: APjAAAVROI4+nlbQfH+oJaSkafyWvGn0So81ahtIYQL9q0w/lKVl31BN
        jn9la7Xmhb/ao9arK8i48uJ7mDelTIR4Ox3qjlJ9V+KT
X-Google-Smtp-Source: APXvYqyG8BO+u2QfXIqyJFgRQ7ieNs9n10EJ89OmtsDNUyfZf6VbOKRgnl7Fxr/7bPUjTPXNkj0ihCxl/EvIubvhqkI=
X-Received: by 2002:a05:6808:8e1:: with SMTP id d1mr5671989oic.68.1580464955465;
 Fri, 31 Jan 2020 02:02:35 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 31 Jan 2020 11:02:24 +0100
Message-ID: <CAJZ5v0iL0Qd9aDzkeidpngyPUcqSxYc++cqbqTFq93S+Tt7XiA@mail.gmail.com>
Subject: [GIT PULL] More ACPI updates for v5.6-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.6-rc1-2

with top-most commit d8639f0d6c230d4c632cbf8ed1f3b9456f338ca0

 MAINTAINERS: Sort entries in database for X-POWERS AXP288

on top of commit 55816dc1a50463ec0ea45954e87ec3dff70e2863

 Merge tag 'acpi-5.6-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional ACPI updates for 5.6-rc1.

These fix up MAINTAINERS entires related to ACPI (Andy Shevchenko).

Thanks!


---------------

Andy Shevchenko (3):
      MAINTAINERS: Sort entries in database for ACPI
      MAINTAINERS: Sort entries in database for ACPICA
      MAINTAINERS: Sort entries in database for X-POWERS AXP288

---------------

 MAINTAINERS | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)
