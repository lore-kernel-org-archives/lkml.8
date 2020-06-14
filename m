Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6742AC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 02:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35E1420739
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 02:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bvJRyRcO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgFNCO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 22:14:56 -0400
Received: from m12-11.163.com ([220.181.12.11]:35210 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbgFNCO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 22:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=dOy00+ORgVMThF5Jzv
        wHERdJTCK000taaz8u/hduP5A=; b=bvJRyRcOyPlnZ6JXS/RXZ0SALawGvZ65Qq
        6b85jsXg8hw2OHOLbCUcfuMOX9gxIFZdUxE2gAwkRoMj6dPbTJtGohXCBQxPm8Ok
        0PX+sBru5lVDaQJaZWOfr2u2kkCkA7d8MQB2ielaHorqs0QE04GgbXmnYwZbWqkH
        kJR6iASQQ=
Received: from localhost.localdomain (unknown [111.202.190.28])
        by smtp7 (Coremail) with SMTP id C8CowACntJj+h+VeJl0CGg--.24256S2;
        Sun, 14 Jun 2020 10:14:22 +0800 (CST)
From:   zzuedu2000@163.com
To:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix code style in css_task_iter_next_css_set()
Date:   Sun, 14 Jun 2020 10:14:12 +0800
Message-Id: <20200614021412.2495-1-zzuedu2000@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200613005306.29988-1-zzuedu2000@163.com>
References: <20200613005306.29988-1-zzuedu2000@163.com>
X-CM-TRANSID: C8CowACntJj+h+VeJl0CGg--.24256S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUreOGUUUUU
X-Originating-IP: [111.202.190.28]
X-CM-SenderInfo: p22xvvbxsqiii6rwjhhfrp/1tbiGR5DQlyPYkSakQAAs4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this patch, I will send a updated one later.

Regards,
Wei Fenghai

