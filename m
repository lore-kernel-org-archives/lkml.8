Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F09C43457
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0B84205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389265AbgEMPAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:00:52 -0400
Received: from v6.sk ([167.172.42.174]:54032 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389247AbgEMPAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:00:42 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id BEE3D610A5;
        Wed, 13 May 2020 15:00:11 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: 
Date:   Wed, 13 May 2020 17:00:04 +0200
Message-Id: <20200513150007.1315395-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <[PATCH 0/3] drm/etnaviv: Clock fixes>
References: <[PATCH 0/3] drm/etnaviv: Clock fixes>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please consider applying patches that are chained to this message.

They make getting/enabling the clocks in the etnaviv driver slightly nicer,
first two also fix potential problems.

Thanks
Lubo


