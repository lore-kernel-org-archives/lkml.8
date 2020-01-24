Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEECFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9544D2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbgAXO3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:29:16 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59378 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391272AbgAXO3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:29:12 -0500
Received: from [IPv6:2003:cb:8716:6a00:9da8:f7b8:a96c:6547] (p200300CB87166A009DA8F7B8A96C6547.dip0.t-ipconnect.de [IPv6:2003:cb:8716:6a00:9da8:f7b8:a96c:6547])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 55C57294BBA;
        Fri, 24 Jan 2020 14:29:10 +0000 (GMT)
Subject: Re: [PATCH] dt-bindings: fix compilation error of the example in
 intel,lgm-emmc-phy.yaml
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Helen Koike <helen.koike@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Collabora Kernel ML <kernel@collabora.com>, dafna3@gmail.com
References: <20200124114914.27065-1-dafna.hirschfeld@collabora.com>
 <CAL_JsqKgNzY=KF8XzuGjw2NogBawfi0gh9ytrk_nw_Ewg2QDdg@mail.gmail.com>
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <9c4a971f-6a65-594e-4a79-9e2aa16e58cb@collabora.com>
Date:   Fri, 24 Jan 2020 15:29:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKgNzY=KF8XzuGjw2NogBawfi0gh9ytrk_nw_Ewg2QDdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.01.20 15:03, Rob Herring wrote:
> On Fri, Jan 24, 2020 at 5:49 AM Dafna Hirschfeld
> <dafna.hirschfeld@collabora.com> wrote:
>>
>> Running:
>> export DT_SCHEMA_FILES=Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
>> 'make dt_binding_check'
>>
>> gives a compilation error. This is because in the example there
>> is the label 'emmc-phy' but labels are not allowed to have '-' sing.
>> Replace the '-' with '_' to fix the error.
>>
>> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> 
> There's a fix from the author, but you're first to get the fix correct, so:
Oh, sorry, I was not aware of that.
Dafna

> 
> Fixes: 5bc999108025 ("dt-bindings: phy: intel-emmc-phy: Add YAML
> schema for LGM eMMC PHY")
> Acked-by: Rob Herring <robh@kernel.org>
> 
> Kishon, Please apply these soon as linux-next is broken.
> 
> Rob
> 
