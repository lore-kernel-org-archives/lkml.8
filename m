Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E123DC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 13:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C65D020708
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 13:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgHPNvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 09:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbgHPNvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 09:51:32 -0400
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B84C061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 06:51:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id C75642FDD;
        Sun, 16 Aug 2020 15:51:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bxklrOI6WaVx; Sun, 16 Aug 2020 15:51:22 +0200 (CEST)
Received: from function.home (2a01cb008800c5009eb6d0fffe88c3c7.ipv6.abo.wanadoo.fr [IPv6:2a01:cb00:8800:c500:9eb6:d0ff:fe88:c3c7])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id E728D2EB7;
        Sun, 16 Aug 2020 15:51:21 +0200 (CEST)
Received: from samy by function.home with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1k7J4C-000a97-15; Sun, 16 Aug 2020 15:51:20 +0200
Date:   Sun, 16 Aug 2020 15:51:20 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: drivers/accessibility/speakup/serialio.c:139:9: sparse: sparse:
 cast removes address space '__iomem' of expression
Message-ID: <20200816135119.gdjmznnbmd53ycqe@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <202008161912.jRyQUNBM%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202008161912.jRyQUNBM%lkp@intel.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot, le dim. 16 août 2020 19:25:17 +0800, a ecrit:
> First bad commit (maybe != root cause):

> >> drivers/accessibility/speakup/serialio.c:139:9: sparse: sparse: cast removes address space '__iomem' of expression

This will also be fixed by the patches I already sent to gregkh for
after rc1.

Samuel
