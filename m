Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B712C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4FE120774
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpFuU0UE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390198AbgF3RRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:17:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49588 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390189AbgF3RRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593537450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=18z1oTfW6/6D2G9GMiQYrGSxrdgHa1a8U8kk2US/2Lw=;
        b=CpFuU0UE2feSmMiMs8bR4r/v5kBuLIDPJ3XBeT1/ZyR5k7O97CDGO+fA93dIAA8oV2aLYV
        bUSbA/PTY//aJDI571wG5gp0HmCcGz9tExW991EnMwBhyUWSbM6cwNxBuDTzptDidCC5H3
        EeNfihqGBWGG1y0bCteQgPjzux/yg/Q=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-bdvGGTr9NwuoSyfxOK1Pgw-1; Tue, 30 Jun 2020 13:17:16 -0400
X-MC-Unique: bdvGGTr9NwuoSyfxOK1Pgw-1
Received: by mail-qv1-f70.google.com with SMTP id q5so14296499qvp.23
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 10:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=18z1oTfW6/6D2G9GMiQYrGSxrdgHa1a8U8kk2US/2Lw=;
        b=G3AVqunVfCgAuDr5UDX+vPf9aBC0jx8hR21MyWm5VlXJtiwZHfSDPUe1MyO21YlV/z
         zcld82SyZJv49U2DciU/VXf6EHAwxXBJU4nBXOi77BEHCADSaNt6rtU9E4WHAwTwoIvf
         LxYeWyBMZUEYHPUeFdHDzDSAaKiEMdjj+kCjTm6hyupi0BYfURMLrzggKS+kiUgxN5Q4
         ZntgL5cJ06c4/MxDrPvpEl/URaEur76xI7Zgj8q4YFL4dO+m0MrOulhofZ5bpN223rOL
         gr0SjBj6V/Q5MYTmywp6qtiVp4YAKZWqMfm726lq5ISQrPLPZw9snRNOjQxDCBRJky4U
         hMBg==
X-Gm-Message-State: AOAM53009qspFm3S6a+cfB3FrvqM6YjEkIr2rZ4RO+oDLGeI2txNcRp7
        wb8v5rGJYSaLLdIc0/KP9VDHpBSi9TAuj/S7ekKWx1p8if1hR8NJOddeC9TuhjY7Ar74Pg/NaR3
        ibj8tsxKPW4zTBiCjItuns+Yn
X-Received: by 2002:ad4:41c1:: with SMTP id a1mr16057961qvq.25.1593537435218;
        Tue, 30 Jun 2020 10:17:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2DSkUrLBgyp7sHt5BFKSklM1kXVf1p88R0WlPlVzruBd3JtL6CyW5QP11XrQjT62wlYI7Wg==
X-Received: by 2002:ad4:41c1:: with SMTP id a1mr16057919qvq.25.1593537434850;
        Tue, 30 Jun 2020 10:17:14 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w44sm3790774qtb.22.2020.06.30.10.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 10:17:14 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, corbet@lwn.net
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [RFC 0/1] fpga: dfl: RFC PCI config
Date:   Tue, 30 Jun 2020 10:16:55 -0700
Message-Id: <20200630171656.20151-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

This configury shows where I would like the dfl pci cards to go
by introducing future cards as well as the current pac 10 card.

The goal is to fully configure the card in the drivers/fpga
area of the config.  Collecting configury of the fpga/ parts
as well as the subdevices scattered over the tree.

The user is not prevented from manually picking the equivlent.

Some documentation started to track the subdevices needed
that are not in the fpga dir as well as guiding the user to
identify the appropriate top level config.


Tom Rix (1):
  fpga: dfl: RFC PCI config

 Documentation/fpga/dfl.rst | 33 +++++++++++++++++++++++++++++++++
 drivers/fpga/Kconfig       | 28 ++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

-- 
2.18.1

