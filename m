Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC06C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DD9920672
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOy0Rn8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgDTTDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 15:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725897AbgDTTDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 15:03:06 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D45C061A0C;
        Mon, 20 Apr 2020 12:03:06 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id z17so9120385oto.4;
        Mon, 20 Apr 2020 12:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=wLNfgc0lK3dfiX3WPq7c7FuxrHVZkfef8LmublWLkTo=;
        b=iOy0Rn8SIxDyWfdZcocnwFGWXzcIQ2y/3oL3DuZRe3PCczBn+0+v2gfoM5xQHgHeUt
         DOUdJfACwGtlhfZteTjNTnBxWLXsyIUVSIayegfYPtgMiOKK65/zkjtIJPukg4vp2sBO
         5APYWks2yLysjRHV7W+Kpytg0AdMwVLl2r9aYb7zwNEcswz+iESIT0tZul7v3WnSrnc3
         yhS7c9N7uy4qhSbKZPRdQs14TMveOT+PpPh+oBJLIJvXrYfaX0MB/XZrR4uiGUVJTMNF
         Aeav05Mk1/Iab4oEd5enukkrJQzrMGjJ3KUpQy5GKJvQQlyRAR/vXd6WbSZFFjpyR5m0
         aN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wLNfgc0lK3dfiX3WPq7c7FuxrHVZkfef8LmublWLkTo=;
        b=GWU3mTvRg+JmMT05VidTN2GNc5EBnj4TytKkIm07bIEd2wuj4EoqmhYXe48qhfplNs
         XesXdgblMsA2JJm5Vjf+uEezNncJJirLYOZUnFsMo8Zw38G6oiuZAuC5we/FsKxEx0IN
         cGB0pA0Ul45epVHio+v0PUI+UWZ3s2hiwSwx4Lj2o1ud0Q+rbR2I+ZQQnaVVYF6DAZuW
         YH4P3AzYx2Uk3dvla4YNuqYZPQh2ctCrkadeSMRy1Uae0nhrfWtP5gO6LAzHAZ856IEn
         /VAAC9k38EbfFiv1z0u0MriJzR+1hTo0zUpDRxkFWbpl/I8ibYIjfepqTgu2gEYCZ8+t
         d87Q==
X-Gm-Message-State: AGi0PubJPuw/M9ozBphsAq4TE32SWdWpJoX7t9gRw6vD3BxwXF+8jI3b
        P99gUpT+jWRcn10LAAY/0PF481JpJOQXZA==
X-Google-Smtp-Source: APiQypIEHrlD6iuGtBAzwdXLY2QyTR9wExQ4s08KTjzuJHKq0KS58CyzLUMnghdjjaJoq+ujRW29XA==
X-Received: by 2002:a9d:6452:: with SMTP id m18mr10460901otl.51.1587409386200;
        Mon, 20 Apr 2020 12:03:06 -0700 (PDT)
Received: from raspberrypi (99-189-78-97.lightspeed.austtx.sbcglobal.net. [99.189.78.97])
        by smtp.gmail.com with ESMTPSA id v17sm56721oif.51.2020.04.20.12.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 12:03:05 -0700 (PDT)
Date:   Mon, 20 Apr 2020 14:03:03 -0500
From:   Grant Peltier <grantpeltier93@gmail.com>
To:     linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     adam.vaughn.xh@renesas.com, grant.peltier.jg@renesas.com
Subject: [PATCH 0/2] hwmon: (pmbus) add debugfs features for Gen 2 Renesas
 digital multiphase
Message-ID: <cover.1587408025.git.grantpeltier93@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch series adds debugfs features for 2nd generation Renesas digital
multiphase voltage regulators. The new debugfs endpoints allow users to
utilize features of the VR that are not compatible with sysfs.

The series contains 2 patches:
 - patch #1 adds the new debugfs features to the isl68137 driver
 - patch #2 adds documentation for the new debugfs endpoints

Grant Peltier (2):
  hwmon: (pmbus/isl68137) add debugfs config and black box endpoints
  docs: hwmon: Update driver documentation for debugfs

 Documentation/hwmon/isl68137.rst |  34 ++-
 drivers/hwmon/pmbus/isl68137.c   | 490 ++++++++++++++++++++++++++++++-
 2 files changed, 520 insertions(+), 4 deletions(-)

-- 
2.20.1

