Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E347FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2F8D204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gwv5NDIA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbgEUVfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 17:35:17 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54100 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgEUVfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 17:35:15 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04LLZC3k062715;
        Thu, 21 May 2020 16:35:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590096912;
        bh=u9qi9KC2xaYyJChlE5LKpjtzP8n7aoXaHe74b3NFy7o=;
        h=Date:From:To:Subject:References:In-Reply-To;
        b=gwv5NDIAy4WYarbXRKAOI6Lcuu1cPqmxA39E1I955qdX8QUSb9KkO6Sn0ns+Gbnpd
         qnYk79R+Su/K/AXPbUfkcrVYx+QURipqPjU3UfqUuqujrN1g7H3lGVthXBuHGufnex
         GyxRbolbMr/lpt4bHpUfd/QhMsV8RZPhi5AS4PMo=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04LLZC6t042910
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 May 2020 16:35:12 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 21
 May 2020 16:35:11 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 21 May 2020 16:35:11 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04LLZBt0066752;
        Thu, 21 May 2020 16:35:11 -0500
Date:   Thu, 21 May 2020 16:35:11 -0500
From:   Bin Liu <b-liu@ti.com>
To:     Paul Cercueil <paul@crapouillou.net>, <od@zcrc.me>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: musb: jz4740: Prevent lockup when CONFIG_SMP is set
Message-ID: <20200521213511.GE5684@iaqt7>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Paul Cercueil <paul@crapouillou.net>, od@zcrc.me,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200520150111.76658-1-paul@crapouillou.net>
 <20200521203422.GA25575@iaqt7>
 <P18PAQ.NMWTDBTHKARL1@crapouillou.net>
 <20200521213028.GC25575@iaqt7>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200521213028.GC25575@iaqt7>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,

On Thu, May 21, 2020 at 04:30:28PM -0500, Bin Liu wrote:
> On Thu, May 21, 2020 at 10:39:25PM +0200, Paul Cercueil wrote:
> > Hi Bin,
> > 
> > The patch it fixes was introduced in 5.7-rc1, is it possible to queue it for
> > the next -rc? Otherwise I'll need to Cc it to linux-stable.
> 
> I pinged Grag if he can directly take it for -rc7.

BTY, it is not an issue if it is too late for -rc7, I've already added
Cc stable@ when queueing it.

-Bin.
