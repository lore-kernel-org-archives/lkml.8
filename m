Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E88C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9C1217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583159958;
	bh=S9YX6OjPgbMI3SxRJ44ChncEyJ5JHI0lpyN8E4uSJiU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Me+QEL5kOvB/IrlRUyTz+um3DKek2c0eoHpBwyzzGGQRRG8NaM1SAh3ReHELdoSmF
	 VJtJ7WZyKG3owOobfjSvfrqxiYFmEMgmRgpM6S/ag3cVWmp6AxSLVJ17POayAVat8g
	 uqUpG7DrSlERQyWC8L+lxjK7rt+g3oFufIXskYMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgCBOjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 09:39:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:49122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727131AbgCBOjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 09:39:17 -0500
Received: from coco.lan (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAD482166E;
        Mon,  2 Mar 2020 14:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583159956;
        bh=S9YX6OjPgbMI3SxRJ44ChncEyJ5JHI0lpyN8E4uSJiU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CDZyD8IsBQz3OtxC4HycZ3hNtuU4udOa6Si9GzEMN1YVu+n0rBPysyWzqP/5kXoG4
         t3L2ShtbPDuTkqZJNpO/XNu5NmPjiZh+EZPlWvOnnJg4PaDuXCcpC9Kxvwl/8znEDG
         F9DqUHwh+TRAnlDNGko/ruh+vXpXLrzV4nP51y8A=
Date:   Mon, 2 Mar 2020 15:39:09 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>, kernel@collabora.com,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH v6 5/6] media: rkvdec: Add the rkvdec driver
Message-ID: <20200302153909.4e90227d@coco.lan>
In-Reply-To: <20200302153529.4e2429e7@collabora.com>
References: <20200220163016.21708-1-ezequiel@collabora.com>
        <20200220163016.21708-6-ezequiel@collabora.com>
        <20200302145746.3e94c1d1@coco.lan>
        <20200302153529.4e2429e7@collabora.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 2 Mar 2020 15:35:29 +0100
Boris Brezillon <boris.brezillon@collabora.com> escreveu:

> On Mon, 2 Mar 2020 14:57:46 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > > +	for (j = 0; j < 3; j++) {    
> > 
> > Again a magic number. I guess this came from that big "M_N" table with 4
> > elements, right? Please use a define instead of hardcoding a number
> > here.  
> 
> Nope, it's unrelated to the cabac_table size, it's related to how the
> HW accesses the P/B reflists (there are 1 P reflist, and 2 B reflists,
> hence the 3 here).

Ah, ok!

> I guess we can have a '#define NUM_REFLISTS 3'.

Works for me. Please use NUM_REFLISTS on a consistent way, making it 
to reflect everywhere you might define or loop over those 3 reflists.


Thanks,
Mauro
