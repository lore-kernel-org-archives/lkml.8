Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB487C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 11:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9411B208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 11:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgFQLJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 07:09:08 -0400
Received: from v6.sk ([167.172.42.174]:50040 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgFQLJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 07:09:07 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 7057E610B4;
        Wed, 17 Jun 2020 11:08:36 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] mfd: Add ENE KB3930 Embedded Controller driver
Date:   Wed, 17 Jun 2020 13:08:27 +0200
Message-Id: <20200617110829.1036898-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please consider applying the patches chained to this message. It's the
fifth version of the driver for the ENE KB3930 Embedded Controller.

This version is essentially a resend of v4. The only actual change is the
addition of the Rob's Reviewed-by tag which I failed to do previously.
Detailed change logs are in the individual patch descriptions.

Thanks,
Lubo


