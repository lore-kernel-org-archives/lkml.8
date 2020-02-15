Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA6DC7114D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 18:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388B62072D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 18:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="hKlxHnr3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgBOSjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 13:39:52 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:33035 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgBOSjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 13:39:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds201912; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5/19AUsXQSsM+Vl14HjA0kAidLjQ78I398OHdWF5mXY=; b=hKlxHnr3r7kEmwppY5QswZF8zA
        sJKNSj+9WC7QiX3xHgpxS3j26U4qBu0oBgHY6AZIfUH4qyJRl5RFwAQgOQbZVAx1vt72ANjsJPlfN
        aTtbzGewdhgjZ/osQzjFbznl+mv5jGf56QE8bnJqHXoLBPpSTSqEKwy0mrpH2Uig2KIzhT8nMCyn1
        13GDeYqx9KhU/7mj7zCK2UY17m/IQOOrPvIDTKljJqInhqwiE0J+xIMRFZKlIdYC1pAg5csmkZZY0
        DwmJk4Ppou3YjvdyylhhSY4mF/e2fComDGcTL+Zja74GZw7y962RHp9cXjxZimPrtoh6R2Gmq33Jr
        k/jtYQ5A==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:53545 helo=[192.168.10.61])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1j32M2-0005Bc-69; Sat, 15 Feb 2020 19:39:50 +0100
Subject: Re: [PATCH v2 2/2] drm/format_helper: Dual licence the file in GPL 2
 and MIT
To:     Emmanuel Vadot <manu@FreeBSD.org>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, jani.nikula@intel.com,
        efremov@linux.com, tzimmermann@suse.de, sam@ravnborg.org,
        chris@chris-wilson.co.uk, kraxel@redhat.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200215180911.18299-1-manu@FreeBSD.org>
 <20200215180911.18299-3-manu@FreeBSD.org>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <5472091e-7b98-7742-c04f-704fb138d1f8@tronnes.org>
Date:   Sat, 15 Feb 2020 19:39:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200215180911.18299-3-manu@FreeBSD.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 15.02.2020 19.09, skrev Emmanuel Vadot:
> From: Emmanuel Vadot <manu@FreeBSD.Org>
> 
> Contributors for this file are :
> Gerd Hoffmann <kraxel@redhat.com>
> Maxime Ripard <mripard@kernel.org>
> Noralf Trønnes <noralf@tronnes.org>
> 
> Signed-off-by: Emmanuel Vadot <manu@FreeBSD.org>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>
