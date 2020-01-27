Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDCCC33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 16:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB8220720
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 16:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580142943;
	bh=mGHHm9gIvJoSfO34Lli2fyCTpvXhFjioPVwmFmJB/Zk=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=AeBR5UbMbmP70H+XOjHRLeMmCc8tYOQiblepz3fqEEFDQCQO2aPTtZRoxtGsrjzsM
	 P+7GnNeb7NNDHH3c0WeQwv9CX9647c8SHruSpwUjhsAMBgCl+WWjvUZJDeqd6pV0g4
	 8RjFuso9ftYQT8CumFycR4jgG+o4LtOiPHvTKd/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgA0Qfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 11:35:42 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37555 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgA0Qfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 11:35:42 -0500
Received: by mail-oi1-f195.google.com with SMTP id z64so7247192oia.4;
        Mon, 27 Jan 2020 08:35:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=QMO3Cv9nxxqHME0y0FCl2RZwRMv6DFTyTvzcNSmPn5g=;
        b=sBGR5vIfYuehm8Su626A3sTvCE7/tq5bERbpubOOEfjKnJ+Jf0k8nBUD8lnXQMo7fy
         bbkM2cpMwkrCeSFrmJBkiSpUx27EDOzar/xm0BNJgzpBZdqkS4ex4XK+t8wEmwdcEAHZ
         GOjhEqqDATJoGeFMnjMaw500RLJOpNmlb5lYHhiwmcHOb7JHUFmjhed8DlZhxZP4pKyu
         Zvkq+8ymGSxt1EI2jKZ1/RcC8ZlEj+bQq3Kvtl5yOOxrAx19A5rMSvlSY5EjQk050kOC
         GexRpGADm2nQMX30GTKhnIJB1AMvQSpolLW3Kdyb49ZwxOJ/WyGeB6yegIaQgj5npl6E
         n+dg==
X-Gm-Message-State: APjAAAVHCuTJJ4jOkjavkuzitV50MtvWslZ5qBuBzmZMVoPnHY/oLUHN
        /Z3hpP5TduJrACFGBrLYq9jxifeXd1yoenMO0z8=
X-Google-Smtp-Source: APXvYqxNaMux+L8vFg8mUW7JzpASAeaLow6UxERCz4gPmqWsVVGvS3G9n+ubvLVcv4+k+MA0zsGMRdWlmODwdAcWLeE=
X-Received: by 2002:a54:488d:: with SMTP id r13mr7625622oic.115.1580142941591;
 Mon, 27 Jan 2020 08:35:41 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Jan 2020 17:35:30 +0100
Message-ID: <CAJZ5v0g3sy7N7EA49pbDd951tVfMAgTA8iCPATG9jO0+1mfQDg@mail.gmail.com>
Subject: [GIT PULL] PNP updates for v5.6-rc1
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
 pnp-5.6-rc1

with top-most commit 786c87cd312ad2ec774bc4606834b06844dada6c

 PNP: isapnp: remove defined but not used function 'isapnp_checksum'

on top of commit b3a987b0264d3ddbb24293ebff10eddfc472f653

 Linux 5.5-rc6

to receive PNP updates for 5.6-rc1.

These get rid of unused variable and function (yu kuai).

Thanks!


---------------

yu kuai (2):
      PNP: isapnp: remove set but not used variable 'checksum'
      PNP: isapnp: remove defined but not used function 'isapnp_checksum'

---------------

 drivers/pnp/isapnp/core.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)
