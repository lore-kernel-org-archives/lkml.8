Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0FCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8D6622BED
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="oVNZg1UZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgHDLwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 07:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730289AbgHDLuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:50:08 -0400
Received: from forward103j.mail.yandex.net (forward103j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983A2C06174A;
        Tue,  4 Aug 2020 04:50:07 -0700 (PDT)
Received: from forward101q.mail.yandex.net (forward101q.mail.yandex.net [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb98])
        by forward103j.mail.yandex.net (Yandex) with ESMTP id DBBA36741E52;
        Tue,  4 Aug 2020 14:50:01 +0300 (MSK)
Received: from mxback3q.mail.yandex.net (mxback3q.mail.yandex.net [IPv6:2a02:6b8:c0e:39:0:640:4545:437c])
        by forward101q.mail.yandex.net (Yandex) with ESMTP id D940BCF40010;
        Tue,  4 Aug 2020 14:50:01 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback3q.mail.yandex.net (mxback/Yandex) with ESMTP id t0F3STMGqu-o1jWF1lR;
        Tue, 04 Aug 2020 14:50:01 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1596541801;
        bh=NVBrXkwf3kegsa/pq5ECHrAXws4O4jVGyY/yJcfMDwM=;
        h=Date:Message-Id:Cc:Subject:To:From;
        b=oVNZg1UZbksm5HuWjcb3lvhNY/ujFqUmNlk+zcvICd8Hm2llTyk/Xe6KwSpxkLhzb
         FQMxWQCxzmVQ0pisRCz268xMJCWdf5f7HXIIcwSl08EcMlNVKVVGfdQI7Qu68W7cwe
         40HEuBrTtUqmHYq9E80ua4ouAdT3St7qLnscSq58=
Authentication-Results: mxback3q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla1-058d120ab76c.qloud-c.yandex.net with HTTP;
        Tue, 04 Aug 2020 14:50:01 +0300
From:   Evgeny Novikov <novikov@ispras.ru>
Envelope-From: eugenenovikov@yandex.ru
To:     Jean Delvare <jdelvare@suse.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: hwmon: (sis5595) potential null pointer dereference in probe
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 04 Aug 2020 14:50:01 +0300
Message-Id: <856951596540762@mail.yandex.ru>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sis5595_pci_probe() registers platform driver callbacks and just then
initializes global pointer variable s_bridge. sis5595_probe() may
dereference it before this happens that can result in null pointer
dereference.

We can not swap registration of platform driver callbacks with
initialization of s_bridge since sm_sis5595_exit() assumes the
current order. Perhaps it has sense to implement a pci_driver.remove
callback that will take care about deregistration of platform driver
callbacks.

Found by Linux Driver Verification project (linuxtesting.org).

