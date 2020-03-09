Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59149C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B5524658
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EqYwQhUb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgCIQLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:11:07 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51184 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgCIQLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:11:06 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 029GB1Ti064923;
        Mon, 9 Mar 2020 11:11:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583770261;
        bh=BoPPFSIyv/x3zMoh4vQgW2YRQN7431G4sFt8c/J7vYc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=EqYwQhUbuF3q890fCxM+d4REL/Eqtuv8qr6Tm0fiXm95JwcuTHhOGJRTzO0BoE1Wq
         gVwXxl9d1JMJh/vBAzjXSbcSwrJRnlPLPsrn18c6ts/CmvNwMzAS57E+u3Wojlo5GS
         LBXjoIWQJ8Ms0rR8pue03bKCCoxB+s6wBDcHqxl8=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 029GB1gI071804
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Mar 2020 11:11:01 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 9 Mar
 2020 11:10:23 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 9 Mar 2020 11:10:23 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 029GAM4O038113;
        Mon, 9 Mar 2020 11:10:22 -0500
Date:   Mon, 9 Mar 2020 11:16:11 -0500
From:   Bin Liu <b-liu@ti.com>
To:     Mans Rullgard <mans@mansr.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: musb: fix crash with highmen PIO and usbmon
Message-ID: <20200309161611.GC31115@iaqt7>
Mail-Followup-To: Bin Liu <b-liu@ti.com>, Mans Rullgard <mans@mansr.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200309152653.29161-1-mans@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200309152653.29161-1-mans@mansr.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 03:26:53PM +0000, Mans Rullgard wrote:
> When handling a PIO bulk transfer with highmem buffer, a temporary
> mapping is assigned to urb->transfer_buffer.  After the transfer is
> complete, an invalid address is left behind in this pointer.  This is
> not ordinarily a problem since nothing touches that buffer before the
> urb is released.  However, when usbmon is active, usbmon_urb_complete()
> calls (indirectly) mon_bin_get_data() which does access the transfer
> buffer if it is set.  To prevent an invalid memory access here, reset
> urb->tranfer_buffer to NULL when finished (musb_host_rx()), or do not

WARNING: 'tranfer' may be misspelled

I have fixed it locally.

> set it at all (musb_host_tx()).
> 
> Fixes: 8e8a55165469 ("usb: musb: host: Handle highmem in PIO mode")
> Signed-off-by: Mans Rullgard <mans@mansr.com>

Applied. Thanks.
-Bin.
