Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140FEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E6F2072C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590018309;
	bh=ngrtvfLYBKfv8MQkCaYk8tYirfeqXPlMFjsOE/YFGgk=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=HtxSjWsJ8jP5fJooh9RGIH79ZyFmtXZkwDgxsRSC/y1DXkAXbZtkbK2c6IOHzY7pQ
	 UTy2PLXd1034ox92kfKfIHUDm+sdep2CAf/JVqNAfFV01MVTe8TVYGce3nXwQ5rOXe
	 twGek0XUq/2Xn6qIzp9eJTC1KnWFwGQXOSuDxW34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgETXpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 19:45:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgETXpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 19:45:08 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F189F20748;
        Wed, 20 May 2020 23:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590018308;
        bh=ngrtvfLYBKfv8MQkCaYk8tYirfeqXPlMFjsOE/YFGgk=;
        h=Date:From:To:cc:Subject:From;
        b=aFQEiP489M9V1lc9WQ1OxfNV/2V+7N4zYIpsMfXXKumiUZCXkMtf0oX/l0ZaBRhko
         XXDUqKcjb3djxslDnJAwC1DX+oVg2M4ipvZyxQQ2EMXpfKDr0PuWTiEpSvLXpbWjS3
         1PiciD+5N1v3vJ8I1FAXnL7M5Kig9bCT9MNlgPYI=
Date:   Wed, 20 May 2020 16:45:07 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
cc:     sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, tamas@tklengyel.com, roman@zededa.com
Subject: [PATCH 00/10] fix swiotlb-xen for RPi4
Message-ID: <alpine.DEB.2.21.2005201628330.27502@sstabellini-ThinkPad-T480s>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series is a collection of fixes to get Linux running on the RPi4 as
dom0.

Conceptually there are only two significant changes:

- make sure not to call virt_to_page on vmalloc virt addresses (patch
  #1)
- use phys_to_dma and dma_to_phys to translate phys to/from dma
  addresses (all other patches)

In particular in regards to the second part, the RPi4 is the first
board where Xen can run that has the property that dma addresses are
different from physical addresses, and swiotlb-xen was written with the
assumption that phys addr == dma addr.

This series adds the phys_to_dma and dma_to_phys calls to make it work.


Cheers,

Stefano
