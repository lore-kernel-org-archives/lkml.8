Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E71C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68A7C20684
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgGQJxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:53:53 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55630 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgGQJxw (ORCPT
        <rfc822;linux-kernel@vger.Kernel.org>);
        Fri, 17 Jul 2020 05:53:52 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id A72CA2A4F59
Subject: Re: [PATCH v3 2/2] dt-bindings: mfd: Add DT compatible string
 "google,cros_ec_uart"
To:     Rob Herring <robh@kernel.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>,
        Furquan Shaikh <furquan@chromium.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Eric Peers <epeers@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.Kernel.org
References: <20200715221150.v3.2.I113cdbaf66d48b37ac0faefb9b845480d122f3b9@changeid>
 <20200716191318.GA2683551@bogus>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <3995892c-340c-3419-3c2d-934a3067f51b@collabora.com>
Date:   Fri, 17 Jul 2020 11:53:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716191318.GA2683551@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 16/7/20 21:13, Rob Herring wrote:
> On Wed, Jul 15, 2020 at 10:16:04PM -0700, Bhanu Prakash Maiya wrote:
>> From: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
>>
>> Add DT compatible string in
>> Documentation/devicetree/bindings/mfd/cros_ec.txt
> 
> Need to update this.
> 
> With that,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 

So this is an ACPI-only driver that is instantiated by using the Device Tree
namespace link in ACPI. I am not sure how to deal with this, but I suspect we
need a proper OF binding definition before accept it.

The driver gets at least the baudrate and the flowcontrol from ACPI resources,
so I'm wondering if we should also add the properties in the device-tree
description (although we're not able to really test because there is not OF
hardware that supports it yet). Or is fine to just accept the compatible for now
and we can do this later when we have the possibility to test with OF-based
hardware.

Rob, any thoughts on this?

Thanks,
  Enric

>> Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
>> ---
>>
>> Changes in v3:
>> - Rebased changes on google,cros-ec.yaml
>>
>> Changes in v2:
>> - No change
>>
>>  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
