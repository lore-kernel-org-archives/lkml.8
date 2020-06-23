Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118F1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E263C2078B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="s72LzhP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbgFWICZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:02:25 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:43000 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731158AbgFWICX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592899342; x=1624435342;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0ogUMEimjCKkrZVTOaTS0pbyYgrTcwl/8QxbW1JRQZo=;
  b=s72LzhP5Xsvag/48itoOU6FY1eJEIOaUgS07NRmNvYT5kEp2C7SF8jSf
   puZqBsr9IEz+v40oJvWlkhhSNRPtLZjxfVUYVPTfhETK9Z+1/Ze5LOqLh
   qPKUoHVfaJxj8NKpG0rRcxyMGACQWZheYgoe2IqBXNzcQ8oN/6zrpJsxD
   fHW+8Icp26T1RawhlXChbEmjzJipR2JAa2VmTHsV88Zek4lTxrNZoO8TU
   ybliO8XJNebycwY4hGkvnuDcRUgpMYAclDt5Jc3np58ou2mGDCrInkeEE
   7nVTXsjTBCcr/oP+07UFqHJ36SzUjPqLbsMo4NM8WfJz6WS7ccyuPe/Wn
   Q==;
IronPort-SDR: J6ZvwGuNaoSpKwnAaAeypTuXdyhRSVceuVIKH3RwYh4QvdmJKHXJ4aGW2lIpkllfCBG+EVA8Pt
 MTFoy6rg2fjQ8W/plsDPPdAIq0cpH+KcuBOSqG3s1XC0DpeTLFPt6Q6t9WzJTQ78I/LjLD8gGb
 45Bs37LWResoGb9gue8JkjT+jMpzEA8fQG6VO00SuLgw8sIYf0SE3DutOirS0ie+RdISpZmDxF
 UcPZC+ensF3o14pj0qxf9JcYn54yRi1SUaUwO2Qu+jQfJppfqKXMZGWDOmRXly33imKYIWmark
 hFs=
X-IronPort-AV: E=Sophos;i="5.75,270,1589266800"; 
   d="scan'208";a="79430541"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jun 2020 01:02:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Jun 2020 01:02:10 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Tue, 23 Jun 2020 01:02:21 -0700
Date:   Tue, 23 Jun 2020 10:02:17 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     David Miller <davem@davemloft.net>
CC:     <nikolay@cumulusnetworks.com>, <UNGLinuxDriver@microchip.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [Resend PATCH net] bridge: uapi: mrp: Fix MRP_PORT_ROLE
Message-ID: <20200623080217.bjsml4jmrvrq6eev@soft-dev3.localdomain>
References: <20200620131403.2680293-1-horatiu.vultur@microchip.com>
 <20200622.160712.2300967026610181117.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200622.160712.2300967026610181117.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 06/22/2020 16:07, David Miller wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> From: Horatiu Vultur <horatiu.vultur@microchip.com>
> Date: Sat, 20 Jun 2020 15:14:03 +0200
> 
> > Currently the MRP_PORT_ROLE_NONE has the value 0x2 but this is in conflict
> > with the IEC 62439-2 standard. The standard defines the following port
> > roles: primary (0x0), secondary(0x1), interconnect(0x2).
> > Therefore remove the port role none.
> >
> > Fixes: 4714d13791f831 ("bridge: uapi: mrp: Add mrp attributes.")
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> 
> The code accepts arbitrary 32-bit values for the role in a configuration
> but only PRIMARY and SECONDARY seem to be valid.
> 
> There is no validation that the value used makes sense.
> 
> In the future if we handle type interconnect, and we add checks, it will
> break any existing applications.  Because they can validly pass any
> non-zero valid and the code treats that as SECONDARY currently.
> 
> So you really can't just remove NONE, you have to add validation code
> too so we don't run into problem in the future.

Thanks for the explanation. I will add some code that checks
specifically for primary(0x0) and secondary(0x1) values and for any
other value to return -EINVAL.
Then in the future when we handle the type interconnect(0x2), we will
just extend this code to check for this value.

> 
> Thanks.

-- 
/Horatiu
