Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A889C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11FA620771
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="Ri407fB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgHKR26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 13:28:58 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:35263 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729108AbgHKR24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 13:28:56 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BR0Dk05rCz2F;
        Tue, 11 Aug 2020 19:28:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1597166934; bh=n+N9yNzMz81wS72bWVcaIoPCwU9Xe/MWkc9PaIS1Yyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ri407fB1Id6QblqdeSC73fV2v3KGkLUzjW1Uu3otRMvAVKhiaeD4qzbc7KgOeHOPd
         Jw3SIF2gVU4hy4SS/zzlE3sFhgR1nuLlcGCNWvvemRaX/tsyvMG/7SgCc5J6do5acS
         tJ6KWeFej+KoIfDuc3NK9OowPWOLoBLwXXGoHnWlZgv0zWZqLdh313VYDQcuIwF97U
         1CgKVaYngp3CK4aM35rJioZWLnOq/X1BcyJ0mCm0iq351M9wLOxHP36KFkjOe1scY+
         iRvuvXSFpjFQvtsHNp0BZxSnBAVujryp3QAwL7zZdjproLldYBkemud1PD4kUWDBVP
         LBYuqy1+1zLVA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Tue, 11 Aug 2020 19:28:52 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     kernel test robot <lkp@intel.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH 4/7] regulator: push allocation in
 set_consumer_device_supply() out of lock
Message-ID: <20200811172852.GB21273@qmqm.qmqm.pl>
References: <2a978483b064b810b00e072fcdb6c3d24a896bd8.1597107682.git.mirq-linux@rere.qmqm.pl>
 <202008111330.UvK1uTd7%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008111330.UvK1uTd7%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 01:23:47PM +0800, kernel test robot wrote:
[...]
> New smatch warnings:
> drivers/regulator/core.c:1491 set_consumer_device_supply() warn: overwrite may leak 'node'

Ah! Good catch!
