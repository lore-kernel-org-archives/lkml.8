Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF2FC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D084B21973
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbgIIJfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:35:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:44698 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgIIJfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:35:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 87B94ADBD;
        Wed,  9 Sep 2020 09:35:03 +0000 (UTC)
Subject: Re: [PATCH v5 6/7] arm: dts: mt7623: move display nodes to separate
 mt7623n.dtsi
From:   Matthias Brugger <matthias.bgg@gmail.com>
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        David Woodhouse <dwmw@amazon.co.uk>
References: <20200819081752.4805-1-linux@fw-web.de>
 <20200819081752.4805-7-linux@fw-web.de>
 <57085883-5044-aec2-021b-3b0880da70bc@gmail.com>
Message-ID: <3b3ef297-a3cf-6a3f-3118-9cc8b4ccc1f4@gmail.com>
Date:   Wed, 9 Sep 2020 11:35:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <57085883-5044-aec2-021b-3b0880da70bc@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2020 11:29, Matthias Brugger wrote:
> 
> 
> On 19/08/2020 10:17, Frank Wunderlich wrote:
>> From: Frank Wunderlich <frank-w@public-files.de>
>>
>> mt7623a has no graphics support so move nodes from generic mt7623.dtsi
>> to mt7623n.dtsi
>>
>> Fixes: 1f6ed224594 ("arm: dts: mt7623: add Mali-450 device node")
>> Suggested-by: David Woodhouse <dwmw@amazon.co.uk>
>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> 
> Applied to v5.9-next/dts32
> 

Realized that there is a v6, so I pull out this and 7/7.

Regards,
Matthias
