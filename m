Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF63C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 17:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A36208C3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 17:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VIDlz9gZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgCIRUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 13:20:36 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:57916 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgCIRUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 13:20:35 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 029HKJhW081517;
        Mon, 9 Mar 2020 12:20:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583774419;
        bh=9tqG8lsZxDbDWkjZmACtivY21dcKdEeq8w0vOUqH4wM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=VIDlz9gZSFX3vc5gnrDWmH9BzHO1hAaTY7kP7VJhbF0/J6Ei/Hg68fdhKNih8KbF2
         t6pZCiBmY+w9oLRjvEbPESi9UJHewOPo4bddYsBhyo/yDskkNi2wMjF+PnrwaMhCVS
         vv/Kx6Gb4pVV0CT3LCvFcnQpRJ7l2+dr/fON115g=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 029HKJGN068509;
        Mon, 9 Mar 2020 12:20:19 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Mar
 2020 12:20:19 -0500
Received: from localhost.localdomain (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Mar 2020 12:20:19 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 029HKJUl079705;
        Mon, 9 Mar 2020 12:20:19 -0500
Date:   Mon, 9 Mar 2020 12:26:07 -0500
From:   Bin Liu <b-liu@ti.com>
To:     Macpaul Lin <macpaul.lin@mediatek.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Min.Guo@mediatek.com>, <Chunfeng.Yun@mediatek.com>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] usb: musb: tusb6010: fix a possible missing data type
 replacement
Message-ID: <20200309172607.GA3839@iaqt7>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Min.Guo@mediatek.com, Chunfeng.Yun@mediatek.com,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <1579603670-10970-1-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1579603670-10970-1-git-send-email-macpaul.lin@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 06:47:50PM +0800, Macpaul Lin wrote:
> Replace "unsigned" to "u32" for checkpatch fix to tusb_writeb().
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>

Queued for v5.7. Thanks.
-Bin.
