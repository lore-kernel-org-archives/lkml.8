Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	TVD_SPACE_RATIO,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D36EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 23:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BBC520747
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 23:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aVjWqI2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgGCXzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 19:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgGCXzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 19:55:44 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D3DC061794;
        Fri,  3 Jul 2020 16:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=jfzvkgWh97c/J/HuSFPbL01MXXhAVUclVv/9CBF7KcU=; b=aVjWqI2JTeUPiLa4tf5DxDCe8/
        0io6O6niuWTsh+5xMaMcq3k1WZVpehcayS8+LY9J4Hu7oynubrYMSTf0Zj8C2NkvbuYjzoIjwD21a
        rt/vYj28j2RNUn2igQwWh+y29VUpu/zgu7SLV6RbZxZ0rhjvUD32N9qwot1dcfrcgr7tGGbfAsHwH
        fw92tg9lWJKkMiPRepGjNHKCQpepDGPEkk3/tZtlIczrD10xxVfwPtz2knGWq9UrwQ+9bqjMbq8ro
        Q7c1DdXc1PWymYhc+A8N8OqcL+eiUywLX+nDvYttGOGkk61h+zHpbQq3zZnXmuuRun0isEGm6jvIk
        w9bKy9ow==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrVWv-0005uW-2z; Fri, 03 Jul 2020 23:55:41 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH 00/11] Documentation: userspace-api/media: eliminate duplicated words
Date:   Fri,  3 Jul 2020 16:55:25 -0700
Message-Id: <20200703235536.30416-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop all doubled words in Documenation/userspace-api/media/ files.


Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org

 Documentation/userspace-api/media/dvb/audio.rst                       |    2 +-
 Documentation/userspace-api/media/dvb/ca.rst                          |    2 +-
 Documentation/userspace-api/media/dvb/demux.rst                       |    2 +-
 Documentation/userspace-api/media/dvb/dmx-qbuf.rst                    |    2 +-
 Documentation/userspace-api/media/dvb/net.rst                         |    2 +-
 Documentation/userspace-api/media/dvb/video.rst                       |    2 +-
 Documentation/userspace-api/media/v4l/buffer.rst                      |    2 +-
 Documentation/userspace-api/media/v4l/selection-api-configuration.rst |    2 +-
 Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst          |    2 +-
 Documentation/userspace-api/media/v4l/vidioc-g-output.rst             |    2 +-
 Documentation/userspace-api/media/v4l/vidioc-qbuf.rst                 |    2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)
