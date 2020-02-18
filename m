Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCC9C34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A253F20679
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgBRR7O convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:59:14 -0500
Received: from mga07.intel.com ([134.134.136.100]:58793 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgBRR7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:59:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 09:59:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,456,1574150400"; 
   d="scan'208";a="348734560"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga001.fm.intel.com with ESMTP; 18 Feb 2020 09:59:12 -0800
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.100]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.242]) with mapi id 14.03.0439.000;
 Tue, 18 Feb 2020 09:59:12 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Anatoly Pugachev <matorola@gmail.com>
CC:     Pat Gefre <pfg@sgi.com>, Christoph Hellwig <hch@lst.de>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "Linux Kernel list" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tty/serial: cleanup after ioc*_serial driver removal
Thread-Topic: [PATCH] tty/serial: cleanup after ioc*_serial driver removal
Thread-Index: AQHV5WqYv292SGF57kuz1XDJAAGim6gfmG+AgAAG1oCAAZ8dMA==
Date:   Tue, 18 Feb 2020 17:59:11 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F57B7D6@ORSMSX115.amr.corp.intel.com>
References: <20200217081558.10266-1-lukas.bulwahn@gmail.com>
 <CADxRZqwGBi=4A224mG0cPgONdNitnvi3LFD_KQckxdYSXzgBGg@mail.gmail.com>
 <alpine.DEB.2.21.2002170950390.11007@felia>
In-Reply-To: <alpine.DEB.2.21.2002170950390.11007@felia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I do not know if there are more ia64 serial drivers, but the MAINTAINERS 
> entry and commit message suggested there is not another serial driver.

Lukas,

There aren't any other ia64 specific serial drivers. But ia64 does use generic
serial drivers (e.g. my test machine has a couple of serial ports attached to 16550A
devices)

I think some notes in that documentation file still apply. Please don't delete.

-Tony
