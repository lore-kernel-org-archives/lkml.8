Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33E9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 23:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE1FD2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 23:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="RSCiZL7G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgGNXrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 19:47:40 -0400
Received: from mail-m964.mail.126.com ([123.126.96.4]:38506 "EHLO
        mail-m964.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgGNXrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 19:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=6ftHnufomPdHe0IaVz
        +dEJ5CVFA2F1hb5s6vpXV/Y1k=; b=RSCiZL7GvzHaS/u8IQn3oRlBsDrvo/zZes
        OUaVFAIqFkMZx3+BudzCj+DMgMTOvLjHCo7iLeuRQtSek0em9703hM2o4MIejLZC
        JbVsEYGU1FV1jzhDpWujXNNUqh9Vh78goSTFs6xpMZ2IMsEtQKxcow+1aQHdKXdH
        qE5Er4zys=
Received: from zhixu-home.lan (unknown [114.249.221.156])
        by smtp9 (Coremail) with SMTP id NeRpCgAnhRVoQw5fvYJGCg--.14881S2;
        Wed, 15 Jul 2020 07:44:40 +0800 (CST)
From:   Zhixu Zhao <zhixu001@126.com>
To:     zhixu001@126.com
Cc:     benchan@chromium.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, joe@perches.com,
        linux-kernel@vger.kernel.org, rcy@google.com, rspringer@google.com,
        toddpoynor@google.com, dan.carpenter@oracle.com
Subject: Re: [PATCH v2] staging: gasket: core: Fix a coding style issue in gasket_core.c
Date:   Wed, 15 Jul 2020 07:44:40 +0800
Message-Id: <20200714234440.27009-1-zhixu001@126.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617161127.32006-1-zhixu001@126.com>
References: <20200617161127.32006-1-zhixu001@126.com>
X-CM-TRANSID: NeRpCgAnhRVoQw5fvYJGCg--.14881S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4Rn2-eDUUUU
X-Originating-IP: [114.249.221.156]
X-CM-SenderInfo: x2kl53qqqrqiyswou0bp/1tbiZghhfFpD+1v+tAAAsA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 12:11:27AM +0800, Zhixu Zhao wrote:
> A coding alignment issue is found by checkpatch.pl.
> Fix it by using a temporary for gasket_dev->bar_data[bar_num].
> 
> Signed-off-by: Zhixu Zhao <zhixu001@126.com>

Hi, there~

Does anybody have any further comments on this?
Can it be merged?

Zhixu

