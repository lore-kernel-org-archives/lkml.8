Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1749DC33CAF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 22:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7890206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 22:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgASWiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 17:38:02 -0500
Received: from verein.lst.de ([213.95.11.211]:42113 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728755AbgASWiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 17:38:02 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 08B0668B20; Sun, 19 Jan 2020 23:37:59 +0100 (CET)
Date:   Sun, 19 Jan 2020 23:37:58 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Namjae Jeon <linkinjeon@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, pali.rohar@gmail.com, arnd@arndb.de,
        namjae.jeon@samsung.com
Subject: Re: [PATCH v11 14/14] staging: exfat: make staging/exfat and
 fs/exfat mutually exclusive
Message-ID: <20200119223758.GH4890@lst.de>
References: <20200118150348.9972-1-linkinjeon@gmail.com> <20200118150348.9972-15-linkinjeon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118150348.9972-15-linkinjeon@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2020 at 12:03:48AM +0900, Namjae Jeon wrote:
> From: Namjae Jeon <namjae.jeon@samsung.com>
> 
> Make staging/exfat and fs/exfat mutually exclusive to select the one
> between two same filesystem.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
