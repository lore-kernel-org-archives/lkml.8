Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35638C33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 06:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C90207E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 06:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgANG45 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 01:56:57 -0500
Received: from mga14.intel.com ([192.55.52.115]:15022 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728680AbgANG45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 01:56:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 22:56:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,431,1571727600"; 
   d="scan'208";a="217650453"
Received: from pgsmsx112.gar.corp.intel.com ([10.108.55.201])
  by orsmga008.jf.intel.com with ESMTP; 13 Jan 2020 22:56:54 -0800
Received: from pgsmsx114.gar.corp.intel.com ([169.254.4.192]) by
 PGSMSX112.gar.corp.intel.com ([169.254.3.207]) with mapi id 14.03.0439.000;
 Tue, 14 Jan 2020 14:56:53 +0800
From:   "Ong, Boon Leong" <boon.leong.ong@intel.com>
To:     Jakub Kicinski <kubakici@wp.pl>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "David S . Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Tan, Tee Min" <tee.min.tan@intel.com>,
        "Voon, Weifeng" <weifeng.voon@intel.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net 3/7] net: stmmac: fix missing netdev->features in
 stmmac_set_features
Thread-Topic: [PATCH net 3/7] net: stmmac: fix missing netdev->features in
 stmmac_set_features
Thread-Index: AQHVyfomk1Civpoau0S27mPh9DveG6foDXcAgAGt5vA=
Date:   Tue, 14 Jan 2020 06:56:53 +0000
Message-ID: <AF233D1473C1364ABD51D28909A1B1B75C45CC79@pgsmsx114.gar.corp.intel.com>
References: <1578967276-55956-1-git-send-email-boon.leong.ong@intel.com>
        <1578967276-55956-4-git-send-email-boon.leong.ong@intel.com>
 <20200113051712.73442991@cakuba>
In-Reply-To: <20200113051712.73442991@cakuba>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [172.30.20.205]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, 14 Jan 2020 10:01:12 +0800, Ong Boon Leong wrote:
>
>Please fix the date on your system.
>
>Please always provide a patch description. For bug fixes description of
>how the bug manifest to the users is important to have.
>
>> Fixes: d2afb5bdffde ("stmmac: fix the rx csum feature")
>>
>
>Please remove the empty lines between the Fixes tag and the other tags
>on all patches.

Thanks for input. Will fix. 

