Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BA7C10F26
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 10:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE632077D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 10:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387983AbgDBKhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 06:37:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:53369 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728612AbgDBKhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 06:37:00 -0400
IronPort-SDR: 1Rl/8h4Mfd/kzmQvBpNMhFHbsrNtq8NIgr7zxtGTNHMwvufvjhgcWfaq/flwWofODmmYY7Komg
 3OWsZRPU2aRg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 03:37:00 -0700
IronPort-SDR: nDjMTiretKLcxg8sx08bMNimZJRAY4/EVlcyqzKt8Rczjsh02E/dFZN9OGNGkdw8QaygRpZk2f
 p0MJhl1bhU3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,335,1580803200"; 
   d="scan'208";a="360158198"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 02 Apr 2020 03:36:57 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 02 Apr 2020 13:36:57 +0300
Date:   Thu, 2 Apr 2020 13:36:57 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Jian-Hong Pan <jian-hong@endlessm.com>,
        Ajay Gupta <ajayg@nvidia.com>
Cc:     linux-i2c@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        Linux Upstreaming Team <linux@endlessm.com>
Subject: Re: [BUG] i2c_nvidia_gpu takes long time and makes system suspend &
 resume failed with NVIDIA cards
Message-ID: <20200402103657.GE1886416@kuha.fi.intel.com>
References: <CAPpJ_edj++oy7_EDN95tM+BPdYFOztpCrRh-cfzFrY6unJb1Rw@mail.gmail.com>
 <20200402103447.GD1886416@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402103447.GD1886416@kuha.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 01:34:51PM +0300, Heikki Krogerus wrote:
> You are using an outdated kernel, 5.4.0. Please make sure that you can
> reproduce the issue with mainline, or at least with the longterm
> 5.4.x.

I meant the latest 5.4.x, which today is 5.4.29.


thanks,

-- 
heikki
