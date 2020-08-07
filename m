Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0297BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C59E4206B5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="m+PWgSDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgHGJeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgHGJd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:33:59 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913CCC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 02:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds201912; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dhBn85DVkd9WiwzdeA0ZAk87Jr2Z06qRR9qaDjfK2Q0=; b=m+PWgSDl91eMGK8rvIUKM0yLbY
        BTtvVt7GHjbFDWuiAwCew1o4DpGo0X5EvPmAu5NoF3KVa/WrJcno0rE7yU1ZuLLtdori78nG3MTCt
        /b8lIQ2wjTrAa0IiTxbfflVOoB7ItTWH5BtnD5ca03DmpWO/VJDk2VuV869dshjYbkabO+gvNdp24
        JWObB1zbNo/5PI0p3ZVDSwL/BO7R7V/6mJxK0CCdbPFRQbzPeg7iUN/yZAnyl20Pngs2xjN3NmTPy
        zdQzdFT7BoYqEc5G2bz0PhPFH2d51HiC/khBGUEla9ZiuFb88uEbH9k/urcGwnv8sV65Q7rLD6Dvg
        5yexQLUA==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:52994 helo=[192.168.10.61])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1k3yl5-0001BT-1d; Fri, 07 Aug 2020 11:33:51 +0200
Subject: Re: [PATCH 5/6] drm/xen-front: Pass dumb buffer data offset to the
 backend
To:     Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     intel-gfx@lists.freedesktop.org, sstabellini@kernel.org,
        dan.carpenter@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20200731125109.18666-1-andr2000@gmail.com>
 <20200731125109.18666-6-andr2000@gmail.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <a8930c22-756f-0fc9-6288-8945a058764e@tronnes.org>
Date:   Fri, 7 Aug 2020 11:33:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200731125109.18666-6-andr2000@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 31.07.2020 14.51, skrev Oleksandr Andrushchenko:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> 
> While importing a dmabuf it is possible that the data of the buffer
> is put with offset which is indicated by the SGT offset.
> Respect the offset value and forward it to the backend.
> 
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>
