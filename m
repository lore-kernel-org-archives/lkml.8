Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A630C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D973D20717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595029453;
	bh=+RzQhn7D4mgCIgQ0I0+BOc+630IL9bfjPk5doweV4lk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=GtanR5Eb3MPlicjm08YskGxfx/AyXT7T/qviZfXAfK14/RpVamtGTQ1Zt4gmvZ6YP
	 UNC7eV7IDwzX1DtAY5fWDxtekojv1ngR6626Unskgbj/wdL/vX3b8QPiRbnwg2msv4
	 KomG+FPdrrb0JtE7Z5u8m+YGiKuvEKlWfPbEKC74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgGQXoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 19:44:13 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34312 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgGQXoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 19:44:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id u185so6120510pfu.1;
        Fri, 17 Jul 2020 16:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=HtQFi7bG9pgYuJ3R5iqH+fBElgVPr9VeuD3HvcyS2kY=;
        b=bfF+1ZYwH3TTRV0UOgi9tweeje6l3NMir0neT7O920GkHraFhqrTHnblAft1SfUM+E
         ksSr9UxezWmWpVnS1g67qvs2UDCQsqxRTBHALqT/Iber4jGtQn17iQmJs1vCy+3KyU1v
         hd1WDVEUGr4CKTpJWpE6TSvTyMeZPDpuKNyf68Dm/olu7VTEEqlREWtvJ0rZtJMHHWP1
         UKDYYf3Op4R6bh1jrvX0Zk3fmKHKv9F1k5qok2M/eDKaKmS0WUPxZtmd/g/rVkUxQzjO
         THsiXSV4KlJoDd8RFQIKcTKchPSv9OYIKBrxiGwXFoBEgrL3+j0h9eaub0OLg1bjyhre
         U0bw==
X-Gm-Message-State: AOAM533Ym8os8LROQwtBd7tYy88p+fjWiNcq95kaygY7KqtarDqKUm4T
        HMX5OyJuh629IK0cbIiUvZ1UQW6+
X-Google-Smtp-Source: ABdhPJxgwlc37MhLdI3R7SbdWbTUuujtlwua+pFNjQECaEUGKEYshzwwTZ8g6wq3uju+CtW1sqFmXA==
X-Received: by 2002:a62:8ccb:: with SMTP id m194mr10243181pfd.36.1595029449447;
        Fri, 17 Jul 2020 16:44:09 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id b14sm8701806pfo.28.2020.07.17.16.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 16:44:09 -0700 (PDT)
Date:   Fri, 17 Jul 2020 16:44:08 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] FPGA Manager (late) fixes for 5.8
Message-ID: <20200717234408.GA4556@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 11ba468877bb23f28956a35e896356252d63c983:

  Linux 5.8-rc5 (2020-07-12 16:34:50 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git fpga-late-fixes-for-5.8

for you to fetch changes up to 8614afd689df59d9ce019439389be20bd788a897:

  fpga: dfl: fix bug in port reset handshake (2020-07-13 22:11:17 -0700)

----------------------------------------------------------------
FPGA manager fixes for 5.8

Here are two (late) dfl fixes for the the 5.8 release.

Matthew's fix addresses an issue in the reset of a port.

Xu'x fix addresses a linter warning.

All patches have been reviewed on the mailing list, and have been in the
last few linux-next releases (as part of my fixes branch) without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Matthew Gerlach (1):
      fpga: dfl: fix bug in port reset handshake

Xu Yilun (1):
      fpga: dfl: pci: reduce the scope of variable 'ret'

 drivers/fpga/dfl-afu-main.c | 3 ++-
 drivers/fpga/dfl-pci.c      | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)
