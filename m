Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7458C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 20:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCC282071A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 20:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgFNUAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 16:00:53 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:34603 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726648AbgFNUAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 16:00:52 -0400
Received: from [37.163.176.33] (port=58546 helo=[192.168.43.3])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jkYoB-0007H9-7c; Sun, 14 Jun 2020 22:00:48 +0200
Subject: Re: [RFC 2/4] regulator: lp87565: dt: remove duplicated section
To:     Rob Herring <robh@kernel.org>, Keerthy <j-keerthy@ti.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Axel Lin <axel.lin@ingics.com>
References: <20200603200319.16184-1-luca@lucaceresoli.net>
 <20200603200319.16184-3-luca@lucaceresoli.net>
 <20200612221954.GA3919662@bogus>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <532c0ac1-b520-3443-1f8f-12fd87011076@lucaceresoli.net>
Date:   Sun, 14 Jun 2020 22:00:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200612221954.GA3919662@bogus>
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

Hi Rob, Keerthy,

On 13/06/20 00:19, Rob Herring wrote:
> On Wed, Jun 03, 2020 at 10:03:17PM +0200, Luca Ceresoli wrote:
>> The "Required properties:" section is copied verbatim for each of the two
>> supported chips. In preparation to add a new chip variant make it a common
>> section and keep the two examples to differentiate between the two chips.
>>
>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>> ---
>>  .../devicetree/bindings/mfd/lp87565.txt       | 21 ++++---------------
>>  1 file changed, 4 insertions(+), 17 deletions(-)
> 
> If you want to clean this up, can you convert it to DT schema?

Sure, no problem. My only question is who should I set in the
"maintainers" property.

Keerty, as the original author and TI employee, you surely know this
chip series much better than I do. Would you like to be the maintainer
for this binding document? Otherwise I can do it "best effort".

Regards,
-- 
Luca
