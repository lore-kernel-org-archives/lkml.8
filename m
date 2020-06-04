Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECB0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D19B206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgFDIw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:52:27 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:45530 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726664AbgFDIw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:52:27 -0400
Received: from [37.160.65.106] (port=1522 helo=[192.168.43.3])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jglbs-0002R5-4Q; Thu, 04 Jun 2020 10:52:24 +0200
Subject: Re: [RFC 4/4] regulator: lp87565: add LP87524-Q1 variant
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Keerthy <j-keerthy@ti.com>, Axel Lin <axel.lin@ingics.com>
References: <20200603200319.16184-1-luca@lucaceresoli.net>
 <20200603200319.16184-5-luca@lucaceresoli.net> <20200604064435.GR3714@dell>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <38652a93-304c-2d3f-c700-594f1ad57903@lucaceresoli.net>
Date:   Thu, 4 Jun 2020 10:52:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604064435.GR3714@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 04/06/20 08:44, Lee Jones wrote:
> On Wed, 03 Jun 2020, Luca Ceresoli wrote:
> 
>> Add support for the LP87524B/J/P-Q1 Four 4-MHz Buck Converter. This is a
>> variant of the LP87565 having 4 single-phase outputs and up to 10 A of
>> total output current.
>>
>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>> ---
>>  drivers/mfd/lp87565.c       | 4 ++++
>>  include/linux/mfd/lp87565.h | 1 +
> 
> Again, this is an MFD patch.  Please change the subject line.

Right.

>>  2 files changed, 5 insertions(+)
> 
> Once changed, please re-submit with my:
> 
> For my own reference (apply this as-is to your sign-off block):
> 
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

Good, thank you.
-- 
Luca
