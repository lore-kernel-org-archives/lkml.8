Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0725C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 21:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2D8D20760
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 21:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WxiiwQIH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbgFFVCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 17:02:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23047 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727994AbgFFVCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 17:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591477373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=+D2GdxTX6b6hA1PHo0qrCmyz04ljiq/Wrl6lhJ+DuTY=;
        b=WxiiwQIHvAmcpjFLqm/NxvFzete+/uvYkqt/2bZhBhmrSYtkXiuDQ8Uf85p32OOfVrNLIU
        S23dYoyOJHXNZ76T3RhqFBA4T0uu8wqfoEBhOTSRtHG1R9AlyjqF2HMtTkSXzFKf8cLVwc
        nLRYv9wmCLHzlvFXIWvhGaIfDw27XVU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-a7mA8_5oMmGswOgqX2VeCQ-1; Sat, 06 Jun 2020 17:02:50 -0400
X-MC-Unique: a7mA8_5oMmGswOgqX2VeCQ-1
Received: by mail-qt1-f197.google.com with SMTP id y5so7140510qto.10
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jun 2020 14:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+D2GdxTX6b6hA1PHo0qrCmyz04ljiq/Wrl6lhJ+DuTY=;
        b=VIcI4CKQFDCC2xX1Km53aZ8jELgDXEUpYBcxZOkZcgNAceUiFEYsDp1zFr0qFuP/13
         fVrt2b+PgrcCwyevPJosc4wM9TG6yodKXegoTHNJXsvWp/OfVI8NTyvzLrUxdQqQxwc2
         KzPqRDWWcYdhY8flUkC0mRO614g8ACptevGwOcByw9u8kk5mkKlTF1KLFsoNmmW4TNw8
         zod0do+2dN2hRF7IeNd7chnTVYaGHoikJvYBt1u3G8ax9CzHZisGi/t5wFiO3uRAf4Yr
         5SzOgLxbeJ3NvFf5MLpq1vhHP/7Yn8I2HIjtPhdUWyzJr1cU9TjMSJ40AH6rRLsKVE4p
         MLng==
X-Gm-Message-State: AOAM530c42YoiWX4P8Hu4PsmCto7jbW2ywLYamcO2/2oGa2a13GoGx8J
        8ngR32X9JLtiYKd1YeK0lj+l2sYBhtYgc6h00ZzcLCNjGgwvPWEpXwEdt+GhtAJzYo1epay0txs
        BA6lk7UCfVBak+9baJSyoHori
X-Received: by 2002:a05:620a:2158:: with SMTP id m24mr7472249qkm.310.1591477369487;
        Sat, 06 Jun 2020 14:02:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw65D2mGOUIJtzIY7DgEMQIIow8keOsqE+PTJD5okzf/CUeT0JbIh3nJd4smxJsAU+Cg+2Sug==
X-Received: by 2002:a05:620a:2158:: with SMTP id m24mr7472221qkm.310.1591477369152;
        Sat, 06 Jun 2020 14:02:49 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id d14sm3025299qkg.25.2020.06.06.14.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2020 14:02:48 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 0/1] fpga: dfl: Fix dead store
Date:   Sat,  6 Jun 2020 14:02:40 -0700
Message-Id: <20200606210241.7459-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Repo linux-next
Tag next-20200605

A couple of fixes for dead stores found by clang's sa tool scan-build

Tom Rix (1):
  Fix dead store

 drivers/fpga/fpga-bridge.c | 6 ++----
 drivers/fpga/fpga-mgr.c    | 4 +---
 2 files changed, 3 insertions(+), 7 deletions(-)

-- 
2.26.0

