Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39B7C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC62F2078E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgDTLSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:18:20 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48278 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgDTLST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:18:19 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id 177A92A0C7C
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Rule for bridge yaml dt binding maintainers?
Date:   Mon, 20 Apr 2020 14:19:24 +0300
Message-ID: <87d082jtfn.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I got confused while doing the txt -> yaml conversion at [1] and 
it's still not clear to me who should be added in the 
"maintainers" field.  Clearly not the maintainers as returned by 
get_maintainer.pl. :)

Rob mentioned that "owners" should be manintainers but I also have 
trouble picking the persons who should be owners / yaml 
maintainers.

Looking at the completed bridge conversions in the latest 
linux-next, I couldn't find a rule and the majority of bindings 
are still txt: 

$ find ./devicetree/bindings/display/bridge/ -name *txt | wc -l
23
$ find ./devicetree/bindings/display/bridge/ -name *yaml | wc -l
5

So my questions are:
1. Is there a general rule for assigning yaml file 
owners/maintainers?

2. Is this vagueness specific to the bridge dt bindings only?

3. Who should step up and maintain these bindings? Original/new 
authors, SoC, bridge, DRM maintainers etc.?

It would be useful to have a rule to make it easier to do these 
conversions. We (Collabora) are considering doing the conversion 
work.

Thank you,
Adrian

[1] https://patchwork.kernel.org/patch/11493009/
