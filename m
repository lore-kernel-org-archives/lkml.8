Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EACAC2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 183EF2076A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404283AbgDOQrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:47:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:45400 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416270AbgDOQrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:47:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0E2BAABD1;
        Wed, 15 Apr 2020 16:47:05 +0000 (UTC)
Date:   Wed, 15 Apr 2020 11:47:02 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        'Hyunchul Lee' <hyc.lee@gmail.com>,
        'Eric Sandeen' <sandeen@sandeen.net>
Subject: Re: [ANNOUNCE] exfat-utils-1.0.1 initial version released
Message-ID: <20200415164702.xf3t2stjpkjl6das@fiona>
References: <CGME20200409015934epcas1p442d68b06ec7c5f3ca125c197687c2295@epcas1p4.samsung.com>
 <001201d60e12$8454abb0$8cfe0310$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001201d60e12$8454abb0$8cfe0310$@samsung.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10:59 09/04, Namjae Jeon wrote:
> The initial version(1.0.1) of exfat-utils is now available.
> This is the official userspace utilities for exfat filesystem of
> linux-kernel.

For the sake of sanity of the distributions which already carry
exfat-utils based on fuse (https://github.com/relan/exfat), would it be
possible to either change the name of the project to say exfat-progs or
increase the version number to beyond 1.4?

exfat-progs is more in line with xfsprogs, btrfsprogs or e2fsprogs :)

-- 
Goldwyn
