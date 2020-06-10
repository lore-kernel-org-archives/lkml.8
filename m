Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B41DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B4A120734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="lD1in5nR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgFJIPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:15:12 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:37856 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726424AbgFJIPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 04:15:11 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 21BE44C849;
        Wed, 10 Jun 2020 08:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:references:message-id:subject:subject:from:from
        :date:date:received:received:received; s=mta-01; t=1591776902;
         x=1593591303; bh=ssxqr7UK6qEgdMyL7dH+arzPRX8wl0hfdoXSy9e6GuY=; b=
        lD1in5nRl1asvbaoxp5CSIcslPJ97egR0FsvzFA5Qe6rNOLlNv98ZLD+ablFJq5h
        CkFPj6VkCst15misLDGQ4YXYJEVNjikauyknE9Unkz6avYBKx4kO4exIUUJO5ZBG
        d3Yqo8lEmWBcfCgbIRX7GbgiMsSM/x5W267/6q5fcGo=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AjbnNF-_vzes; Wed, 10 Jun 2020 11:15:02 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 291614C84E;
        Wed, 10 Jun 2020 11:15:01 +0300 (MSK)
Received: from localhost (172.17.14.122) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 10
 Jun 2020 11:15:01 +0300
Date:   Wed, 10 Jun 2020 11:15:00 +0300
From:   "Alexander A. Filippov" <a.filippov@yadro.com>
To:     Alexander Filippov <a.filippov@yadro.com>
CC:     <linux-aspeed@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Geissler <geissonator@yahoo.com>,
        Patrick Williams <patrick@stwcx.xyz>
Subject: Re: [PATCH v7] ARM: DTS: Aspeed: Add YADRO Nicole BMC
Message-ID: <20200610081500.GA27959@bbwork.lan>
References: <20200429113711.13183-1-a.filippov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200429113711.13183-1-a.filippov@yadro.com>
X-Originating-IP: [172.17.14.122]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 02:37:11PM +0300, Alexander Filippov wrote:
> Nicole is an OpenPower machine with an Aspeed 2500 BMC SoC manufactured
> by YADRO.
> 
> Signed-off-by: Alexander Filippov <a.filippov@yadro.com>
> 

ping
