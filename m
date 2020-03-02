Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA6EC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7D321D56
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbgCBSFm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:05:42 -0500
Received: from mga09.intel.com ([134.134.136.24]:38805 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbgCBSFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:05:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 10:05:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,507,1574150400"; 
   d="scan'208";a="412388040"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga005.jf.intel.com with ESMTP; 02 Mar 2020 10:05:40 -0800
Received: from hasmsx603.ger.corp.intel.com (10.184.107.143) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Mar 2020 10:05:40 -0800
Received: from hasmsx602.ger.corp.intel.com (10.184.107.142) by
 HASMSX603.ger.corp.intel.com (10.184.107.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Mar 2020 20:05:38 +0200
Received: from hasmsx602.ger.corp.intel.com ([10.184.107.142]) by
 HASMSX602.ger.corp.intel.com ([10.184.107.142]) with mapi id 15.01.1713.004;
 Mon, 2 Mar 2020 20:05:38 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Christoph Hellwig" <hch@lst.de>
Subject: RE: [PATCH v1] mei: Don't encourage to use kernel internal types in
 user code
Thread-Topic: [PATCH v1] mei: Don't encourage to use kernel internal types in
 user code
Thread-Index: AQHV7kmoHRGWq8a92EO3ikJkF4xQsagyWSTQgAL/iQCAAECokA==
Date:   Mon, 2 Mar 2020 18:05:38 +0000
Message-ID: <c42fc7597d7c4d0a9867c41a94b0844b@intel.com>
References: <20200228151328.45062-1-andriy.shevchenko@linux.intel.com>
 <3bb5abe91919458aa6166eb60d9451ff@intel.com>
 <20200302155818.GG1224808@smile.fi.intel.com>
In-Reply-To: <20200302155818.GG1224808@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
x-originating-ip: [10.184.70.1]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> +Cc: Christoph.
> 
> On Sat, Feb 29, 2020 at 04:28:11PM +0000, Winkler, Tomas wrote:
> > > uuid_le is internal kernel type which shall not be exposed to the
> > > user in the first place.
> > Why, these types are exported via include/uapi/linux/uuid.h
> 
> Which is wrong from the day 1.
I'm not sure why, this is API between kernel and the user space. 

> The uuid_t type is being provided by libuuid in the user space, there is no
> (more) kernel exported equivalent. Same should be done to the uuid_le.

There are many uuid libraries, which  is the one that provides the uuid type
between kernel and the user space? 

> 
> We already discussed this couple of years ago.
I do not recall be part of this conversation, please share the link. 

> 
> > In order to mitigate the (wrong) distribution of the use of that type,
> > > switch MEI AMT sample to plain unsigned char array.
> >
> > There was a change to guid_t from uuild_le, anyhow there is much more
> > code  except this sample that uses those types.
> 
> I guess you misunderstood the point. The types are for kernel use and keeping
> them exported in a condition like it's now (quoter baked due to drop of uuid_be
> part completely and uuid_le partially) is wrong.
Is wrong how... ?  What is broken in the concept ? Please give me an example of what is going to wrong, here. 
Just saying that something is wrong is not convincing. 

> There is *no* ABI change. And basically libuuid or another one should provide
> type and infrastructure for this.
But API is already out there, do you plan to remove it? 
  
> > Nack so far.
> 
> If you would like to bear the legacy type, why not to move this UUID UAPI parts
> directly to MEI?
I can but do you know all the software that includes <linux/uuid.h> ?
Thanks
Tomas


