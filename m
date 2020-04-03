Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A247AC2BA16
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784A9206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icv0VWTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgDCS4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:56:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44180 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbgDCS4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:56:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id m17so9704775wrw.11;
        Fri, 03 Apr 2020 11:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a3M8YItqIhClkhbG5WGG9uWZ2umFIqJq2XRnrb76fdo=;
        b=icv0VWThmaZ4yxF2ZlKpjQzJg5heW2K2ZelgdLBMJ+9wabsygipHJcTDyqzCJeLzad
         VBTST+WVJuEOGJgyj56SHZTRpAlYl1IHCvbvO6Cx/huzLrnWwjhVJKTBgtmg+Bak70QF
         8dXCgbHqPWlQ6U9gVffbimv/HxrpjtjlIfP3+OJCugmwsqm1JtkLWXzjyCEKDWevqakX
         3qJQORLsVKVXx+Rts2TWR61peHXUetQWwxYxmu49zDMLDVkQA0aq1T9CiHoSR2Q0ls/9
         oeJlvEesvBJ1rPYGQesa9g6Y1HEC0J+9yQlW0QeqmdcundVo9MVP2ZKgB7OmTONL3sCr
         OCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a3M8YItqIhClkhbG5WGG9uWZ2umFIqJq2XRnrb76fdo=;
        b=jq1TWtCoA5Rt3EQTmDLkpq3tcSU0SNSvKydaz7fjKz4vHeG4jtUBw7s9ADEwa5Enrr
         ejRqtwTJSNfh/N0GXD2sIs9OyxWox/oPzffUuEV+tKTRCuMZN3AKTEpE8hJse/MAjBFa
         SgCJ0ljujbpMeJ6wHrr7rYxOdqhMa6miB4PTjX8WFLL1LjysLjxaGawgpIBu0NyJPtWZ
         C1EYr6l6HSmlAzpEOa66nQfOTYk4kkyizplA45rXWiBCgbeZxnSlwtwVGiIP9Irq96Qw
         L0LSbVU6AwkddaAhiHUzFVzW11wHqpk6enJLGENpwsgvokrqayCFkHDyiyGUwd+aS87t
         xTaA==
X-Gm-Message-State: AGi0PuZCvwJ0kgfviuVX3/YFsTtuqWvdAVfqk/NsZwK/rXnOxhDxgpe8
        ldkTvPDeYkBI4DkpIIbg/eI=
X-Google-Smtp-Source: APiQypLzflinO7J9tLxuiq1cZATE9oqKo9oYMbRO/FpAhkj6uMAzWCTr7JnXZHcQzXgs3ZI0wZacNw==
X-Received: by 2002:adf:b258:: with SMTP id y24mr10338372wra.318.1585940206078;
        Fri, 03 Apr 2020 11:56:46 -0700 (PDT)
Received: from localhost (pD9E51CDC.dip0.t-ipconnect.de. [217.229.28.220])
        by smtp.gmail.com with ESMTPSA id i2sm13119594wrx.22.2020.04.03.11.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 11:56:45 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] of: reserved-memory: Various improvements
Date:   Fri,  3 Apr 2020 20:56:36 +0200
Message-Id: <20200403185640.118569-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Hi Rob, all,

this is a set of patches that I've been working on to allow me to use
reserved memory regions more flexibly. One of the use-cases that I have
is an external memory controller driver that gets passed one or two
tables from firmware containing a set of EMC frequencies and the
corresponding register values to program for these frequencies.

One of these tables is the "nominal" table and an optional second table
is "derated" and is used when the DRAM chips are overheating. I want to
be able to pass these tables as separate memory-region entries.

So what this small patchset does is make the reserved-memory code adapt
to this situation better. On one hand, while the DT bindings currently
support multiple regions per device tree node, it's slightly unintuitive
to specify them. The first patch adds a memory-region-names property
that allows the DT to specify a "consumer" name for these regions much
like we do for things like clocks, resets or the reg property. At the
same time, a new alias for memory-region, named memory-regions, is
introduced to make this more consistent with other bindings.

Patches 2 and 3 add support in the core OF reserved-memory code for
these binding changes, with a fallback to the memory-region property if
no memory-regions property exists.

Patch 4 implements support for releasing multiple regions assigned to a
single device rather than just the first.

Thierry

Thierry Reding (4):
  dt-bindings: reserved-memory: Introduce memory-region{s,-names}
  of: reserved-memory: Support memory-regions property
  of: reserved-memory: Support lookup of regions by name
  of: reserved-memory: Support multiple regions per device

 .../reserved-memory/reserved-memory.txt       | 12 +++--
 drivers/of/of_reserved_mem.c                  | 52 +++++++++++++------
 include/linux/of_reserved_mem.h               | 11 ++++
 3 files changed, 55 insertions(+), 20 deletions(-)

-- 
2.24.1

