Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27FBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 11:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8860207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 11:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbgESLwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 07:52:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:22615 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726949AbgESLwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 07:52:03 -0400
IronPort-SDR: mVZbLkjj4cA7yNFGuaJ7uT5du5OnWoIqisx40weUsqxRFgRe8TPcf7xdr7JlZ052mfnb+msicb
 MFCusBAm+9cA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 04:52:03 -0700
IronPort-SDR: 1NJu7J3wH8sNYfzvwybFMGSvTG4hzFGDTTFWdM1Ih5YiG9F0aYjkqlRGhCiweu3ZdVhyZ7o3JY
 kuCqg4pKmeEg==
X-IronPort-AV: E=Sophos;i="5.73,410,1583222400"; 
   d="scan'208";a="254705056"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 04:51:59 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 0AF8820CEF; Tue, 19 May 2020 14:51:57 +0300 (EEST)
Date:   Tue, 19 May 2020 14:51:57 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Roman Kovalivskyi <roman.kovalivskyi@globallogic.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Luis Oliveira <lolivei@synopsys.com>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>, Jacopo Mondi <jacopo@jmondi.org>,
        Michael Rodin <mrodin@de.adit-jv.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hugues Fruchet <hugues.fruchet@st.com>,
        Maxime Ripard <mripard@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        Todor Tomov <todor.tomov@linaro.org>,
        Suresh Udipi <sudipi@jp.adit-jv.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.org>
Subject: Re: [PATCH v2 1/6] media: ov5647: Add set_fmt and get_fmt calls.
Message-ID: <20200519115156.GJ20066@paasikivi.fi.intel.com>
References: <cover.1589850165.git.roman.kovalivskyi@globallogic.com>
 <8a4c0d157d26251c9916b32866e6a4a91c023ef9.1589850165.git.roman.kovalivskyi@globallogic.com>
 <20200519112403.GG20066@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519112403.GG20066@paasikivi.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 02:24:03PM +0300, Sakari Ailus wrote:
> Hi Dave,

I meant to say "Hi Roman".

-- 
Sakari Ailus
