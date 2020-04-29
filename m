Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE88C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB7642074A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=phytec.de header.i=@phytec.de header.b="oXlvIHRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgD2NpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:45:08 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:62566 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgD2NpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1588167904; x=1590759904;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xlNJzENzGdwVrLtZkCj2SP29S7rBf6E3uG2taG606uk=;
        b=oXlvIHRP5IFNPMrTe6r7bTXJLhcQmXCAk9cHNE+FPRCwi3S8aFVxLeG568wYwWDR
        YBV+KORkLoks3YqeoOMy/Ol7+jEyt4Sw/JEO+lnA6s+DHgZThgJap1RhXS8jiYNp
        rT9CS5MNwYO96aUFCHBA+Aib/NVA36v1pfXuE9BPwuE=;
X-AuditID: c39127d2-9f7ff70000001ac4-3e-5ea984e0caf8
Received: from idefix.phytec.de (Unknown_Domain [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 0D.BC.06852.0E489AE5; Wed, 29 Apr 2020 15:45:04 +0200 (CEST)
Received: from [172.16.21.128] ([172.16.21.128])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2020042915450423-291825 ;
          Wed, 29 Apr 2020 15:45:04 +0200 
Subject: Re: [PATCH v2] drm/panel: simple: Support reset GPIOs
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Thierry Reding <thierry.reding@gmail.com>
References: <20191224142134.22902-1-miquel.raynal@bootlin.com>
 <20200102172700.GA15341@ravnborg.org> <20200106101042.5bb5b742@xps13>
From:   Wadim Egorov <w.egorov@phytec.de>
Message-ID: <519b5628-3e40-b034-8efd-56288cc2159e@phytec.de>
Date:   Wed, 29 Apr 2020 15:45:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200106101042.5bb5b742@xps13>
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 29.04.2020 15:45:04,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 29.04.2020 15:45:04
X-TNEFEvaluated: 1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsWyRoCBS/dBy8o4g9fLRCx6z51ksrjy9T2b
        xeVdc9gsXr7exmxxuH0fq8Xlr32MFit+bmW0+LlrHotF55t37A6cHvPWVHvsnHWX3WP7twes
        Hve7jzN5LJl2lc3j8ya5ALYoLpuU1JzMstQifbsErowXW78xFtwRq1h+4hB7A+NaoS5GTg4J
        AROJizcXsYHYQgLbGCWudvJ3MXIB2WcYJQ5MXs7cxcjBISxgJzHnMjNIjYiAn8THp03sIDXM
        AkuYJGY132SDaGhjlPj4cDsjSBWbgLrEnQ3fWEFsXgEbiSNX74BtYBFQlbi2dycTiC0qECHx
        +eARNogaQYmTM5+wgNicAjoSzz5cYQIZKiFwhVHi07b9TBCnCkmcXnwW7AxmoAV/5l2CssUl
        bj2ZzwRha0ssW/iaeQKj0Cwkc2chaZmFpGUWkpYFjCyrGIVyM5OzU4sys/UKMipLUpP1UlI3
        MQLj6PBE9Us7GPvmeBxiZOJgPMQowcGsJML7KGNZnBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe
        DbwlYUIC6YklqdmpqQWpRTBZJg5OqQZGqymOjyevWNWW6XhrHdvJI8IH4w0Vfp5aa/Svh1l0
        sTjr2W8F3cX9BS/PHtnIdLHs17QIv4OruOfX/hL1/G18JnDHr4aEj4k8r8+c61Yo/OWx4ty0
        JbIpcWsDEuIsp001WO4YM31G4IusQ+eFgtY+WXnhZfEOm5J+zpiZGjOsvq9baPuu1yuST4ml
        OCPRUIu5qDgRAAWr3EKRAgAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

you've asked in another thread [1] if there is any known simple panel
that requires a reset. We have a Densitron DMT070WSNLCMI-1E Panel
(compatible to avic,tm070ddh03) with some reset timing requirements, [2]
Page 20. So it would be nice to see this patch accepted.

[1] https://patchwork.kernel.org/patch/11292207/
[2]
https://www.densitron.com/sites/default/files/2019-09/DMT070WSNLCMI-1E%20Re=
v%20A.pdf

Regards,
Wadim

On 06.01.20 10:10, Miquel Raynal wrote:
> Hi Sam,
>
> Sam Ravnborg <sam@ravnborg.org> wrote on Thu, 2 Jan 2020 18:27:00 +0100:
>
>> Hi Miquel
>>
>> On Tue, Dec 24, 2019 at 03:21:34PM +0100, Miquel Raynal wrote:
>>> The panel common bindings provide a gpios-reset property. Let's
>>> support it in the simple driver.
>>>
>>> Two fields are added to the panel description structure: the time to
>>> assert the reset and the time to wait right after before starting to
>>> interact with it in any manner. In case these default values are not
>>> filled but the GPIO is present in the DT, default values are applied.  =

>> Wehn we discussed this the last time you wrote:
>>
>> """
>> my hardware is:
>>
>> LVDS IP <----------> LVDS to RGB bridge <------------> Panel
>>
>> While there is a simple "RGB to LVDS" bridge driver, there is none
>> doing the work the other way around. In my case, the bridge has a reset
>> pin.
>>
>> As until now there is no way to represent the "LVDS to RGB" bridge and
>> because the bindings already document such reset pin, I decided to add
>> support for it in the simple panel driver.
>> """
>>
>> Based on the information provided it seems that the correct way is to
>> add a "LVDS to RGB bridge" and then let the bridge handle the reset
>> functionality.
> This I agree, but we are talking about my current situation.=20
>
>> It is obviously much more code to do it this way but then
>> other panels using the same type of brigde have the
>> same functionality without adding bridge functionality to the panel.
> This, I do not fully agree as bindings for the panel reset already
> exist and we could have a reset on both: the bridge and the panel.
> I choose to use a wrong (private) DT representation because I am not
> willing to add an LVDS->RGB bridge: as you say, it is much more work to
> do. But, IMHO, this is not related to the patch. If you consider this
> patch wrong because a panel cannot have a reset, then it should be
> stated clearly and maybe removed from the bindings?
>
> Anyway if you think this change can't be useful, let's put it aside.
>
> Thanks for your time,
> Miqu=C3=A8l
>
> =5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
