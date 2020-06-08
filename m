Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7730FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55C982081A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQjGCScO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbgFHMzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 08:55:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39371 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729665AbgFHMy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 08:54:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591620896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=jY3OPm4RpBTiGQk+tMR5hTIetdqJd5vfaxOWuwXTB3Y=;
        b=aQjGCScOH+6dHIP/kZiTwFfjjUaSQHBvd55rSYVCfWVwJEsv1snQrPyIw895fQQsoKzplF
        9ie/fyGYIq0MteJWWk8heOs4zTDhpEWl3I3ZFfjPQfNd8vD80MFMI+WlyRZ25QBVLYx/t1
        NKYHWM4D4JcNFPIQbUobr+tQ4i5R/+o=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-o1M4BBS5M6Wy74CuiGyl4w-1; Mon, 08 Jun 2020 08:54:53 -0400
X-MC-Unique: o1M4BBS5M6Wy74CuiGyl4w-1
Received: by mail-qk1-f198.google.com with SMTP id 140so14196843qko.23
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 05:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jY3OPm4RpBTiGQk+tMR5hTIetdqJd5vfaxOWuwXTB3Y=;
        b=btkpweLmJZC7Zctg3UTR/WEkNSvBJ1ORW1jK2MTJfVHIpbUS0+2kg4ZNGWxUcuspYg
         cKfk/GRFAFgYXOs7UShHH7wfj5Esh4uv8jMi86KNwnbqEmL4Va6d3N+t3Tv6/ZPPPLSj
         R5SMkSsViG8Xg7Vrrji6DVEH/+DaPcJ9q2TDCx3vpqaQ5R5qc/Zu+huQqtYgdgMV57RK
         55dQUetX8rgnOEP2tMDHa/ZbR78s0GpRAJbYeU/3g7Vt9dIsiLdPrwcCJSO3cclnaPIG
         oLjVnXKWOudgSYvXqkBBGAfH1XyN3VGhOkVaRMz8pymKbcIO1rmQH43RANru2PUOIwY9
         capg==
X-Gm-Message-State: AOAM532+xO030ZhyWkcLtw1JOqJMAOL6XsYh0tdEyMs5AujIUXldUBNh
        y0xVvwtS009srDzp+XJJI2UxB3uYqRPOAVINdAn5XZOPBMD4dF0QfCOrwxdm6C1zTwkVarwOPRB
        v6cHQP1OmCRUuFmO6aQ65os2F
X-Received: by 2002:a05:6214:72a:: with SMTP id c10mr21411627qvz.189.1591620892878;
        Mon, 08 Jun 2020 05:54:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLX+kbWJfuOOXSXfzby71lXVvgp9fnIX3ZtAcmuGXq2m7+Kc0tu6+ZGRov6RdZsjVIs7Jo0A==
X-Received: by 2002:a05:6214:72a:: with SMTP id c10mr21411615qvz.189.1591620892683;
        Mon, 08 Jun 2020 05:54:52 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id y54sm7750628qtj.28.2020.06.08.05.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 05:54:52 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2 0/2] fpga: Fix dead store
Date:   Mon,  8 Jun 2020 05:54:44 -0700
Message-Id: <20200608125446.23311-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

repo: linux-next
tag: next-20200608

A couple of fixes for dead stores found by clang's sa tool scan-build

Main changes from v1:
Split single patch into two patch

Tom Rix (2):
  fpga: Fix dead store fpga-mgr.c
  fpga: Fix dead store in fpga-bridge.c

 drivers/fpga/fpga-bridge.c | 6 ++----
 drivers/fpga/fpga-mgr.c    | 4 +---
 2 files changed, 3 insertions(+), 7 deletions(-)

-- 
2.26.0

