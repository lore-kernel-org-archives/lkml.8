Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035F6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D26BF206B5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="MslSwSkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgHGJf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgHGJf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:35:29 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA45C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 02:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds201912; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gGIwDhOjA1LUWyVCPaxr0QUqfVFuaQ2aeOuDTG1FAG0=; b=MslSwSkr01gt37As8fjtp3c4L+
        6xxPqtPSL4bh0HaSr22/l0EGjObkF7Y1b2yd2VrnO1qxWjAao21ToRnsob2Q5HbRxmUk+K7ktL12e
        fWSA93OWvOje0tkgZmr2nk07ub+RYndaYdyv+soRH/pget70PhJuqhr+rN+PgY2iCwHGJtCohnlZg
        v4TLPW1TL7Ywcwt3k72wJq6XiXclEFTwFNgw7x4GdYH1v54sHHX+/uCERdnN1lRTARFnk8sUiEwEi
        Uit4ZbeeL+I0RrTXQKS5ObwCFH0AHHQtFg6tWAe7QKe14ZsFxgXUV+ABxCRIBtndf2CBx3IADZFgB
        HQotCxuQ==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:53009 helo=[192.168.10.61])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1k3ymc-0001ze-4F; Fri, 07 Aug 2020 11:35:26 +0200
Subject: Re: [PATCH 3/6] drm/xen-front: Add YUYV to supported formats
To:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     intel-gfx@lists.freedesktop.org, sstabellini@kernel.org,
        dan.carpenter@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20200731125109.18666-1-andr2000@gmail.com>
 <20200731125109.18666-4-andr2000@gmail.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <a7a3ce30-34a8-c084-5cbd-88271271ac67@tronnes.org>
Date:   Fri, 7 Aug 2020 11:35:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200731125109.18666-4-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 31.07.2020 14.51, skrev Oleksandr Andrushchenko:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> 
> Add YUYV to supported formats, so the frontend can work with the
> formats used by cameras and other HW.
> 
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>
