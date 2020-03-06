Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AA3C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ADEC20848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bvhFhJ1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgCFRUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:20:35 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58902 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726090AbgCFRUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 12:20:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583515234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XAx9sQaK7bodB4OzBEqr6zkjadfLBVOBUYyHPPPcxGE=;
        b=bvhFhJ1cidwXpkg+mUw8WIlEegkKr9w1tVNKDFF1otsep997NSPPQr5cK3JtjqkM4LvzHh
        nLx+h51qIUw6KJOuLUBik6JzgIOiz3tuYiQPkBN1pAKtzmXaMhHqlZkHTs2u/wirQI4Oxm
        OSEDsGbJROG2mjVLUoeb7spvs3Mwrsc=
Received: from mail-yw1-f71.google.com (mail-yw1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-2nqi5235O6m6g9sv4eJ-lA-1; Fri, 06 Mar 2020 12:20:30 -0500
X-MC-Unique: 2nqi5235O6m6g9sv4eJ-lA-1
Received: by mail-yw1-f71.google.com with SMTP id i81so4207097ywa.19
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 09:20:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XAx9sQaK7bodB4OzBEqr6zkjadfLBVOBUYyHPPPcxGE=;
        b=ms2UEmbcDVzJDLkud/0fG4H2VnkDGvn+ka38AafdNNk8Z795MC1kgwxSwPIvAypoRn
         EWWqZR+cxXTF82dduPjsPkyYYEtoHit9oXLH84M2/0B/whHROcH1a1uUOb6HN3cT+BvD
         +n6n7yzyAgFeDIFm0ZP5WNg6yc7Nh9OpnyxMpy9sJsX8PmH/0ICqAT68NelLrarqYq0c
         XzBZu51xSNAHJLhBGu23DOsxn8R2elg7SaTLmHFXtzj/hv4WsSsOZjIRogLff0sLqEo5
         +eO7LTV1FfXeqvIO3kBVTBfBeKixk66r1O40s4avSwTCLkA5NEHrckNCM73Fu75NqiPv
         gO0A==
X-Gm-Message-State: ANhLgQ1dbnmMWIpdLz+8MIOUPyuwWTnFpaINDmcqhGFSBq8AMH5tsIhI
        9D6lhINWWLwTbXRw3zhG+tavf39ZhhRfcKgXEeHRhrzGlemYY/v5mMUvhFO++4pFpe9FB6B9RCf
        WHgdIhKtBWdISr+jLmbHFkSqO
X-Received: by 2002:a25:320b:: with SMTP id y11mr4777524yby.19.1583515230124;
        Fri, 06 Mar 2020 09:20:30 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvO7Gg2HsQsn8KLIE47IzfOAGYwdFJXF3Ilm7f9M4y3lVKwHav9bwJVbLJ2Aibk1fOGDBHw3g==
X-Received: by 2002:a25:320b:: with SMTP id y11mr4777488yby.19.1583515229861;
        Fri, 06 Mar 2020 09:20:29 -0800 (PST)
Received: from redhat.redhat.com (c-71-63-171-240.hsd1.or.comcast.net. [71.63.171.240])
        by smtp.gmail.com with ESMTPSA id y77sm7887218ywg.66.2020.03.06.09.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 09:20:28 -0800 (PST)
From:   Connor Kuehl <ckuehl@redhat.com>
To:     thomas.lendacky@amd.com, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc:     gary.hook@amd.com, erdemaktas@google.com, rientjes@google.com,
        brijesh.singh@amd.com, npmccallum@redhat.com, bsd@redhat.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Connor Kuehl <ckuehl@redhat.com>
Subject: [PATCH 0/1] crypto: ccp: use file mode for sev ioctl permissions
Date:   Fri,  6 Mar 2020 09:20:09 -0800
Message-Id: <20200306172010.1213899-1-ckuehl@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some background:

My team is working on a project that interacts very closely with
SEV so we have a layer of code that wraps around the SEV ioctl calls.
We have an automated test suite that ends up testing these ioctls
on our test machine.

We are in the process of adding this test machine as a dedicated test
runner in our continuous integration process. Any time someone opens a
pull request against our project, this test runner automatically checks
that code out and executes the tests.

Right now, the SEV ioctls that affect the state of the platform require
CAP_SYS_ADMIN to run. This is not a capability we can give to an
automated test runner, because it means that anyone who would like to
contribute to the project would be able to run any code they want (for
good or evil) as CAP_SYS_ADMIN on our machine.

This patch replaces the check for CAP_SYS_ADMIN with a check that can
still be easily controlled by an administrator with the file permissions
ACL. This way access to the device can still be controlled, but without
also assigning such broad system privileges at the same time.

Connor Kuehl (1):
  crypto: ccp: use file mode for sev ioctl permissions

 drivers/crypto/ccp/sev-dev.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

-- 
2.24.1

