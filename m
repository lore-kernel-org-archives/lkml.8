Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47555C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 05:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28566206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 05:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgHCFog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 01:44:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:39242 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbgHCFog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 01:44:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2B2BAAC20;
        Mon,  3 Aug 2020 05:44:50 +0000 (UTC)
Subject: Re: [PATCH v3 0/3] Few bug fixes and Convert to pin_user_pages*()
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        boris.ostrovsky@oracle.com, sstabellini@kernel.org
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Paul Durrant <xadimgnik@gmail.com>
References: <1594525195-28345-1-git-send-email-jrdr.linux@gmail.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <b26b61b9-de1f-b86c-be8b-049fa412b509@suse.com>
Date:   Mon, 3 Aug 2020 07:44:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1594525195-28345-1-git-send-email-jrdr.linux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.07.20 05:39, Souptick Joarder wrote:
> This series contains few clean up, minor bug fixes and
> Convert get_user_pages() to pin_user_pages().
> 
> I'm compile tested this, but unable to run-time test,
> so any testing help is much appriciated.
> 
> v2:
>          Addressed few review comments and compile issue.
>          Patch[1/2] from v1 split into 2 in v2.
> v3:
> 	Address review comment. Add review tag.
> 
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Paul Durrant <xadimgnik@gmail.com>
> 
> Souptick Joarder (3):
>    xen/privcmd: Corrected error handling path
>    xen/privcmd: Mark pages as dirty
>    xen/privcmd: Convert get_user_pages*() to pin_user_pages*()
> 
>   drivers/xen/privcmd.c | 32 ++++++++++++++------------------
>   1 file changed, 14 insertions(+), 18 deletions(-)
> 

Series pushed to xen/tip.git for-linus-5.9


Juergen
