Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B711C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 21:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E172071A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 21:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbgAYVcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 16:32:32 -0500
Received: from verein.lst.de ([213.95.11.211]:47427 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgAYVcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 16:32:32 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3933868BFE; Sat, 25 Jan 2020 22:32:29 +0100 (CET)
Date:   Sat, 25 Jan 2020 22:32:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Namjae Jeon <linkinjeon@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, pali.rohar@gmail.com, arnd@arndb.de,
        namjae.jeon@samsung.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v13 00/13] add the latest exfat driver
Message-ID: <20200125213228.GA5518@lst.de>
References: <20200121125727.24260-1-linkinjeon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121125727.24260-1-linkinjeon@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RCU changes looks sensible to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
