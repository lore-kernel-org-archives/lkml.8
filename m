Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A09C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 10:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C227020789
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 10:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgHRKMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 06:12:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:50628 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgHRKMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 06:12:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3BD06AF8E;
        Tue, 18 Aug 2020 10:12:48 +0000 (UTC)
Subject: Re: [PATCH v3 5/9] dt-bindings: pinctrl: realtek: Add Realtek DHC SoC
 rtd1295
To:     Rob Herring <robh@kernel.org>, TY Chang <tychang@realtek.com>
Cc:     linux-realtek-soc@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, linus.walleij@linaro.org
References: <20200813074908.889-1-tychang@realtek.com>
 <20200813074908.889-6-tychang@realtek.com> <20200817203358.GA1508879@bogus>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <012eee35-6835-7244-0013-9fc6980107e0@suse.de>
Date:   Tue, 18 Aug 2020 12:12:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817203358.GA1508879@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 17.08.20 um 22:33 schrieb Rob Herring:
> On Thu, 13 Aug 2020 15:49:04 +0800, TY Chang wrote:
>> Add device tree binding Documentation for rtd1295
>> pinctrl driver.
>>
>> Signed-off-by: TY Chang <tychang@realtek.com>
>> ---
>>  .../pinctrl/realtek,rtd1295-pinctrl.yaml      | 192 ++++++++++++++++++
>>  1 file changed, 192 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pinctrl/realtek,rtd1295-pinctrl.yaml
>>
> 
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
> If a tag was not added on purpose, please state why and what changed.

The thing really missing here is a per-patch change log.

Things were added here that I'm sure you would not give your Reviewed-by
for, in particular new properties prefixed with unregistered rtk prefix
instead of the registered realtek prefix.

@TY, hiding such changes in a big previously reviewed patch without any
mention is problematic - please rather do smaller follow-up patches to
not invalidate previous reviews with new features.

Thanks,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
