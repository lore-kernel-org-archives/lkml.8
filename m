Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3985C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF246204EA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="C9hSX+w9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733096AbgFWRVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:21:24 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50016 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732526AbgFWRVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:21:24 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05NHKc0j066726;
        Tue, 23 Jun 2020 12:20:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592932838;
        bh=dFXTf2bV1PYWlUjmPKLKA4y17HgI+6Myl1rwDwUgsl4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=C9hSX+w98eQ/z/nwdUCWOZgWuDf/ArBLgoOEFlILif4KZmZ4PGWJeaLv/FM8+2vhJ
         bvbl8qQ+rSufQcoyz6+s0I3YbZQaopuLBAHnKDqRBfAvIrXOF/s29LgRmmiTkY75KI
         MzN+4bo0MPHxkAsuIqhYbdVTWKMzmNlQo1cfQbHA=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05NHKcQ5077730
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Jun 2020 12:20:38 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 23
 Jun 2020 12:20:38 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 23 Jun 2020 12:20:38 -0500
Received: from [10.250.52.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05NHKbvR014960;
        Tue, 23 Jun 2020 12:20:37 -0500
Subject: Re: [PATCH v4 2/2] ASoC: tas2562: Update shutdown GPIO property
To:     Mark Brown <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <robh@kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20200612171412.25423-1-dmurphy@ti.com>
 <20200612171412.25423-2-dmurphy@ti.com>
 <cfb043e3-77c5-2957-20b6-2814f1445cf0@ti.com>
 <20200623171842.GH5582@sirena.org.uk>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <63eb06e7-451d-0e8f-36fb-5b5d93ccf803@ti.com>
Date:   Tue, 23 Jun 2020 12:20:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200623171842.GH5582@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark

On 6/23/20 12:18 PM, Mark Brown wrote:
> On Tue, Jun 23, 2020 at 10:59:49AM -0500, Dan Murphy wrote:
>> On 6/12/20 12:14 PM, Dan Murphy wrote:
>>> Update the shutdown GPIO property to be shutdown from shut-down.
>> I have some other patches that go on top of this patchset I am wondering if
>> I should re-submit with those patches on top or indicate in a cover letter
>> the dependency
> If you decide to resubmit please make the YAML conversion the very last
> thing you do in your series, there is a considerable backlog on YAML
> conversion reviews which slows down any changes that depend on them.

Thanks for the advice.  I know the DT folks have a lot to review and the 
merge window did not help them.

I will re-factor these and re-submit as well as the TAS2770 patchset.

Dan

